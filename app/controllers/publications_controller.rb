class PublicationsController < AuthenticatedController
  respond_to :xml, :only => [:export]
  respond_to :json, :only => [:index]
  respond_to :html, :js
  layout "content"
    # GET /publication
    # GET /publication.xml
    def index
      @publications = Publication.all
    end
    
    def export
#     params can be tag=?, type=?, group=?
			@publications = Publication.scoped
			@publications = params[:type]  ? @publications.where("type ==?", params[:type]) : @publications
			@publications = params[:tag]   ? @publications.with_tag(params[:tag]) : @publications
			@publications = params[:group] ? @publications.group(params[:group]) : @publications

      respond_to do |format|
        format.xml {
          @temp_file = Tempfile.new("xmlPublicationslist", "#{Rails.root}/tmp")
          render #export.xml.builder
          send_file(@temp_file.path, :filename => "PublicationsList.xml", :type => "text/xml")  
        }   
        format.json {
          render :json => @publications.to_json
        }       
      end
    end
   
    # GET /publications/1/edit
    def edit
      @object = params[:id].blank?? params[:filter][:sf].constantize.new() : Publication.find(params[:id])
	    respond_with(@object) do |format|
	    	format.js  	{render :template=>'shared/edit', :layout => 'layouts/edit', :formats=>[:html]}
	    end
    end

    # POST /publications
    # POST /publications.xml

    def create
      @publication = params[:kind].constantize.new(params[:publication])
      flash[:notice] =  @publication.Name + ' created.' if @publication.save
    	respond_with @publication do |format|
    		format.js {render 'shared/close', :format=>:js}
    	end
    end

    # PUT /publications/1
    # PUT /publications/1.xml
    def update
    	logger.debug "Updating Publication"
      @publication = Publication.find(params[:id])
      flash[:notice] = @publication.Name + ' was successfully updated.' if @publication.update_attributes(params[:publication])
      render :template=>'shared/close', :format=> :js, :content_type=>'text/javascript'
    end

    # DELETE /publications/1
    # DELETE /publications/1.xml
    def destroy
      @publication = Publication.find(params[:id])
      if @publication.destroy
        flash[:notice] = "Successfully deleted #{@publication.Name}."
        redirect_to '/'
      end
    end
end
