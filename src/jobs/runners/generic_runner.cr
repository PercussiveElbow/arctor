require "./utils/*"
require "log"

class GenericRunner

    def runner_log_error(message : String)
        backend = Log::IOBackend.new(File.new("arctor_log_error.log","a"))
        Log.builder.bind "*", :error, backend
        Log.error {message}
    end

    def runner_log_info(message : String)
        backend = Log::IOBackend.new(File.new("arctor_log_info.log","a"))
        Log.builder.bind "*", :info, backend
        Log.info {message}
    end

    def runner_log_debug(message : String)
        backend = Log::IOBackend.new(File.new("arctor_log_debug.log","a"))
        Log.builder.bind "*", :debug, backend
        Log.debug {message}
    end 

end