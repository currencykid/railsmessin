require 'test_helper' 

class CategoriesControllerTest < ActionController::TestCase
	def setup
		@category = Category.create(name: "sports") #use create instead of new cuz we want to hit db

		@user = User.create(username: "god" , email: "god@gmail.com", password:"password" , admin: true) 
	end 

	test "should get categories index" do
		get :index
		assert_response :success
	end

	test "should get new" do
		session[:user_id] = @user.id 
		get :new
		assert_response :success
	end

	test "shoud get show" do

		get(:show, {'id' => @category.id})
		assert_response :success
	end 

	test "should redirect create when not admin" do 
		assert_no_difference "Category.count" do 
			post :create, category: {name: "sports"}
		end 
		assert_redirected_to categories_path
	end
end 	
