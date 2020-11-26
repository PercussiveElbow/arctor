require "../generic_runner"
require "random"

class SubJackRunner < GenericRunner

    def initialize(@scan_id : Int64, @subdomain : String, @subdomain_id : Int64)

    end

    def run()
        self.runner_log_info("Subdomain Takeover - Subjack - Beginning Subjack scan of #{@subdomain}")

        filename = "/tmp/arctor-#{Random::Secure.hex}.json"
        self.runner_log_info("Subdomain Takeover - Subjack - Filename #{filename}")
        args = ["-d", "#{@subdomain}", "-o", "#{filename}"]
        
        status, output = CommandRunner.run("/home/am/go/bin/subjack", args) #CHANGEME
        if status
            self.runner_log_info("Subdomain Takeover - Subjack - Completed Subjack scan of #{@subdomain}")
            puts(output)
            parse_file(filename)
        else
            self.runner_log_error("Subdomain Takeover - Subjack - Failed Subjack scan of #{@subdomain}")
        end
    end

    def parse_file(filename : String)
        self.runner_log_info("Subdomain Takeover - Subjack - Retrieving from #{filename}")
  
        if File.exists?(filename)
          file_content = File.read(filename)
          puts(file_content)
        else
            self.runner_log_info("No subjack data found for #{@subdomain} at #{filename}")
        end
    end
end