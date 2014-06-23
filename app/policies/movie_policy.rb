class MoviePolicy < Struct.new(:user, :movie)
  class Scope < Struct.new(:user, :scope)
    
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(:published => true)
      end
    end

  end

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