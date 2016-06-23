class GroupGroupsController < ApplicationController
  before_action :set_group_group, only: [:show, :edit, :update, :destroy]

  # GET /group_groups
  # GET /group_groups.json
  def index
    @group_groups = GroupGroup.all
  end

  # GET /group_groups/1
  # GET /group_groups/1.json
  def show
  end

  # GET /group_groups/new
  def new
    @group_group = GroupGroup.new
  end

  # GET /group_groups/1/edit
  def edit
  end

  # POST /group_groups
  # POST /group_groups.json
  def create
    @group_group = GroupGroup.new(group_group_params)

    respond_to do |format|
      if @group_group.save
        format.html { redirect_to @group_group, notice: 'Group group was successfully created.' }
        format.json { render :show, status: :created, location: @group_group }
      else
        format.html { render :new }
        format.json { render json: @group_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /group_groups/1
  # PATCH/PUT /group_groups/1.json
  def update
    respond_to do |format|
      if @group_group.update(group_group_params)
        format.html { redirect_to @group_group, notice: 'Group group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group_group }
      else
        format.html { render :edit }
        format.json { render json: @group_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /group_groups/1
  # DELETE /group_groups/1.json
  def destroy
    @group_group.destroy
    respond_to do |format|
      format.html { redirect_to group_groups_url, notice: 'Group group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group_group
      @group_group = GroupGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_group_params
      params.require(:group_group).permit(:group_id, :member_group_id)
    end
end
