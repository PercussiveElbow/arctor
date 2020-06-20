h1 Domains
table 
    tr 
        th Domains
        th Subdomain Count
    - domains.each do |domain|
        tr
           td 
                a href="#{domain.fqdn}/" #{domain.fqdn} 
            td 
                = domain.subdomains.size() 
                