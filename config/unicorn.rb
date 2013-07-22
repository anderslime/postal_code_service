worker_processes 1 # this should be >= nr_cpus
listen ENV['PORT']

# pid "/path/to/app/shared/pids/unicorn.pid"
# # stderr_path "/path/to/app/shared/log/unicorn.log"
# # stdout_path "/path/to/app/shared/log/unicorn.log"
# stderr_path "unicorn.stderr.log"
# stdout_path "unicorn.stdout.log"
