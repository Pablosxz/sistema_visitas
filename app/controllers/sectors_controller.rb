class SectorsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_sector, only: %i[ show edit update destroy ]
  load_and_authorize_resource
  
  # GET /sectors or /sectors.json
  def index
    @sectors = Sector.all
  end

  # GET /sectors/1 or /sectors/1.json
  def show
  end

  # GET /sectors/new
  def new
    @sector = Sector.new
  end

  # GET /sectors/1/edit
  def edit
  end

  # POST /sectors or /sectors.json
  def create
    @sector = Sector.new(sector_params)

    respond_to do |format|
      if @sector.save
        format.html { redirect_to @sector, notice: "Sector was successfully created." }
        format.json { render :show, status: :created, location: @sector }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @sector.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sectors/1 or /sectors/1.json
  def update
    respond_to do |format|
      if @sector.update(sector_params)
        format.html { redirect_to @sector, notice: "Sector was successfully updated." }
        format.json { render :show, status: :ok, location: @sector }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @sector.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sectors/1 or /sectors/1.json
  def destroy
    @sector.destroy!

    respond_to do |format|
      format.html { redirect_to sectors_path, status: :see_other, notice: "Sector was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # PATCH /sectors/1/deactivate
  def deactivate
    @sector.deactivate!
    redirect_to sectors_path, notice: "Sector was successfully deactivated."
  end

  # PATCH /sectors/1/activate
  def activate
    @sector.activate!
    redirect_to sectors_path, notice: "Sector was successfully activated."
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sector
      @sector = Sector.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def sector_params
      params.expect(sector: [ :name, :unit_id ])
    end
end
