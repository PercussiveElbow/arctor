
div.row
    div.col.col-lg-12
        h1 Subdomain
            = subdomain.fqdn

div.row
    .col.col-lg-1
        div.sidebar.sidebar-left 
            h3.sidebar-category Hosts
            ul.sidebar-links
                - hosts.each do | host|
                    - if host.ipv4
                        li.a href="" = host.ipv4
                    - if host.ipv6
                        li.a href="" = host.ipv6

    .col.col-lg-10
        h3 Screenshots
        - screenshots.each do | screenshot |
            h4 =="Port #{screenshot.port.to_s}"
            img src=="data:image/jpeg;base64, #{screenshot.image}"

        - hosts.each do | host|
            h3 = host.ipv4

            div.col.col-lg-6.float-right
            img src="/dist/images/shodan.png"
            div id=host.ipv4
                == render(partial: "shodan.slang")
