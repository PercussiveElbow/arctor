require "../generic_runner"
require "marionette"
require "random"

class FlyoverRunner < GenericRunner

    def initialize(@scan_id : Int64, @subdomain : String, @subdomain_id : Int64)

    end

    def run()
        puts("Subdomain Flyover - Attempting to take screenshot of #{@subdomain}")

        
        options = Marionette.firefox_options(args: ["headless"])

        session = Marionette::WebDriver.create_session(:firefox)

        session.navigate("https://#{@subdomain}")

        base64 = session.full_page_screenshot()
        Screenshot.create(subdomain_id: @subdomain_id, image: base64, port: 443)
        sleep 3
        session.close
    end
end