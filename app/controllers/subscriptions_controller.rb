class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: [:show, :edit, :update, :destroy]

  # GET /subscriptions
  # GET /subscriptions.json
  def index
    puts 'here'
    #@subscriptions = Subscription.find(:all, :params => {:sport => "Boxing", :user_id => 'newuser1'})
  end

  # GET /subscriptions/1
  # GET /subscriptions/1.json
  def show
   # @subscription = Subscription.find(:id)
    #@subscription = Subscription.find(:all, :params => {:sport => "Cycling", :user_id => 'newuser1'})
    @subscription = Subscription.find(params[:id], :params => { :user_id => params[:user_id]})
    @user = User.find(params[:user_id])
    logger.debug(@subscription.http_response['Date'])
    #Subscription.element_name ="Cycling"
    #@sub = Subscription.new({:publicvisible=>0, :sport=>"Cycling"}, true)
    @sub = Subscription.new({:publicvisible=>0}, true)
    #@sub = Subscription.new(:sport_name => "Cycling")
    #@user = User.new({:username => "newuser37", :email => "newuser37@gmail.com", :publicvisible => 0, :realname => "b", :password => "newuser"}, true)
    #@sub.id = "Cycling"
    #@sub = Subscription.new
    @sub = Subscription.new(:publicvisible=>"0")
    @sub.prefix_options[:user_id] = params[:user_id]

    #@sub.sport = 'Cycling'
    #@sub.collection_path='newuser1'
    #@sub = Subscription.new({:params => { :user_id => params[:user_id]}}, true)
    @sub.publicvisible = 0
    logger.debug("new")
    logger.debug(@sub.new?)
    logger.debug("persisted")
    logger.debug(@sub.persisted?)
    #@user.save!
    @sub.save!
  end

  # GET /subscriptions/new
  def new
    @subscription = Subscription.new
  end

  # GET /subscriptions/1/edit
  def edit
  end

  # POST /subscriptions
  # POST /subscriptions.json
  def create
    @subscription = Subscription.new(subscription_params)

    respond_to do |format|
      if @subscription.save
        format.html { redirect_to @subscription, notice: 'Subscription was successfully created.' }
        format.json { render action: 'show', status: :created, location: @subscription }
      else
        format.html { render action: 'new' }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subscriptions/1
  # PATCH/PUT /subscriptions/1.json
  def update
    respond_to do |format|
      if @subscription.update(subscription_params)
        format.html { redirect_to @subscription, notice: 'Subscription was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subscriptions/1
  # DELETE /subscriptions/1.json
  def destroy
    @subscription.destroy
    respond_to do |format|
      format.html { redirect_to subscriptions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subscription
      #Subscription.user = session[:user_id]
      #Subscription.password = session[:passwd]
      Api::Base.user = session[:user_id]
      Api::Base.password = session[:passwd]
      @subscription = Subscription.find(params[:id], :params => { :user_id => params[:user_id]})
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subscription_params
      params[:subscription]
    end
end
