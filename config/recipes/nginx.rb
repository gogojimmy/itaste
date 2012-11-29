namespace :nginx do
  task :setup do

  end
  after "deploy:setup", "nginx:setup"
end
