class MoviesController < ApplicationController
  helper_method :ratings_params

  def index
    @all_ratings = Movie.all_ratings
    @selected_ratings = []

    @movies_sort = params[:movies_sort]
    @movies_ratings = params[:ratings]

    session[:movies_sort] = params[:movies_sort] if params[:movies_sort]
    session[:ratings] = params[:ratings] if params[:ratings]

    @selected_ratings = @movies_ratings.present? ? @movies_ratings.keys : @all_ratings
    @movies = Movie.list(rating: ratings_params.keys,order:("#{session[:movies_sort]}" + " " + "#{params[:direction]}"))
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

  def ratings_params
    session[:ratings] || Hash[@all_ratings.map { |r| [r, "1"]}]
  end

end
