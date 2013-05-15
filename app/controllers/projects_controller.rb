class ProjectsController < AuthenticatedController
    respond_to :xml, :only => [:export]
    respond_to :html, :js
    respond_to :json, :only => [:index]
    layout "content"
    
    
    # GET /projects
    # GET /projects.xml

    def index
 			@projects = Project.all
    end

    def export
      @projects = Project.all
      respond_to do |format|
        format.xml {
          @temp_file = Tempfile.new("xmlProjectlist", "#{Rails.root}/tmp")
          render  'export.xml.builder'
          send_file(@temp_file.path, :filename => "ProjectList.xml", :type => "text/xml")
 	     }
      end
    end

    # GET /projects/1
    # GET /projects/1.xml
    # GET /projects/1/edit
    def edit
      @object = params[:id].blank?? Project.new : Project.find(params[:id])
      respond_with @object do |format|
      	format.js  	{render :template=> 'shared/edit', :layout => 'layouts/edit', :formats=>[:html]}
      end
    end

    # POST /projects
    # POST /projects.xml
    def create
      @object = Project.new(params[:project])
      flash[:notice] =  @object.Title + ' created.' if @object.save
      render :template=>'shared/close', :format=> :js, :content_type=>'text/javascript'
    end

    # PUT /projects/1
    # PUT /projects/1.xml
    def update
      @object = Project.find(params[:id])
      flash[:notice] = @object.Title + ' updated.' if @object.update_attributes(params[:project])
      render :template=>'shared/close', :format=> :js, :content_type=>'text/javascript'
    end

    # DELETE /projects/1

    def destroy
      @project = Project.find(params[:id])
      if @project.destroy
        flash[:notice] = "Successfully deleted #{@project.Name}."
        render :template=>'shared/close.js'
      end
    end
end
