require 'rails_helper'

RSpec.describe 'Merchants Record API', type: :request do
  it 'returns a list of merchants' do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_success

    merchants = JSON.parse(response.body)
    merchant  = merchants.first

    expect(merchants.count).to eq(3)

    expect(merchant).to have_key('id')
    expect(merchant['id']).to be_a(Integer)

    expect(merchant).to have_key('name')
    expect(merchant['name']).to be_a(String)
  end

  it 'can get a single merchant' do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    expect(response).to be_success

    merchant = JSON.parse(response.body)

    expect(merchant).to have_key('id')
    expect(merchant['id']).to eq(id)
    expect(merchant['id']).to be_a(Integer)

    expect(merchant).to have_key('name')
    expect(merchant['name']).to eq(Merchant.first.name)
    expect(merchant['name']).to be_a(String)
  end

  it 'finds a single merchant based on name' do
    name = create(:merchant).name

    get "/api/v1/merchants/find?name=#{name}"

    expect(response).to be_success

    merchant = JSON.parse(response.body)

    expect(merchant).to have_key('id')
    expect(merchant['id']).to eq(Merchant.first.id)
    expect(merchant['id']).to be_a(Integer)

    expect(merchant).to have_key('name')
    expect(merchant['name']).to eq(name)
    expect(merchant['name']).to be_a(String)
  end

  it 'finds a single merchant based on id' do
    id = create(:merchant).id

    get "/api/v1/merchants/find?id=#{id}"

    expect(response).to be_success

    merchant = JSON.parse(response.body)

    expect(merchant).to have_key('id')
    expect(merchant['id']).to eq(id)
    expect(merchant['id']).to be_a(Integer)

    expect(merchant).to have_key('name')
    expect(merchant['name']).to eq(Merchant.first.name)
    expect(merchant['name']).to be_a(String)
  end

  it 'finds a single merchant based on id and name' do
    db_merchant = create(:merchant)
    id          = db_merchant.id
    name        = db_merchant.name

    get "/api/v1/merchants/find?id=#{id}&name=#{name}"

    expect(response).to be_success

    merchant = JSON.parse(response.body)

    expect(merchant).to have_key('id')
    expect(merchant['id']).to eq(id)
    expect(merchant['id']).to be_a(Integer)

    expect(merchant).to have_key('name')
    expect(merchant['name']).to eq(name)
    expect(merchant['name']).to be_a(String)
  end

  it 'finds all merchants matching name' do
    name = create_list(:merchant, 3).first.name

    get "/api/v1/merchants/find_all?name=#{name}"

    expect(response).to be_success

    merchants = JSON.parse(response.body)
    names     = merchants.map { |merchant| merchant['name'] }

    expect(merchants.count).to eq(3)
    expect(names.all? { |n| n == name }).to be true
  end

  it 'finds all merchants matching created_at timestamp' do
    create_list(:merchant, 3)
    created = Merchant.first.created_at.to_json

    get "/api/v1/merchants/find_all?created_at=#{created}"

    expect(response).to be_success

    merchants = JSON.parse(response.body)
    created_ats = merchants.map { |merchant| merchant['created_at'] }

    expect(merchants.count).to eq(3)
    expect(created_ats.all? { |c| created.include?(c) }).to be true
  end

  it 'picks a random merchant' do
    create_list(:merchant, 100)

    get '/api/v1/merchants/random'
    merchant1 = JSON.parse(response.body)

    get '/api/v1/merchants/random'
    merchant2 = JSON.parse(response.body)

    expect(merchant1['id']).to_not eq(merchant2['id'])
  end

  context 'invalid data' do
    it 'raises error for invalid id' do
      id = 123124

      get "/api/v1/merchants/find?id=#{id}"
      expect(response.body).to eq('null')
    end

    it 'returns null for invalid name' do
      name = 'Bilbo'

      get "/api/v1/merchants/find?name=#{name}"

      expect(response.body).to eq("null")
    end

    it 'returns null if id is valid and name is wrong' do
      id   = create(:merchant).id
      name = 'Sam'

      get "/api/v1/merchants/find?id=#{id}&name=#{name}"

      expect(response.body).to eq("null")
    end

    it 'raises error if name is valid but id is wrong' do
      name = create(:merchant).name
      id   = 123124

      get "/api/v1/merchants/find?id=#{id}&name=#{name}"

      expect(response.body).to eq("null")
    end
  end
end
