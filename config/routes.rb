Dinorails::Application.routes.draw do
  
  resources :users, :only => [:index, :show]
  
end
