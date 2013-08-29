class CaregiversController < ApplicationController
  before_action :set_caregiver, only: [:show, :edit, :update, :destroy]

  #before_action :set_post, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction
  # GET /caregivers
  # GET /caregivers.json
  def index
    if params[:start].nil?
      params[:start] = 0
      params[:size] = 20
    end
    @caregivers = Caregiver.all
  end

  # GET /caregivers/1
  # GET /caregivers/1.json
  def show
  end

  # GET /caregivers/new
  def new
    @caregiver = Caregiver.new
  end

  # GET /caregivers/1/edit
  def edit
  end

  # POST /caregivers
  # POST /caregivers.json
  def create
    @caregiver = Caregiver.new(caregiver_params)

    respond_to do |format|
      if @caregiver.save
        format.html { redirect_to @caregiver, notice: 'Caregiver was successfully created.' }
        format.json { render action: 'show', status: :created, location: @caregiver }
      else
        format.html { render action: 'new' }
        format.json { render json: @caregiver.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /caregivers/1
  # PATCH/PUT /caregivers/1.json
  def update
    respond_to do |format|
      if @caregiver.update(caregiver_params)
        format.html { redirect_to @caregiver, notice: 'Caregiver was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @caregiver.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /caregivers/1
  # DELETE /caregivers/1.json
  def destroy
    Caregiver.delete(params[:id])
    respond_to do |format|
      format.html { redirect_to caregivers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_caregiver
      @caregiver = Caregiver.find(params[:id])
    end

# Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:caregiver).permit(:lastName, :firstName)
  end

  def sort_column
    Patient.column_names.include?(params[:sort]) ? params[:sort] : "firstName"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
