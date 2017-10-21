require 'rails_helper'

describe 'Calls', type: :feature do
  describe 'show page' do
    before do
      @call = create(:call)
    end
    it 'renders properly' do
      visit call_path @call.slug
      expect(page).to have_css 'div#page'
    end
  end
end
