# frozen_string_literal: true

require 'rails_helper'

feature 'User can create code' do
  given(:user) { create(:user) }

  describe 'Authenticated user' do
    background do
      sign_in(user)
      visit codes_path
      click_on 'New code'
    end
    
    scenario 'create code' do
      fill_in 'Code', with: '123'
      click_on 'Create code'
    
      expect(page).to have_content 'Your code successfully created.'
      expect(page).to have_content '123'
    end
    
    scenario 'create code with errors' do
      click_on 'Create code'
      expect(page).to have_content "Code can't be blank"
    end 
  end

  scenario 'Unauthenticated user create code' do
    visit codes_path
    click_on 'New code'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
