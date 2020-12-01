require "./runners/utils/*"
require "./runners/subdomain_takeover/*"
require "./runners/generic_runner"

class SubDomainTakeoverJob < Mosquito::QueuedJob
    params(scan_id : Int64, subdomain : String, subdomain_id : Int64)
    
    def perform
      puts("TAKEOVER - Recieved Subdomain takeover job - #{subdomain}")
      if subdomain && subdomain_id
        SubJackRunner.new(scan_id, subdomain, subdomain_id).run()
      end
    end

end

