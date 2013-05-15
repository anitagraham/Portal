class ThemesController < AuthenticatedController
  respond_to :xml, :json, :only => [:show, :index, :export]
  respond_to :html, :js
  layout "content"


	# GET /theme/1
	
	def show
   	subs = {'_' => '-', '.' => ' '}
    theme = params[:id].gsub(/_|\./) {|match| subs[match]}		
    @theme = Theme.where("Title = ?", theme)
	end
        
    # GET /themes
    # GET /themes.xml
    def index
    	@themes = Theme.all
    end #index

    def export
      @themes = Theme.all
      get_theme_tags
      respond_to do |format|
        format.xml {
            @temp_file = Tempfile.new("xmlthemelist", "#{Rails.root}/tmp")
            render  #export.xml.builder
            send_file(@temp_file.path, :filename => "ThemeList.xml", :type => "text/xml")
        }
      end
    end
    # GET /themes/1
    # GET /themes/1.xml
            
    def edit
      @object = params[:id].blank?? Theme.new : Theme.find(params[:id])
      respond_with(@object) do |format|
    		format.js { render 'shared/edit'}      	
      end
    end #edit

   def create
      @theme = Theme.new(params[:theme])
      flash[:notice] =  @theme.Title + ' created.' if @theme.save
      respond_with(@theme) do |format|
        format.js {render :template=>'shared/close.js'}
      end
    end #create

   
   def update
      @theme = Theme.find(params[:id])
      flash[:notice] = @theme.Title + ' updated.' if @theme.update_attributes(params[:theme])              
      respond_with(@theme) do |format|
       format.js {render :template=>'shared/close.js', :content_type=>'text/javascript'}
    end
    end #update

    # DELETE /themes/1
    # DELETE /themes/1.xml
    
    def destroy
      @theme = Theme.find(params[:id])
      if @theme.destroy
          flash[:notice] = "Successfully deleted #{@theme.Title}."
          render :template=>'shared/close.js'
      end          
    end    # DELETE /themes/1
    
end  # Class ThemesController

