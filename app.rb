require("bundler/setup")
require('pry')
Bundler.require(:default)

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get('/') do
  @recipes = Recipe.all()
  erb(:index)
end

post('/recipes') do
  name = params.fetch('name')
  instructions = params.fetch('instructions')
  rating = params.fetch('rating').to_i()
  Recipe.create({:name => name, :instructions => instructions, :rating => rating})
  redirect back
end

delete('/recipes/delete/:id') do
  recipe = Recipe.find(params.fetch('id').to_i())
  recipe.destroy
  redirect back
end

get('/recipes/:id') do
  @recipe = Recipe.find(params.fetch('id').to_i)
  @ingredients = Ingredient.all()
  erb(:recipe)
end

post('/recipes/:id/add/ingredients') do
  ingredient_name = params.fetch('ingredient')
  recipe_id = params.fetch('id').to_i()
  new_ingredient = Ingredient.create({:name => ingredient_name})
  # binding.pry
  if new_ingredient.id
    Recipe.find(recipe_id).ingredients.push(new_ingredient)
    redirect back
  else
    redirect back
  end
end

post('/recipes/:id/ingredients') do
  recipe_id = params.fetch('id').to_i()
  ingredient_id = params.fetch('ingredient_id').to_i()
  recipe = Recipe.find(recipe_id)
  recipe.ingredients().each do |ingredient|
    if ingredient.id == ingredient_id
      redirect back
    end
  end
  ingredient = Ingredient.find(ingredient_id)
  recipe.ingredients.push(ingredient)
  redirect back
end

delete('/recipes/delete/ingredients/:id') do
  ingredient_id = params.fetch('id').to_i()
  ingredient = Ingredient.find(ingredient_id)
  ingredient.destroy()
  redirect back
end

get('/ingredients') do
  @ingredients = Ingredient.all()
  erb(:ingredients)
end

post('/ingredients') do
  name = params.fetch('name')
  Ingredient.create({:name => name})
  redirect back
end

get('/ingredients/:id') do
  @ingredient = Ingredient.find(params.fetch('id').to_i)
  @recipes = @ingredient.recipes()
  erb(:ingredient)
end

delete('/ingredients/delete/:id') do
  ingredient_id = params.fetch('id').to_i()
  ingredient = Ingredient.find(ingredient_id)
  ingredient.destroy()
  redirect back
end
