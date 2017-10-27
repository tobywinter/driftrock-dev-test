require 'httparty'
require 'json'

class ApiClient

  def check_status
    response = HTTParty.get("https://driftrock-dev-test-2.herokuapp.com/status")
    response.code
  end

  def users
    response = HTTParty.get("https://driftrock-dev-test-2.herokuapp.com/users?page=1&per_page=20")
    JSON.parse(response.body)
  end
end
