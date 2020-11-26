h1 Scans

- if scan_created
    p.alert.alert-success Scan created

table class="table table-borderless"
    thead 
        tr
            th Scan ID
            th Status
            th User 
            th Target
            th Stages
            th Error Message 
            th Timestamp
    tbody
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
                            span class="badge badge-pill badge-success" = stage
            td = scan.error_reason
            td = scan.created_at

h1 New Scan
.col.col-lg-6
        form method="post"
            div.form-group
                legend Domain recon
                label.label-inline Domain
                input.text name="domain" id="domain"
                div.form-check
                    input.form-check-input type="radio" id="dns_active" name="dns_recon" value="true"
                    label.form-check-label Active
                div.form-check
                    input.form-check-input type="radio" id="dns_passive" name="dns_recon" value="true"
                    label.form-check-label Passive
            div.form-group
                legend OSINT Sources
                div.form-check
                    label.label-inline Shodan
                    input type="checkbox" id="shodan" name="shodan" value="true"
                div.form-check
                    label.label-inline Other
                    input type="checkbox" id="other" name="other" value="true"
            div.form-group
                legend Subdomain Takeover
                div.form-check 
                    label.label-inline Subjack
                    input type="checkbox" id="subjack" name="subjack" value="true"

            div.form-group
                legend Service Identification
                div.form-check 
                    label.label-inline Port Scanning
                    input type="checkbox" id="portscan" name="portscan" value="true"
                div.form-check
                    label.label-inline Domain flyover
                    input type="checkbox" id="flyover" name="flyover" value="true"
            div.form-group
                legend Alerting
                div.form-check 
                    label.label-inline Pushover
                    input type="checkbox" id="pushover" name="pushover" value="true"

            == csrf_tag
            input.button.btn-success type="submit" action="/scans" value="Scan"