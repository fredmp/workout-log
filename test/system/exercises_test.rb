require "application_system_test_case"

class ExercisesTest < ApplicationSystemTestCase

  def setup
    @bench = exercises(:bench)
    login!
    visit exercises_url
  end

  def teardown
    logout!
  end

  test 'index' do
    assert_selector 'h1', text: 'Exercises'
    assert page.has_content?(@bench.name)
  end

  test 'show' do
    click_on @bench.name
    assert page.has_content?(@bench.description)
  end

  test 'create' do
    click_on 'New Exercise'
    select('Aerobic', from: 'exercise_exercise_category_id')
    fill_in 'Name', with: 'Running'
    fill_in 'Description',  with: 'A good exercise'
    click_on 'Create Exercise'
    assert page.has_content?('Exercise created successfully')
  end

  test 'update' do
    find("a[href='/exercises/#{@bench.id}/edit']").click
    fill_in 'Name', with: 'Running'
    fill_in 'Description',  with: 'A good exercise'
    click_on 'Update Exercise'
    assert page.has_content?('Exercise updated successfully')
  end

  test 'delete' do
    accept_alert do
      find("a[href='/exercises/#{@bench.id}'][data-method='delete']").click
    end
    assert page.has_content?('Exercise removed successfully')
  end
end
