require "./runners/port_scan/*"
require "./runners/utils/*"
require "./runners/generic_runner"

class PortScanJob < Mosquito::QueuedJob
    params(scan_id : Int64, host_id : Int64, host : String)
    
    def perform
        puts("PORTSCAN - Recieved port scan job - #{host}")
        port_scan(scan_id, host, host_id) if host
    end

    def port_scan(scan_id : Int64, host : String, host_id : Int64)
        puts("PORTSCAN - Passive Shodan Recon - Beginning passive Shodan recon of #{host} associated with #{host_id}")
        shodan_runner = PortScanRunner.new(scan_id,host,host_id)
        shodan_runner.run()
    end

end

