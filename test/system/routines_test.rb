require "application_system_test_case"

class RoutinesTest < ApplicationSystemTestCase

  def setup
    @monday = routines(:monday)
    login!
    visit routines_url
  end

  def teardown
    logout!
  end

  test 'index' do
    assert_selector 'h1', text: 'Routines'
    assert page.has_content?(@monday.name)
  end

  test 'show' do
    click_on @monday.name
    assert page.has_content?('Add Exercise')
  end

  test 'create' do
    click_on 'New Routine'
    fill_in 'Name', with: 'Friday'
    fill_in 'Description',  with: 'Description'
    click_on 'Create Routine'
    assert page.has_content?('Routine created successfully')
  end

  test 'update' do
    find("a[href='/routines/#{@monday.id}/edit']").click
    fill_in 'Name', with: '20'
    fill_in 'Description',  with: 'Description'
    click_on 'Update Routine'
    assert page.has_content?('Routine updated successfully')
  end

  test 'delete' do
    accept_alert do
      find("a[href='/routines/#{@monday.id}'][data-method='delete']").click
    end
    assert page.has_content?('Routine removed successfully')
  end
end
