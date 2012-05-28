module Refinery
  module Categories
    class CategoriesController < ::ApplicationController

      before_filter :find_all_categories
      before_filter :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @category in the line below:
        present(@page)
      end

      def show
        @category = Category.find(params[:id])
	@category_top = @category
	@html = ""
	@html += "<ul>"

	while @category_top.parent do 
	  @category_top = @category_top.parent
	end
	# i know 
	# first to find the last level
	# second to set the menu
	# the follow method is bad even wrong change it please
	#

	if @category_top.children
	  @category_top.children.each do |c|
	    @html += "<li class=#{}> <a href='/categories/#{c.id}'>#{c.name}</a></li>"
	    if c.children
	      @html += "<ul class='submenu2'>"
	      c.children.each do |cc|
		@html += "<li> <a href='/categories/#{cc.id}'>#{cc.name} </a></li>"
	      end
	      @html += "</ul>"

	    end

	  end
	end
	@html += "</ul>"



	if @category.children.first.nil?
	  @category_sub = @category
	else
  	  @category_sub = @category.children.first
	end

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @category in the line below:
        present(@page)
      end

    protected

      def find_all_categories
        @categories = Category.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/categories").first
      end

    end
  end
end
