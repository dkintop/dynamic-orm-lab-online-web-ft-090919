require_relative "../config/environment.rb"
require 'active_support/inflector'
require 'pry'
class InteractiveRecord
  
  def self.table_name 
    table = self.to_s.downcase.pluralize
  end 
  
  def self.column_names
    
  end 
  
end