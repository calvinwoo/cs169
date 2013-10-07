class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = ['G','PG','PG-13','R']
    @highlight = ""
    redirect_session = false
    if not params[:ratings] and session[:ratings]
        @ratings = session[:ratings]
        redirect_session = true
    elsif not params[:ratings]
        @ratings = ['G','PG','PG-13','R']
    else
        @ratings = params[:ratings].keys
    end
    session[:ratings] = @ratings
    
    if params[:sort]
      @highlight = params[:sort]
      @movies = Movie.where(rating: @ratings).order(params[:sort])
      session[:sort] = params[:sort]
    elsif not params[:sort] and session[:sort]
      @movies = Movie.where(rating: @ratings).order(session[:sort])
      @highlight = session[:sort]
      params[:sort] = session[:sort]
      redirect_session = true
    else
      @movies = Movie.where(rating: @ratings)
      @highlight = ""
    end
    
    if redirect_session
        flash.keep
        map = {}
        @ratings.each do |rating|
          map[rating] = 1
        end
        redirect_to movies_path(:sort => session[:sort], :ratings => map)
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end

