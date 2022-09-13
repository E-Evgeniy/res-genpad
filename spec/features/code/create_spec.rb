# frozen_string_literal: true

require 'rails_helper'

feature 'User can create code' do
  given(:user) { User.create!(first_name: 'user', last_name: 'test', email: 'user@test.com', password: '12345678') }
  scenario 'Authenticated user create code' do
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'

    visit codes_path
    click_on 'New code'

    fill_in 'Code', with: '123'
    click_on 'Create code'

    expect(page).to have_content 'Your code successfully created.'
  end
  scenario 'Authenticated user create code with errors'
  scenario 'Unauthenticated user create code'
end
