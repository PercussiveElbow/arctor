require "http/client"
require "json"
require "../generic_runner"

class AlertRunner < GenericRunner

    def self.pushover(message : String)
        settings = Settings.first

        if settings 
            pushover_user_key = settings.pushover_user_key
            pushover_app_key = settings.pushover_app_key
        else
            raise("No Pushover keys supplied.")
            # self.runner_log_info("ERROR - No pushover key supplied")
        end

        response = HTTP::Client.post("https://api.pushover.net/1/messages.json", body: "token=#{pushover_app_key}&user=#{pushover_user_key}&message=#{message}") # need to strip out params here
    end
end