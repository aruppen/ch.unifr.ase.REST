class PatientsController < ApplicationController
  before_action :set_patient, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction
  def index
    if params[:start].nil?
      params[:start] = 0
      params[:size] = 20
    end
    #@patients = Patient.order(sort_column + ' ' + sort_direction)
    #@patients = Patient.all(:all, :params => {:start => params[:start], :size => params[:size]})
    #@patients = Patient.all(:all)
    @patients = Patient.all()
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @patient = Patient.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @patient = Patient.new(post_params).save
    respond_to do |format|
      if @patient.save
        format.html { redirect_to @patient, notice: 'Post was successfully created.' }
        format.json { render action: 'show', status: :created, location: @patient }
      else
        format.html { render action: 'new' }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @patient.update(post_params)
        format.html { redirect_to @patient, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    #@patient.destroy
    Patient.delete(params[:id])
    respond_to do |format|
      format.html { redirect_to patients_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_patient
    @patient = Patient.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:patient).permit(:lastName, :firstName)
  end

  def sort_column
    Patient.column_names.include?(params[:sort]) ? params[:sort] : "title"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
