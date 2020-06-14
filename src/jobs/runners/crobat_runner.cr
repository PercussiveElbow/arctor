require "./generic_runner"

class CrobatRunner


    def self.run(domain)
      client = Crobat::CrobatSDK.new("https://sonar.omnisint.io")
      puts("INFO - DNS Recon - Beginning passive Crobat scan of #{domain}")
      #puts(client.retrieve_subdomains(domain))
    end
  
  
  
  end
  