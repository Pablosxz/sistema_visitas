# Criando um usuário administrador
admin = User.create!(
  email: "admin@example.com",
  password: "password",
  password_confirmation: "password",
  role: :admin
)

employee_user1 = User.create!(
  email: "funcionario@gmail.com",
  password: "funcionario",
  password_confirmation: "funcionario",
  role: :employee
)

employee_user2 = User.create!(
  email: "funcionario1@gmail.com",
  password: "funcionario1",
  password_confirmation: "funcionario1",
  role: :employee
)

employee_user3 = User.create!(
  email: "funcionario2@gmail.com",
  password: "funcionario2",
  password_confirmation: "funcionario2",
  role: :employee
)

# Criando unidades
unit1 = Unit.create!(name: "Unidade A")
unit2 = Unit.create!(name: "Unidade B")
unit3 = Unit.create!(name: "Unidade C")

# Criando atendentes para cada unidade
attendant1 = User.create!(
  email: "atendente1@gmail.com",
  password: "atendente1",
  password_confirmation: "atendente1",
  role: :attendant,
  unit: unit1
)

attendant2 = User.create!(
  email: "atendente2@gmail.com",
  password: "atendente2",
  password_confirmation: "atendente2",
  role: :attendant,
  unit: unit2
)

attendant3 = User.create!(
  email: "atendente3@gmail.com",
  password: "atendente3",
  password_confirmation: "atendente3",
  role: :attendant,
  unit: unit3
)

# Criando setores
sector1 = Sector.create!(name: "RH", unit: unit1)
sector2 = Sector.create!(name: "TI", unit: unit1)

sector3 = Sector.create!(name: "Financeiro", unit: unit2)
sector4 = Sector.create!(name: "Compras", unit: unit2)

sector5 = Sector.create!(name: "Vendas", unit: unit3)
sector6 = Sector.create!(name: "Marketing", unit: unit3)

# Criando funcionários (vinculados a usuários do tipo employee)
employee1 = Employee.create!(name: "Alice", sector: sector1, user: employee_user1)
employee2 = Employee.create!(name: "Bob", sector: sector3, user: employee_user2)
employee3 = Employee.create!(name: "Charlie", sector: sector5, user: employee_user3)

# Caminho das imagem dos visitantes exemplo
image_path1 = Rails.root.join("public/uploads/visitor/photo/1/john.jpg")
image_path2 = Rails.root.join("public/uploads/visitor/photo/2/jane.jpeg")
image_path3 = Rails.root.join("public/uploads/visitor/photo/3/paulo.jpeg")


# Criando visitantes
visitor1 = Visitor.create!(cpf: "12345678900", name: "John Doe", rg: "1234567", phone: "84987654321", photo: File.open(image_path1))
visitor2 = Visitor.create!(cpf: "98765432100", name: "Jane Doe", rg: "7654321", phone: "84912345678", photo: File.open(image_path2))
visitor3 = Visitor.create!(cpf: "12345678901", name: "Paulo Henrique", rg: "1234568", phone: "84987654320", photo: File.open(image_path3))

# Criando visitas
Visit.create!(visitor: visitor1, sector: sector1, employee: employee1, unit: unit1, visit_time: Time.now)
Visit.create!(visitor: visitor2, sector: sector3, employee: employee2, unit: unit2, visit_time: Time.now)
Visit.create!(visitor: visitor3, sector: sector5, employee: employee3, unit: unit3, visit_time: Time.now)
