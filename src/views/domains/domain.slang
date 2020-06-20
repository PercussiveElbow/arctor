h1 = domain.fqdn

h3 Analytics
h6 Statistics

.card
    table
        tr 
            th Unique host count
            th = unique_hosts.size()
        tr
            th Unique subdomain count
            th = domain.subdomains.size()
        tr
            th Known hijackable subdomains 
            th 0

h6 Open ports
.card 
    .ct-chart

javascript:
    new Chartist.Bar('.ct-chart', {
    labels: #{port_labels},
    series: #{port_series}
    }, {
    distributeSeries: true
    });

h3 Subdomains of 
    = domain.fqdn

.card
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
                a href="./subdomain/#{subdomain.fqdn}/" #{subdomain.fqdn}
            td
                - a_records = subdomain.a
                - if a_records
                    - a_records.each do | a |
                        p = a
            td
                - aaaa_records = subdomain.aaaa
                - if aaaa_records
                    - aaaa_records.each do | aaaa |
                        - puts(aaaa)
                        p = aaaa
            td = subdomain.mx
            td = subdomain.ns
            td = subdomain.source