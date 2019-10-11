require_relative "../config/environment.rb"
require 'active_support/inflector'
require 'pry'
class InteractiveRecord
  
  def self.table_name 
    table = self.to_s.downcase.pluralize
  end 
  
  def self.column_names
    sql = <<-SQL 
    Pragma table_info('#{self.table_name}')
    SQL
    table_info = DB[:conn].execute(sql)
    
  end 
  
end