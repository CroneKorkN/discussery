class GroupRolesController < ApplicationController
  before_action :set_group_role, only: [:show, :edit, :update, :destroy]

  # GET /group_roles
  # GET /group_roles.json
  def index
    @group_roles = GroupRole.all
  end

  # GET /group_roles/1
  # GET /group_roles/1.json
  def show
  end

  # GET /group_roles/new
  def new
    @group_role = GroupRole.new
  end

  # GET /group_roles/1/edit
  def edit
  end

  # POST /group_roles
  # POST /group_roles.json
  def create
    @group_role = GroupRole.new(group_role_params)

    respond_to do |format|
      if @group_role.save
        format.html { redirect_to @group_role, notice: 'Group role was successfully created.' }
        format.json { render :show, status: :created, location: @group_role }
      else
        format.html { render :new }
        format.json { render json: @group_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /group_roles/1
  # PATCH/PUT /group_roles/1.json
  def update
    respond_to do |format|
      if @group_role.update(group_role_params)
        format.html { redirect_to @group_role, notice: 'Group role was successfully updated.' }
        format.json { render :show, status: :ok, location: @group_role }
      else
        format.html { render :edit }
        format.json { render json: @group_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /group_roles/1
  # DELETE /group_roles/1.json
  def destroy
    @group_role.destroy
    respond_to do |format|
      format.html { redirect_to group_roles_url, notice: 'Group role was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group_role
      @group_role = GroupRole.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_role_params
      params.require(:group_role).permit(:group_id, :role_id, :category_id, :recursive)
    end
end
