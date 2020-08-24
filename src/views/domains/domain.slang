h1 = domain.fqdn

h3 Analytics
h6 Statistics

.card
    table
        tr 
            th Unique host count
            td = unique_hosts.size()
        tr
            th Unique subdomain count
            td = domain.subdomains.size()
        tr
            th Known hijackable subdomains 
            td 0

h6 Exposed ports
.card 
    .ct-chart

h6 Geographical Distribution
.card
    .row
        .col.col-lg-9
            .div.mapcontainer style="height: 400px;width: 100%;"
                .div id="leafletMap" style="height: 400px;width: 100%;"
        .col.col-lg-3
            h6 Top Countries by host count
                table
                    tr 
                        th Country
                        th Count 
                    - unique_countries.each do | country,count|
                        tr 
                            td = country 
                            td = count

h6 Subdomain host mapping
.card
    .row
        div id="cyto" style="width:100%; height:800px;"

.row
    .col.col-lg-6
        h6 Organisation count
        .card
            table
                tr
                    th Organisation name
                    th Count
                - unique_orgs.each do | org,count|
                    tr 
                        td = org 
                        td = count
    .col.col-lg-6
        h6 Other
        .card
            table
                tr
                    th Organisation name

h3 Subdomains of 
    = domain.fqdn

.card
    table 
        tr
            th Subdomain
            th Hijackable
            th A 
            th AAAA 
            th MX
            th NS
            th Recon source
        - subdomains.each do |subdomain|
            tr
            td 
                a href="./subdomain/#{subdomain.fqdn}/" #{subdomain.fqdn}
            td = subdomain.hijackable
            td
                - a_records = subdomain.a
                - if a_records
                    - a_records.each do | a |
                        p = a
                - else
                    p -
            td
                - aaaa_records = subdomain.aaaa
                - if aaaa_records
                    - aaaa_records.each do | aaaa |
                        - puts(aaaa)
                        p = aaaa
                - else
                    p -
            td = subdomain.mx
            td = subdomain.ns
            td = subdomain.source

javascript:
    window.onload = function() {
    var cfg = {"radius": 2,"maxOpacity": .8,"scaleRadius": true, "useLocalExtrema": true,latField: 'lat',lngField: 'lng',valueField: 'count'}; 
    var leafletMap = L.map('leafletMap').setView([1, 1], 2);
    var baseLayer = L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png').addTo(leafletMap)
    var heatmapLayer = new HeatmapOverlay(cfg);
    var testData = {max: 8,  data: #{coords}};
    heatmapLayer.setData(testData);
    heatmapLayer.addTo(leafletMap)
    new Chartist.Bar('.ct-chart', {labels: #{port_labels},series: #{port_series}}, {distributeSeries: true});
    var cy = cytoscape({
        container: document.getElementById('cyto'),
        elements: #{elements},
        viewport: { zoom:1},
        layout: { name: 'concentric',minDist: 500,   minNodeSpacing: 50, padding: 200, expandingFactor: -1.0,maxExpandIterations: 4,fit:true},
        style: [
        {
            selector: 'node',
            style: {
                shape: 'round',
                "background-color": 'red',
                label: 'data(id)'
            }
        }]
    });
    cy.on('tap', 'node', function (evt) {
         console.log(evt.target.id())
    });
    };

