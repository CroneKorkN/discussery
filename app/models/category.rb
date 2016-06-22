class Category < ActiveRecord::Base
  has_many :categories, foreign_key: 'parent_id'
  has_many :topics
  belongs_to :category

  scope :root, ->{ where("parent_id IS NULL") }


  def self.visible_for user
    where("id IN(?)", AccessControl.category_ids_visibile_for(user))
  end

  def parent_categories
    unless @parent_categories
      @parent_categories = []
      collect_parent_categories self
    end
    @parent_categories
  end

  def collect_parent_categories category
    if category.category
      @parent_categories << category.category
      collect_parent_categories category.category
    end
  end
end
