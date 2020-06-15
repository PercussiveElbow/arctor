require "crobat/crobat_sdk"
require "./runners/*"

class ScansJob < Mosquito::QueuedJob
    params(scan_id : Int64, domain : String, scan_type : String)
    
    def perform
      puts("ALERT - Recieved job - #{domain}")
      if domain
        if scan_type == "passive"
            passive_dns_scan(domain)
        elsif scan_type == "active"
            active_dns_scan(domain)
        end
      end
    end

    def passive_dns_scan(domain : String)
      puts("INFO - DNS Recon - Beginning passive DNS recon of #{domain}")
      amass_runner = AmassRunner.new(domain)
      amass_runner.run(true)
      CrobatRunner.run(domain)
    end

    def active_dns_scan(domain : String)
      puts("INFO - DNS Recon - Beginning active DNS recon of #{domain}")
      amass_runner = AmassRunner.new(domain)
      amass_runner.run(false)
    end

end

