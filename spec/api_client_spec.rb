describe ApiClient do
  subject(:api_client) { described_class.new }

  it 'calls API with :check_status' do
    expect(api_client.check_status).to eq 200
  end

  it 'queries api for users with :users' do
    expect(api_client.users).to include("data")
  end

end
