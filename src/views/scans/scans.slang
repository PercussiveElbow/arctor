h1 Scans

h4 New Scan.
form method="post"
    fieldset
        label Domain
        input.text name="domain" id="domain"
        label.label-inline Active Scan?
        input type="checkbox" id="active" name="active" value="true"
        == csrf_tag
        input.button-primary type="submit" action="/scans"
 
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