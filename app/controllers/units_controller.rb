class UnitsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_unit, only: %i[ show edit update destroy ]
  load_and_authorize_resource

  # GET /units or /units.json
  def index
    @units = Unit.all

    # Filtra as unidades com base no parâmetro `status`
    case params[:status]
    when "active"
      @units = @units.active
    when "inactive"
      @units = @units.inactive
    end

    # Filtra as unidades com base na pesquisa
    if params[:search].present?
      @units = @units.where("name LIKE ?", "%#{params[:search]}%")
    end
  end

  # GET /units/1 or /units/1.json
  def show
  end

  # GET /units/new
  def new
    @unit = Unit.new
  end

  # GET /units/1/edit
  def edit
  end

  # POST /units or /units.json
  def create
    @unit = Unit.new(unit_params)

    respond_to do |format|
      if @unit.save
        format.html { redirect_to @unit, notice: "Unit was successfully created." }
        format.json { render :show, status: :created, location: @unit }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /units/1 or /units/1.json
  def update
    respond_to do |format|
      if @unit.update(unit_params)
        format.html { redirect_to @unit, notice: "Unit was successfully updated." }
        format.json { render :show, status: :ok, location: @unit }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /units/1 or /units/1.json
  def destroy
    @unit.destroy!

    respond_to do |format|
      format.html { redirect_to units_path, status: :see_other, notice: "Unit was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # PATCH /units/1/deactivate
  def deactivate
    @unit.deactivate!
    redirect_to units_path, notice: "Unidade desativada com sucesso."
  end

  # PATCH /units/1/activate
  def activate
    @unit.activate!
    redirect_to units_path, notice: "Unidade ativada com sucesso."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_unit
      @unit = Unit.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def unit_params
      params.expect(unit: [ :name ])
    end
end
