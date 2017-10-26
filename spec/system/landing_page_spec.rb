require 'rails_helper'

describe 'Landing page' do
  scenario 'user visits the landing page' do
    visit '/'

    expect(page).to have_text "Let's Do It!"
  end
end
