require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    return @columns if @columns
    save = DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
    SQL
    @columns = save[0].map(&:to_sym)
    @columns
  end

  def self.finalize!
    self.columns.each do |column|
      define_method(column) do
        self.attributes[column]
      end
      define_method("#{column}=") do |arg|
        self.attributes[column] = arg
      end
    end
  end

  def self.table_name=(table_name)
    # ...
    @table_name = table_name
  end

  def self.table_name
    # ...
    @table_name ||= "#{self.to_s.tableize}"
  end

  def self.all
    # ...
    save = DBConnection.execute(<<-SQL)
      SELECT
        *
      FROM
        #{table_name}
    SQL
    parse_all(save)
  end

  def self.parse_all(results)
    # ...
    results.map{ |i| self.new(i)}
  end

  def self.find(id)
    # ...
    save = DBConnection.execute(<<-SQL, id)
      SELECT
        *
      FROM
        #{self.table_name}
      WHERE
        id = ?
    SQL
    parse_all(save).first
  end

  def initialize(params = {})
    # ...
    params.each do |k, v|
      if self.class.columns.include?(k.to_sym)
        k = "#{k}="
        self.send(k, v)
      else
        raise "unknown attribute '#{k}'"
      end
    end
  end

  def attributes
    # ...
    @attributes ||= {}
  end

  def attribute_values
    # ...
    self.class.columns.map { |method| send(method) }
  end

  def insert
    col_names = self.class.columns[1..-1].join(',')
    question_marks = (["?"] * (self.class.columns.length-1)).join(', ')
    a = attribute_values[1..-1]
    # ...
    DBConnection.execute(<<-SQL, *a)
    INSERT INTO
     #{self.class.table_name} (#{col_names})
    VALUES
      (#{question_marks})
    SQL
  end

  def update
    # ...
  end

  def save
    # ...
  end
end
