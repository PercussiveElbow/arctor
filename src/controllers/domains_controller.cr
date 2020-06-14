require "../jobs/scans_job"

class DomainsController < ApplicationController
    def index
      render("index.slang")
    end

end  