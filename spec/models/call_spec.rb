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
    call = FactoryGirl.build(:call, recipient_name: nil, recipient_email: nil,
                            sender_email: nil)
    expect(call).not_to be_valid
    call.recipient_name = 'Jon'
    expect(call).not_to be_valid
    call.recipient_email = 'jon@someemail.com'
    expect(call).not_to be_valid
    call.sender_email = 'mike.tyson@gmail.com'
    expect(call).to be_valid
  end
end
