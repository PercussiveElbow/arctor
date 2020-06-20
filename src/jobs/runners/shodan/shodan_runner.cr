require "shodan/shodan"

class ShodanRunner < GenericRunner

    def initialize(@host : String, @host_id : Int64)
    end

    def run(passive : Bool)
      puts("INFO - DNS Recon - Amass - Beginning Shodan recon of #{@host}")
      shodan_api = Shodan::Client.new("keykeykeykeykeykey")

      begin
        host_info = shodan_api.host(@host)
        if host_info
          insert_host_data(host_info)
        end
      rescue ex : Shodan::Client::ShodanAPIException
        puts(ex)
      end      
    
    end

    def insert_host_data(host_info : Shodan::Host) # very messy need a  better method, maybe macro or figure out a way to base db model off existing serializable shodan obj
      puts(host_info.instance_vars_names)
      ports = host_info.ports
      domains = host_info.domains
      hostnames = host_info.hostnames

      new_shodan_entry = ShodanInfo.create(host_id: @host_id, ports: ports,os: host_info.area_code, tags: host_info.tags, 
      org: host_info.org, last_update: host_info.last_update, country_code: host_info.country_code, 
      area_code: host_info.area_code, region_code: host_info.region_code, postal_code: host_info.postal_code,
      city: host_info.city, country_name: host_info.country_name, dma_code: host_info.dma_code, longitude: host_info.longitude,
      latitude: host_info.latitude, hostnames:  host_info.hostnames, domains: host_info.domains)

      new_shodan_entry_id = new_shodan_entry.id 
      datas = host_info.data
      if new_shodan_entry_id && datas
        datas.each do | data |
          ShodanService.create(shodan_info_id: new_shodan_entry_id, port: data.port, product: data.product, isp: data.isp, asn: data.asn, hostnames: data.hostnames, domains: data.domains, os: data.os, hash: data.hash, version: data.version, cpes: data.cpe)
        end
      end
    end
end