class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new  # Caso não esteja logado

    if user.admin?
      can :manage, :all  # Administrador pode fazer tudo
    elsif user.attendant?
      can :read, Visitor
      can :create, Visitor
      can :manage, Visit, unit_id: user.unit_id  # Só pode gerenciar visitas da sua unidade
    elsif user.employee?
      employee = user.employee  # Pegamos o funcionário associado ao usuário
      can :read, Visit, employee_id: employee.id
      can :confirm, Visit, employee_id: employee.id  # Apenas confirma suas visitas
    end
  end
end
