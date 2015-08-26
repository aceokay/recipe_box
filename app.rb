require("bundler/setup")
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
  erb(:recipe)
end

post('/recipes/:id') do
  ingredient_name = params.fetch('ingredient')
  recipe_id = params.fetch('id').to_i()
  new_ingredient = Ingredient.create({:name => ingredient_name})
  Recipe.find(recipe_id).ingredients.push(new_ingredient)
  redirect back
end

delete('/recipes/delete/ingredients/:id') do
  ingredient_id = params.fetch('id').to_i()
  ingredient = Ingredient.find(ingredient_id)
  ingredient.destroy()
  redirect back
end
