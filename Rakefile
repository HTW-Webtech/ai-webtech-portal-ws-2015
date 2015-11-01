require 'complex_config/rude'
require 'fileutils'

namespace :deploy do
  def log(msg, env = '?')
    puts "[#{env}] #{msg}"
  end

  def deploy(env)
    clean_build env
    rsync_files env
  end

  def rsync_files(env)
    puts "Rsyncing local files from #{cc(:site).build_dir_path} to remote: #{cc(:site).remote_path}", env
    sh "rsync -avhze ssh --delete --progress #{cc(:site).build_dir_path}/ #{cc(:site).rsync_host}:#{cc(:site).remote_path}"
  end

  def clean_build(env)
    log "Removing all files from current build: #{cc(:site).build_dir_path}", env
    sh "rm -rf #{cc(:site).build_dir_path}/*"
    log "Generating latest build: #{cc(:site).build_dir_path}", env
    sh 'bundle exec middleman build'
  end

  def build
    puts `bundle exec middleman build`
  end

  desc 'Deploy slides to staging: virual machine'
  task :stg do
    # TODO: complex config does primarily respect the RAILS_ENV
    ENV['RAILS_ENV'] = 'development'
    deploy :staging
  end

  desc 'Deploy slides to production'
  task :prd do
    # TODO: complex config does primarily respect the RAILS_ENV
    ENV['RAILS_ENV'] = 'production'
    deploy :production
  end
end

namespace :setup do
  task default: [:symlink_githooks, :npm_install]

  desc 'Symlink githooks'
  task :symlink_githooks do
    puts "Creating git-hook symlinks"
    FileUtils.cd('.git/hooks') do
      FileUtils.ln_sf Dir['../../config/git-hooks/*'], '.', verbose: true
    end
  end

  desc 'Install node modules'
  task :npm_install do
    sh 'npm install'
  end
end

desc 'Setup for development'
task setup: ['setup:default']

task :default do
  system "rake -sT"
end
