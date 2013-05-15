class NewsItemsController < AuthenticatedController
    respond_to :xml, :html, :js 
    respond_to :json, :only => [:index]
    layout 'content'

  # GET /news_item
  # GET /news_item.xml
	def index
		respond_with @news_items = NewsItem.all
	end
	
  def export
    @objects = NewsItem.all
    respond_with do |format|
      format.xml {
        @temp_file = Tempfile.new("xmlnewslist", "#{Rails.root}/tmp")
        render  #export.xml.builder
        send_file(@temp_file.path, :filename => "NewsList.xml", :type => "text/xml")
      }
    end
  end
  
	def synchronize
		@news_items = NewsItem.all
	end

  # GET /newsitems/1/edit
  def edit
    @object = params[:id].blank?? NewsItem.new : NewsItem.find(params[:id])
    respond_with(@object) do |format|
    	format.js  	{render :template=>'shared/edit', :layout => 'layouts/edit', :formats=>[:html]}
    end
  end

  # POST /newsitems
  # POST /newsitems.xml
  def create
      @object = NewsItem.new(params[:news_item])
      flash[:notice] = @object.Name + ' was successfully created.' if @object.save
      respond_with(@object) do |format|
        format.js {render :template=>'shared/close',  :formats => [:js], :content_type=>'text/javascript'}
      end
  end

  def update
    @object = NewsItem.find(params[:id])
    flash[:notice] = @object.Name + ' was successfully updated.' if @object.update_attributes(params[:news_item])
      # render :template=>'shared/close.js', :content_type=>'text/javascript', :layout=>false
    respond_with(@object) do |format|
      format.js {render :template=>'shared/close', :formats => [:js], :content_type=>'text/javascript'}
    end      
  end

  # DELETE /News_item/1
  # DELETE /News_item/1.xml
  def destroy
    @object = NewsItem.find(params[:id])
    flash[:notice] = @object.Title + " deleted." if @object.destroy
    respond_with(@object) do |format|
      format.js {render :template=>'shared/close.js', :content_type=>'text/javascript'}
    end   
  end
end
