class PermissionTypesController < ApplicationController
  before_action :set_permission_type, only: [:show, :edit, :update, :destroy]

  # GET /permission_types
  # GET /permission_types.json
  def index
    @permission_types = PermissionType.all
  end

  # GET /permission_types/new
  def new
    @permission_type = PermissionType.new
  end

  # POST /permission_types
  # POST /permission_types.json
  def create
    @permission_type = PermissionType.new(permission_type_params)

    respond_to do |format|
      if @permission_type.save
        format.html { redirect_to permission_types_path, notice: 'PermissionType was successfully created.' }
        format.json { render :show, status: :created, location: permission_types_path }
      else
        format.html { render :new }
        format.json { render json: @permission_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /permission_types/1
  # PATCH/PUT /permission_types/1.json
  def update
    respond_to do |format|
      if @permission_type.update(permission_type_params)
        format.html { redirect_to @permission_type, notice: 'PermissionType was successfully updated.' }
        format.json { render :show, status: :ok, location: @permission_type }
      else
        format.html { render :edit }
        format.json { render json: @permission_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /permission_types/1
  # DELETE /permission_types/1.json
  def destroy
    @permission_type.destroy
    respond_to do |format|
      format.html { redirect_to permission_types_url, notice: 'PermissionType was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_permission_type
      @permission_type = PermissionType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def permission_type_params
      params.require(:permission_type).permit(:controller, :action)
    end
end
