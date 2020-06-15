h1 Subdomains of 
    = domain.fqdn

table 
    tr
        th Subdomain
        th A 
        th AAAA 
        th MX
        th NS
        th Recon source
    - subdomains.each do |subdomain|
        tr
           td 
                a href="./subdomain/#{subdomain.fqdn}/" subdomain.fqdn
           td = subdomain.a
           td = subdomain.aaaa
           td = subdomain.mx
           td = subdomain.ns
           td = subdomain.source