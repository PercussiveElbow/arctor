require "./generic_runner"
require "random"
require "json"

class AmassRunner < GenericRunner

    def initialize(@domain : String)
    end

    def run(passive : Bool)
      puts("INFO - DNS Recon - Beginning Amass scan of #{@domain}")

      filename = Random::Secure.hex
      puts("Filename #{filename}")
      if passive
        puts("Passive Amass scan")
        args = ["enum", "-passive", "-d", "#{@domain}"]
        puts(args)
      else
        puts("Active Amass scan")
        args = ["enum", "-active", "-d", "#{@domain}", "-ip", "-json", "/tmp/#{filename}"]
      end
      
      status, output = CommandRunner.run("amass", args) 
      if status
        puts("INFO - DNS Recon - Completed Amass scan of #{@domain}")
        puts(output)

        if passive
          parse_stdout(output)
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

    def insert_subdomain(subdomain : String)
      db_domain_found = Domain.find_by(fqdn: @domain)

      if !db_domain_found
        new_domain = Domain.create(fqdn: @domain)
        new_domain.save
        domain_id = new_domain.id
      else
        domain_id = db_domain_found.id
      end
      puts("Loaded subdomain #{subdomain} into database")
      subdomain = SubDomain.create(domain_id: domain_id, fqdn: subdomain)
      subdomain.save
    end
  
end