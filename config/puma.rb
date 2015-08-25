workers Integer(ENV['PUMA_WORKERS'] || 3)
threads Integer(ENV['MIN_THREADS']  || 4), Integer(ENV['MAX_THREADS'] || 16)

preload_app!

port 3000
environment 'production'

daemonize
bind 'unix:///home/ugran/artiveria.sock'