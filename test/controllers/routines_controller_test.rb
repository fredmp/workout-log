require 'test_helper'

class RoutinesControllerTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers

  def setup
    sign_in users(:user)
  end

  test 'index' do
    get routines_url
    assert_response :success
  end

  test 'show' do
    get routine_url(routines(:monday).id)
    assert_response :success
  end

  test 'new' do
    get new_routine_url
    assert_response :success
  end

  test 'create' do
    post routines_url({
      routine: {
        name: 'Name',
        description: 'Description'
      }
    })
    assert_equal 'Routine created successfully', flash[:notice]
    assert_redirected_to routines_url
  end

  test 'update' do
    put routine_url(routines(:monday).id, {
      routine: {
        name: 'Friday',
        description: 'Description'
      }
    })
    assert_equal 'Routine updated successfully', flash[:notice]
    assert_redirected_to routines_url
  end

  test 'destroy' do
    delete routine_url(routines(:monday).id)
    assert_equal 'Routine removed successfully', flash[:notice]
    assert_redirected_to routines_url
  end
end
