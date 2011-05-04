$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

$KCODE = 'u'

##
# A Rails Plugin to autogenerate long text content to multipage.
#
module Autopage
  VERSION = '0.0.12'

  def self.included(base)
    base.extend ClassMethods
  end

  ##
  # Split String into array with fixed length characters
  #
  #   "xxxxxxxxx".split_page(3)          #=>  ['xxx','xxx','xxx']
  #
  # @return [Array]
  #
  # @api public
  def split_page(width=200)
    scan(/.{1,#{width}}/m)
  end

  ##
  # Split String into array with fixed length characters and
  # wrapped into jQuery tabs by idsTab plugin
  #
  #   "xxxxxx".split_page(3)          #=> '<ul class="idTabs"><li><a href='#page1'>1</a></li><li><a href='#page2'>2</a></li></ul><div id='page1'>xxx</div><div id='page2'>xxx</div>'
  #
  # @return [String]
  #
  # @api public
  def tab_page(width=200)
    tabs = split_page(width)
    ret = %{<div id='idTabs'><ul>}
    tabs.each_with_index do |p,n|
      ret += %{<li><a href='#page#{n+1}'>#{n+1}</a></li>}
    end 
    ret += '</ul>' 
    tabs.each_with_index do |p,n|
      ret += %{<div id='page#{n+1}'>#{p}</div>} 
    end 
    ret += '</div>' 
    ret.strip.chomp
  end

  module ClassMethods
    ##
    # ActionView Helper method to generate required javascript and css inclusion in webpage's head
    # and initialize the tab DIV
    #
    # Usage: <%= javascript_include_autopage %> 
    #
    # @return [String]
    #
    # @api public    
    def javascript_include_autopage(pageDiv='idTabs')
      %{
        <link rel="stylesheet" type="text/css" href="/stylesheets/jquery-ui-tab.css" />
        <script src="/javascripts/jquery.min.js" type="text/javascript"></script>
        <script src="/javascripts/jquery-ui.min.js" type="text/javascript"></script>
        <script type="text/javascript"> 
        $(function(){
          $('##{pageDiv}').tabs();
          });
        </script> 
      }
    end


  end

end

class String
  include Autopage
end

if defined?(ActionView) && defined?(ActionView::Base) 
  ActionView::Base.send :include, Autopage::ClassMethods
else
  Object.send :extend, Autopage::ClassMethods
end 
