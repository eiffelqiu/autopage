$:.unshift "#{File.dirname(__FILE__)}/lib"
require 'autopage'
ActionView::Base.send :include, Autopage::ClassMethods
