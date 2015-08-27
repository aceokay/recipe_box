require('spec_helper')

describe('the ingredient funtionality', {:type => :feature}) do
  it('allows user to add new recipe') do
    visit('/ingredients')
    fill_in('name', with: "nuts")
    click_button('Add Ingredient')
    expect(page).to have_content('Nuts')
  end
end
