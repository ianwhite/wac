# the following tasks are for doc building
begin
  require 'hanna/rdoctask'
  require 'grancher/task'
  
  Rake::RDocTask.new(:doc) do |d|
    d.options << '--all'
    d.rdoc_dir = 'doc'
    d.main     = 'README.rdoc'
    d.title    = "Wac API Docs"
    d.rdoc_files.include('README.rdoc', 'License.txt', 'lib/**/*.rb')
  end

  namespace :doc do
    task :publish => :doc do
      Rake::Task['doc:push'].invoke unless uptodate?('.git/refs/heads/gh-pages', 'doc')
    end
    
    Grancher::Task.new(:push) do |g|
      g.keep_all
      g.directory 'doc', 'doc'
      g.branch = 'gh-pages'
      g.push_to = 'origin'
    end
  end

rescue LoadError
end
