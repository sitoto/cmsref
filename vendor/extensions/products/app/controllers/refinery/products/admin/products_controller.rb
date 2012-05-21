module Refinery
  module Products
    module Admin
      class ProductsController < ::Refinery::AdminController

        crudify :'refinery/products/product', :xhr_paging => true

      end
    end
  end
end
