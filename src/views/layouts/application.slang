doctype html
html
  head
    title Arctor
    meta charset="utf-8"
    meta http-equiv="X-UA-Compatible" content="IE=edge"
    meta name="viewport" content="width=device-width, initial-scale=1"
    link rel="javascript" href="/dist/main.bundle.js"
    link rel="apple-touch-icon" href="/favicon.png"
    link rel="icon" href="/favicon.png"
    link rel="icon" type="image/x-icon" href="/favicon.ico"
    
    link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,300italic,700,700italic"
    / link rel="stylesheet" href="/dist/mustard-ui.min.css"
    link rel="stylesheet" href="/dist/css/bootstrap.css"
    link rel="stylesheet" href="/dist/css/style.css"


    script src="/dist/js/bootstrap/bootstrap.bundle.js"

    link rel="stylesheet" href="/dist/js/chartist/chartist.min.css"
    script src="/dist/js/chartist/chartist.js"

    script src="/dist/js/heatmap/heatmap.min.js"
    link rel="stylesheet" href="/dist/js/leaflet/leaflet.css"

    script src="/dist/js/leaflet/leaflet.js"

    script src="/dist/js/heatmap/leaflet-heatmap.js"

    script src="/dist/js/cytoscape/cytoscape.min.js"
    script src="/dist/js/cytoscape/cola.min.js"
    script src="/dist/js/cytoscape/cytoscape-cola.js"
    script src="/dist/js/cytoscape/bluebird.min.js"
    script src="/dist/js/cytoscape/weaver.min.js"
    script src="/dist/js/cytoscape/fetch.min.js"
    script src="/dist/js/cytoscape/cytoscape-spread.js"


  body
      nav class="navbar navbar-expand-lg navbar-light bg-light"
          a.navbar-brand href="/" alt="Arctor" object-fit="fill" Arctor
          ul class="navbar-nav"
            == render(partial: "layouts/_nav.slang")
    == render(partial: "layouts/_session.slang")

    .main
        - flash.each do |key, value|
          div class="alert alert-#{key}" role="alert"
            = flash[key]

        .row.justify-content-center
            .col.col-lg-11 == content

    script src="/dist/main.bundle.js"

    - if Amber.settings.auto_reload?
      script src="/js/client_reload.js"
