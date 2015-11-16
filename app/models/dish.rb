class Dish < ActiveRecord::Base
  has_many :menus
  has_many :meals, through: :menus
end
