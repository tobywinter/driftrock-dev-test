describe ApiClient do
  subject(:api_client) { described_class.new }

  before do
    api_client.get_users
  end

  it 'calls API with :check_status' do
    expect(api_client.check_status).to eq 200
  end

  context 'Users' do

    it 'returns parsed user data' do
      expect(api_client.users.class).to eq Array
    end

    it 'get_users saves user data in @users' do
      expect(api_client.users[0]).to include("id")
    end

    it 'can search for a user by email' do
      user = {"id"=>"MQIK-25DG-IG10-EA5I",
         "first_name"=>"Damaris",
         "last_name"=>"Strosin",
         "phone"=>"1-612-206-7708",
         "email"=>"damaris.strosin@ruel.name"}
      expect(api_client.find_user('damaris.strosin@ruel.name')).to eq user
    end

  end

end
