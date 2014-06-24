class MoviePolicy < Struct.new(:user, :movie)
  class Scope < Struct.new(:user, :scope)
    
    def resolve
      if user.admin?
        scope.all
      else
        #scope.where('published = :p OR user_id = :u', p: false, u: user.id)
        scope.where(
          'twin_id IN (select m.twin_id from movies m group by m.twin_id having COUNT(m.id) > 1)'
        )
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