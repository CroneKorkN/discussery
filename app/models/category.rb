class Category < ActiveRecord::Base
  has_many :categories,
    foreign_key: 'parent_id'
  has_many :topics
  belongs_to :category, optional: true

  scope :root, ->{ where("parent_id IS NULL") }

  def all_categories
    unless @all_categories
      @all_category_ids = []
      categories.each do |category|
        collect_category_ids category
      end
      @all_categories = Group.where "ID IN(?)", @all_group_ids
    end
    return @all_categories
  end

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
  
private

  def collect_category_ids category
    @all_category_ids << category
    category.categories.each do |category|
      collect_category_ids category
    end
  end

  def collect_parent_categories category
    if category.category
      @parent_categories << category.category
      collect_parent_categories category.category
    end
  end
end
