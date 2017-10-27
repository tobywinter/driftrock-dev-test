describe ApiClient do
  subject(:api_client) { described_class.new }

  it 'calls API with :checkstatus' do
    expect(api_client.checkstatus).to eq 200
  end

end
