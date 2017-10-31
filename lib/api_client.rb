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

  def total_spend(email)
    sum_value(user_purchases(email))
  end

  def average_spend(email)
    mean_value(user_purchases(email))
  end

  def most_loyal
    purchase_frequency = frequency_of(user_ids_from_each_purchase)
    most_purchases = purchase_frequency.values.max
    most_frequent_user = find_most_frequent(purchase_frequency, most_purchases)
    user_id = most_frequent_user.flatten[0]
    find_email(user_id)
  end

  def most_sold
    item_sales = frequency_of(items)
    max_frequency = item_sales.values.max
    most_sold_item = find_most_frequent(item_sales, max_frequency)
    most_sold_item.flatten[0]
  end

  def highest_value
    user_values = total_spends
    max_spend = user_values.values.max
    user_id = user_values.find { |key, value| value == max_spend}[0]
    find_email(user_id)
  end

  def find_user(email)
    @users.find {|user| user["email"] == email }
  end

  def find_user_purchases(user_id)
    @purchases.select {|purchase| purchase["user_id"] == user_id }
  end

  def sum_value(purchases)
    sum = 0
    purchases.each { |purchase| sum += purchase["spend"].to_f }
    sum
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

  def user_ids
    @users.map { |user| user["id"] }
  end

  def find_email(id)
    @users.find { |user| user["id"] == id }['email']
  end

  def items
    @purchases.map { |purchase| purchase['item'] }
  end

  def total_spends
    user_ids.map { |id| [id, sum_value(find_user_purchases(id))]}.to_h
  end

  def mean_value(purchases)
    sum_value(purchases) / purchases.length
  end

  def frequency_of(objects)
    objects.inject(Hash.new(0)) { |hash,key| hash[key] += 1; hash }
  end

  def find_most_frequent(frequency_of_objects, max_frequency)
    frequency_of_objects.select { |key, frequency| frequency == max_frequency }
  end
end
