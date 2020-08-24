class CommandRunner

    def self.run(cmd, args, stdin = "")
      stdout = IO::Memory.new
      stderr = IO::Memory.new
      if stdin && stdin.size() > 0
        stdin = IO::Memory.new(stdin)
        status = Process.run(cmd, args: args, output: stdout, error: stderr,input: stdin)
      else
        status = Process.run(cmd, args: args, output: stdout, error: stderr)
      end
      if status.success?
        {status.exit_code, stdout.to_s}
      else
        {status.exit_code, stderr.to_s}
      end
    end
  
  
    def filter_cli_arguments() # stub to escape all the cli escape params  
  
  
    end
  
end
  