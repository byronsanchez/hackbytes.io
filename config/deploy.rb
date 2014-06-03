set :application, @config['application']
set :repo_url, @config['repo']

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :deploy_to, @config['remote_destination']
set :scm, "git"

# set :format, :pretty
# set :log_level, :debug
# set :pty, true
#
# set :linked_files, %w{config/database.yml}
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

set :default_env, {
  path: @config['remote_path_env']
}
set :user, @config['remote_user']
set :branch, @config['repo_branch']

set :use_sudo, false
set :deploy_via, :copy
set :copy_cache, "/tmp/#{@config['application']}"
set :copy_compression,:gzip 
set :keep_releases, 5
#set :ssh_options, { :forward_agent => true }

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  after :finishing, 'deploy:cleanup'

end
