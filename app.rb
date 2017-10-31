require './lib/api_client'

client = ApiClient.new
loading = '--------------- Retrieving Information ---------------'

first_arg, *email = ARGV

if first_arg == 'total_spend'
  puts "What is the total spend of the user with this email address #{email[0].chomp}?"
  puts loading
  client.get_users
  client.get_purchases
  puts client.total_spend(email[0].chomp)
end

if first_arg == 'average_spend'
  puts "What is the average spend of the user with this email address #{email[0].chomp}?"
  puts loading
  client.get_users
  client.get_purchases
  puts client.average_spend(email[0].chomp)
end

if first_arg == 'most_loyal'
  puts "What is the email address of the most loyal user(most purchases)?"
  puts loading
  client.get_users
  client.get_purchases
  puts client.most_loyal
end

if first_arg == 'highest_value'
  puts "What is the email address of the highest value user?"
  puts loading
  client.get_users
  client.get_purchases
  puts client.highest_value
end

if first_arg == 'most_sold'
  puts "What is the name of the most sold item?"
  puts loading
  client.get_users
  client.get_purchases
  puts client.most_sold
end
