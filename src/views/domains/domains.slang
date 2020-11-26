h1 Domains
table class="table table-borderless" 
    thead
        tr 
            th Domains
            th Subdomain Count
    tbody
    - domains.each do |domain|
        tr
           td 
                a href="#{domain.fqdn}/" #{domain.fqdn} 
            td 
                = domain.subdomains.size() 
                