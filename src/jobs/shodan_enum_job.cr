require "./runners/shodan/*"
require "./runners/generic_runner"

class ShodanEnumJob < Mosquito::QueuedJob
    params(scan_id : Int64, host_id : Int64, host : String)
    
    def perform
      puts("SHODAN - Recieved Shodan job - #{host}")
      if host
        scan_type = "passive"
        if scan_type == "passive"
            passive_shodan_scan(host,host_id)
        elsif scan_type == "active"
            active_shodan_scan(host,host_id)
        end
      end
    end

    def passive_shodan_scan(host : String,host_id : Int64)
      puts("SHODAN - Passive Shodan Recon - Beginning passive Shodan recon of #{host} associated with #{host_id}")
      shodan_runner = ShodanRunner.new(host,host_id)
      shodan_runner.run(true)
    end

    def active_shodan_scan(host : String,host_id : Int64)
      puts("SHODAN - Beginning active Shodan recon of #{host} associated with #{host_id}")
      shodan_runner = ShodanRunner.new(host,host_id)
      shodan_runner.run(false)
    end

end

