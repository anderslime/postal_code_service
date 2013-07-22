worker_processes 1 # this should be >= nr_cpus
listen ENV['PORT']

pid         "/var/www/postal_code_service/shared/pids/unicorn.pid"
stderr_path "/var/www/postal_code_service/shared/log/unicorn.log"
stdout_path "/var/www/postal_code_service/shared/log/unicorn.log"

after_fork do |server, worker|
  # per-process listener ports for debugging/admin/migrations
  # addr = "127.0.0.1:#{9293 + worker.nr}"
  # server.listen(addr, :tries => -1, :delay => 5, :tcp_nopush => true)

  # the following is *required* for Rails + "preload_app true",
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection

  # if preload_app is true, then you may also want to check and
  # restart any other shared sockets/descriptors such as Memcached,
  # and Redis.  TokyoCabinet file handles are safe to reuse
  # between any number of forked children (assuming your kernel
  # correctly implements pread()/pwrite() system calls)

  old_pid = "#{server.config[:pid]}.oldbin"
  if old_pid != server.pid
    begin
      if (worker.nr + 1) >= server.worker_processes
        Process.kill(:QUIT, File.read(old_pid).to_i)
      end
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end
