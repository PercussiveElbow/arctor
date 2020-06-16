require "shodan/shodan"

class ShodanRunner < GenericRunner

    def initialize(@host : String)
    end

    def run(passive : Bool)
      puts("INFO - DNS Recon - Amass - Beginning Shodan recon of #{@host}")
      shodan_api = Shodan::Client.new("KEY_KEY_KEY_KEY")

      begin
        host_info = shodan_api.host(@host)
        if host_info
            host_info_data = host_info.data 
            if host_info_data
                host_info_data.each do | data | 
                    # puts(data)
                end
            end
        end
      rescue ex : Shodan::Client::ShodanAPIException
        puts(ex)
      end      
    
    end

    def insert_host_data(host : String)
    end
end