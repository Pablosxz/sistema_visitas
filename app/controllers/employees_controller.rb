class EmployeesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_employee, only: %i[ show edit update destroy ]
  load_and_authorize_resource
  
  # Método para desativar o funcionário
  def deactivate
    @employee = Employee.find(params[:id])
    @employee.deactivate!
    redirect_to employees_path, notice: "Funcionário desativado com sucesso."
  rescue => e
    redirect_to employees_path, alert: "Erro ao desativar funcionário: #{e.message}"
  end

  def activate
    @employee = Employee.find(params[:id])
    @employee.activate!
    redirect_to reactivate_employee_path(@employee), notice: "Funcionário ativado com sucesso."
  end

  def reactivate
    @employee = Employee.find(params[:id])
    @employee.build_user(role: 2) if @employee.user.nil?  # Garante que um novo usuário seja criado
  end

  # GET /employees or /employees.json
  def index
    @employees = Employee.includes(:sector).all
    @units = Unit.all # Para preencher o dropdown de unidades
    @sectors = Sector.all # Para preencher o dropdown de setores

    # Aplicando filtros
    @employees = @employees.where("name ILIKE ?", "%#{params[:name]}%") if params[:name].present?
    @employees = @employees.where(active: params[:active] == "true") if params[:active].present?
    @employees = @employees.joins(:sector).where(sectors: { unit_id: params[:unit_id] }) if params[:unit_id].present?
    @employees = @employees.where(sector_id: params[:sector_id]) if params[:sector_id].present?
  end

  # GET /employees/1 or /employees/1.json
  def show
  end

  # GET /employees/new
  def new
    @employee = Employee.new
    @employee.build_user(role: 2) # Inicializa um novo usuário associado
  end

  # GET /employees/1/edit
  def edit
  end

  # POST /employees or /employees.json
  def create
    @employee = Employee.new(employee_params)

    if @employee.user.nil?
      @employee.build_user
    end

    @employee.user.role = 2 # Define o papel do usuário como funcionário
    
    respond_to do |format|
      if @employee.save
        format.html { redirect_to @employee, notice: "Employee was successfully created." }
        format.json { render :show, status: :created, location: @employee }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employees/1 or /employees/1.json
  def update
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to @employee, notice: "Employee was successfully updated." }
        format.json { render :show, status: :ok, location: @employee }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1 or /employees/1.json
  def destroy
    @employee.destroy!

    respond_to do |format|
      format.html { redirect_to employees_path, status: :see_other, notice: "Employee was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params.expect(:id))
    end

    def employee_params
      params.expect(employee: [ :name, :sector_id, :user_id, :active,
      user_attributes: [:id, :email, :password, :password_confirmation, :role] # Permite atributos aninhados para o usuário
    ])
    end
end
