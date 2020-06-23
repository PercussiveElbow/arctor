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
    subdomains_with_ips = DNSInserter.resolve_subdomain(domain_id,subdomains,"Crobat")
  end
  
end
  