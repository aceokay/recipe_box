require('spec_helper')

describe('recipe path', {:type => :feature}) do
  it('allows a user to add a new recipe') do
    visit('/')
    fill_in('name', :with => "Pizza")
    fill_in('instructions', :with => "Find store, buy pizza.")
    select('7', from: "rating")
    click_button('Add Recipe!')
    expect(page).to have_content('Pizza')
  end
end
