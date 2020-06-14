require "./generic_runner"

class AmassRunner < GenericRunner

    def self.run(domain : String, passive : Bool)
      puts("INFO - DNS Recon - Beginning Amass scan of #{domain}")
      if passive
        args = ["enum", "-passive", "-d", "#{domain}", "-json", "#{domain}.json"]
      else
        args = ["enum", "-active", "-d", "#{domain}", "-ip", "-json", "#{domain}.json"]
      end
      
      status, output = CommandRunner.run("amass", args) 
      if status
        puts("INFO - DNS Recon - Completed Amass scan of #{domain}")
        puts(output)
      else
        puts("ERROR - DNS Recon - Failed Amass scan of #{domain}")
        puts(output)
      end
  
    end
  
end