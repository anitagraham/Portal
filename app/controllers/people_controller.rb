class PeopleController < AuthenticatedController
  respond_to :xml, :json, :only => [:show, :index, :export]
  respond_to :html, :js
  respond_to :png, :jpg
  layout "content"

	# GET /people/1
	
	def show
   	subs = {"_" => "-", "." => " "}
    fullname = params[:id].gsub(/_|\./) {|match| subs[match]}
    @person = Person.named(fullname)
    respond_with @person do |format|
      format.png { send_file @person.first.photo.path, type: "image/png", disposition: "inline"}
      format.jpg { send_file @person.first.photo.path, type: "image/jpg", disposition: "inline"}
    end
	end

  # GET /people
  # GET /people.xml
  def index
    @people = Person.scoped
    if params[:status]
    	@people = @people.has_status(params[:status])
    end
    if params[:role]
    	@people = @people.has_role(params[:role])
    end
    if params[:tag]
    	@people=@people.has_tag(params[:tag])
    end
    respond_with @people do |format|
    	format.png {send_data view_context.photo_strip('png', 12), type: "image/png",disposition: "inline"}
    	format.jpg {send_data view_context.photo_strip('jpg', 12), type: "image/jpg",disposition: "inline"}
    end
  end

  # def export
# 
    # if params[:id]    #is this a single person export (name sent as id in format firstname.surname)
    	# # Where there is a hyphenated name the hyphen has been substituted with an underscore (ed.barrett-lennard)
    	# # Where a name has a space (eg Chun Woo Baek) the space has been substituted with a period  (chun.woo.baek)
    	# subs = {"_" => "-", "." => " "}
      # fullname = params[:id].gsub(/_|\./) {|match| subs[match]}
      # @people = Person.named(fullname)
# 
    # elsif params[:tag]
      # # export people with a particular tag 
      # @people = Person.where("tags.css_class = ?", params[:tag])
      # fn = params[:tag]
    # else
      # # export all active people
      # @people = Person.where("Status='Active'")
      # fn = "staffList"
    # end
# 
    # respond_with @people do |format|
      # format.xml {
      	# now = Time.now.strftime("%d%m%Y%H%M").to_s
 	    	# @fileNames = "#{Rails.root}/downloads/#{fn}-#{now}"
       	# render  #export.xml.builder
        # send_file(@fileNames+".zip", :type=>"application/zip", :disposition=>"attachment")
      # }
      # format.json {
      	# render :json =>  {list: @people},	:callback => params[:callback]
      # }
    # end
  # end

 
  # GET /people/1
  # GET /people/1.xml
  # GET /people/1,json
  # GET /people/1/edit
  def edit
    @object = params[:id].blank? ? Person.new : Person.find(params[:id])
    @pubs = @object.publications
    respond_with(@object) do |format|
    	format.js  	{render :template=> 'shared/edit', :layout => 'layouts/edit', :formats=>[:html]}
    	format.json { render :json => {person:@object}, :callback=> params[:callback]}
    end

  end

  # POST /people
  # POST /people.xml
  def create
    @object = Person.new(params[:person])
    flash[:notice] =  @object.Name +  ' created.' if @object.save
    render :template=>'shared/close', :format=> :js, :content_type=>'text/javascript'   
  end

  # PUT /people/1
  # PUT /people/1.xml
  def update
    @object = Person.find(params[:id])
    flash[:notice] = @object.Name + " updated." if @object.update_attributes(params[:person])
	  render :template=>'shared/close', :format=> :js, :content_type=>'text/javascript' 
  end

  # DELETE /people/1
  # DELETE /people/1.xml
  def destroy
    @person = Person.find(params[:id])
    if @person.destroy
	    flash[:notice] = "Successfully deleted #{@person.Name}."
	    redirect_to '/'
    end

  end

end
