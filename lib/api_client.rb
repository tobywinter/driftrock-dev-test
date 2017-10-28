require 'httparty'
require 'json'

class ApiClient
  BASE_URI = "https://driftrock-dev-test-2.herokuapp.com"
  PAGE_LENGTH = 2000

  def check_status
    response = HTTParty.get("#{BASE_URI}/status")
    response.code
  end

  def users
    i = 1
    data_available = true
    users = []
    while data_available do
      response = HTTParty.get("#{BASE_URI}/users?page=#{i}&per_page=#{PAGE_LENGTH}")
      users += JSON.parse(response.body)["data"]
      data_available = page_full?(response)
      i += 1
    end
    users
  end

private

  def page_full?(response)
    JSON.parse(response.body)["data"].length == PAGE_LENGTH
  end

end
