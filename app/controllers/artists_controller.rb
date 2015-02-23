class ArtistsController < ApplicationController
  before_action :set_artist, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :admin_user, except: [:index, :show]

  require 'will_paginate/array'

  respond_to :html

  def index
    @q = Artist.search(params[:q])
    @alphabet = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z']
    if params[:start].present?
      artists = Artist.all.select{ |a| a.name.start_with?(params[:start].capitalize)}.sort_by!{ |m| m.name.downcase }
      if artists.length > 0
        @artists = artists.paginate(:page => params[:page], :per_page => 20)
      end 
    elsif params[:q].present?
      artists = @q.result
      if artists.length > 0
        @artists = artists.paginate(:page => params[:page], :per_page => 20)
      end 
    elsif params[:spec].present?
      @artists = Artist.where(:specialization => params[:spec]).paginate(:page => params[:page], :per_page => 20)
    else
      artists = Artist.reorder('name ASC')
      if artists.length > 0
        @artists = artists.paginate(:page => params[:page], :per_page => 20)
      end 
    end
    respond_with(@artists)
  end

  def show
    respond_with(@artist, @items = @artist.items)
  end

  def new
    @artist = Artist.new
    respond_with(@artist)
  end

  def edit
  end

  def create
    @artist = Artist.new(artist_params)
    @artist.save
    respond_with(@artist)
  end

  def update
    @artist.update(artist_params)
    respond_with(@artist)
  end

  def destroy
    @artist.destroy
    respond_with(@artist)
  end

  private
    def set_artist
      @artist = Artist.find(params[:id])
      @og_title = @artist.name.split.map(&:capitalize)*' '+' Artiveria Profile'
      @og_description = @artist.description
      @og_image = @artist.image.url(:medium)
    end

    def admin_user
      unless current_user.try(:admin?)
        redirect_to :root, notice: "Only admins are authorized for this"
      end
    end

    def artist_params
      params.require(:artist).permit(:name, :description, :rmore, :image, :specialization, :country, :manager, :phone_number, :secondary_phone_number, :email, :secondary_email )
    end
end