class PagesController < ApplicationController
	
  def home
      @q = Item.where(:sold_out => 0).search(params[:q])
      @items = @q.result.order("created_at DESC").paginate(:page => params[:page], :per_page => 21)
  end

  def paintings
    @q = Item.where(:item_type => "Painting", :sold_out => 0).search(params[:q])

    if (params[:theme].present? && params[:sort_by].nil?)
      @theme = params[:theme]
      @items = Item.where(:item_type => "Painting", :item_tag => params[:theme], :sold_out => 0).order("created_at DESC").paginate(:page => params[:page], :per_page => 21)
    elsif (params[:sort_by].present? && params[:theme].nil?)
      @sort_by = params[:sort_by]
      if params[:sort_by] == 'Recently added'
        @items = Item.where(:item_type => "Painting", :sold_out => 0).order("created_at DESC").paginate(:page => params[:page], :per_page => 21)
      elsif params[:sort_by] == 'Price low to high'
         @items = Item.where(:item_type => "Painting", :sold_out => 0).order(price: :asc).paginate(:page => params[:page], :per_page => 21)
      elsif params[:sort_by] == 'Price high to low'
         @items = Item.where(:item_type => "Painting", :sold_out => 0).order(price: :desc).paginate(:page => params[:page], :per_page => 21)
      elsif params[:sort_by] == 'Most Comments'
         @items = Item.where(:item_type => "Painting", :sold_out => 0).order(comments_count: :desc).paginate(:page => params[:page], :per_page => 21)
      elsif params[:sort_by] == 'Most Votes'
         @items = Item.where(:item_type => "Painting", :sold_out => 0).order(likes_count: :desc).paginate(:page => params[:page], :per_page => 21)
      elsif params[:sort_by] == 'Discounted Items'
        @items = Item.where(:item_type => "Painting", :sold_out => 0).where.not(:discount => 0).order("created_at DESC").paginate(:page => params[:page], :per_page => 21)
      elsif params[:sort_by] == 'Sold Items'
        @items = Item.where(:item_type => "Painting", :sold_out => 1).order("created_at DESC").paginate(:page => params[:page], :per_page => 21)
      end
    elsif (params[:theme].present? && params[:sort_by].present?)
      @theme = params[:theme]
      @sort_by = params[:sort_by]
      if params[:sort_by] == 'Recently added'
        @items = Item.where(:item_type => "Painting", :item_tag => params[:theme], :sold_out => 0).order("created_at DESC").paginate(:page => params[:page], :per_page => 21)
      elsif params[:sort_by] == 'Price low to high'
         @items = Item.where(:item_type => "Painting", :item_tag => params[:theme], :sold_out => 0).order(price: :asc).paginate(:page => params[:page], :per_page => 21)
      elsif params[:sort_by] == 'Price high to low'
         @items = Item.where(:item_type => "Painting", :item_tag => params[:theme], :sold_out => 0).order(price: :desc).paginate(:page => params[:page], :per_page => 21)
      elsif params[:sort_by] == 'Most Comments'
         @items = Item.where(:item_type => "Painting", :item_tag => params[:theme], :sold_out => 0).order(comments_count: :desc).paginate(:page => params[:page], :per_page => 21)
      elsif params[:sort_by] == 'Most Votes'
         @items = Item.where(:item_type => "Painting", :item_tag => params[:theme], :sold_out => 0).order(likes_count: :desc).paginate(:page => params[:page], :per_page => 21)
      elsif params[:sort_by] == 'Discounted Items'
        @items = Item.where(:item_type => "Painting", :item_tag => params[:theme], :sold_out => 0).where.not(:discount => 0).order("created_at DESC").paginate(:page => params[:page], :per_page => 21)
      elsif params[:sort_by] == 'Sold Items'
         @items = Item.where(:item_type => "Painting", :item_tag => params[:theme], :sold_out => 1).order("created_at DESC").paginate(:page => params[:page], :per_page => 21)
      end
    elsif params[:q].present?
      @items = @q.result.order("created_at DESC").paginate(:page => params[:page], :per_page => 21)
    else
      @items = Item.where(:item_type => "Painting", :sold_out => 0).order("created_at DESC").paginate(:page => params[:page], :per_page => 21)
    end
  end

  def enamels
    @q = Item.where(:item_type => "Enamel", :sold_out => 0).search(params[:q])

    if (params[:theme].present? && params[:sort_by].nil?)
      @theme = params[:theme]
      @items = Item.where(:item_type => "Enamel", :item_tag => params[:theme], :sold_out => 0).order("created_at DESC").paginate(:page => params[:page], :per_page => 21)
    elsif (params[:sort_by].present? && params[:theme].nil?)
      @sort_by = params[:sort_by]
      if params[:sort_by] == 'Recently added'
        @items = Item.where(:item_type => "Enamel", :sold_out => 0).order("created_at DESC").paginate(:page => params[:page], :per_page => 21)
      elsif params[:sort_by] == 'Price low to high'
        @items = Item.where(:item_type => "Enamel", :sold_out => 0).order(price: :asc).paginate(:page => params[:page], :per_page => 21)
      elsif params[:sort_by] == 'Price high to low'
        @items = Item.where(:item_type => "Enamel", :sold_out => 0).order(price: :desc).paginate(:page => params[:page], :per_page => 21)
      elsif params[:sort_by] == 'Most Comments'
        @items = Item.where(:item_type => "Enamel", :sold_out => 0).order(comments_count: :desc).paginate(:page => params[:page], :per_page => 21)
      elsif params[:sort_by] == 'Most Votes'
        @items = Item.where(:item_type => "Enamel", :sold_out => 0).order(likes_count: :desc).paginate(:page => params[:page], :per_page => 21)
      elsif params[:sort_by] == 'Discounted Items'
        @items = Item.where(:item_type => "Enamel", :sold_out => 0).where.not(:discount => 0).order("created_at DESC").paginate(:page => params[:page], :per_page => 21)
      elsif params[:sort_by] == 'Sold Items'
        @items = Item.where(:item_type => "Enamel", :sold_out => 1).order("created_at DESC").paginate(:page => params[:page], :per_page => 21)
      end
    elsif (params[:theme].present? && params[:sort_by].present?)
      @theme = params[:theme]
      @sort_by = params[:sort_by]
      if params[:sort_by] == 'Recently added'
        @items = Item.where(:item_type => "Enamel", :item_tag => params[:theme], :sold_out => 0).order("created_at DESC").paginate(:page => params[:page], :per_page => 21)
      elsif params[:sort_by] == 'Price low to high'
        @items = Item.where(:item_type => "Enamel", :item_tag => params[:theme], :sold_out => 0).order(price: :asc).paginate(:page => params[:page], :per_page => 21)
      elsif params[:sort_by] == 'Price high to low'
        @items = Item.where(:item_type => "Enamel", :item_tag => params[:theme], :sold_out => 0).order(price: :desc).paginate(:page => params[:page], :per_page => 21)
      elsif params[:sort_by] == 'Most Comments'
        @items = Item.where(:item_type => "Enamel", :item_tag => params[:theme], :sold_out => 0).order(comments_count: :desc).paginate(:page => params[:page], :per_page => 21)
      elsif params[:sort_by] == 'Most Votes'
        @items = Item.where(:item_type => "Enamel", :item_tag => params[:theme], :sold_out => 0).order(likes_count: :desc).paginate(:page => params[:page], :per_page => 21)
      elsif params[:sort_by] == 'Discounted Items'
        @items = Item.where(:item_type => "Enamel", :item_tag => params[:theme], :sold_out => 0).where.not(:discount => 0).order("created_at DESC").paginate(:page => params[:page], :per_page => 21)
      elsif params[:sort_by] == 'Sold Items'
        @items = Item.where(:item_type => "Enamel", :item_tag => params[:theme], :sold_out => 1).order("created_at DESC").paginate(:page => params[:page], :per_page => 21)
      end
    elsif params[:q].present?
      @items = @q.result.order("created_at DESC").paginate(:page => params[:page], :per_page => 21)
    else
      @items = Item.where(:item_type => "Enamel", :sold_out => 0).order("created_at DESC").paginate(:page => params[:page], :per_page => 21)
    end
  end

end
