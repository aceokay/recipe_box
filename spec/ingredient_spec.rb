require('spec_helper')

describe(Ingredient) do
  describe('#recipes') do
    it { should have_and_belong_to_many(:recipes) }
  end

  describe('#create') do
    it('normalizes text') do
      new_ingredient = Ingredient.create({:name => " milk    "})
      expect(new_ingredient.name).to(eq("Milk"))
      expect(Ingredient.find(new_ingredient.id()).name).to(eq("Milk"))
    end

    it('does not save an ingredient already saved in the database') do
      new_ingredient = Ingredient.create({:name => " milk    "})
      new_ingredient2 = Ingredient.create({:name => " milk    "})
      new_ingredient3 = Ingredient.create({:name => " bread    "})
      expect(Ingredient.all()).to(eq([new_ingredient, new_ingredient3]))
    end
  end
end
