class VisitsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_visit, only: %i[ show edit update destroy ]
  load_and_authorize_resource

  # Confirmar visita
  def confirm
    if current_user.employee? && @visit.employee == current_user.employee
      @visit.confirm!
      redirect_to visits_path, notice: "Visita confirmada com sucesso."
    else
      redirect_to visits_path, alert: "Você não tem permissão para confirmar esta visita."
    end
  end

  # GET /visits or /visits.json
  def index
    @visits = Visit.where(unit_id: current_user.unit_id) if current_user.attendant?
    @visits = @visits.includes(:visitor, :sector, :employee)

    # Filtros
    @visits = @visits.joins(:visitor).where("visitors.name ILIKE ?", "%#{params[:name]}%") if params[:name].present?
    @visits = @visits.where(sector_id: params[:sector]) if params[:sector].present?
    @visits = @visits.where(employee_id: params[:employee]) if params[:employee].present?

    # Ordenação por data
    if params[:order] == "asc"
      @visits = @visits.order(visit_time: :asc)
    else
      @visits = @visits.order(visit_time: :desc)
    end

    # Carregar setores e funcionários para o filtro
    @sectors = Sector.where(unit_id: current_user.unit_id, active: true)
    @employees = Employee.all
    @employees = @employees.where(sector_id: params[:sector]) if params[:sector].present?
  end

  # GET /visits/1 or /visits/1.json
  def show
  end

  # GET /visits/new
  def new
    @visit = Visit.new(visit_time: Time.current) # Define a data/hora
    @sectors = Sector.where(unit_id: current_user.unit_id, active: true) # Apenas setores da unidade do atendente que estejam ativos
  end

  # GET /visits/1/edit
  def edit
    @sectors = Sector.where(unit_id: current_user.unit_id, active: true) # Apenas setores da unidade do atendente que estejam ativos
  end

  # POST /visits or /visits.json
  def create
    @visit = Visit.new(visit_params)
    @sectors = Sector.where(unit_id: current_user.unit_id, active: true) # Apenas setores da unidade do atendente que estejam ativos
    @employees_by_sector = Employee.includes(:sector).where(sector: @sectors).group_by(&:sector_id) # Agrupa funcionários por setor

    respond_to do |format|
      if @visit.save
        format.html { redirect_to @visit, notice: "Visit was successfully created." }
        format.json { render :show, status: :created, location: @visit }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @visit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /visits/1 or /visits/1.json
  def update
    respond_to do |format|
      if @visit.update(visit_params)
        format.html { redirect_to @visit, notice: "Visit was successfully updated." }
        format.json { render :show, status: :ok, location: @visit }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @visit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /visits/1 or /visits/1.json
  def destroy
    @visit.destroy!

    respond_to do |format|
      format.html { redirect_to visits_path, status: :see_other, notice: "Visit was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_visit
      @visit = Visit.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def visit_params
      params.expect(visit: [ :visitor_id, :sector_id, :employee_id, :visit_time, :unit_id ])
    end
end
