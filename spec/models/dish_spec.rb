require 'rails_helper'

RSpec.describe Dish, type: :model do

  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
  end

  describe "relationships" do
    it {should belong_to :chef}
    it { should have_many :dish_ingredients }
    it { should have_many(:ingredients).through(:dish_ingredients)}
  end

  before(:each) do
    @chef = Chef.create(name: "Gordon Ramsay")

    @dish = Dish.create(name: "Chicken and Rice", description: "simple recipe", chef_id: @chef.id)

    @ingredient1 = Ingredient.create(name: "Chicken Thigh", calories: 400)
    @ingredient2 = Ingredient.create(name: "Rice", calories: 300)
    @ingredient3 = Ingredient.create(name: "Teriyaki Sauce", calories: 200)
    @ingredient4 = Ingredient.create(name: "Scallions", calories: 100)

    DishIngredient.create(dish_id: @dish.id, ingredient_id: @ingredient1.id)
    DishIngredient.create(dish_id: @dish.id, ingredient_id: @ingredient2.id)
    DishIngredient.create(dish_id: @dish.id, ingredient_id: @ingredient3.id)
  end

  describe "#all_ingredient_names" do
    it "can create an array with all ingredient names" do
      expect(@dish.all_ingredient_names).to eq([@ingredient1.name, @ingredient2.name, @ingredient3.name])
    end
  end

end