ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'dashboard', :action => 'index'
  map.resources :students



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
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
