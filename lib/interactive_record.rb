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
    column_names = []
    table_info.each do|row|
      column_names << row["name"]
    end
    column_names
  end 
  
  def initialize(options = {})
    options.each do |key, value|
      self.send("#{key}=" , value)
    end
  end
  
  def table_name_for_insert
     self.class.table_name
  end
  
  def col_names_for_insert
    self.class.column_names.delete_if {|column_name| column_name == "id"}.join (", ")
  end 
  
  def values_for_insert
    column_names = 
  end 
  
  
  
  
end