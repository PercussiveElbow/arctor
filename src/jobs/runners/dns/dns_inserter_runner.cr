require "../../subdomain_takeover_job" 
require "../../subdomain_flyover_job" 
require "../../portscan_job" 
require "../generic_runner"

class DNSInserter < GenericRunner

    def initialize(@scan_id : Int64, @domain_id : Int64)
    end

    def insert_subdomain_with_host_data(subdomain : String, ipv4 : Array(String) = [] of String, ipv6 : Array(String) = [] of String, source : String = "")
        subdomain_id = self.insert_subdomain_if_not_already_exists(subdomain,ipv4,ipv6,source)
        if subdomain_id
            self.insert_hosts(subdomain_id,ipv4,true)
            self.insert_hosts(subdomain_id,ipv6,false)
        end
    end

    def insert_hosts(subdomain_id : Int64, ips : Array(String),ipv4 : Bool)
        if ips && ips.size() > 0
            ips.each do |ip | 
                existing_host = ipv4 ? Host.find_by(ipv4: ip) : Host.find_by(ipv6: ip)
                if existing_host
                    link = SubDomainHostLink.create(host_id: existing_host.id, sub_domain_id: subdomain_id)
                    self.runner_log_info("DNS Recon - Host #{ip.to_s} already present in DB. Linked.")
                else
                    host = Host.create(ipv4: ip)
                    self.runner_log_info("DNS Recon - Created host #{host.id.to_s} with IP #{ip.to_s} in database")
                    host_id = host.id if host
                    self.start_relevant_host_scans(ip,host_id) if host_id
                    link = SubDomainHostLink.create(host_id: host_id, sub_domain_id: subdomain_id)
                end        
            end            
        end
    end


    def valid_ip4?(ip : String)
        return ip.match(/^((25[0-5]|(2[0-4]|1[0-9]|[1-9]|)[0-9])(\.(?!$)|$)){4}$/)
    end

    def not_private_ip?(ip : String)
        return !ip.match(/(^127\.)|(^192\.168\.)|(^10\.)|(^172\.1[6-9]\.)|(^172\.2[0-9]\.)|(^172\.3[0-1]\.)|(^::1$)|(^[fF][cCdD])/)
    end


    def valid_ipv6?(ip : String)
        1 # stub
    end

    def insert_subdomain_if_not_already_exists(subdomain : String, ipv4 : Array(String) = [] of String, ipv6 : Array(String) = [] of String, source : String = "")
        existing = SubDomain.find_by(fqdn: subdomain)
        if existing
            existing_a = existing.a
            if existing_a
                merged =  existing_a | ipv4
                existing.a = merged 
            end
            existing_aaaa = existing.aaaa
            if existing_aaaa
                merged = existing_aaaa | ipv6
                existing.aaaa = merged
            end
            existing.save 
            return existing.id
        else
            if ipv4 && ipv4.size() > 0
                subdomain_obj = SubDomain.create(domain_id: @domain_id, fqdn: subdomain, a: ipv4,  source: source)
                subdomain_id = subdomain_obj.id
                self.start_relevant_subdomain_scans(subdomain, subdomain_id) if subdomain_id
            end
            if ipv6 && ipv6.size() > 0
                subdomain_obj = SubDomain.create(domain_id: @domain_id, fqdn: subdomain, aaaa: ipv6, source: source)
                subdomain_id = subdomain_obj.id
                self.start_relevant_subdomain_scans(subdomain, subdomain_id) if subdomain_id
            end
            self.runner_log_info("DNS Recon - Loaded subdomain #{subdomain} into database")
            if subdomain_obj
                return subdomain_obj.id
            end
        end
        raise Exception.new("Unable to insert subdomain #{subdomain}")
    end

    def resolve_and_insert_subdomains(subdomains : Array(String),source)
        subdomains_with_ips = [] of Array(String)
        resolver = DNS::Resolver.new
    
        subdomains.each do | subdomain |
          begin
            self.runner_log_info("DNS Recon - Resolving #{subdomain}")
            response = resolver.query(subdomain, DNS::RecordType::A)
            response.answers.each do |answer|
                if valid_ip4?(answer.data.to_s) && not_private_ip?(answer.data.to_s)
                    self.insert_subdomain_with_host_data(subdomain: subdomain, ipv4: [answer.data.to_s],source: source)
                end
            end
            response = resolver.query(subdomain, DNS::RecordType::AAAA)
            response.answers.each do |answer|
              self.insert_subdomain_with_host_data(subdomain: subdomain, ipv6: [answer.data.to_s], source: source)
            end
          rescue IO::TimeoutError
          end
        end
        resolver.close
        subdomains_with_ips
      end


    # 
    # Defs to queue next jobs
    #
    def start_relevant_host_scans(host_ip : String, host_id : Int64)
        scan = Scan.find(@scan_id)
        if scan
            stages = scan.stages
            if stages
                if stages.includes?("shodan")
                    self.runner_log_info("DNS Recon - Queueing Shodan recon for #{host_ip}")
                    ShodanEnumJob.new(scan_id: @scan_id, host: host_ip, host_id: host_id).enqueue
                end
                if stages.includes?("portscan")
                    self.runner_log_info("DNS Recon - Queueing port scan for #{host_ip}")
                    PortScanJob.new(scan_id: @scan_id, host: host_ip, host_id: host_id).enqueue
                else
                    puts("Not port scanning")
                end
            end
        end
    end

    def start_relevant_subdomain_scans(subdomain : String, subdomain_id : Int64)
        scan = Scan.find(@scan_id)
        if scan 
            stages = scan.stages 
            if stages 
                if stages.includes?("flyover")
                        self.runner_log_info("DNS Recon - Queueing flyover recon for subdomain #{host_ip}")
                        SubDomainFlyoverJob.new(scan_id: @scan_id, subdomain: subdomain, subdomain_id: subdomain_id).enqueue
                end
            end
        end
    end

    def start_relevant_subdomain_scans(subdomain : String, subdomain_id : Int64)
        scan = Scan.find(@scan_id)
        if scan
            stages = scan.stages
            if stages
                if stages.includes?("subjack")
                    self.runner_log_info("DNS Recon - Queueing Subdomain Takeover job for #{subdomain}")
                    SubDomainTakeoverJob.new(@scan_id, subdomain, subdomain_id).enqueue
                end
                if stages.includes?("flyover")
                    self.runner_log_info("DNS Recon - Queueing Subdomain Flyover job for #{subdomain}")
                    SubDomainFlyoverJob.new(@scan_id, subdomain, subdomain_id).enqueue
                end
            end
        end
    end

end