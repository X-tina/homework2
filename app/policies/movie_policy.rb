class MoviePolicy < Struct.new(:user, :movie)

  def create?
    user.admin?
  end

  def show?
    user.admin? || !movie.draft?
  end

  def update?
    user.admin? || user == movie.user
  end

  alias_method :edit?, :update?
  alias_method :new?, :create?

end