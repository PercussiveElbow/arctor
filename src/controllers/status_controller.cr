require "../jobs/dns_enum_job"
require "redis"


class StatusController < ApplicationController
    def index
        redis = Redis.new
        tasks = redis.keys("mosquito:task:*")
        pendings = redis.keys("mosquito:pending:*")

        render("status.slang")
    end


end  