require "./runners/utils/*"
require "./runners/subdomain_takeover/*"

class SubDomainTakeoverJob < Mosquito::QueuedJob
    params(scan_id : Int64, subdomain : String, subdomain_id : Int64)
    
    def perform
      puts("ALERT - Recieved Subdomain takeover job - #{subdomain}")
      if subdomain && subdomain_id
        SubJackRunner.new(scan_id, subdomain, subdomain_id).run()
      end
    end

end

