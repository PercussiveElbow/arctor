h1 Settings

- if saved
    p.alert.alert-success Settings saved

form method="post"
    fieldset
        legend API Keys
        div.form-group
            label Shodan
            - if settings
                input.text name="shodan_key" id="shodan_key" value==settings.shodan_key
            - else
                input.text name="shodan_key" id="shodan_key"
        div.form-group
            label Pushover (User)
            - if settings
                input.text name="pushover_user_key" id="pushover_user_key" value==settings.pushover_user_key
            - else
                input.text name="pushover_user_key" id="pushover_user_key"
        div.form-group
            label Pushover (App)
            - if settings
                input.text name="pushover_app_key" id="pushover_app_key" value==settings.pushover_app_key
            - else
                input.text name="pushover_app_key" id="pushover_app_key"
        == csrf_tag
        button.btn.btn-outline-primary type="submit" action="/settings" value="Save" Save