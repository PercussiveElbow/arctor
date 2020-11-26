require "../generic_runner"
require "./dns_inserter_runner"
require "crobat/crobat_sdk"
require "dns"

class CrobatRunner < GenericRunner

  def initialize(@scan_id : Int64, @domain : String, @domain_id : Int64)
    @dns_inserter = DNSInserter.new(@scan_id, @domain_id)
  end

  def run()
    client = Crobat::CrobatSDK.new("https://sonar.omnisint.io")
    self.runner_log_info("DNS Recon - Beginning passive Crobat scan of #{@domain}")
    subdomains = client.retrieve_subdomains(@domain)
    subdomains.each do | subdomain | 
      puts(subdomain)
    end
    subdomains_with_ips = @dns_inserter.resolve_and_insert_subdomains(subdomains,"Crobat")
  end
  
end
  