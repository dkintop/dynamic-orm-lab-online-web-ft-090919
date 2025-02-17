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
    values = []
    self.class.column_names.each do |column|
      values << "'#{send(column)}'" unless send(column).nil?
    end
    values.join(", ")
  end 
  
  def save 
    sql = "INSERT INTO #{table_name_for_insert} (#{col_names_for_insert}) VALUES (#{values_for_insert})"
    DB[:conn].execute(sql)
    self.id = DB[:conn].execute("SELECT last_insert_rowid() FROM #{table_name_for_insert}")[0][0]
  end 
  
  def self.find_by_name(name)
    sql = <<-SQL
      Select * From #{self.table_name} 
      WHERE name = ?
    SQL
    DB[:conn].execute(sql, name)
  end 
  
  def self.find_by(attribute)
      key = attribute.keys.join()
      value = attribute.values.first
    sql =<<-SQL
      SELECT * FROM #{self.table_name}
      WHERE #{key} = "#{value}"
      LIMIT 1
    SQL
    row = DB[:conn].execute(sql)
    
  end
  
  
  
  
end