require "./runners/utils/*"
require "./runners/flyover/*"
require "./runners/generic_runner"

class SubDomainFlyoverJob < Mosquito::QueuedJob
    params(scan_id : Int64, subdomain : String, subdomain_id : Int64)
    
    def perform
      puts("FLYOVER - Recieved Subdomain flyover job - #{subdomain}")
      if subdomain && subdomain_id
        FlyoverRunner.new(scan_id, subdomain, subdomain_id).run()
      end
    end

end

