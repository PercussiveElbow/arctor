
div.row
    div.col.col-lg-12
        h1 Hosts of 
            = subdomain.fqdn

div.row
    .col.col-lg-3
        div.sidebar.sidebar-left 
            h3.sidebar-category Hosts
            ul.sidebar-links
                - hosts.each do | host|
                    - if host.ipv4
                        li.a href="" = host.ipv4
                    - if host.ipv6
                        li.a href="" = host.ipv6

    .col.col-lg-9
        - hosts.each do | host|
            h3 = host.ipv4

            div.col.col-lg-6.float-right
            img src="/dist/images/shodan.png"
            .card
                == render(partial: "shodan.slang")
