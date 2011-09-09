# Dinorails

## Initial setup
```
rails new dinorails
cd dinorails
git init
mate .
```

# Gemfile
* Kill everything except rails and sqlite3
* Change rails to 3.1.0

# rvm
Add a .rvmrc file with the following content:
```
#!/usr/bin/env bash

# This is an RVM Project .rvmrc file, used to automatically load the ruby
# development environment upon cd'ing into the directory

# First we specify our desired <ruby>[@<gemset>], the @gemset name is optional.
environment_id="ruby-1.9.2-p290@dinorails"

#
# First we attempt to load the desired environment directly from the environment
# file, this is very fast and efficicent compared to running through the entire
# CLI and selector. If you want feedback on which environment was used then
# insert the word 'use' after --create as this triggers verbose mode.
#
if [[ -d "${rvm_path:-$HOME/.rvm}/environments" \
  && -s "${rvm_path:-$HOME/.rvm}/environments/$environment_id" ]] ; then
  \. "${rvm_path:-$HOME/.rvm}/environments/$environment_id"
else
  # If the environment file has not yet been created, use the RVM CLI to select.
  rvm --create use  "$environment_id"

rvm wrapper "$environment_id" textmate
echo $MY_RUBY_HOME
```


     - cd ../
     - cd dinorails
     - hit enter
     - type yes
     - ruby -v, rails -v, and notice that they are the version specified in rvmrc and Gemfile, respectively
     explanation of rvm, ruby version, etc

Bundler
     - gem install bundler (because that gem set will not have it)
     - bundle install
     explanation of bundler and how gems are managed

Starting the app
     - rails server
     - navigate to localhost:3000 in your browser, see the app running, wow!
     - open new terminal tab and cd to where dinorails is

