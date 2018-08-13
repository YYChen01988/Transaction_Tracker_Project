require_relative("db/sqlrunner.rb")
require_relative("models/tag.rb")
require_relative("models/merchant.rb")
require_relative("models/transaction.rb")



require ("pry")

Transaction.delete_all()
Tag.delete_all()
Merchant.delete_all()


tag1 = Tag.new({
"type" => "Groceries"
})
tag1.save()

tag2 = Tag.new({
"type" => "Transport"
})
tag2.save()

tag3 = Tag.new({
"type" => "Entertainment"
})
tag3.save()




merchant1 = Merchant.new({
"store_name" => "Tesco"
})
merchant1.save()

merchant2 = Merchant.new({
"store_name" => "Lidl"
})
merchant2.save()

merchant3 = Merchant.new({
"store_name" => "Aldi"
})
merchant3.save()

merchant4 = Merchant.new({
"store_name" => "Scotrail"
})
merchant4.save()



transaction1 = Transaction.new({
  "merchant_id" => merchant1.id,
  "tag_id" => tag1.id,
  "transaction_time" => Time.now.asctime,
  "amount" => 25
  });
transaction1.save()

transaction2 = Transaction.new({
  "merchant_id" => merchant3.id,
  "tag_id" => tag1.id,
  "transaction_time" => Time.now.asctime,
  "amount" => 67
  });
transaction2.save()

transaction3 = Transaction.new({
  "merchant_id" => merchant4.id,
  "tag_id" => tag2.id,
  "transaction_time" => Time.now.asctime,
  "amount" => 100
  });
transaction3.save()



binding.pry
nil
