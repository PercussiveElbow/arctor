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
    link rel="stylesheet" href="/dist/style.css"


    script src="/dist/js/bootstrap.bundle.js"

    link rel="stylesheet" href="/dist/chartist/chartist.min.css"
    script src="/dist/chartist/chartist.js"

    script src="/dist/heatmap/heatmap.min.js"
    link rel="stylesheet" href="/dist/leaflet/leaflet.css"

    script src="/dist/leaflet/leaflet.js"

    script src="/dist/heatmap/leaflet-heatmap.js"

    script src="/dist/cytoscape.min.js"
    script src="/dist/cola.min.js"
    script src="/dist/cytoscape-cola.js"
    script src="/dist/bluebird.min.js"
    script src="/dist/weaver.min.js"
    script src="/dist/fetch.min.js"
    script src="/dist/cytoscape-spread.js"


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
