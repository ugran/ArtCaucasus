class PagesController < ApplicationController

  require 'will_paginate/array'
	
  def home
      @carousels = Carousel.all.select{|x| x.placerank > 0}.sort_by(&:"#{:placerank}")
      if params[:q].present?
        @q = Item.where(:sold_out => 0).search(params[:q])
        @items = @q.result.order("created_at DESC").paginate(:page => params[:page], :per_page => 30)
      else
        @q = Item.where(:sold_out => 0).search(params[:q])
        @items = Item.all.order("RANDOM()").paginate(:page => params[:page], :per_page => 30)
      end
      @og_image = 'artiveria.jpg'
      @og_title = 'Artiveria.com is an online store where you can buy Georgian Art.'
      @og_description = 'Aritveria.com is a joint venture of an American company Artiveria LLC and of its sister company Artiveria Ltd. based in Tbilisi, Georgia. Artiveria.com is the best place to buy Georgian Art from any place in the world.'
  end

  def paintings
    @q = Item.where(:item_type => "Painting", :sold_out => 0).search(params[:q])

    if (params[:theme].present? && params[:sort_by].nil?)
      @theme = params[:theme]
      @items = Item.where(:item_type => "Painting", :item_tag => params[:theme], :sold_out => 0).order("created_at DESC").paginate(:page => params[:page], :per_page => 30)
    elsif (params[:sort_by].present? && params[:theme].nil?)
      @sort_by = params[:sort_by]
      if params[:sort_by] == 'Recently added'
        @items = Item.where(:item_type => "Painting", :sold_out => 0).order("created_at DESC").paginate(:page => params[:page], :per_page => 30)
      elsif params[:sort_by] == 'Random'
        @items = Item.where(:item_type => "Painting", :sold_out => 0).order("RANDOM()").paginate(:page => params[:page], :per_page => 30)
      elsif params[:sort_by] == 'Price low to high'
         @items = Item.where(:item_type => "Painting", :sold_out => 0).order(price: :asc).paginate(:page => params[:page], :per_page => 30)
      elsif params[:sort_by] == 'Price high to low'
         @items = Item.where(:item_type => "Painting", :sold_out => 0).order(price: :desc).paginate(:page => params[:page], :per_page => 30)
      elsif params[:sort_by] == 'Most Comments'
         @items = Item.where(:item_type => "Painting", :sold_out => 0).order(comments_count: :desc).paginate(:page => params[:page], :per_page => 30)
      elsif params[:sort_by] == 'Most Votes'
         @items = Item.where(:item_type => "Painting", :sold_out => 0).order(likes_count: :desc).paginate(:page => params[:page], :per_page => 30)
      elsif params[:sort_by] == 'Discounted Items'
        @items = Item.where(:item_type => "Painting", :sold_out => 0).where.not(:discount => 0).order("created_at DESC").paginate(:page => params[:page], :per_page => 30)
      elsif params[:sort_by] == 'Sold Items'
        @items = Item.where(:item_type => "Painting", :sold_out => 1).order("created_at DESC").paginate(:page => params[:page], :per_page => 30)
      end
    elsif (params[:theme].present? && params[:sort_by].present?)
      @theme = params[:theme]
      @sort_by = params[:sort_by]
      if params[:sort_by] == 'Recently added'
        @items = Item.where(:item_type => "Painting", :item_tag => params[:theme], :sold_out => 0).order("created_at DESC").paginate(:page => params[:page], :per_page => 30)
      elsif params[:sort_by] == 'Random'
        @items = Item.where(:item_type => "Painting", :item_tag => params[:theme], :sold_out => 0).order("RANDOM()").paginate(:page => params[:page], :per_page => 30)
      elsif params[:sort_by] == 'Price low to high'
         @items = Item.where(:item_type => "Painting", :item_tag => params[:theme], :sold_out => 0).order(price: :asc).paginate(:page => params[:page], :per_page => 30)
      elsif params[:sort_by] == 'Price high to low'
         @items = Item.where(:item_type => "Painting", :item_tag => params[:theme], :sold_out => 0).order(price: :desc).paginate(:page => params[:page], :per_page => 30)
      elsif params[:sort_by] == 'Most Comments'
         @items = Item.where(:item_type => "Painting", :item_tag => params[:theme], :sold_out => 0).order(comments_count: :desc).paginate(:page => params[:page], :per_page => 30)
      elsif params[:sort_by] == 'Most Votes'
         @items = Item.where(:item_type => "Painting", :item_tag => params[:theme], :sold_out => 0).order(likes_count: :desc).paginate(:page => params[:page], :per_page => 30)
      elsif params[:sort_by] == 'Discounted Items'
        @items = Item.where(:item_type => "Painting", :item_tag => params[:theme], :sold_out => 0).where.not(:discount => 0).order("created_at DESC").paginate(:page => params[:page], :per_page => 30)
      elsif params[:sort_by] == 'Sold Items'
         @items = Item.where(:item_type => "Painting", :item_tag => params[:theme], :sold_out => 1).order("created_at DESC").paginate(:page => params[:page], :per_page => 30)
      end
    elsif params[:q].present?
      @items = @q.result.order("created_at DESC").paginate(:page => params[:page], :per_page => 30)
    else
      @items = Item.where(:item_type => "Painting", :sold_out => 0).order("RANDOM()").paginate(:page => params[:page], :per_page => 30)
    end
  end

  def enamels
    @q = Item.where(:item_type => "Enamel", :sold_out => 0).search(params[:q])

    if (params[:theme].present? && params[:sort_by].nil?)
      @theme = params[:theme]
      @items = Item.where(:item_type => "Enamel", :item_tag => params[:theme], :sold_out => 0).order("created_at DESC").paginate(:page => params[:page], :per_page => 30)
    elsif (params[:sort_by].present? && params[:theme].nil?)
      @sort_by = params[:sort_by]
      if params[:sort_by] == 'Recently added'
        @items = Item.where(:item_type => "Enamel", :sold_out => 0).order("created_at DESC").paginate(:page => params[:page], :per_page => 30)
      elsif params[:sort_by] == 'Random'
        @items = Item.where(:item_type => "Enamel", :sold_out => 0).order("RANDOM()").paginate(:page => params[:page], :per_page => 30)
      elsif params[:sort_by] == 'Price low to high'
        @items = Item.where(:item_type => "Enamel", :sold_out => 0).order(price: :asc).paginate(:page => params[:page], :per_page => 30)
      elsif params[:sort_by] == 'Price high to low'
        @items = Item.where(:item_type => "Enamel", :sold_out => 0).order(price: :desc).paginate(:page => params[:page], :per_page => 30)
      elsif params[:sort_by] == 'Most Comments'
        @items = Item.where(:item_type => "Enamel", :sold_out => 0).order(comments_count: :desc).paginate(:page => params[:page], :per_page => 30)
      elsif params[:sort_by] == 'Most Votes'
        @items = Item.where(:item_type => "Enamel", :sold_out => 0).order(likes_count: :desc).paginate(:page => params[:page], :per_page => 30)
      elsif params[:sort_by] == 'Discounted Items'
        @items = Item.where(:item_type => "Enamel", :sold_out => 0).where.not(:discount => 0).order("created_at DESC").paginate(:page => params[:page], :per_page => 30)
      elsif params[:sort_by] == 'Sold Items'
        @items = Item.where(:item_type => "Enamel", :sold_out => 1).order("created_at DESC").paginate(:page => params[:page], :per_page => 30)
      end
    elsif (params[:theme].present? && params[:sort_by].present?)
      @theme = params[:theme]
      @sort_by = params[:sort_by]
      if params[:sort_by] == 'Recently added'
        @items = Item.where(:item_type => "Enamel", :item_tag => params[:theme], :sold_out => 0).order("created_at DESC").paginate(:page => params[:page], :per_page => 30)
      elsif params[:sort_by] == 'Random'
        @items = Item.where(:item_type => "Enamel", :item_tag => params[:theme], :sold_out => 0).order("RANDOM()").paginate(:page => params[:page], :per_page => 30)
      elsif params[:sort_by] == 'Price low to high'
        @items = Item.where(:item_type => "Enamel", :item_tag => params[:theme], :sold_out => 0).order(price: :asc).paginate(:page => params[:page], :per_page => 30)
      elsif params[:sort_by] == 'Price high to low'
        @items = Item.where(:item_type => "Enamel", :item_tag => params[:theme], :sold_out => 0).order(price: :desc).paginate(:page => params[:page], :per_page => 30)
      elsif params[:sort_by] == 'Most Comments'
        @items = Item.where(:item_type => "Enamel", :item_tag => params[:theme], :sold_out => 0).order(comments_count: :desc).paginate(:page => params[:page], :per_page => 30)
      elsif params[:sort_by] == 'Most Votes'
        @items = Item.where(:item_type => "Enamel", :item_tag => params[:theme], :sold_out => 0).order(likes_count: :desc).paginate(:page => params[:page], :per_page => 30)
      elsif params[:sort_by] == 'Discounted Items'
        @items = Item.where(:item_type => "Enamel", :item_tag => params[:theme], :sold_out => 0).where.not(:discount => 0).order("created_at DESC").paginate(:page => params[:page], :per_page => 30)
      elsif params[:sort_by] == 'Sold Items'
        @items = Item.where(:item_type => "Enamel", :item_tag => params[:theme], :sold_out => 1).order("created_at DESC").paginate(:page => params[:page], :per_page => 30)
      end
    elsif params[:q].present?
      @items = @q.result.order("created_at DESC").paginate(:page => params[:page], :per_page => 30)
    else
      @items = Item.where(:item_type => "Enamel", :sold_out => 0).order("RANDOM()").paginate(:page => params[:page], :per_page => 30)
    end
  end

  def textiles
    @q = Item.where(:item_type => "Textile", :sold_out => 0).search(params[:q])

    if (params[:theme].present? && params[:sort_by].nil?)
      @theme = params[:theme]
      @items = Item.where(:item_type => "Textile", :item_tag => params[:theme], :sold_out => 0).order("created_at DESC").paginate(:page => params[:page], :per_page => 30)
    elsif (params[:sort_by].present? && params[:theme].nil?)
      @sort_by = params[:sort_by]
      if params[:sort_by] == 'Recently added'
        @items = Item.where(:item_type => "Textile", :sold_out => 0).order("created_at DESC").paginate(:page => params[:page], :per_page => 30)
      elsif params[:sort_by] == 'Random'
        @items = Item.where(:item_type => "Textile", :sold_out => 0).order("RANDOM()").paginate(:page => params[:page], :per_page => 30)
      elsif params[:sort_by] == 'Price low to high'
         @items = Item.where(:item_type => "Textile", :sold_out => 0).order(price: :asc).paginate(:page => params[:page], :per_page => 30)
      elsif params[:sort_by] == 'Price high to low'
         @items = Item.where(:item_type => "Textile", :sold_out => 0).order(price: :desc).paginate(:page => params[:page], :per_page => 30)
      elsif params[:sort_by] == 'Most Comments'
         @items = Item.where(:item_type => "Textile", :sold_out => 0).order(comments_count: :desc).paginate(:page => params[:page], :per_page => 30)
      elsif params[:sort_by] == 'Most Votes'
         @items = Item.where(:item_type => "Textile", :sold_out => 0).order(likes_count: :desc).paginate(:page => params[:page], :per_page => 30)
      elsif params[:sort_by] == 'Discounted Items'
        @items = Item.where(:item_type => "Textile", :sold_out => 0).where.not(:discount => 0).order("created_at DESC").paginate(:page => params[:page], :per_page => 30)
      elsif params[:sort_by] == 'Sold Items'
        @items = Item.where(:item_type => "Textile", :sold_out => 1).order("created_at DESC").paginate(:page => params[:page], :per_page => 30)
      end
    elsif (params[:theme].present? && params[:sort_by].present?)
      @theme = params[:theme]
      @sort_by = params[:sort_by]
      if params[:sort_by] == 'Recently added'
        @items = Item.where(:item_type => "Textile", :item_tag => params[:theme], :sold_out => 0).order("created_at DESC").paginate(:page => params[:page], :per_page => 30)
      elsif params[:sorty_by] == 'Random'
        @items = Item.where(:item_type => "Textile", :item_tag => params[:theme], :sold_out => 0).order("RANDOM()").paginate(:page => params[:page], :per_page => 30)
      elsif params[:sort_by] == 'Price low to high'
         @items = Item.where(:item_type => "Textile", :item_tag => params[:theme], :sold_out => 0).order(price: :asc).paginate(:page => params[:page], :per_page => 30)
      elsif params[:sort_by] == 'Price high to low'
         @items = Item.where(:item_type => "Textile", :item_tag => params[:theme], :sold_out => 0).order(price: :desc).paginate(:page => params[:page], :per_page => 30)
      elsif params[:sort_by] == 'Most Comments'
         @items = Item.where(:item_type => "Textile", :item_tag => params[:theme], :sold_out => 0).order(comments_count: :desc).paginate(:page => params[:page], :per_page => 30)
      elsif params[:sort_by] == 'Most Votes'
         @items = Item.where(:item_type => "Textile", :item_tag => params[:theme], :sold_out => 0).order(likes_count: :desc).paginate(:page => params[:page], :per_page => 30)
      elsif params[:sort_by] == 'Discounted Items'
        @items = Item.where(:item_type => "Textile", :item_tag => params[:theme], :sold_out => 0).where.not(:discount => 0).order("created_at DESC").paginate(:page => params[:page], :per_page => 30)
      elsif params[:sort_by] == 'Sold Items'
         @items = Item.where(:item_type => "Textile", :item_tag => params[:theme], :sold_out => 1).order("created_at DESC").paginate(:page => params[:page], :per_page => 30)
      end
    elsif params[:q].present?
      @items = @q.result.order("created_at DESC").paginate(:page => params[:page], :per_page => 30)
    else
      @items = Item.where(:item_type => "Textile", :sold_out => 0).order("RANDOM()").paginate(:page => params[:page], :per_page => 30)
    end
  end

  def sculptures
    @q = Item.where(:item_type => "Sculpture", :sold_out => 0).search(params[:q])

    if (params[:theme].present? && params[:sort_by].nil?)
      @theme = params[:theme]
      @items = Item.where(:item_type => "Sculpture", :item_tag => params[:theme], :sold_out => 0).order("created_at DESC").paginate(:page => params[:page], :per_page => 30)
    elsif (params[:sort_by].present? && params[:theme].nil?)
      @sort_by = params[:sort_by]
      if params[:sort_by] == 'Recently added'
        @items = Item.where(:item_type => "Sculpture", :sold_out => 0).order("created_at DESC").paginate(:page => params[:page], :per_page => 30)
      elsif params[:sorty_by] == 'Random'
        @items = Item.where(:item_type => "Sculpture", :sold_out => 0).order("RANDOM()").paginate(:page => params[:page], :per_page => 30)
      elsif params[:sort_by] == 'Price low to high'
         @items = Item.where(:item_type => "Sculpture", :sold_out => 0).order(price: :asc).paginate(:page => params[:page], :per_page => 30)
      elsif params[:sort_by] == 'Price high to low'
         @items = Item.where(:item_type => "Sculpture", :sold_out => 0).order(price: :desc).paginate(:page => params[:page], :per_page => 30)
      elsif params[:sort_by] == 'Most Comments'
         @items = Item.where(:item_type => "Sculpture", :sold_out => 0).order(comments_count: :desc).paginate(:page => params[:page], :per_page => 30)
      elsif params[:sort_by] == 'Most Votes'
         @items = Item.where(:item_type => "Sculpture", :sold_out => 0).order(likes_count: :desc).paginate(:page => params[:page], :per_page => 30)
      elsif params[:sort_by] == 'Discounted Items'
        @items = Item.where(:item_type => "Sculpture", :sold_out => 0).where.not(:discount => 0).order("created_at DESC").paginate(:page => params[:page], :per_page => 30)
      elsif params[:sort_by] == 'Sold Items'
        @items = Item.where(:item_type => "Sculpture", :sold_out => 1).order("created_at DESC").paginate(:page => params[:page], :per_page => 30)
      end
    elsif (params[:theme].present? && params[:sort_by].present?)
      @theme = params[:theme]
      @sort_by = params[:sort_by]
      if params[:sort_by] == 'Recently added'
        @items = Item.where(:item_type => "Sculpture", :item_tag => params[:theme], :sold_out => 0).order("created_at DESC").paginate(:page => params[:page], :per_page => 30)
      elsif params[:sort_by] == 'Random'
        @items = Item.where(:item_type => "Sculpture", :item_tag => params[:theme], :sold_out => 0).order("RANDOM()").paginate(:page => params[:page], :per_page => 30)
      elsif params[:sort_by] == 'Price low to high'
         @items = Item.where(:item_type => "Sculpture", :item_tag => params[:theme], :sold_out => 0).order(price: :asc).paginate(:page => params[:page], :per_page => 30)
      elsif params[:sort_by] == 'Price high to low'
         @items = Item.where(:item_type => "Sculpture", :item_tag => params[:theme], :sold_out => 0).order(price: :desc).paginate(:page => params[:page], :per_page => 30)
      elsif params[:sort_by] == 'Most Comments'
         @items = Item.where(:item_type => "Sculpture", :item_tag => params[:theme], :sold_out => 0).order(comments_count: :desc).paginate(:page => params[:page], :per_page => 30)
      elsif params[:sort_by] == 'Most Votes'
         @items = Item.where(:item_type => "Sculpture", :item_tag => params[:theme], :sold_out => 0).order(likes_count: :desc).paginate(:page => params[:page], :per_page => 30)
      elsif params[:sort_by] == 'Discounted Items'
        @items = Item.where(:item_type => "Sculpture", :item_tag => params[:theme], :sold_out => 0).where.not(:discount => 0).order("created_at DESC").paginate(:page => params[:page], :per_page => 30)
      elsif params[:sort_by] == 'Sold Items'
         @items = Item.where(:item_type => "Sculpture", :item_tag => params[:theme], :sold_out => 1).order("created_at DESC").paginate(:page => params[:page], :per_page => 30)
      end
    elsif params[:q].present?
      @items = @q.result.order("created_at DESC").paginate(:page => params[:page], :per_page => 30)
    else
      @items = Item.where(:item_type => "Sculpture", :sold_out => 0).order("RANDOM()").paginate(:page => params[:page], :per_page => 30)
    end
  end

  def favorites
    itemIds = []
    if user_signed_in?
      if current_user.likes.present?
        current_user.likes.each do |like|
          itemIds.push(like.item_id)
        end
      end
    end
    @itemIds = itemIds.paginate(:page => params[:page], :per_page => 30)
  end

  def aboutus
  end

  def contact
  end

  def channel
  end

  def ordermanagement
    @orders = Order.all
  end

  def requestmanagement
    @requests = Pricerequest.all
  end

  def sitemap
  end

end
