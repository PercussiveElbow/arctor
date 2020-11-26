require "../jobs/dns_enum_job"
require "redis"


class StatusController < ApplicationController
    def index
        redis = Redis.new
        tasks = redis.keys("mosquito:task:*")
        pendings = redis.keys("mosquito:pending:*")

        begin 
            info_logs = File.read("arctor_log_info.log")
        rescue Exception 
            info_logs = ""
        end

        begin 
            error_logs = File.read("arctor_log_error.log")
        rescue Exception
            error_logs = ""
        end


        render("status.slang")
    end


end  