worker_processes 1 # this should be >= nr_cpus
listen ENV['PORT']

pid         "/var/www/postal_code_service/shared/pids/unicorn.pid"
stderr_path "/var/www/postal_code_service/shared/log/unicorn.log"
stdout_path "/var/www/postal_code_service/shared/log/unicorn.log"
