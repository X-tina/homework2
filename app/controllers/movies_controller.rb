class MoviesController < ApplicationController

  def index
    @all_ratings = %W[G PG PG-13 NC-17 R]
    
    if params[:movies_sort] == "by_title"
      @movies = sort_title
      @change_color_title = "highlight"
    elsif params[:movies_sort] == "by_release"
      @movies = sort_release
      @change_color_release = "highlight"
    else @movies = Movie.all
    end  
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

  def sort_title
    Movie.order(:title)
  end

  def sort_release
    Movie.order(:release_date)
  end

end
