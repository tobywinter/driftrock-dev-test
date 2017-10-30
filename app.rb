require './lib/api_client'

client = ApiClient.new
puts '--------------- Retrieving Information ---------------'
client.get_users
client.get_purchases
line_break = '------------------------------------------------------'

first_arg, *email = ARGV

if first_arg == 'total_spend'
  puts "What is the total spend of the user with this email address #{email[0].chomp}?"
  puts line_break
  puts client.total_spend(email[0].chomp)
end

if first_arg == 'average_spend'
  puts "What is the average spend of the user with this email address #{email[0].chomp}?"
  puts line_break
  puts client.average_spend(email[0].chomp)
end

if first_arg == 'most_loyal'
  puts "What is the email address of the most loyal user(most purchases)?"
  puts line_break
  puts client.most_loyal
end

if first_arg == 'highest_value'
  puts "What is the email address of the highest value user?"
  puts client.highest_value
end

if first_arg == 'most_sold'
  puts "What is the name of the most sold item?"
end
