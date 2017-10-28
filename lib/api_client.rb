require 'httparty'
require 'json'

class ApiClient
  BASE_URI = "https://driftrock-dev-test-2.herokuapp.com"

  def initialize
  end

  def check_status
    response = HTTParty.get("#{BASE_URI}/status")
    response.code
  end

  def users
    response = HTTParty.get("#{BASE_URI}/users?page=1&per_page=20")
    JSON.parse(response.body)
  end
end
