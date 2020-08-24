h1 Scans

- if scan_created
    p.alert.alert-success Scan created

table 
    tr
        th Scan ID
        th Status
        th User 
        th Target
        th Stages
        th Error Message 
        th Timestamp
    - scans.each do |scan|
        tr
            td = scan.id
            td = scan.scan_status
            td User
            td = scan.target_query
            td 
                ul.tags
                    - stages = scan.stages
                    - if stages 
                        - stages.each do | stage |
                            li.tag.tag-green.tag-rounded = stage
            td = scan.error_reason
            td = scan.created_at

.col.col-lg-6
    .card
        h4 New Scan.
        form method="post"
            fieldset
                    fieldset
                        legend Domain Recon (Required)
                        div.form-control
                            label.label-inline Domain
                            input.text name="domain" id="domain"
                        div.form-control
                            label.label-inline Active
                            input type="checkbox" id="dns_active" name="dns_active" value="true"
                            label.label-inline Passive
                            input type="checkbox" id="dns_passive" name="dns_passive" value="true"
                    fieldset
                        legend OSINT Sources
                        div.form-control 
                            label.label-inline Shodan
                            input type="checkbox" id="shodan" name="shodan" value="true"
                            label.label-inline Other
                            input type="checkbox" id="other" name="other" value="true"
                    fieldset
                        legend Subdomain Takeover
                        div.form-control 
                            label.label-inline Subjack
                            input type="checkbox" id="subjack" name="subjack" value="true"

                    fieldset
                        legend Service Identification
                        div.form-control 
                            label.label-inline Port Scanning
                            input type="checkbox" id="portscan" name="portscan" value="true"
                            label.label-inline Domain flyover
                            input type="checkbox" id="flyover" name="flyover" value="true"
                    fieldset
                        legend Alerting
                        div.form-control 
                            label.label-inline Pushover
                            input type="checkbox" id="pushover" name="pushover" value="true"

                    == csrf_tag
                    input.button-primary.button-round type="submit" action="/scans" value="Scan"