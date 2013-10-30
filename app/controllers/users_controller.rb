class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction

  # GET /users
  # GET /users.json
  def index
    if params[:start].nil?
      params[:start] = 0
      params[:size] = 20
    end
    @users = User.find(:all)#, :params => {:start => params[:start], :size => params[:size]})
  end

  # GET /users/1
  # GET /users/1.json
  def show
    User.user = 'newuser2'
  #@user = User.find(:id)
  #rescue ActiveResource::ResourceNotFound
  #  redirect_to :action => 'not_found'
  #rescue ActiveResource::ResourceConflict, ActiveResource::ResourceInvalid
  #  redirect_to :action => 'new'
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    respond_to do |format|

      @user = User.new({:username => user_params[:username], :email => user_params[:email], :publicvisible => user_params[:publicvisible], :realname => user_params[:realname], :password => user_params[:password]}, true)
      if user_params[:password] != '*'
        @user.password = user_params[:password]
      else
        @user.password = nil
      end



      if @user.save!
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|

      @user.email = user_params[:email]
      @user.publicvisible = user_params[:publicvisible]
      @user.realname = user_params[:realname]
      if user_params[:password] != '*'
        @user.password = user_params[:password]
      else
        @user.password = nil
      end



      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:uri, :username, :password, :realname, :email, :publicvisible)
    end

  def sort_column
    Post.column_names.include?(params[:sort]) ? params[:sort] : "title"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
