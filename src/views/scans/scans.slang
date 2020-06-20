h1 Scans

- if scan_created
    p.alert.alert-success Scan created

table 
    tr
        th Scan ID
        th Status 
        th Error Message 
        th Timestamp
    - scans.each do |scan|
        tr
            td = scan.id
            td = scan.scan_status
            td = scan.error_reason
            td = scan.created_at

h4 New Scan.
.col.col-lg-3 
    form method="post"
        fieldset
                fieldset
                    legend Domain (Required)
                    div.form-control
                        label.label-inline Domain
                        input.text name="domain" id="domain"
                    div.form-control
                        label.label-inline Active
                        input type="radio" id="active" name="active" value="true"
                        label.label-inline Passive
                        input type="radio" id="passive" name="passive" value="true"
                fieldset
                    legend OSINT Sources
                    div.form-control 
                        label.label-inline Shodan
                        input type="checkbox" id="shodan" name="shodan" value="true"
                        label.label-inline Other
                        input type="checkbox" id="other" name="other" value="true"
                fieldset
                    legend Service Identification
                    div.form-control 
                        label.label-inline Port Scanning
                        input type="checkbox" id="portscan" name="portscan" value="true"
                        label.label-inline Domain flyover
                        input type="checkbox" id="flyover" name="flyover" value="true"

                == csrf_tag
                input.button-primary.button-round.float-right type="submit" action="/scans" value="Scan"