class MoviesController < ApplicationController
  before_action :authenticate_user!
  helper_method :ratings_params, :allow

  def index
    @all_ratings = Movie.all_ratings
    @selected_ratings = []

    @movies_sort = params[:movies_sort]
    @movies_ratings = params[:ratings]

    session[:movies_sort] = params[:movies_sort] if params[:movies_sort]
    session[:ratings] = params[:ratings] if params[:ratings]

    @selected_ratings = @movies_ratings.present? ? @movies_ratings.keys : @all_ratings

    movie_list = Movie.list(rating: ratings_params.keys, order:("#{session[:movies_sort]}" + " " + "#{params[:direction]}"))
    @movies = policy_scope(movie_list)
  end

  def show
    @movie = find_movie
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new movie_params
    @movie.user = current_user
    if @movie.save
      flash[:notice] = "#{@movie.title} was successfully created."
      redirect_to movies_url
    else
      render 'new'
    end
  end

  def edit
    @movie = find_movie
    authorize @movie
  end

  def update
    @movie = find_movie
    authorize @movie
    @movie.published = false
    if @movie.update_attributes(movie_params)
      flash[:notice] = "#{@movie.title} was successfully updated."
      redirect_to @movie
    else
      render 'edit'
    end
  end

  def destroy
    @movie = find_movie
    @movie.avatar = nil
    @movie.save
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_url
  end

  def author?(movie)
    movie.user_id == current_user?
  end

  def publish
    @movie = find_movie
    #authorize @movie
    @movie.published = true
    if @movie.save
      redirect_to movies_url
    else
      flash[:notice] = "Movie '#{@movie.title}' can't be published"
    end
  end

  private

  def allow
    Pundit.policy!(current_user, @movie)
  end

  def find_movie
    Movie.find(params[:id])
  end

  def movie_params
    fields = [:title, :rating, :release_date, :description, :avatar, :description]
    fields << :published if current_user.admin?
    params.require(:movie).permit(fields)
  end

  def ratings_params
    session[:ratings] || Hash[@all_ratings.map { |r| [r, "1"]}]
  end

end
