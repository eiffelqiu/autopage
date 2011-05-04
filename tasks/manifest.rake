

# rake manifest does not work on windows,
# this task do the same task.
namespace :autopage do
  
  desc "rake manifest's replacement rake task"
  task :manifest do 
    system %[find . -type f | egrep -v "(.git\/|nbproject\/|pkg\/|script\/|\.gitignore$|\.gem$)" > Manifest.txt]
    strio =  File.read('Manifest.txt').gsub!(/\.\//,''); puts strio
    File.open('Manifest.txt','w') {|f| f.puts strio }
  end

end