# Criando um usuário administrador
admin = User.create!(
  email: "admin@example.com",
  password: "password",
  password_confirmation: "password",
  role: :admin
)

employee_user1 = User.create!(
  email: "funcionario1@gmail.com",
  password: "funcionario123",
  password_confirmation: "funcionario123",
  role: :employee
)

employee_user2 = User.create!(
  email: "funcionario2@gmail.com",
  password: "funcionario123",
  password_confirmation: "funcionario123",
  role: :employee
)

# Criando unidades
unit1 = Unit.create!(name: "Unidade A")
unit2 = Unit.create!(name: "Unidade B")

# Criando atendente
attendant = User.create!(
  email: "atendente1@gmail.com",
  password: "atendente123",
  password_confirmation: "atendente123",
  role: :attendant,
  unit: unit1
)

# Criando setores
sector1 = Sector.create!(name: "RH", unit: unit1)
sector2 = Sector.create!(name: "TI", unit: unit2)

# Criando funcionários (vinculados a usuários do tipo employee)
employee1 = Employee.create!(name: "Alice", sector: sector1, user: employee_user1)
employee2 = Employee.create!(name: "Bob", sector: sector2, user: employee_user2)

# Criando visitantes
visitor1 = Visitor.create!(cpf: "12345678900", name: "John Doe", rg: "1234567", phone: "987654321")
visitor2 = Visitor.create!(cpf: "98765432100", name: "Jane Doe", rg: "7654321", phone: "912345678")

# Criando visitas
Visit.create!(visitor: visitor1, sector: sector1, employee: employee1, unit: unit1, visit_time: Time.now)
Visit.create!(visitor: visitor2, sector: sector2, employee: employee2, unit: unit2, visit_time: Time.now)