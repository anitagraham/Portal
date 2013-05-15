Portal::Application.routes.draw do
# remove export and toggle on all resources

  match "/media/:dragonfly/:file_name", :to => Dragonfly[:images]  

  get "/people/new" => "people#edit", :as => :new_person_path
    
  resources :people, :id => /[\w\.\-]*?/, :format => /json|html|xml|js|png|jpg|/ do
  	resources :tags
 	end

  get "/publications/new" => "publications#edit", :as => :new_publication_path
  resources :publications do
    resources :tags
	end
	
  get "/news_sources/new" => "news_sources#edit", :as=> :new_news_source_path
  resources :news_sources

  get "/themes/new" => "themes#edit", :as => :new_theme_path
  resources :themes, :id => /[\w\.\-]*?/, :format => /json|html|xml|js|/ do
    resources :tags
  end

  get "/tags/new" => "tags#edit", :as => :new_tag_path
  resources :tags, :id => /[\w\.\-]*?/, :format => /json|html|xml|js|/ do
    resources :people
    resources :news_items
    resources :news_links
    resources :publications
    resources :projects
    resources :locations
  end
  
  get "/news_items/new" => "news_items#edit", :as => :new_news_item_path
  resources :news_items do
   	resources :tags
  end
  
  get "/news_links/new" => "news_links#edit", :as => :new_news_link_path
  resources :news_links do
    resources :tags
  end

	get "/projects/new" => "projects#edit", :as => :new_project_path
  get "/projects/new/toggle" => "projects#toggle", :as=>:toggle_project_path
  resources :projects do
    resources :tags
  end
 
  get "/locations/new" => "locations#edit", :as => :new_location_path
    resources :locations do
    resources :tags
  end
  
# Users (people who can login and access the db)
  get "log_in" => "sessions#new", :as => "log_in"
  get "log_out" => "sessions#destroy", :as => "log_out"

  get "/users/new" => "users#edit", :as => "new_user_path"
  resources :users do
  	put :enable,  :on => :member
  	put :disable, :on => :member
  end
  
  resources :sessions

  root :to => "home#index"
end