require_relative "../config/environment.rb"
require 'active_support/inflector'

class InteractiveRecord
  
  def self.table_name 
    table = self.to_s.downcase.pluralize
  end 
  
end