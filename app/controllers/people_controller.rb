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
    @person = Person.new(params[:person])
    flash[:notice] =  @person.Name +  ' created.' if @person.save
  end

  # PUT /people/1
  # PUT /people/1.xml
  def update
    @person = Person.find(params[:id])
    flash[:notice] = @person.Name + " updated." if @person.update_attributes(params[:person])
  end

  # DELETE /people/1
  # DELETE /people/1.xml
  def destroy
    @object = Person.find(params[:id])
    name = @object.Name
    flash[:notice] = "#{name} deleted" if @object.destroy
    render template: 'shared/delete', formats: ['js'], content_type: 'text/javascript'
  end

end