Your first model
     - rails generate model user
     talk about each of the files created
     - open user.rb and user_test.rb
     - add test_creation test, run test
     - ActiveRecord::StatementInvalid: Could not find table 'users'
     - rake db:migrate, run test, same error
     - rake db:test:prepare, run test
     - ActiveRecord::UnknownAttributeError: unknown attribute: name
     introduce rails console
     - rails console
     - User (look at the columns on user, no name)
     - since you haven't yet committed, open migration and add t.string :name
     -  rake:db:redo, rake db:test:prepare
     - passing test, yay!
     - rails console
     - User (look at the columns on user, name, awesome)
     good time to commit, reminder to always run rake before committing
     - mate .gitignore, add .rvmrc to gitignore
     - git status; git add .; git commit -m 'Add user model'; git push
     back to model, add validation
     - want to make sure the user always has a name
     - add test_validations, run test, failure!
     - add validates_presence_of :name to model under the validations section (talk about partitioning our models into sections)
     - run test, NoMethodError: undefined method `assert_errors_on' for #<UserTest:0x00000100cc7d00>
     - add assert_errors_on to test_helper
     - run test, pass, yay again
     - add test_destroy StandardError: No fixture with name 'default' found for table 'users'
     - set up fixture without a name, write failing test_fixtures_validity
     - add name to fixture, see passing test_fixtures_validity and test_destroy
     class methods
     - add test_self_fancy_name
     - NoMethodError: undefined method `fancy_name' for #<Class:0x00000103a80558>
     - add empty method self.fancy_name(name) under class methods heading, run test
     - <"Dinosaur Owner This is my awesome name"> expected but was <nil>.
     - add "Dinosaur Owner #{name}" inside self.fancy_name, run test, pass
     - refactor by creating a constant PREFIX = 'Dinosaur owner', and using the constant within self.fancy_name
     - verify that test still passes, tests + refactoring = <3
     instance methods
     - add test_fancy_name to tests
     - NoMethodError: undefined method `fancy_name' for #<User:0x00000101ce6010>
     - add empty fancy_name method to model, run test
     - <"Dinosaur Owner Default User"> expected but was <nil>.
     - add self.class.fancy_name(self.name) to fancy_name method, run test, pass
     - !!!!CALLBACKS STILL NEEDED!!!!

Your first controller
     - rails g controller users
     talk about each of the files created, delete helpers and stuff in asset pipeline?
     - rm app/helpers/users_helper.rb, rm test/unit/helpers/users_helper_test.rb (talk about helpers later)
     - open users_controller and users_controller_test
     talk about the actions we will be creating
     index
     - add test_get_index (without assert assigns(:users)), run test
     - ActionController::RoutingError: No route matches {:controller=>"users"}
     talk about routes
     - add resources :users, :only => :index to routes
     - rake routes (discuss paths created)
     - run test
     - AbstractController::ActionNotFound: The action 'index' could not be found for UsersController
     - add empty index action to controller, run test
     - ActionView::MissingTemplate: Missing template users/index, application/index with {:handlers=>[:erb, :builder, :haml], :formats=>[:html], :locale=>[:en, :en]
     - add empty file index.erb, run test, passing
     - add assert assigns(:users) to test_index, failure
     - add @users = User.all to index action, run test, pass
     show
     - add test_get_show (without assert assigns(:user)), run test
     - ActionController::RoutingError: No route matches {:id=>"593363170", :controller=>"users", :action=>"show"}
     - modify routes to resources :users, :only => [:index, :show]
     - AbstractController::ActionNotFound: The action 'show' could not be found for UsersController
     - add empty show action to the controller
     - ActionView::MissingTemplate: Missing template users/show, application/show with {:handlers=>[:erb, :builder, :haml], :formats=>[:html], :locale=>[:en, :en]}. Searched in:
  * "/Users/dess-e/code/rails/dinorails/app/views"     - add empty file show.erb to controller, run test, pass
     - add assert assigns(:user) to test_show, run test, failure
     - add @user = User.find(params[:id]) to show action, run test, pass
     show (failing)
     - add test_get_show_failure
     - ActiveRecord::RecordNotFound: Couldn't find User with id=invalid
     - add rescue ActiveRecord::RecordNotFound to show action, without anything in the rescue block, run test
     - test_get_show_failure(UsersControllerTest) [/Users/dess-e/code/rails/dinorails/test/functional/users_controller_test.rb:22]:
Expected response to be a <:not_found>, but was <200>
     - add render :not_found, :status => :not_found to rescue block, run test
     - test_get_show_failure(UsersControllerTest):
ActionView::MissingTemplate: Missing template users/not_found, application/not_found with {:handlers=>[:erb, :builder, :haml], :formats=>[:html], :locale=>[:en, :en]}. Searched in:
  * "/Users/dess-e/code/rails/dinorails/app/views"     - add empty not_found.erb, run test, pass
     new
     - add test_get_new without assert assigns(:user)
     - ActionController::RoutingError: No route matches {:controller=>"users", :action=>"new"}
     - kill the :only option of the resources route
     - rake routes, check out all the awesome routes
     - run test again
     - AbstractController::ActionNotFound: The action 'new' could not be found for UsersController
     - add empty new action to controller, run test
     - ActionView::MissingTemplate: Missing template users/new, application/new with {:handlers=>[:erb, :builder, :haml], :formats=>[:html], :locale=>[:en, :en]}. Searched in:
  * "/Users/dess-e/code/rails/dinorails/app/views"     - add empty new.erb, run test, pass
     - add assert assigns(:user), run test, failure
     - add @user = User.new(params[:user]) to new action, run test, pass
     edit (failing)
     - add test_get_edit without assert assigns(:user), run test
     - AbstractController::ActionNotFound: The action 'edit' could not be found for UsersController
     - reminder that the routing error is no longer showing because the :only option was removed
     - add empty edit action, run test
     - ActionView::MissingTemplate: Missing template users/edit, application/edit with {:handlers=>[:erb, :builder, :haml], :formats=>[:html], :locale=>[:en, :en]}. Searched in:
  * "/Users/dess-e/code/rails/dinorails/app/views"     - add empty edit.erb, run test, pass
     - add assert assigns(:user), run test, failure
     - add @user = User.find(params[:id]) to edit action, run test, pass
     - add test_get_edit_failure
     - ActiveRecord::RecordNotFound: Couldn't find User with id=invalid
     - add empty rescue ActiveRecord::RecordNotFound block, run test
     - Expected response to be a <:not_found>, but was <200>
     - add render :not_found, :status => :not_found to rescue block, run test, pass
     two things to note here: first, there was no template missing error, because we're re-using the 404 page; second, the code for show and edit is identical, which begs for refactoring. Let's do this now. Talk about before filters
     - add protected load_user method, and copy the code from show/edit into the new method
     - add before_filter :load_user, :only => [:show, :edit] (talk about the :only option)
     - admire clean code, pat self on back
     - replace the code in show/edit with render, run controller tests again, make sure they all pass
     again, stress tests + refactoring = <3
     create
     - add test_creation
     - AbstractController::ActionNotFound: The action 'create' could not be found for UsersController
     - add empty create action to controller, run test
     - ActionView::MissingTemplate: Missing template users/create, application/create with {:handlers=>[:erb, :builder, :haml], :formats=>[:html], :locale=>[:en, :en]}. Searched in:
  * "/Users/dess-e/code/rails/dinorails/app/views"     note that in this situation, you don't need a template, because we'll be redirecting
     - add the create method with instantiation (which we'll later refactor out to a build_user method), and without the rescue block
     - run test, pass
     create (failure)
     - add test_creation_failure
     - ActiveRecord::RecordInvalid: Validation failed: Name can't be blank
     - add empty rescue ActiveRecord::RecordInvalid block, run test
     - ActionView::MissingTemplate: Missing template users/create, application/create with {:handlers=>[:erb, :builder, :haml], :formats=>[:html], :locale=>[:en, :en]}. Searched in:
  * "/Users/dess-e/code/rails/dinorails/app/views"
     - add render :new to rescue block, run test, failure
     - add flash.now[:error] = 'Failed to create user' before render :new, run test, pass
     update
     - add test_update
     - AbstractController::ActionNotFound: The action 'update' could not be found for UsersController
     - add empty update action to controller
     - ActionView::MissingTemplate: Missing template users/update, application/update with {:handlers=>[:erb, :builder, :haml], :formats=>[:html], :locale=>[:en, :en]}. Searched in:
  * "/Users/dess-e/code/rails/dinorails/app/views"     - need to load the user, and redirect to the user show page, so add :update to the before filter, and redirect_to :action => :show, :id => @user to the update action, run test, failure
     - add flash[:notice] = 'PRO updated' before the redirect, run test
     - <"Updated User Name"> expected but was <"Default User">.
     - add @user.update_attributes!(params[:pro]) as the first line in the update action, run test, pass
     update (failure)
     - add test_update_failure
     - ActiveRecord::RecordInvalid: Validation failed: Name can't be blank
     - add empty rescue ActiveRecord::RecordInvalid block, run test
     - ActionView::MissingTemplate: Missing template users/update, application/update with {:handlers=>[:erb, :builder, :haml], :formats=>[:html], :locale=>[:en, :en]}. Searched in:
  * "/Users/dess-e/code/rails/dinorails/app/views"
     - need to redirect instead of adding a template, so add render :edit to the rescue block, run test, failure
     - add flash.now[:error] = 'Failed to update User' before render in the rescue block, run test, pass
     destroy
     - add test_destroy
     - AbstractController::ActionNotFound: The action 'destroy' could not be found for UsersController
     - add empty destroy action to controller, run test
     - ActionView::MissingTemplate: Missing template users/destroy, application/destroy with {:handlers=>[:erb, :builder, :haml], :formats=>[:html], :locale=>[:en, :en]}. Searched in:
  * "/Users/dess-e/code/rails/dinorails/app/views"     - need to load user and redirect, so add :destroy to the before filter, and redirect_to :action => :index to the update action, run test, failure
     - add flash[:notice] = 'User deleted' before the redirect, run test
     - "User.count" didn't change by -1. <0> expected but was <1>.
     - add @user.destroy as the first line in the destroy action, run test, pass
