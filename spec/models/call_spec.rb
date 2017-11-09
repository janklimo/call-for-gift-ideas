require 'rails_helper'

describe Call, type: :model do
  it 'autogenerates a slug only on create' do
    call = create(:call)
    slug = call.slug
    expect(call).to be_valid
    expect(call).to be_active
    expect(slug).to be_present

    call.update(recipient_name: 'Jon')
    expect(call.slug).to eq slug
  end

  it 'validates stuff' do
    call = build(:call, recipient_name: nil, recipient_email: nil,
                            sender_email: nil)
    expect(call).not_to be_valid
    call.recipient_name = 'Jon'
    expect(call).not_to be_valid
    call.recipient_email = 'jon@someemail.com'
    expect(call).not_to be_valid
    call.sender_email = 'mike.tyson@gmail.com'
    expect(call).to be_valid
  end

  describe 'products' do
    before do
      @drill = create(:product, name: 'Drill', target_audience: :men)
      @jet = create(:product, name: 'Jet', target_audience: :men)
      @makeup = create(:product, name: 'Makeup', target_audience: :women)
      @call = create(:call, recipient_sex: :female)
    end

    it 'loads the correct products' do
      expect(@call.products).to eq [@makeup]
    end
  end

  describe 'total_wishlist_items_count' do
    before do
      create(:call, preferences: ['1', '5', '2'])
      create(:call, preferences: ['1', '5', '2', '11', '9'])
    end

    it 'returns the right number' do
      expect(Call.total_wishlist_items_count).to eq 8
    end
  end
end
