require_relative("../db/sqlrunner")

class Tag
  attr_reader :id
  attr_accessor :type

  def initialize(options)
    @id = options["id"].to_i()if options["id"]
    @type = options["type"]
  end

  def save()
    sql = "INSERT INTO tags (type) VALUES ($1) RETURNING id"
    values = [@type]
    result = SqlRunner.run(sql, values).first
    @id = result["id"].to_i
  end

  def self.all()
    sql = "SELECT * FROM tags"
    tags = SqlRunner.run(sql)
    result = tags.map{|tag| Tag.new(tag)}
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM tags"
    SqlRunner.run(sql)
  end

  def update()
    sql = "UPDATE tags SET type = $1
    WHERE id = $2"
    values = [@type, @id]
    SqlRunner.run(sql, values)
  end

  def delete_by_id(id)
    sql = "DELETE FROM tags
    WHERE id = $1"
    values = [@id]
    SqlRunner.run( sql, values )
  end

  def delete_by_type(type)
    sql = "DELETE FROM tags
    WHERE type = $1"
    values = [@type]
    SqlRunner.run( sql, values )
  end

  def self.find( type )
    sql = "SELECT * FROM tags WHERE type = $1"
    values = [type]
    tag = SqlRunner.run( sql, values )
    result = Tag.new( tag.first )
    return result
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM tags WHERE id = $1"
    values = [id]
    tag = SqlRunner.run( sql, values )
    result = Tag.new( tag.first )
    return result
  end






end
