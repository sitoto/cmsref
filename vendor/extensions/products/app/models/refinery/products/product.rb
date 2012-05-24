module Refinery
  module Products
    class Product < Refinery::Core::BaseModel
      self.table_name = 'refinery_products'

      attr_accessible :title, :position, :size, :date, :title_info, :dimension, :note, :specification, :accessories, :blurb, :position, :photo_id

      acts_as_indexed :fields => [:title, :size, :note, :blurb]

      validates :title, :presence => true, :uniqueness => true

      belongs_to :photo, :class_name => '::Refinery::Image'
    end
  end
end
