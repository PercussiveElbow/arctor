require "./runners/shodan/*"

class ShodanEnumJob < Mosquito::QueuedJob
    params(scan_id : Int64, host : String, scan_type : String)
    
    def perform
      puts("ALERT - Recieved Shodan job - #{host}")
      if host
        if scan_type == "passive"
            passive_shodan_scan(host)
        elsif scan_type == "active"
            active_shodan_scan(host)
        end
      end
    end

    def passive_shodan_scan(host : String)
      puts("INFO - Passive Shodan Recon - Beginning passive Shodan recon of #{host}")
      shodan_runner = ShodanRunner.new(host)
      shodan_runner.run(true)
    end

    def active_shodan_scan(host : String)
      puts("INFO - DNS Recon - Beginning active Shodan recon of #{host}")
      shodan_runner = ShodanRunner.new(host)
      shodan_runner.run(false)
    end

end

