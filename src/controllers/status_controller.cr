require "../jobs/dns_enum_job"
require "redis"


class StatusController < ApplicationController
    def index
        puts("redis")
        redis = Redis.new
        keys = redis.keys("*")

        #keys = redis.get("mosquito:pending:dns_enum_job*")
        puts(keys)

        render("status.slang")
    end


end  