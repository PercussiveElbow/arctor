class ShodanServiceHTTP < Granite::Base
    connection pg
    table shodan_http_service
    belongs_to :shodan_service
    column id : Int64, primary: true

    #column html : String?
    column html_hash : Int64?
    # securitytxt
    column securitytxt : String?
    column securitytxt_hash : Int64?
    #robots
    column robots : String?
    column robots_hash : Int64?
    # sitemaps
    column sitemap : String? 
    column sitemap_hash : Int64?
    # location and redirect
    column location : String? 
    #column redirects : Array(HostDataHTTPRedirects)?
    # other details
    column server : String?
    column title : String?
    #property favicon : HostDataHTTPFavicon? 


    timestamps
  end
  