class NewsSourcesController < AuthenticatedController

  respond_to :html, :js
  layout 'content'
  
  # GET /news_sources
  # GET /news_sources.xml

  def index
    respond_with @news_sources = NewsSource.all
  end

  def edit
    @object = NewsSource.find_by_id(params[:id]) || NewsSource.new
    respond_with @object do |format|
    	format.js  	{render :template=>'shared/edit', :layout => 'layouts/edit', :formats=>[:html]}
	  end
  end

  # POST /news_sources
  # POST /news_sources.xml
  def create
    @object = NewsSource.new(params[:news_source])
    flash[:notice] =  @object.Name +  ' created.' if @object.save
	  render :template=>'shared/close', :format=> :js, :content_type=>'text/javascript'   
  end

  # PUT /news_sources/1
  # PUT /news_sources/1.xml
  def update
    @object = NewsSource.find(params[:id])
    flash[:notice] = @object.Name + " updated." if @object.update_attributes(params[:news_source])
	  render :template=>'shared/close', :format=> :js, :content_type=>'text/javascript' 
  end


    # DELETE /news_sources/1
    # DELETE /news_sources/1.xml
    def destroy
        @object = News_source.find(params[:id])
        @object.destroy
        if request.xhr?
            render :nothing => true
        else
            flash[:notice] = "Successfully deleted news source."
            redirect_to news_sources_url
        end
    end
end
