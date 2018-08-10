require_relative("../db/sqlrunner")


class Transaction

  attr_reader :id
  attr_accessor :amount, :merchant_id, :tag_id, :transaction_time

  def initialize(options)
    @id = options["id"].to_i()if options["id"]
    @merchant_id = options["merchant_id"]
    @tag_id = options["tag_id"]
    @transaction_time = DateTime.parse(options["transaction_time"])
    @amount = options["amount"].to_i

  end

  def save()
    sql = "INSERT INTO transactions (merchant_id, tag_id, transaction_time, amount) VALUES ($1, $2, $3, $4) RETURNING id"
    values = [@merchant_id, @tag_id, @transaction_time, @amount]
    result = SqlRunner.run(sql, values).first
    @id = result["id"].to_i
  end

  def self.all()
    sql = "SELECT * FROM transactions"
    transactions = SqlRunner.run(sql)
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
    values = [@amount, @merchant_id, @tag_id, @transaction_time, @id]
    SqlRunner.run( sql, values )
  end

  def delete_by_id(id)
    sql = "DELETE FROM transactions
    WHERE id = $1"
    values = [@id]
    SqlRunner.run( sql, values )
  end






end
