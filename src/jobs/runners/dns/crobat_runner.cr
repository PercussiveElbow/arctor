require "../generic_runner"
require "./dns_inserter_runner"
require "crobat/crobat_sdk"
require "dns"

class CrobatRunner

  def initialize(@domain : String, @domain_id : Int64)
  end

  def run()
    client = Crobat::CrobatSDK.new("https://sonar.omnisint.io")
    puts("INFO - DNS Recon - Beginning passive Crobat scan of #{@domain}")
    subdomains = client.retrieve_subdomains(@domain)

    subdomains.each do | subdomain | 
      puts(subdomain)
    end
    subdomains_with_ips = resolve_subdomain(subdomains)
  end
  
  
  def resolve_subdomain(subdomains : Array(String))
    subdomains_with_ips = [] of Array(String)
    resolver = DNS::Resolver.new


    subdomains.each do | subdomain |
      begin
        puts("Resolving #{subdomain}")
        response = resolver.query(subdomain, DNS::RecordType::A)
        response.answers.each do |answer|
          puts "got ipv4 address #{answer.data}"
          DNSInserter.insert_subdomain(domain_id: @domain_id, subdomain: subdomain, ipv4: [answer.data.to_s],source: "Crobat")

        end
        response = resolver.query(subdomain, DNS::RecordType::AAAA)
        response.answers.each do |answer|
          puts "got ipv6 address #{answer.data}"
          DNSInserter.insert_subdomain(domain_id: @domain_id , subdomain: subdomain, ipv6: [answer.data.to_s], source: "Crobat")
        end
      rescue IO::TimeoutError

      end
    end
    resolver.close
    subdomains_with_ips
  end
  
end
  