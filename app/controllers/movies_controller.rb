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
    @movies = policy_scope(
      Movie.list(rating: ratings_params.keys, order:("#{session[:movies_sort]}" + " " + "#{params[:direction]}"))
    )
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
    authorize @movie
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
    @movie.attributes = movie_params
    if @movie.valid?
      unless @movie.published?
        Movie.create! Movie.find(@movie.id).attributes.except('id', 'created_at', 'updated_at')
        @movie.published = true
      end
      @movie.save
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
    authorize @movie, :update?
    @movie.update_column :published, false
    redirect_to @movie
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
