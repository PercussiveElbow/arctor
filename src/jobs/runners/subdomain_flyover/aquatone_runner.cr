require "../generic_runner"
require "random"

class AquatoneRunner < GenericRunner

    def initialize(@scan_id : Int64, @subdomain : String, @subdomain_id : Int64)

    end

    def run()
        puts("INFO - Subdomain Flyover - Aquatone - Beginning Aquatone scan of #{@subdomain}")

        dirname = "/tmp/arctor-#{Random::Secure.hex}"
        puts("INFO - Subdomain Flyover - Aquatone - Directory #{dirname}")
        args = ["-out", "#{dirname}", "--chrome-path", "/usr/bin/google-chrome"]
        
        status, output = CommandRunner.run("/bin/aquatone", args, @subdomain) #CHANGEME
        if status
            puts("INFO - Subdomain Takeover - Aquatone - Completed Aquatone scan of #{@subdomain}")
            puts(output)

            if Dir.exists?(dirname)
                if File.exists?(dirname + "aquatone_session")
                        file_content = File.read(dirname + "aquatone_session")
                        puts(file_content)
                end
            end
        else
          puts("ERROR - Subdomain Takeover - Aquatone - Failed Aquatone scan of #{@subdomain}")
        end
    end
end