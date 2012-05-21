module Refinery
  module Products
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Products

      engine_name :refinery_products

      initializer "register refinerycms_products plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "products"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.products_admin_products_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/products/product'
          }
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Products)
      end
    end
  end
end
