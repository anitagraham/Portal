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

    def export
      if params[:id]    #is this a single tag export
#     export uses the cssclass not the numerical id
        @tags = Tag.where("name = ?", params[:id]).includes([:people, :publications])
      else
        @tags = Tag.all
        respond_to do |format|
          format.xml {
            @temp_file = Tempfile.new("xmltaglist", "#{Rails.root}/tmp")
            render  #export.xml.builder
            send_file(@temp_file.path, :filename => "TagList.xml", :type => "text/xml")
          }
          format.json render :json =>@tags
        end
      end
 
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
      @object = Tag.new(params[:tag])
      flash[:notice] = @object.Title + ' was successfully created.' if @object.save
      respond_with(@object) do |format|
        format.js {render :template=>'shared/close.js', :content_type=>'text/javascript'}
      end
    end

    def update
      @tag = Tag.find(params[:id])
      flash[:notice] = @tag.Title + ' was successfully updated.' if @tag.update_attributes(params[:tag])
       respond_with(@tag) do |format|
        format.js {render :template=>'shared/close', :format=>:js, :content_type=>'text/javascript'}
      end      
   end

    # DELETE /tags/1
    # DELETE /tags/1.xml
  def destroy
    @object = Tag.find(params[:id])
    title = @object.Title
    @object.destroy
    redirect_to "/", :notice => "Successfully deleted tag #{title}."
  end
end

