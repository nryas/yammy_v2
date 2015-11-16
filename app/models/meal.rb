class Meal < ActiveRecord::Base
  has_many :menus
  has_many :dishes, through: :menus
end
