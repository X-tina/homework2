class MoviesController < ApplicationController

  def index
    @all_ratings = Movie.all_ratings
    @selected_ratings = []
    session[:filters] = {}

    @movies_sort = params[:movies_sort]
    @movies_ratings = params[:ratings]

    @selected_ratings = @movies_ratings.present? ? @movies_ratings.keys : @all_ratings
    @movies = Movie.order(@movies_sort).where(:rating => @selected_ratings)
    
    session[:filters].merge!(movies_sort: @movies_sort) if(@movies_sort.present?)
    session[:filters].merge!(ratings: @movies_ratings) if(@movies_ratings.present?)
  end

  def show
    @movie = find_movie
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new movie_params
    if @movie.save
      flash[:notice] = "#{@movie.title} was successfully created."
      redirect_to movies_url
    else
      render 'new'
    end
  end

  def edit
    @movie = find_movie
  end

  def update
    @movie = find_movie
    if @movie.update_attributes(movie_params)
      flash[:notice] = "#{@movie.title} was successfully updated."
      redirect_to @movie
    else
      render 'edit'
    end
  end

  def destroy
    @movie = find_movie
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_url
  end

  private

  def find_movie
    Movie.find(params[:id])
  end

  def movie_params
    params[:movie].permit(:title, :rating, :release_date, :description)
  end

end
