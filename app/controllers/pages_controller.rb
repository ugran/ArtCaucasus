class PagesController < ApplicationController
	
  def home
  	if params[:item_type].present?
      @items = Item.where(:item_type => params[:item_type])
    elsif params[:theme].present?
      @items = Item.where(:item_tag => params[:theme])
    elsif params[:shape].present?
      @items = Item.where(:shape => params[:shape])
    else
      @items = Item.all
    end
  end

  def test
    if params[:item_type].present?
      @items = Item.where(:item_type => params[:item_type])
    elsif params[:theme].present?
      @items = Item.where(:item_tag => params[:theme])
    elsif params[:shape].present?
      @items = Item.where(:shape => params[:shape])
    else
      @items = Item.all
    end
  end

end
