class LocationsController < AuthenticatedController
  respond_to :xml, :only => [:export]
  respond_to :html, :js
  layout "content"
  # GET /locations
  # GET /locations.xml
 
  def index
    @locations = Location.all
  end
  
  
	def export
	  @locations = Location.all
	  respond_to do |format|
      format.xml {
        @temp_file = Tempfile.new("xmlLocationList", "#{Rails.root}/tmp")
        render  #export.builder.xml
        send_file(@temp_file.path, :filename => "LocationList.xml", :type => "text/xml")
      }
    end
	end


  # GET /locations/1
  # GET /locations/1.xml
  def edit
    @object = Location.find_by_id(params[:id]) || Location.new
    respond_to  do |format|
    	format.js {render 'shared/edit', :content_type=>'text/javascript'}
    end
  end

  def create
    @object = Location.new(params[:location])
    flash[:notice] =  @object.Name + ' created.' if @object.save
      render :template=>'shared/close', :format=> :js, :content_type=>'text/javascript'
  end

  # DELETE /locations/1
  # DELETE /locations/1.xml
  def destroy
    @location = Location.find(params[:id])
    @location.destroy
    if request.xhr?
      render :nothing => true
    else
      flash[:notice] = "Successfully deleted #{@location}."
      redirect_to "/"
    end
  end
end
