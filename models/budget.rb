require_relative("../db/sqlrunner")


class Budget

  attr_reader :id
  attr_accessor :amount, :add_time

  def initialize(options)
    @id = options["id"].to_i()if options["id"]
    @amount = options["amount"].to_f
    @add_time = DateTime.parse(options["add_time"])

  end

  def save()
    sql = "INSERT INTO budgets (amount, add_time) VALUES ($1, $2) RETURNING id"
    values = [@amount, @add_time]
    result = SqlRunner.run(sql, values).first
    @id = result["id"].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM budgets"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM budgets"
    budgets = SqlRunner.run(sql)
    result = budgets.map{|budget| Budget.new(budgets)}
    return result
  end

  def update()
    sql = "UPDATE budgets
    SET
    (
      amount, add_time
    ) =
    (
      $1, $2
    )
    WHERE id = $3"
    values = [@amount, @add_time, @id]
    SqlRunner.run( sql, values )
  end



end
