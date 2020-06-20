- shodan = host.shodan_info
- if shodan
    h6 Basic Information
    table
        tr 
            th Open ports
            th 
                ul.tags
                    - ports = shodan.ports
                    - if ports 
                        - ports.each do | port |
                            li.tag.tag-green.tag-rounded = port

        tr 
            th Operating System
            th = shodan.os
        tr 
            th Tags
            th 
                ul.tags
                    - tags = shodan.tags
                    - if tags 
                        - tags.each do | tag |
                            li.tag.tag-rounded = tag
        tr
            th Last seen
            th = shodan.last_update
    h6 Hostnames
    table
        tr 
            th Organisation
            th = shodan.org 
        tr
            th Domains
            th 
                ul.tags
                    - domains = shodan.domains
                    - if domains 
                        - domains.each do | domain |
                            li.tag.tag-rounded = domain
        tr 
            th Hostnames 
            th 
                ul.tags
                    - hostnames = shodan.hostnames
                    - if hostnames 
                        - hostnames.each do | hostname |
                            li.tag.tag-rounded = hostname
    h6 Location
    table
        tr
            th Country
            th = shodan.country_name
        tr
            th City
            th = shodan.city
        tr
            th Postal Code
            th = shodan.postal_code
        tr
            th Latitude
            th = shodan.latitude
        tr
            th Longitude
            th = shodan.longitude
    h6 Services
    .row
        - services = shodan.shodan_services
        - services.each do | service |
                .col.col-lg-6
                    .card 
                        h6 Port 
                            = service.port
                        table 
                            tr
                                th Product 
                                th = service.product 
                            tr
                                th Version 
                                th = service.version 
                            tr
                                th CPE
                                th = service.cpes
                            tr 
                                th Banner
                                th = service.banner 
                            tr
                                th OS 
                                th = service.os
