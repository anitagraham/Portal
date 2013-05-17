class UsersController < AuthenticatedController
  respond_to :html, :js
  layout "content"
  
  def index
  	@users = User.all
  end
    
  def create
    @user = User.new(params[:user])
    flash[:notice] =  @user.Name + ' created.' if @user.save
    respond_with(@user) do |format|
      format.js {render :template=>'shared/close', :content_type=>'text/javascript', :formats=>[:js]}
    end
  end
  
  def edit
    @object = params[:id].blank?? User.new : User.find(params[:id])
    respond_with(@object) do |format|
    	format.js  	{render :template=> 'shared/edit', :layout => 'layouts/edit', :formats=>[:html]}
    end
  end #edit
    
  def update
    @user = User.find(params[:id])
    flash[:notice] = @user.Name + ' updated.' if @user.update_attributes(params[:user])              
  end #update    
    
  def disable
    @user = User.find(params[:id])
    flash[:notice] = @user.Name + ' disabled.' if @user.disable
    render :update, format: [:js]
  end 

  def enable
    @user = User.find(params[:id])
    flash[:notice] = @user.Name + ' enabled.' if @user.enable
    render :update, format: [:js]
  end
end

