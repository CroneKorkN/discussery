class LastAccessesController < ApplicationController
  before_action :set_last_access, only: [:show, :edit, :update, :destroy]

  # GET /last_accesses
  # GET /last_accesses.json
  def index
    @last_accesses = LastAccess.all
  end

  # GET /last_accesses/1
  # GET /last_accesses/1.json
  def show
  end

  # GET /last_accesses/new
  def new
    @last_access = LastAccess.new
  end

  # GET /last_accesses/1/edit
  def edit
  end

  # POST /last_accesses
  # POST /last_accesses.json
  def create
    @last_access = LastAccess.new(last_access_params)

    respond_to do |format|
      if @last_access.save
        format.html { redirect_to @last_access, notice: 'Last access was successfully created.' }
        format.json { render :show, status: :created, location: @last_access }
      else
        format.html { render :new }
        format.json { render json: @last_access.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /last_accesses/1
  # PATCH/PUT /last_accesses/1.json
  def update
    respond_to do |format|
      if @last_access.update(last_access_params)
        format.html { redirect_to @last_access, notice: 'Last access was successfully updated.' }
        format.json { render :show, status: :ok, location: @last_access }
      else
        format.html { render :edit }
        format.json { render json: @last_access.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /last_accesses/1
  # DELETE /last_accesses/1.json
  def destroy
    @last_access.destroy
    respond_to do |format|
      format.html { redirect_to last_accesses_url, notice: 'Last access was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_last_access
      @last_access = LastAccess.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def last_access_params
      params.require(:last_access).permit(:user_id, :topic_id, :time)
    end
end
