require 'httparty'
require 'json'

class ApiClient
  BASE_URI = "https://driftrock-dev-test-2.herokuapp.com"
  PAGE_LENGTH = 2000

  attr_reader :users, :purchases

  def initialize
    @users = []
    @purchases = []
  end

  def check_status
    response = HTTParty.get("#{BASE_URI}/status")
    response.code
  end

  def get_users
    i = 1
    data_available = true
    while data_available do
      response = HTTParty.get("#{BASE_URI}/users?page=#{i}&per_page=#{PAGE_LENGTH}")
      @users += JSON.parse(response.body)["data"]
      data_available = page_full?(response)
      i += 1
    end
  end

  def find_user(email)
    @users.find {|user| user["email"] == email }
  end

  def get_purchases
    i = 1
    data_available = true
    while data_available do
      response = HTTParty.get("#{BASE_URI}/purchases?page=#{i}&per_page=#{PAGE_LENGTH}")
      @purchases += JSON.parse(response.body)["data"]
      data_available = page_full?(response)
      i += 1
    end
  end

  def find_user_purchases(user_id)
    @purchases.select {|purchase| purchase["user_id"] == user_id }
  end

  def sum_value(purchases)
    sum = 0
    purchases.each { |purchase| sum += purchase["spend"].to_f }
    sum
  end

  def mean_value(purchases)
    sum_value(purchases) / purchases.length
  end

  def total_spend(email)
    sum_value(user_purchases(email))
  end

  def average_spend(email)
    mean_value(user_purchases(email))
  end

  def most_loyal
    purchase_frequency = user_ids_from_each_purchase.inject(Hash.new(0)) { |hash,value| hash[value] += 1; hash }
    most_purchases = purchase_frequency.values.max
    most_frequent_user = purchase_frequency.select { |user_id, frequency| frequency == most_purchases }
    user_id = most_frequent_user.flatten[0]
    find_email(user_id)
  end

  def most_sold
    item_sales = items.inject(Hash.new(0)) { |hash,value| hash[value] += 1; hash }
    max_frequency = user_frequency.values.max
    most_frequent = user_frequency.select { |user_id, frequency| frequency == max_frequency }
    user_id = most_frequent.flatten[0]
    find_email(user_id)
  end

  def items
    @purchases.map { |purchase| purchase['item'] }.uniq
  end

  def highest_value
    user_values = total_spends
    max_spend = user_values.values.max
    user_id = user_values.find { |key, value| value == max_spend}[0]
    find_email(user_id)
  end

  def total_spends
    user_ids.map { |id| [id, sum_value(find_user_purchases(id))]}.to_h
  end

  def user_ids
    @users.map { |user| user["id"] }
  end

  def find_email(id)
    @users.find { |user| user["id"] == id }['email']
  end

private

  def page_full?(response)
    JSON.parse(response.body)["data"].length == PAGE_LENGTH
  end

  def user_purchases(email)
    user = find_user(email)
    purchases = find_user_purchases(user["id"])
  end

  def user_ids_from_each_purchase
    @purchases.map { |purchase| purchase["user_id"] }
  end

end
