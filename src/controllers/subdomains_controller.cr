require "../jobs/scans_job"

class SubDomainsController < ApplicationController
    
    def get
      domain = Domain.find_by(fqdn: params[:domain])
      if domain && domain.id
        subdomain = SubDomain.find_by(domain_id: domain.id,fqdn: params[:subdomain])
        if subdomain
          hosts = subdomain.hosts


          render("subdomains.slang")
        end
      end
    end

end  