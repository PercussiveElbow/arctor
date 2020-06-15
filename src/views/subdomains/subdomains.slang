h1 Subdomain 
- subdomain
table 
    tr 
        th Host
        th ipv4
    - hosts.each do | host|
        tr
           td 
                a href="./#{host.ipv4}/" #{host.ipv4} 
            td 
                - host.ipv4 
