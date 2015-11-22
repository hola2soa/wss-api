require 'rake/testtask'
# require ::File.expand_path('../config/environments', __FILE__)

# task :default => :spec

# Rake::TestTask.new(name=:spec) do |t|
#  t.pattern = 'spec/*_spec.rb'
# end

desc "Launch app locally for development and rerun on file changes"
task :devrun do
  sh "rerun 'bundle exec rackup -p 9393'"
end
