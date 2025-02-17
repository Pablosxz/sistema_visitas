class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new  # Caso não esteja logado

    if user.admin?
      can :manage, Employee
      can :manage, Sector
      can :manage, Unit
      can :manage, User # Administrador pode mexer em tudo que não sejam as visitas e os visitantes
    elsif user.attendant?
      can :manage, Visitor
      can :manage, Visit, unit_id: user.unit_id  # Só pode gerenciar visitas da sua unidade
      cannot :confirm, Visit  # Não pode confirmar visitas

      # Permitir acesso à rota 'employees' de setores para filtrar funcionários
      can :read, Sector # Permite que o atendente veja setores
      can :employees, Sector # Permite que o atendente veja funcionários do seu setor
    elsif user.employee?
      employee = user.employee  # Pega o funcionário associado ao usuário
      can :read, Visit, employee_id: employee.id
      can :confirm, Visit, employee_id: employee.id  # Apenas confirma suas visitas
    end
  end
end
