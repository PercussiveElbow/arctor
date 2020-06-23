
class DomainsController < ApplicationController
    def index
      domains = Domain.all

      domains_with_count = []  of Hash(String,String)
      domains.each do | domain |
        hosts_count = 0
        subs = domain.subdomains
      end
      
      render("domains.slang")
    end

    def get # get specific domain
      domain = Domain.find_by(fqdn: params[:domain])
      if domain && domain.id
        subdomains = SubDomain.where(domain_id: domain.id)
      end
      if subdomains && domain

        edges = [] of Hash(String,String)
        nodes = [] of Hash(String,String)
        elements = [] of Hash(String,Hash(String,String))

        # Gather unique hosts
        unique_hosts = [] of Int64
        subdomains.each do | sub |
          host_links = SubDomainHostLink.all("WHERE sub_domain_id=?", [sub.id])
          
          fqdn = sub.fqdn

          if fqdn
            elements << {"data" => {"id" => fqdn}}
          end

          if host_links
            host_links.each do  | host |
              if host
                host_id = host.host_id 
                host_obj = Host.find(host_id)
                if host_id && host_obj
                  unique_hosts << host_id
                  rand_no = Random.new.rand(1..100000).to_s
                  ipv4 = host_obj.ipv4
                  if rand_no && fqdn && ipv4 && ipv4.size()>0
                    elements << {"data" => {"id" => rand_no, "source" => fqdn, "target" => ipv4}}
                  end
                end
              end
            end
          end
        end
        unique_hosts = unique_hosts.uniq

        unique_ports = {} of Int32 => Int32
        unique_countries = {} of String => Int32
        unique_orgs = {} of String => Int32
        coords =  [] of Hash(String, Float64)
        port_labels = [] of Int32
        port_series = [] of Int32

        # Calculate port and geo stats
        unique_hosts.each do | host_id| 
          host = Host.find(host_id)
          if host
            ipv4 = host.ipv4 

            if ipv4 && ipv4.size()>0
              elements << {"data" => {"id" => ipv4}}
            end

            shodan_info = host.shodan_info
            if shodan_info
              ports = shodan_info.ports
              if ports
                ports.each do | port |
                  if unique_ports.has_key?(port)
                    unique_ports[port] +=  1
                  else
                    unique_ports[port] = 1
                  end
                end
              end
              country = shodan_info.country_name
              if country
                if unique_countries.has_key?(country)
                  unique_countries[country] +=1
                else
                  unique_countries[country] = 1
                end
              end

              org = shodan_info.org 

              if org
                if unique_orgs.has_key?(org)
                  unique_orgs[org] +=1
                else
                  unique_orgs[org] = 1
                end
              end

              lat = shodan_info.latitude
              long = shodan_info.longitude
              if lat && long 
                coords << {"lat"=> lat , "lng" => long,"count" => 1.to_f}
              end

            end
          end 
        end
        
        # Calculate port stats
        unique_ports.each do | key , value |
          port_labels << key
          port_series << value
        end

        # Conver to JSON
        coords = coords.to_json
        elements = elements.to_json

        render("domain.slang")
      end
    end


end  