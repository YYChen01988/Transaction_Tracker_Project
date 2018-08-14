require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require('sinatra/flash')

require_relative ( './models/transaction.rb')
require_relative ( './models/merchant.rb')
require_relative ( './models/tag.rb')

enable :sessions
also_reload ( './models/*')

get '/analytics' do
  @transactions = Transaction.all()
  @tags = Tag.all()
  @merchants = Merchant.all()
  erb(:analytics)
end

#List of Transactions
get '/transactions' do
  @transactions = Transaction.all()
  erb (:index)
end
#New
get '/transactions/new' do
  @merchants = Merchant.all()
  @tags = Tag.all()
  erb(:new)
end
#Create
post '/transactions' do
  params["transaction_time"] = Time.now.asctime
  @transaction =  Transaction.new(params)
  @transaction.save()
  erb(:create)
end
#Delete
get '/transactions/:id/delete' do
  @transaction = Transaction.find(params[:id])
  @transaction.delete()
  erb(:delete)
end

# Edit
get '/transactions/:id/edit' do
  @transactions = Transaction.all()
  @tags = Tag.all()
  @merchants = Merchant.all()
  @transaction = Transaction.find(params[:id])
  erb(:edit)
end

# Update
post '/transactions/:id' do
  params["transaction_time"] = Time.now.asctime
  @transaction = Transaction.new(params)
  @transaction.update()
  redirect '/transactions'
end





#List of Merchants
get '/merchants' do
  @merchants = Merchant.all()
  erb (:merchant_index)
end

#Delete Warning
get '/merchants/:id/delete-warning' do
  @merchant = Merchant.find_by_id(params[:id])
  erb(:merchant_delete_warning)
end

#Delete alert
get '/merchants/:id/delete' do
  flash[:notice] = "Your related transactions are removed!"
  redirect '/merchants'
end
#Delete Merchant
post '/merchants/:id/delete' do
  @merchant = Merchant.find_by_id(params[:id])
  @merchant.delete_by_id([:id])
  redirect '/merchants'
end
#New
get '/merchants/new' do
  erb(:merchant_new)
end
#Create
post '/merchants' do
  @merchant = Merchant.new(params)
  @merchant.save()
  redirect '/merchants'
end

# Edit
get '/merchants/:id/edit' do
  @merchants = Merchant.all()
  @merchant = Merchant.find_by_id(params[:id])
  erb(:merchant_edit)
end

# Update
post '/merchants/:id' do
  @merchant = Merchant.new(params)
  @merchant.update()
  redirect '/merchants'
end





#List of Tags
get '/tags' do
  @tags = Tag.all()
  erb (:tag_index)
end

#Delete Warning
get '/tags/:id/delete-warning' do
  @tag = Tag.find_by_id(params[:id])
  erb(:tag_delete_warning)
end

#Delete
post '/tags/:id/delete' do
  @tag = Tag.find_by_id(params[:id])
  @tag.delete_by_id([:id])
  redirect '/tags'
end
#New
get '/tags/new' do
  erb(:tag_new)
end
#Create
post '/tags' do
  @tag = Tag.new(params)
  @tag.save()
  redirect '/tags'
end

# Edit
get '/tags/:id/edit' do
  @tags = Tag.all()
  @tag = Tag.find_by_id(params[:id])
  erb(:tag_edit)
end

# Update
post '/tags/:id' do
  @tag = Tag.new(params)
  @tag.update()
  redirect '/tags'
end
