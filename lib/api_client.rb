require 'httparty'
require 'json'

class ApiClient

  def check_status
    response = HTTParty.get("https://driftrock-dev-test-2.herokuapp.com/status")
    response.code
  end
end
