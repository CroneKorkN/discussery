class RoleScopesController < ApplicationController
  before_action :set_role_scope, only: [:show, :edit, :update, :destroy]

  # GET /role_scopes
  # GET /role_scopes.json
  def index
    @role_scopes = RoleScope.all
  end

  # GET /role_scopes/1
  # GET /role_scopes/1.json
  def show
  end

  # GET /role_scopes/new
  def new
    @role_scope = RoleScope.new
  end

  # GET /role_scopes/1/edit
  def edit
  end

  # POST /role_scopes
  # POST /role_scopes.json
  def create
    @role_scope = RoleScope.new(role_scope_params)

    respond_to do |format|
      if @role_scope.save
        format.html { redirect_to @role_scope, notice: 'Role scope was successfully created.' }
        format.json { render :show, status: :created, location: @role_scope }
      else
        format.html { render :new }
        format.json { render json: @role_scope.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /role_scopes/1
  # PATCH/PUT /role_scopes/1.json
  def update
    respond_to do |format|
      if @role_scope.update(role_scope_params)
        format.html { redirect_to @role_scope, notice: 'Role scope was successfully updated.' }
        format.json { render :show, status: :ok, location: @role_scope }
      else
        format.html { render :edit }
        format.json { render json: @role_scope.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /role_scopes/1
  # DELETE /role_scopes/1.json
  def destroy
    @role_scope.destroy
    respond_to do |format|
      format.html { redirect_to role_scopes_url, notice: 'Role scope was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_role_scope
      @role_scope = RoleScope.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def role_scope_params
      params.require(:role_scope).permit(:group_id, :role_id, :scopable_id, :scopable_type)
    end
end
