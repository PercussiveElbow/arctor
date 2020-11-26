require "../jobs/dns_enum_job"

class ScansController < ApplicationController
    def index
      scans = Scan.all
      scan_created = false
      render("scans.slang")
    end

    def start
      scan_created = false
      stages = [] of String

      if params && params[:domain]
        domain = params[:domain]
        scan_type = "passive"

        accepted_stages = ["dns_passive","dns_active","shodan","subjack","pushover","portscan","flyover"]
        params_hash = params.to_unsafe_h
        params_hash.keys().each do |key|
          if accepted_stages.includes?(key)
            stages << key
          end
        end
        
        this_scan = Scan.create(scan_status: "Created", stages: stages,target_query: domain)
        this_scan_id = this_scan.id
        if this_scan_id
          db_domain_found = Domain.find_by(fqdn: domain)
          if !db_domain_found
            puts("Creating new domain in DB #{domain}")
            new_domain = Domain.create(fqdn: domain)
            if new_domain
              domain_id = new_domain.id
            end
          else
            domain_id = db_domain_found.id
            puts("Existing domain #{domain} found in DB")
          end

          puts("Queueing #{scan_type} DNS enumeration job.")
          if domain_id 
            DNSEnumJob.new(scan_id: this_scan_id, domain: domain, domain_id: domain_id, scan_type: scan_type).enqueue
            scan_created = true
          end
        end
      end
      scans = Scan.all
      render("scans.slang") 
    end

end  