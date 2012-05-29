module Refinery
  module Products
    class ProductsController < ::ApplicationController

      before_filter :find_all_products
      before_filter :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @product in the line below:
        present(@page)
      end

      def show
        @product = Product.find(params[:id])
	@category = @product.category

	@category_top = @category
	@category_last = @category
	
	@html = ""
	@html += "<ul class='abc'>"

	while @category_top.parent do 
	  @category_top = @category_top.parent
	end
	while @category_last.children.first do 
	  @category_last = @category_last.children.first
	end

	# i know 
	# first to find the last level
	# second to set the menu
	# the follow method is bad even wrong change it please
	#

	if (@category_last.parent and @category_last.parent.parent_id != 0) 
	  @html_2 = ""
	  
	  @category_last.parent.children.each do |l|
	    @html_2 += "<li #{l.id == @category.id ? 'class="current"' : ''}><a href='/categories/#{l.id}' >#{l.name}</a></li>"
	  end

	  @category_middle = @category_last.parent
	  if @category_middle.parent
	     @category_middle.parent.children.each do |m|
	      if @category_middle.id == m.id
		@html += "<li class='open current'}> <a href='/categories/#{m.id}'>#{m.name}</a> <ul class=\"submenu2\">#{@html_2}</ul> </li>"
	      else
		@html += "<li><a href='/categories/#{m.id}' >#{m.name}</a></li>"
	      end
	    end
	  end





        elsif (@category_last.parent and @category_last.parent.parent_id == 0)
	  @category_last.parent.children.each do |l|
	    @html += "<li #{l.id == @category.id ? 'class="current open"' : ''}><a href='/categories/#{l.id}' >#{l.name}</a></li>"

	  end
	end

	@html += "</ul>"


        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @product in the line below:
        present(@page)
      end

    protected

      def find_all_products	
	@products = Product.order('date DESC') 
      end 
      def find_page
        @page = ::Refinery::Page.where(:link_url => "/products").first
      end

    end
  end
end
