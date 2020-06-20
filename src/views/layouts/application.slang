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
    link rel="stylesheet" href="https://unpkg.com/mustard-ui@latest/dist/css/mustard-ui.min.css"
     link rel="stylesheet" href="/dist/chartist.min.css"
    script src="/dist/chartist.js"

  body
    nav
      div.nav-container
          div.nav-logo
            a href="/" alt="Arctor" object-fit="fill" Arctor

          ul.nav-links
            == render(partial: "layouts/_nav.slang")
          ul.navbar-nav
              == render(partial: "layouts/_session.slang")

    .main 
        - flash.each do |key, value|
          div class="alert alert-#{key}" role="alert"
            = flash[key]

        .row
            .col.col-lg-12 == content

    script src="/dist/main.bundle.js"

    - if Amber.settings.auto_reload?
      script src="/js/client_reload.js"
