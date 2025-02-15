class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin
  before_action :set_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all

    # Filtra os usuários com base no parâmetro `role`
    case params[:role]
    when "admin"
      @users = @users.admin
    when "employee"
      @users = @users.employee
    when "attendant"
      @users = @users.attendant
    end

    # Filtra os usuários com base na pesquisa
    if params[:search].present?
      @users = @users.where("email LIKE ?", "%#{params[:search]}%")
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to users_path, notice: "Usuário criado com sucesso."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to users_path, notice: "Usuário atualizado com sucesso."
    else
      render :edit
    end
  end

  def destroy
    @user.destroy!
    redirect_to users_path, notice: "Usuário excluído com sucesso."
  end

  private

  def authorize_admin
    redirect_to root_path, alert: "Acesso negado." unless current_user.admin?
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role, :unit_id)
  end
  
end
