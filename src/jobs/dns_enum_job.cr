require "./runners/dns/*"
require "./runners/utils/*"

class DNSEnumJob < Mosquito::QueuedJob
    params(scan_id : Int64, domain_id : Int64, domain : String, scan_type : String)
    
    def perform
      puts("ALERT - Recieved job - #{domain}")
      if domain
        if scan_type == "passive"
            passive_dns_scan(domain,domain_id)
        elsif scan_type == "active"
            active_dns_scan(domain,domain_id)
        end
      end

      scan = Scan.find(scan_id)
      if scan
        stages = scan.stages
        if stages
          if stages.includes?("pushover")
            puts("INFO - DNS Recon - Alerting Pushover that scan finished.")
            AlertRunner.pushover("DNS recon finished for #{domain}")
          end
        end
      end
    end

    def passive_dns_scan(domain : String, domain_id : Int64)
      puts("INFO - DNS Recon - Beginning passive DNS recon of #{domain}")
      crobat_runner = CrobatRunner.new(scan_id,domain,domain_id)
      crobat_runner.run()
      amass_runner = AmassRunner.new(scan_id, domain,domain_id)
      amass_runner.run(true)
    end

    def active_dns_scan(domain : String, domain_id : Int64)
      puts("INFO - DNS Recon - Beginning active DNS recon of #{domain}")
      amass_runner = AmassRunner.new(scan_id, domain,domain_id)
      amass_runner.run(false)
    end

end

