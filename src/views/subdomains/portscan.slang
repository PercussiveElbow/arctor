- port_scans = host.port_scans
- if port_scans
    - port_scans.each do | port_scan |
        - ports = port_scan.ports
        - if ports 
            - ports.sort.each do | port |
                span.badge.badge-pill.badge-light = port
        - services = port_scan.services
        - if services
            ul 
            - services.sort.each do | service |
                li ==service
    br
    br