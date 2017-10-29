describe ApiClient do
  subject(:api_client) { described_class.new }

  it 'calls API with :check_status' do
    expect(api_client.check_status).to eq 200
  end

  context 'Users' do

    before do
      api_client.get_users
    end

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

  context 'Purchases' do

    it 'get_purchases saves purchase data in @purchases' do
      api_client.get_purchases
      expect(api_client.purchases[0]).to include("item")
    end

    it 'can search for purchases by user id' do
      api_client.get_purchases
      purchase = {"user_id"=>"MQIK-25DG-IG10-EA5I",
         "item"=>"Synergistic Plastic Pants",
         "spend"=>"9.53"}
      expect(api_client.find_user_purchases('MQIK-25DG-IG10-EA5I')).to include purchase
    end

    it 'can find the sum of a set of purchases cost' do
      purchases = [{"user_id"=>"IT2W-5ZIE-Y48U-4HNE",
        "item"=>"Fantastic Copper Plate",
        "spend"=>"50.12"},
        {"user_id"=>"XYH0-7HTD-A6MH-M2NH",
          "item"=>"Sleek Copper Bench",
          "spend"=>"10.2"},
        {"user_id"=>"EHK5-TURY-0IQQ-CZPC",
          "item"=>"Gorgeous Iron Computer",
          "spend"=>"87.55"}]
      expect(api_client.sum_value(purchases)).to eq 147.87
    end
  end

  context "Queries" do

    before do
      api_client.get_purchases
      api_client.get_users
    end
    it 'can calculate total_spend for a user' do
      expect(api_client.total_spend('damaris.strosin@ruel.name')).to eq 212.73
    end

    it 'can calculate average_spend for a user' do
      expect(api_client.average_spend('damaris.strosin@ruel.name')).to eq 42.546
    end

    it 'can calculate user with the most purchases' do
      p api_client.most_loyal
    end
  end

end
