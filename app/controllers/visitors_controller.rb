class VisitorsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_visitor, only: %i[ show edit update destroy ]
  load_and_authorize_resource
  
  # GET /visitors or /visitors.json
  def index
    @visitors = Visitor.all

    # Filtra os visitantes com base no parâmetro `status`
    case params[:status]
    when "active"
      @visitors = @visitors.active
    when "inactive"
      @visitors = @visitors.inactive
    end

    # Filtra os visitantes com base na pesquisa
    if params[:search].present?
      @visitors = @visitors.where("name LIKE ?", "%#{params[:search]}%")
    end
  end

  # GET /visitors/1 or /visitors/1.json
  def show
  end

  # GET /visitors/new
  def new
    @visitor = Visitor.new
  end

  # GET /visitors/1/edit
  def edit
  end

  # POST /visitors or /visitors.json
  def create
    @visitor = Visitor.new(visitor_params)

    respond_to do |format|
      if @visitor.save
        format.html { redirect_to @visitor, notice: "Visitor was successfully created." }
        format.json { render :show, status: :created, location: @visitor }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @visitor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /visitors/1 or /visitors/1.json
  def update
    respond_to do |format|
      if @visitor.update(visitor_params)
        format.html { redirect_to @visitor, notice: "Visitor was successfully updated." }
        format.json { render :show, status: :ok, location: @visitor }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @visitor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /visitors/1 or /visitors/1.json
  def destroy
    @visitor.destroy!

    respond_to do |format|
      format.html { redirect_to visitors_path, status: :see_other, notice: "Visitor was successfully destroyed." }
      format.json { head :no_content }
    end
  end

   # PATCH /visitors/1/deactivate
  def deactivate
    @visitor = Visitor.find(params[:id])
    @visitor.deactivate!
    redirect_to visitors_path, notice: "Visitante desativado com sucesso."
  rescue => e
    redirect_to visitors_path, alert: "Erro ao desativar visitante: #{e.message}"
  end

  # PATCH /visitors/1/activate
  def activate
    @visitor = Visitor.find(params[:id])
    @visitor.activate!
    redirect_to visitors_path, notice: "Visitante ativado com sucesso."
  rescue => e
    redirect_to visitors_path, alert: "Erro ao ativar visitante: #{e.message}"
  end

  def search
    cpf = params[:cpf]
    visitor = Visitor.find_by(cpf: cpf)

    if visitor
      if visitor.active?
        render json: {
          id: visitor.id,
          name: visitor.name,
          rg: visitor.rg,
          phone: visitor.phone,
          active: true
        }
      else
        render json: {
          id: visitor.id,
          name: visitor.name,
          rg: visitor.rg,
          phone: visitor.phone,
          active: false,
        }
      end
    else
      render json: nil
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_visitor
      @visitor = Visitor.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def visitor_params
      params.expect(visitor: [ :cpf, :name, :rg, :phone, :photo ])
    end
end
