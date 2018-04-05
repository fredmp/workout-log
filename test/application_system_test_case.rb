require 'test_helper'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :chrome, screen_size: [1400, 1400]

  def login!
    visit new_user_session_url
    fill_in 'Email', with: 'user@domain.com'
    fill_in 'Password',  with: '123456'
    click_on 'Log in'
  end

  def logout!
    visit root_url
    click_on 'Log out'
  end
end
