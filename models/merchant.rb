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
    result = merchants.map{|merchant| Tag.new(merchant)}
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM merchants"
    SqlRunner.run(sql)
  end






end
