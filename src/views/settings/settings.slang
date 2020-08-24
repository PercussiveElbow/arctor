h1 Settings

.col.col-lg-6
    .card
        h4 Settings.
        form method="post"
            fieldset
                    fieldset
                        legend API Keys
                        div.form-control
                            label.label-inline Shodan
                            input.text name="shodan_key" id="shodan_key"
                            
                    == csrf_tag
                    input.button-primary.button-round type="submit" action="/settings" value="Save"