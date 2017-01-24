module RequestHelpers
  def verify_merchant_attributes(merchant, db_merchant)
    expect(merchant).to have_key('id')
    expect(merchant['id']).to eq db_merchant.id
    expect(merchant['id']).to be_a(Integer)

    expect(merchant).to have_key('name')
    expect(merchant['name']).to eq db_merchant.name
    expect(merchant['name']).to be_a(String)
  end
end
