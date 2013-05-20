class TagsController < AuthenticatedController
    respond_to :xml, :json, :only => [:show, :index, :export]
    respond_to :html, :js
    layout 'content'
 	# GET /tag/1
	
	def show
   	subs = {'_' => '-', '.' => ' '}
    tag = params[:id].gsub(/_|\./) {|match| subs[match]}		
    @tag = Tag.where("name = ? or Title =?", tag, tag)
	end
	
	
  # GET /tags
  # GET /tags.xml
  def index
		@tags = Tag.all
  end

  def toggle     
    @tag = Tag.find(params[:id])
    respond_with(@tag)
  end
    
  def edit
      @object = params[:id].blank?? Tag.new : Tag.find(params[:id])
      respond_with(@object) do |format|
	    	format.js  	{render :template=> 'shared/edit', :layout => 'layouts/edit', :formats=>[:html]}
      end
  end

  def create
    @tag = Tag.new(params[:tag])
    flash[:notice] = @tag.Title + ' was successfully created.' if @tag.save
  end

  def update
    @tag = Tag.find(params[:id])
    flash[:notice] = @tag.Title + ' was successfully updated.' if @tag.update_attributes(params[:tag])
  end

    # DELETE /tags/1
    # DELETE /tags/1.xml
  def destroy
    @object = Tag.find(params[:id])
    title = @object.Title
    @object.destroy
    flash[:notice] = "Successfully deleted #{title}."
    render template: 'shared/delete', formats: ['js'], content_type: 'text/javascript'
  end
end

