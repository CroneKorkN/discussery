class SettingGroupsController < ApplicationController
  before_action :set_setting_group, only: [:show, :edit, :update, :destroy]
  layout "backend"

  # GET /setting_groups
  # GET /setting_groups.json
  def index
    @setting_groups = SettingGroup.all
  end

  # GET /setting_groups/1
  # GET /setting_groups/1.json
  def show
  end

  # GET /setting_groups/new
  def new
    @setting_group = SettingGroup.new
  end

  # GET /setting_groups/1/edit
  def edit
  end

  # POST /setting_groups
  # POST /setting_groups.json
  def create
    @setting_group = SettingGroup.new(setting_group_params)

    respond_to do |format|
      if @setting_group.save
        format.html { redirect_to @setting_group, notice: 'Setting group was successfully created.' }
        format.json { render :show, status: :created, location: @setting_group }
      else
        format.html { render :new }
        format.json { render json: @setting_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /setting_groups/1
  # PATCH/PUT /setting_groups/1.json
  def update
    respond_to do |format|
      if @setting_group.update(setting_group_params)
        format.html { redirect_to @setting_group, notice: 'Setting group was successfully updated.' }
        format.json { render :show, status: :ok, location: @setting_group }
      else
        format.html { render :edit }
        format.json { render json: @setting_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /setting_groups/1
  # DELETE /setting_groups/1.json
  def destroy
    @setting_group.destroy
    respond_to do |format|
      format.html { redirect_to setting_groups_url, notice: 'Setting group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_setting_group
      @setting_group = SettingGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def setting_group_params
      params.require(:setting_group).permit(:name, :setting_group_id)
    end
end
