
class DNSInserter
    def self.insert_subdomain(domain_id : Int64, subdomain : String, ipv4 : Array(String) = [] of String, ipv6 : Array(String) = [] of String, source : String = "")
        subdomain_id = self.insert_subdomain_if_not_already_exists(domain_id,subdomain,ipv4,ipv6,source)

        if subdomain_id

            if ipv6 && ipv6.size() > 0
                ipv6.each do | ip |
                    existing_host = Host.find_by(ipv6: ip)
                    if existing_host
                        puts("INFO - DNS Recon - Host #{ip.to_s} already present in DB. Linking..")
                        link = SubDomainHostLink.create(host_id: existing_host.id, sub_domain_id: subdomain_id)
                    else
                        host = Host.create(ipv6: ip)
                        if host
                            host_id = host.id
                            if host_id
                                puts("INFO - DNS Recon - Created host #{host_id} in database")
                                puts("INFO - DNS Recon - Queueing Shodan recon for #{ip}")
                                ShodanEnumJob.new(scan_id: 1, host: ip, host_id: host_id, scan_type: "passive").enqueue
                            end
                        end
                        link = SubDomainHostLink.create(host_id: host.id, sub_domain_id: subdomain_id)
                    end
                end
            end

            if ipv4 && ipv4.size() > 0
                ipv4.each do |ip | 
                    existing_host = Host.find_by(ipv4: ip)
                    if existing_host
                        puts("INFO - DNS Recon - Host #{ip.to_s} already present in DB. Linking..")
                        link = SubDomainHostLink.create(host_id: existing_host.id, sub_domain_id: subdomain_id)
                    else
                        host = Host.create(ipv4: ip)
                        if host
                            host_id = host.id
                            if host_id
                                puts("INFO - DNS Recon - Created host #{host_id} in database")
                                puts("INFO - DNS Recon - Queueing Shodan recon for #{ip}")
                                ShodanEnumJob.new(scan_id: 1, host: ip, host_id: host_id, scan_type: "passive").enqueue
                            end
                        end
                        link = SubDomainHostLink.create(host_id: host.id, sub_domain_id: subdomain_id)
                    end        
                end            
            end
        end
    end

    def self.insert_subdomain_if_not_already_exists(domain_id : Int64, subdomain : String, ipv4 : Array(String) = [] of String, ipv6 : Array(String) = [] of String, source : String = "")
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
                subdomain_obj = SubDomain.create(domain_id: domain_id, fqdn: subdomain, a: ipv4,  source: source)
            end
            if ipv6 && ipv6.size() > 0
                subdomain_obj = SubDomain.create(domain_id: domain_id, fqdn: subdomain, aaaa: ipv6, source: source)
            end
            puts("INFO - DNS Recon - Loaded subdomain #{subdomain} into database")
            if subdomain_obj
                return subdomain_obj.id
            end
        end
        raise Exception.new("Unable to insert subdomain #{subdomain}")
    end

    def self.resolve_subdomain(domain_id, subdomains : Array(String),source)
        subdomains_with_ips = [] of Array(String)
        resolver = DNS::Resolver.new
    
    
        subdomains.each do | subdomain |
          begin
            puts("Resolving #{subdomain}")
            response = resolver.query(subdomain, DNS::RecordType::A)
            response.answers.each do |answer|
              puts "got ipv4 address #{answer.data}"
              self.insert_subdomain(domain_id: domain_id, subdomain: subdomain, ipv4: [answer.data.to_s],source: source)
    
            end
            response = resolver.query(subdomain, DNS::RecordType::AAAA)
            response.answers.each do |answer|
              puts "got ipv6 address #{answer.data}"
              self.insert_subdomain(domain_id: domain_id , subdomain: subdomain, ipv6: [answer.data.to_s], source: source)
            end
          rescue IO::TimeoutError
    
          end
        end
        resolver.close
        subdomains_with_ips
      end
end