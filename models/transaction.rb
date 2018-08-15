require_relative("../db/sqlrunner")


class Transaction

  attr_reader :id
  attr_accessor :amount, :merchant_id, :tag_id, :transaction_time

  def initialize(options)
    @id = options["id"].to_i()if options["id"]
    @merchant_id = options["merchant_id"].to_i
    @tag_id = options["tag_id"].to_i
    @transaction_time = DateTime.parse(options["transaction_time"])
    @amount = options["amount"].to_f

  end

  def save()
    sql = "INSERT INTO transactions (merchant_id, tag_id, transaction_time, amount) VALUES ($1, $2, $3, $4) RETURNING id"
    values = [@merchant_id, @tag_id, @transaction_time, @amount]
    result = SqlRunner.run(sql, values).first
    @id = result["id"].to_i
  end

  def self.all()
    sql = "SELECT * FROM transactions ORDER BY transaction_time DESC"
    transactions = SqlRunner.run(sql)
    result = transactions.map{|transaction| Transaction.new(transaction)}
    return result
  end

  def self.filter_by_tag_and_merchant(tag_id,merchant_id)
    sql = "SELECT * FROM transactions WHERE tag_id = $1 AND merchant_id = $2 ORDER BY transaction_time DESC"
    values = [tag_id, merchant_id]
    transactions = SqlRunner.run( sql, values )
    result = transactions.map{|transaction| Transaction.new(transaction)}
    return result
  end

  def self.filter_by_tag(tag_id)
    sql = "SELECT * FROM transactions WHERE tag_id = $1 ORDER BY transaction_time DESC"
    values = [tag_id]
    transactions = SqlRunner.run( sql, values )
    result = transactions.map{|transaction| Transaction.new(transaction)}
    return result
  end

  def self.filter_by_merchant(merchant_id)
    sql = "SELECT * FROM transactions WHERE merchant_id = $1 ORDER BY transaction_time DESC"
    values = [tag_id, merchant_id]
    transactions = SqlRunner.run( sql, values )
    result = transactions.map{|transaction| Transaction.new(transaction)}
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM transactions"
    SqlRunner.run(sql)
  end

  def update()
    sql = "UPDATE transactions
    SET
    (
      merchant_id,
      tag_id,
      transaction_time,
      amount
    ) =
    (
      $1, $2, $3, $4
    )
    WHERE id = $5"
    values = [@merchant_id, @tag_id, @transaction_time, @amount, @id]
    SqlRunner.run( sql, values )
  end

  def delete()
    sql = "DELETE FROM transactions
    WHERE id = $1"
    values = [@id]
    SqlRunner.run( sql, values )
  end

  def self.find(id)
    sql = "SELECT * FROM transactions WHERE id = $1"
    values = [id]
    transaction = SqlRunner.run( sql, values )
    result = Transaction.new( transaction.first )
    return result
  end

def self.group_by_tag(tag)
    sql = "SELECT sum(amount) FROM transactions WHERE tag_id = $1"
    values = [tag]
    total_amount = SqlRunner.run( sql, values )
    result =  total_amount.first
    return result["sum"]
end


def self.number_by_tag(tag)
    sql = "SELECT count(*) FROM transactions WHERE tag_id = $1"
    values = [tag]
    total_amount = SqlRunner.run( sql, values )
    result = total_amount.first
    return result["count"]
end

def self.group_by_merchant(merchant)
    sql = "SELECT sum(amount) FROM transactions WHERE merchant_id = $1"
    values = [merchant]
    total_amount = SqlRunner.run( sql, values )
    result =  total_amount.first
    return result["sum"]
end


def self.number_by_merchant(merchant)
    sql = "SELECT count(*) FROM transactions WHERE merchant_id = $1"
    values = [merchant]
    total_amount = SqlRunner.run( sql, values )
    result = total_amount.first
    return result["count"]
end

def self.total_amount()
  sql = "SELECT sum(amount) FROM transactions"
  total_amount = SqlRunner.run(sql)
  result = total_amount[0]["sum"]
  return result.to_i
end

end
