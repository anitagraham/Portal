class NewsLinksController < AuthenticatedController
	respond_to :html, :xml, :js
  respond_to :json, :only => [:index]
	layout 'content'

  def index
    @news_links = NewsLink.scoped
  	if params[:limit]
    	@news_links = @news_links.limit(params[:limit])
    end
    respond_with @news_links
  end

  def export
      @news_links = NewsLink.include(:news_source)
      get_all_sources
      get_all_tags
      respond_to do |format|
          format.xml {
              @temp_file = Tempfile.new("xmlnewslist", "#{Rails.root}/tmp")
              render  #export.xml.builder
              send_file(@temp_file.path, :filename => "NewsList.xml", :type => "text/xml")
          }
      end
  end

  # GET /newslinks/1/edit
  def edit
      @object = params[:id].blank?? NewsLink.new : NewsLink.find(params[:id]) 
      respond_with(@object) do |format|
      	format.js  	{render :template=>'shared/edit', :layout => 'layouts/edit', :formats=>[:html]}
      end
	end

  # POST /newslinks
  # POST /newslinks.xml
  def create
    @NewsLink = NewsLink.new(params[:news_link])
    flash[:notice] = @NewsLink.Title + " created." if @NewsLink.save
    render :template=>'shared/close', :format=> :js, :content_type=>'text/javascript'   
  end

  def update
    @object = NewsLink.find(params[:id])
    flash[:notice] = @object.Title + " updated." if @object.update_attributes(params[:news_link])
	  render :template=>'shared/close', :format=> :js, :content_type=>'text/javascript' 
  end

  # DELETE /NewsLink/1
  # DELETE /NewsLink/1.xml
  def destroy
    @object = NewsLink.find(params[:id])
    if @object.destroy
	    flash[:notice] = "Successfully deleted #{@object.Title}."
	    redirect_to '/'
    end
  end
end
