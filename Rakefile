namespace :deploy do
  def deploy(env)
    clean_build
    puts "Deploying to #{env}"
    puts "Removing all current files from: #{remote_path}"
    cleanup env
    puts "Copying all files from #{build_dir_path} to: #{remote_path}"
    scp_build_dir env
  end

  def clean_build
    puts 'Removes current build dir'
    puts `rm -rf #{build_dir_path}`
    build
  end

  def build
    puts "Building the current project in: #{build_dir_path}"
    puts `bundle exec middleman build`
  end

  def build
    puts `bundle exec middleman build`
  end

  def cleanup(env)
    puts `ssh #{env} -F .ssh-config 'cd #{remote_path}/ && sudo rm -rf ./*'`
  end

  def scp_build_dir(env)
    puts `scp -r -F .ssh-config #{build_dir_path} #{env}:#{remote_path} > /dev/tty`
  end

  def build_dir_path
    './build/*'
  end

  def remote_path
    '/var/apps/slides/public'
  end

  task :dev do
    # TODO: FIXME
    ENV['RAILS_ENV'] = 'development'
    deploy :development
  end

  task :prod do
    # TODO: FIXME
    ENV['RAILS_ENV'] = 'production'
    deploy :production
  end
end
