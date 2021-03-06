require_relative("../db/sqlrunner")


class Merchant
  attr_reader :id
  attr_accessor :store_name

  def initialize(options)
    @id = options["id"].to_i()if options["id"]
    @store_name = options["store_name"]
  end

  def save()
    sql = "INSERT INTO merchants (store_name) VALUES ($1) RETURNING id"
    values = [@store_name]
    result = SqlRunner.run(sql, values).first
    @id = result["id"].to_i
  end

  def self.all()
    sql = "SELECT * FROM merchants"
    merchants = SqlRunner.run(sql)
    result = merchants.map{|merchant| Merchant.new(merchant)}
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM merchants"
    SqlRunner.run(sql)
  end

  def update()
    sql = "UPDATE merchants SET
      store_name = $1
    WHERE id = $2"
    values = [@store_name, @id]
    SqlRunner.run(sql, values)
  end

  def delete_by_id(id)
    sql = "DELETE FROM merchants
    WHERE id = $1"
    values = [@id]
    SqlRunner.run( sql, values )
  end

  def delete_by_store_name(store_name)
    sql = "DELETE FROM merchants
    WHERE store_name = $1"
    values = [@store_name]
    SqlRunner.run( sql, values )
  end

  def self.find(store_name)
    sql = "SELECT * FROM merchants WHERE store_name = $1"
    values = [store_name]
    merchant = SqlRunner.run( sql, values )
    result = Merchant.new( merchant.first )
    return result
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM merchants WHERE id = $1"
    values = [id]
    merchant = SqlRunner.run( sql, values )
    result = Merchant.new( merchant.first )
    return result
  end





end
