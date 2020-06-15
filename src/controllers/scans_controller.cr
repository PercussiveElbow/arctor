require "../jobs/scans_job"

class ScansController < ApplicationController
    def index
      scans = Scan.all
      render("scans.slang")
    end

    def start
      puts(params)
      if params[:domain]
        domain = params[:domain]
        scan_type = "passive"

        if params && params.to_unsafe_h.has_key?("active")
          scan_type = "active"
        end

        this_scan = Scan.create(status: "Created")
        this_scan.save
        this_scan_id = this_scan.id
        if this_scan_id
          db_domain_found = Domain.find_by(fqdn: domain)

          if !db_domain_found
            puts("Creating new domain in DB #{domain}")
            new_domain = Domain.create(fqdn: domain)
            new_domain.save
          else
            puts("Existing domain #{domain} found in DB")
          end
          puts("Starting scan job")
          ScansJob.new(scan_id: this_scan_id, domain: domain, scan_type: scan_type).enqueue
        end
      end
      #render("scans.slang") 
    end

end  