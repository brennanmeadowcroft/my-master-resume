set :application, "mymasterresume"
# Need to establish a git SSH key from github (https://help.github.com/articles/generating-ssh-keys)
set :repository,  "git@github.com:brennanmeadowcroft/master_resume.git"

set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "fanta.asmallorange.com"                          # Your HTTP server, Apache/etc
role :app, "fanta.asmallorange.com"                          # This may be the same as your `Web` server
role :db,  "fanta.asmallorange.com", :primary => true # This is where Rails migrations will run

set :deploy_via, :copy	# This copies the repo locally and then uploads it to the server via SFTP
						#  
set :deploy_to,	"rails_apps/mymasterresume"
set :user,		"mymaster"
set :use_sudo,	false

default_run_options[:pty] = true
#ssh_options[:forward_agent] = true

after 'deploy:update_code', 'deploy:assets:precompile'
after 'deploy:create-_symlink', 'deploy:link_release_to_public'

desc "deploy the precompiled assets"
namespace :deploy do
	namespace :assets do
		task :precompile, :roles => [ :web, :app ], :except => { :no_release => true } do
			# Delete the existing assets folder from the server
			run "rm -rf ~/#{shared_path}/assets"

			# Precompile assets locally
			run_locally("rake assets:clean && rake assets:precompile RAILS_ENV=production")
			run_locally "cd public && tar -czf assets.tar.gz assets"
			top.upload("public/assets.tar.gz", "#{shared_path}", :via => :scp)
			run "cd #{shared_path} && tar -xzf assets.tar.gz && rm assets.tar.gz"
			# x = Extract, z = Gzip, f = Next item is file name to be unzipped
			run_locally "rm public/assets.tar.gz"
			run_locally("rake assets:clean")
		end
	end

	# Symlink the release to the public directory
	desc "Symlink current directory to the public directory"
	task :link_release_to_public do
		# Get to highest level possible
		run "cd ~"

		# remove the public_html folder... it won't be recreated by the symlink if it exists
		run "rm -rf ~/public_html && ln -s ~/#{current_path}/public/ ~/public_html"

		# link the current release's public folder to the public_html.  The 
		# public_html will be created fresh in this step
#		run "ln -s ~/#{current_path}/public/ ~/public_html"
	end

	desc "Symlink current release to current directory"
	# Since the symlink is custom and not Capistrano-standard, overwrite the default create_symlink method
	task :create_symlink do
		# Get to the highest level possible
		run "cd ~"

		# remove the "current" directory under the application
		run "rm -rf ~/#{current_path}"

		# create a symlink between the most recent release and the "current" directory.
		# Since "current/" was deleted in the previous step, it will create it
		run "ln -sf ~/#{current_release} ~/#{current_path}"
		
		# Link the assets in the shared path to the current deployment's assets
		run "ln -sf ~/#{shared_path}/assets ~/#{current_path}/public/assets"

		# Link the shared database.yml file to the current versions
		run "ln -sf ~/#{shared_path}/config/database.yml ~/#{current_path}/config"
	end

	desc "Clean up symlinks before recreating them"
	task :cleanup_symlink do
		run "cd ~"

		run "rm -rf public_html"
		run "rm public_html"
	end
end

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end