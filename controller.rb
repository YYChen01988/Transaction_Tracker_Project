require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )

require_relative ( './models/transaction.rb')
require_relative ( './models/merchant.rb')
require_relative ( './models/tag.rb')

also_reload ( './models/*')


get '/transactions' do
  @transactions = Transaction.all()
  @tags = Tag.all()
  erb (:index)
end

get '/transactions/new' do
  @merchants = Merchant.all()
  @tags = Tag.all()
  erb(:new)
end

post '/transactions' do
  params["transaction_time"] = Time.now.asctime
  @transactions =  Transaction.new(params)
  @transactions.save()
  erb(:create)
end

get '/transactions/:id/delete' do
  @transaction = Transaction.find(params[:id])
  @transaction.delete()
  erb(:delete)
end
