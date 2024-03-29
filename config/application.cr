# About Application.cr File
#
# This is Amber application main entry point. This file is responsible for loading
# initializers, classes, and all application related code in order to have
# Amber::Server boot up.
#
# > We recommend not modifying the order of the requires since the order will
# affect the behavior of the application.

require "amber"
require "mosquito"
# require "sidekiq"

require "./settings"
require "./i18n"
require "./database"
require "./initializers/**"

# Start Generator Dependencies: Don't modify.
require "../src/models/**"
# End Generator Dependencies

require "../src/controllers/application_controller"
require "../src/controllers/**"
require "./routes"

Mosquito.configure do |settings|
    settings.redis_url = (ENV["REDIS_TLS_URL"]? || ENV["REDIS_URL"]? || "redis://redis:6379")
end