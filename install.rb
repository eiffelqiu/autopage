require 'fileutils'

["jquery.min.js","jquery-ui.min.js","jquery-ui-tab.css"].each do |o|
  if o.index('.js') then
    x = File.dirname(__FILE__) + "/../../../public/javascripts/#{o}"
    FileUtils.cp File.dirname(__FILE__) + "/templates/js/#{o}", x unless File.exist?(x)
  else
    x = File.dirname(__FILE__) + "/../../../public/stylesheets/#{o}"
    FileUtils.cp File.dirname(__FILE__) + "/templates/css/#{o}", x unless File.exist?(x)  
  end
end
