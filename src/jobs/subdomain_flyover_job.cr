require "./runners/utils/*"
require "./runners/subdomain_flyover/*"

class SubDomainFlyoverJob < Mosquito::QueuedJob
    params(scan_id : Int64, subdomain : String, subdomain_id : Int64)
    
    def perform
      puts("ALERT - Recieved Subdomain flyover job - #{subdomain}")
      if subdomain && subdomain_id
        AquatoneRunner.new(scan_id, subdomain, subdomain_id).run()
      end
    end

end

