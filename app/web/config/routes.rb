ActionController::Routing::Routes.draw do |map|

  map.root :controller => 'dashboard', :action => 'index'
  map.resources :students
  map.resources :alerts
  map.administration '/administration', :controller => 'administration'



  #
  # Developer Routes (for testing and stuff)
  #
  map.with_options :controller => 'dev', :path_prefix => 'dev' do |dev|
    dev.flash '/flash/:level/:message', :action => 'demo_flash' #, :controller => 'dev', :path_prefix => 'dev'
  end



  #
  # Authenticated System routes
  #
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  #map.register '/register', :controller => 'admins', :action => 'create'
  #map.signup '/signup', :controller => 'admins', :action => 'new'
  map.resources :admins

  map.resource :session



  #
  # default routes
  #
  map.connect ':controller/:action'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
