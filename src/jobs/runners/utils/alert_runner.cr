require "http/client"
require "json"

class AlertRunner

    def self.pushover(message : String)
        response = HTTP::Client.post("https://api.pushover.net/1/messages.json", body: "token=&user=&message=#{message}") # need to strip out params here   #CHANGEME
        puts(response.body)
    end
end