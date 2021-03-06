class MembershipsController < ApplicationController
  before_action :set_membership, only: [:show, :edit, :update, :destroy]

  def select
    return unless params[:query] and params[:query].length > 0
    @members = User.where("name LIKE ? OR mail LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")
  end  

  def index
    @group = Group.find params[:group_id]
    @members = @group.members
  end

  # GET /memberships/1
  # GET /memberships/1.json
  def show
  end

  # GET /memberships/new
  def new
    @membership = Membership.new
  end

  # GET /memberships/1/edit
  def edit
  end

  # POST /memberships
  # POST /memberships.json
  def create
    @group = Group.find params[:group_id]
    @membership = @group.members.new(membership_params)

    if @membership.save
      render partial: "groups/member", locals: {membership: @membership}
    else
      render plain: "ERROR"
    end
  end

  # PATCH/PUT /memberships/1
  # PATCH/PUT /memberships/1.json
  def update
    respond_to do |format|
      if @membership.update(membership_params)
        format.html { redirect_to @membership, notice: 'Membership was successfully updated.' }
        format.json { render :show, status: :ok, location: @membership }
      else
        format.html { render :edit }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /memberships/1
  # DELETE /memberships/1.json
  def destroy
    @membership.destroy
    render plain: "OK"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_membership
      @membership = Membership.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def membership_params
      params.require(:membership).permit(:member_type, :member_id)
    end
end
