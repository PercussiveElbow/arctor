- shodan = host.shodan_info
- if shodan
    h4 Basic Information
    table
        tr 
            th Open ports
            td 
                ul.tags
                    - ports = shodan.ports
                    - if ports 
                        - ports.sort.each do | port |
                            span.badge.badge-pill.badge-info = port

        tr 
            th Operating System
            td = shodan.os
        tr 
            th Tags
            td 
                ul.tags
                    - tags = shodan.tags
                    - if tags 
                        - tags.each do | tag |
                            li.tag.tag-rounded = tag
        tr
            th Last seen
            td = shodan.last_update
    h6 Hostnames
    table
        tr 
            th Organisation
            td = shodan.org 
        tr
            th Domains
            td 
                ul.tags
                    - domains = shodan.domains
                    - if domains 
                        - domains.each do | domain |
                            li.tag.tag-rounded = domain
        tr 
            th Hostnames 
            td 
                ul.tags
                    - hostnames = shodan.hostnames
                    - if hostnames 
                        - hostnames.each do | hostname |
                            li.tag.tag-rounded = hostname
    h6 Location
    table
        tr
            th Country
            td = shodan.country_name
        tr
            th City
            td = shodan.city
        tr
            th Postal Code
            td = shodan.postal_code
        tr
            th Latitude
            td = shodan.latitude
        tr
            th Longitude
            td = shodan.longitude
    br
    h4 Services
    .row.justify-content-md-left
        .container
            - services = shodan.shodan_services
            - services.each do | service |
                    .row.justify-content-md-left
                        .card
                            h5 = service.port
                            table 
                                tr
                                    th Product 
                                    td = service.product 
                                tr
                                    th Version 
                                    td = service.version 
                                tr
                                    th CPE
                                    td = service.cpes
                                tr 
                                    th Banner
                                    td = service.banner 
                                tr
                                    th OS 
                                    td = service.os
                            - http = service.shodan_http_service
                            - if http 
                                h5 HTTP Service
                                table
                                    tr
                                        th Title
                                        td = http.title
                                    tr
                                        th Server
                                        td = http.server
                                        tr
                                        th Host
                                        td = http.host
                                    tr
                                        th Location
                                        td = http.location
                                    tr
                                        th Robot.txt
                                        td = http.robots
                                        td = http.robots_hash
                                    tr
                                        th Sitemap
                                        td = http.sitemap 
                                        td = http.sitemap_hash
                                    tr 
                                        th Security.txt 
                                        td = http.securitytxt 
                                        td = http.securitytxt_hash
                                        tr 
                                        th HTML 
                                        td = http.html 