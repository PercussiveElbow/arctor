require "../generic_runner"
require "random"
require "xml"


class PortScanRunner < GenericRunner

    def initialize(@scan_id : Int64, @host : String, @host_id : Int64)

    end

    def run()
        self.runner_log_info("PORTSCAN - Beginning port scan of #{@host}")

        filename = "/tmp/arctor-#{Random::Secure.hex}"
        self.runner_log_info("PORTSCAN - Filename #{filename}")
        args = ["-T","4", "-p-", "-oA", "#{filename}","127.0.0.1"]
        filename = "#{filename}.xml"
        
        status, output = CommandRunner.run("/usr/bin/nmap", args) #CHANGEME
        if status
            self.runner_log_info("PORTSCAN - Completed port scan of #{@host}")
            puts(output)
            parse_file(filename)
        else
            self.runner_log_error("PORTSCAN - Failed port scan of #{@host}")
        end
    end

    def parse_file(filename : String)
        self.runner_log_info("PORTSCAN - Retrieving from #{filename}")
  
        if File.exists?(filename)
            file_content = File.read(filename)
            puts(file_content)
            doc = XML.parse(file_content)
            ports = doc.xpath_nodes("//port")
            
            open_ports = [] of Int32
            open_services = [] of String
            
            if ports && ports.is_a?(XML::NodeSet)
                ports.each do | port |
                    state = port.xpath_node("//state")
            
                    if state && state["state"] == "open"
                        children = port.children
            
                        if children
                            children.each do | child |
                                if child.name == "state" && child["state"] == "open"
                                    open_ports << port["portid"].to_i
                                end
                                open_services << port["portid"] + " - " +  child["name"] if child.name == "service"
                            end
                        end
                    end
                end
            end
            
            self.runner_log_error("PORTSCAN - #{@host} - #{open_ports.to_s}")
            self.runner_log_error("PORTSCAN - #{@host} - #{open_services.to_s}")
            insert_results(open_ports,open_services)
        else
            self.runner_log_info("PORTSCAN - No port scan data found for #{@host} at #{filename}")
        end
    end

    def insert_results(open_ports : Array(Int32), open_services : Array(String))
        self.runner_log_info("PORTSCAN - Inserting port scan results into DB  for #{@host}")
        PortScan.create(host_id: @host_id, ports: open_ports, services: open_services)
    end

end