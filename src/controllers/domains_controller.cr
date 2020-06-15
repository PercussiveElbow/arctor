require "../jobs/scans_job"

class DomainsController < ApplicationController
    def index
      domains = Domain.all

      domains_with_count = []  of Hash(String,String)

      domains.each do | domain |
        puts(domain.fqdn)
        subs = domain.subdomains
        puts(subs.size())
      #  subs =  SubDomain.where(domain_id: domain.id)
      #   if subs
      #     length = subs.size()
      #   end 

      end
      
      render("domains.slang")
    end

    def get
      domain = Domain.find_by(fqdn: params[:domain])
      if domain && domain.id
        subdomains = SubDomain.where(domain_id: domain.id)
      end
      if subdomains && domain
        render("subdomains.slang")
      end
    end

end  