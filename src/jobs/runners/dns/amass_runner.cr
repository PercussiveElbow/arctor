require "random"
require "json"
require "./dns_inserter_runner"
require "../generic_runner"
require "../../shodan_enum_job"

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

    def initialize(@domain : String, @domain_id : Int64)
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
      DNSInserter.resolve_subdomain(@domain_id,output_split,"Amass Passive")
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
            ip = parsed_sub.addresses[0].ip 

            ipv4 = ""
            ipv6 = ""
            if ip =~ /^(?:[0-9]{1,3}\.){3}[0-9]{1,3}$/
              puts("Found Ipv4 #{ip}")
              ipv4 = ip
              DNSInserter.insert_subdomain(domain_id: @domain_id, subdomain: parsed_sub.name,ipv4: [ipv4], source: parsed_sub.source)
            elsif ip =~ /(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))/
              puts("Found Ipv6 #{ip}")
              ipv6 = ip
              DNSInserter.insert_subdomain(domain_id: @domain_id, subdomain: parsed_sub.name,ipv4: [ipv4], ipv6: [ipv6], source: parsed_sub.source)
            end
          end
        end
      end

    end
  
end