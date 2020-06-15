doctype html
html
  head
    title Arctor
    meta charset="utf-8"
    meta http-equiv="X-UA-Compatible" content="IE=edge"
    meta name="viewport" content="width=device-width, initial-scale=1"
    link rel="stylesheet" href="/dist/main.bundle.css"
    link rel="apple-touch-icon" href="/favicon.png"
    link rel="icon" href="/favicon.png"
    link rel="icon" type="image/x-icon" href="/favicon.ico"
    link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,300italic,700,700italic"
    link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.1/normalize.css"
    link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/milligram/1.4.0/milligram.css"

  body
    nav.navbar.navbar-expand.navbar-dark.bg-primary.mb-3
      .container
        a.navbar-brand href="/"
          img src="/dist/images/logo.png" alt="Arctor" object-fit="fill"
          
        ul.navbar-nav.mr-auto
          == render(partial: "layouts/_nav.slang")
        ul.navbar-nav
            == render(partial: "layouts/_session.slang")

    .container
      - flash.each do |key, value|
        div class="alert alert-#{key}" role="alert"
          = flash[key]

      .main== content

    script src="/dist/main.bundle.js"

    - if Amber.settings.auto_reload?
      script src="/js/client_reload.js"
