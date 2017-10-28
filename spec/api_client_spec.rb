describe ApiClient do
  subject(:api_client) { described_class.new }

  it 'calls API with :check_status' do
    expect(api_client.check_status).to eq 200
  end

  it 'queries api for users with :users' do
    expect(api_client.users[0]).to include("id")
  end

  context 'Users' do

    it 'returns parsed user data' do
      expect(api_client.users.class).to eq Array
    end

    # it 'can search for a user by email' do
    #   expect(api_client.users)
    # end

  end

end
