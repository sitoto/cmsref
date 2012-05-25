module Refinery
  module Categories
    class Category < Refinery::Core::BaseModel
      self.table_name = 'refinery_categories'

      has_many :products, :class_name => Refinery::Products::Product

      attr_accessible :name, :parent_id, :sort_order, :position

      acts_as_indexed :fields => [:name]

      validates :name, :presence => true, :uniqueness => true
      
      belongs_to :parent,
		 :class_name => 'Category'
      has_many   :children,
		 :class_name => "Category",
		 :foreign_key => "parent_id",
		 :order	=> "name",
		 :dependent => :destroy
    end
  end
end
