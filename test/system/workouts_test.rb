require 'application_system_test_case'

class WorkoutsTest < ApplicationSystemTestCase

  def setup
    @today = workouts(:today)
    login!
    visit workouts_url
  end

  def teardown
    logout!
  end

  test 'index' do
    assert_selector 'h1', text: 'Workouts'
    assert page.has_content?(@today)
  end

  test 'show' do
    click_on @today
    assert page.has_content?('Add Exercise')
  end

  test 'create' do
    click_on 'New Workout'
    select('Monday', from: 'routine_id')
    fill_in 'Duration', with: '20'
    fill_in 'Comments',  with: 'A comment'
    click_on 'Create Workout'
    assert page.has_content?('Workout created successfully')
  end

  test 'update' do
    find("a[href='/workouts/#{@today.id}/edit']").click
    fill_in 'Duration', with: '20'
    fill_in 'Comments',  with: 'A comment'
    click_on 'Update Workout'
    assert page.has_content?('Workout updated successfully')
  end

  test 'delete' do
    accept_alert do
      find("a[href='/workouts/#{@today.id}'][data-method='delete']").click
    end
    assert page.has_content?('Workout removed successfully')
  end
end
