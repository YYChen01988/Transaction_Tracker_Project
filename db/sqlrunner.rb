require('pg')

class SqlRunner
  def self.run( sql, values=[])
    begin
      db = PG.connect({ dbname:'ddl0s568f7t8k1', host:'ec2-54-235-146-51.compute-1.amazonaws.com', user:'jltisvkvvigirx', port:'5432', password:'536f91eecc1359f9b59a5d82835a9a40c1b52c9274fa4856fb473d695ad90ac0'})
      db.prepare("query", sql)
      result = db.exec_prepared("query", values)
    ensure
      db.close() if db != nil
    end
    return result
  end


end
