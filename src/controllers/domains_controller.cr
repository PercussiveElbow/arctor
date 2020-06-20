
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

    def get
      domain = Domain.find_by(fqdn: params[:domain])
      if domain && domain.id
        subdomains = SubDomain.where(domain_id: domain.id)
      end
      if subdomains && domain
        unique_hosts = [] of Int64
        subdomains.each do | sub |
          host_links = SubDomainHostLink.all("WHERE sub_domain_id=?", [sub.id])
          if host_links
            host_links.each do  | host |
              if host
                host_id = host.host_id 
                if host_id
                  unique_hosts << host_id
                end
              end
            end
          end
        end
        unique_ports = {} of Int32 => Int32
        port_labels = [] of Int32
        port_series = [] of Int32
        unique_hosts = unique_hosts.uniq

        unique_hosts.each do | host_id| 
          host = Host.find(host_id)
          if host
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
                  puts(unique_ports)
                end
              end
            end
          end 
        end
        unique_ports.each do | key , value |
          puts(key)
          puts(value)
          port_labels << key
          port_series << value
        end
        render("domain.slang")
      end
    end

end  