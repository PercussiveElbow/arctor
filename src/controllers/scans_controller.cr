require "../jobs/scans_job"

class ScansController < ApplicationController
    def index
      render("index.slang")
    end

    def start
      if params[:domain]
        domain = params[:domain]

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
          ScansJob.new(scan_id: this_scan_id, domain: domain, scan_type: "passive").enqueue
        end
      end
      render("index.slang") 
    end

end  