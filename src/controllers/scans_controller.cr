require "../jobs/scans_job"

class ScansController < ApplicationController
    def index
      render("index.slang")
    end

    def start
      if params[:domain]
        domain = params[:domain]
        ScansJob.new(scan_id: "123", domain: domain, scan_type: "passive").enqueue
      end
      render("index.slang") 
    end

end  