class Category < ActiveRecord::Base
  has_many :categories,
    foreign_key: 'parent_id'
  has_many :topics
  belongs_to :category, optional: true

  def all_categories
    @all_categories ||= Recursion.collect self, :categories
  end

  def self.visible_for user
    where("id IN(?)", AccessControl.category_ids_visibile_for(user))
  end

  def parent_categories
    @parent_categories ||= Recursion.collect self, :category
  end
end
