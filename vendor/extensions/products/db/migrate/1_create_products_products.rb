class CreateProductsProducts < ActiveRecord::Migration

  def up
    create_table :refinery_products do |t|
      t.string :title
      t.string :size
      t.datetime :date
      t.integer :photo_id
      t.integer :category_id
      t.text :title_info
      t.text :note
      t.text :blurb
      t.text :specification
      t.text :accessories
      t.text :dimension
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-products"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/products/products"})
    end

    drop_table :refinery_products

  end

end
