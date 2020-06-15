require "./generic_runner"
require "random"
require "json"

class AmassRunner < GenericRunner

    class AmassJson include JSON::Serializable
      property name : String
      property domain : String
      property addresses : Array(AmassAddressJson)
      property source : String
      property tag : String?
    end

    class AmassAddressJson include JSON::Serializable
      property ip : String
      property cidr : String?
      property desc : String?
      property asn : Int64? 
    end

    def initialize(@domain : String)
    end

    def run(passive : Bool)
      puts("INFO - DNS Recon - Amass - Beginning Amass scan of #{@domain}")

      filename = "/tmp/arctor-#{Random::Secure.hex}.json"
      puts("INFO - DNS Recon - Amass - Filename #{filename}")
      if passive
        puts("INFO - DNS Recon - Amass - Beginning PASSIVE scan  of #{@domain}")
        args = ["enum", "-passive", "-d", "#{@domain}"]
      else
        puts("INFO - DNS Recon - Amass - Beginning ACTIVE scan  of #{@domain}")
        args = ["enum", "-active", "-d", "#{@domain}", "-ip", "-json", "#{filename}"]
      end
      
      status, output = CommandRunner.run("amass", args) 
      if status
        puts("INFO - DNS Recon - Completed Amass scan of #{@domain}")
        puts(output)

        if passive
          parse_stdout(output)
        else
          parse_file(filename)
        end
      else
        puts("ERROR - DNS Recon - Failed Amass scan of #{@domain}")
        puts(output)
      end
    end

    def parse_stdout(stdout : String)
      output_split = stdout.split("\n")
      output_split.each do | line | 
        insert_subdomain(line)
      end
    end

    def insert_subdomain(subdomain : String, ipv4 = "", ipv6 : String = "", source : String = "")
      db_domain_found = Domain.find_by(fqdn: @domain)

      if !db_domain_found
        new_domain = Domain.create(fqdn: @domain)
        new_domain.save
        domain_id = new_domain.id
      else
        domain_id = db_domain_found.id
      end

      puts("INFO - DNS Recon - Amass - Loaded subdomain #{subdomain} into database")
      subdomain = SubDomain.create(domain_id: domain_id, fqdn: subdomain, a: ipv4, aaaa: ipv6, source: source)
      subdomain.save
      host = Host.create(ipv6: ipv6, ipv4: ipv4)
      host.save
      link = SubDomainHostLink.create(host_id: host.id, sub_domain_id: subdomain.id)
      link.save
    end

    def parse_file(filename : String)
      puts("INFO - DNS Recon - Amass - Retrieving from #{filename}")

      if File.exists?(filename)
        file_content = File.read(filename)
        content = File.read(filename).gsub(/\s(?=([^"]*"[^"]*")*[^"]*$)/,"")
        content = content.split("}{") # amass doesn't actually output valid JSON because ?????????
        
        content.each do |json_chunk|
          if json_chunk
            if !(json_chunk[0] == '{')
                json_chunk = "{#{json_chunk}"
            end
            if json_chunk[json_chunk.size()-1] != '}'
                json_chunk = "#{json_chunk}}"
            end
            parsed_sub = AmassJson.from_json(json_chunk)
            # puts(parsed_sub)
            # puts(parsed_sub.source)
            insert_subdomain(parsed_sub.name,parsed_sub.addresses[0].ip,parsed_sub.addresses[0].ip, parsed_sub.source)
          end
        end
      end

    end
  
end