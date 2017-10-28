require 'httparty'
require 'json'

class ApiClient
  BASE_URI = "https://driftrock-dev-test-2.herokuapp.com"
  PAGE_LENGTH = 2000

  attr_reader :users

  def initialize
    @users = []
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

private

  def page_full?(response)
    JSON.parse(response.body)["data"].length == PAGE_LENGTH
  end

end
