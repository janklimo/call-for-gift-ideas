# frozen_string_literal: true

describe Call, type: :model do
  it 'autogenerates a slug only on create' do
    call = FactoryGirl.create(:call)
    slug = call.slug
    expect(call).to be_valid
    expect(call).to be_active
    expect(slug).to be_present

    call.update(recipient_name: 'Jon')
    expect(call.slug).to eq slug
  end
end
