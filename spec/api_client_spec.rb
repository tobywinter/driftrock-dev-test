describe ApiClient do
  subject(:api_client) { described_class.new }

  before do
    api_client.instance_variable_set(:@users, [{"id"=>"3ASC-MN9C-JPUU-5AKX",
        "first_name"=>"Nico", "last_name"=>"Rodriguez",
        "phone"=>"816-682-1552 x540", "email"=>"rodriguez.nico@hamill.co"},
      {"id"=>"0G2M-BGVV-I4CY-PI20", "first_name"=>"Caesar",
        "last_name"=>"Metz", "phone"=>"574.732.0454",
        "email"=>"caesar_metz@osinski.name"},
      {"id"=>"MNYR-CMZZ-1VR0-OY5R", "first_name"=>"Roslyn",
        "last_name"=>"Schowalter", "phone"=>"191.636.9911",
        "email"=>"schowalter.roslyn@moen.name"}])
    api_client.instance_variable_set(:@purchases, [{"user_id"=>"3ASC-MN9C-JPUU-5AKX",
        "item"=>"Lightweight Leather Keyboard", "spend"=>"2.49"},
      {"user_id"=>"3ASC-MN9C-JPUU-5AKX", "item"=>"Heavy Duty Cotton Keyboard",
        "spend"=>"94.52"},
      {"user_id"=>"3ASC-MN9C-JPUU-5AKX", "item"=>"Sleek Aluminum Clock",
        "spend"=>"42.17"},
      {"user_id"=>"0G2M-BGVV-I4CY-PI20", "item"=>"Synergistic Iron Plate",
        "spend"=>"65.36"},
      {"user_id"=>"0G2M-BGVV-I4CY-PI20", "item"=>"Synergistic Steel Gloves",
        "spend"=>"2.58"},
      {"user_id"=>"0G2M-BGVV-I4CY-PI20", "item"=>"Rustic Iron Clock",
        "spend"=>"24.23"},
      {"user_id"=>"0G2M-BGVV-I4CY-PI20", "item"=>"Synergistic Concrete Table",
        "spend"=>"65.09"},
      {"user_id"=>"MNYR-CMZZ-1VR0-OY5R", "item"=>"Heavy Duty Bronze Bench",
        "spend"=>"21.44"},
      {"user_id"=>"MNYR-CMZZ-1VR0-OY5R", "item"=>"Practical Rubber Table",
        "spend"=>"64.6"},
      {"user_id"=>"MNYR-CMZZ-1VR0-OY5R", "item"=>"Awesome Aluminum Bench",
        "spend"=>"37.6"},
      {"user_id"=>"MNYR-CMZZ-1VR0-OY5R", "item"=>"Mediocre Rubber Coat",
        "spend"=>"55.39"},
      {"user_id"=>"MNYR-CMZZ-1VR0-OY5R", "item"=>"Synergistic Concrete Table",
        "spend"=>"5.68"}])
  end

  it 'calls API with :check_status' do
    expect(api_client.check_status).to eq 200
  end

  context 'Users' do

    before do
    end

    it 'get_users saves user data in @users' do
      expect(api_client.users[0]).to include("id")
    end

    it 'can search for a user by email' do
      user = api_client.users[1]
      expect(api_client.find_user("caesar_metz@osinski.name")).to eq user
    end

  end

  context 'Purchases' do

    it 'get_purchases saves purchase data in @purchases' do
      expect(api_client.purchases[0]).to include("item")
    end

    it 'can search for purchases by user id' do
      purchase = api_client.purchases[3]
      expect(api_client.find_user_purchases('0G2M-BGVV-I4CY-PI20')).to include purchase
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

    it 'can calculate total_spend for a user' do
      expect(api_client.total_spend('caesar_metz@osinski.name')).to eq 157.26
    end

    it 'can calculate average_spend for a user' do
      expect(api_client.average_spend('caesar_metz@osinski.name')).to eq 39.315
    end

    it 'can calculate user with the most purchases' do
      loyal_user = api_client.users[2]['email']
      expect(api_client.most_loyal).to eq loyal_user
    end

    it 'can calculate the user with the highest spend' do
      expect(api_client.highest_value).to eq 'schowalter.roslyn@moen.name'
    end

    it 'can calculate the item sold the most times' do
      expect(api_client.most_sold).to eq 'Synergistic Concrete Table'
    end
  end
end
