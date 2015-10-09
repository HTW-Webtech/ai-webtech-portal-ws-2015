namespace :deploy do
  def deploy(env)
    puts "Deploying to #{env}"
    puts "Removing all current files from: #{remote_path}"
    cleanup env
    puts "Copying all files from #{local_path} to: #{remote_path}"
    scp_build_dir env
  end

  def cleanup(env)
    puts `ssh #{env} -F .ssh-config 'cd #{remote_path}/ && sudo rm -rf ./*'`
  end

  def scp_build_dir(env)
    puts `scp -r -F .ssh-config #{local_path} #{env}:#{remote_path} > /dev/tty`
  end

  def local_path
    './build'
  end

  def remote_path
    '/var/apps/slides/public'
  end

  task :dev do
    deploy :development
  end

  task :prod do
    deploy :production
  end
end
