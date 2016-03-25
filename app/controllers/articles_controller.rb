class ArticlesController < ApplicationController
	before_action :set_item , only: [:edit, :update, :show, :destroy]
	before_action :require_user, except: [:index,  :show]
	before_action :require_same_user, only: [:edit, :update, :destroy]


	def index
		@articles = Article.paginate(page: params[:page], per_page:5).order("created_at DESC")
	end 

	def new

		@article = Article.new  # Article is the class name
	end

	def edit
	end


	def create 
		# 	render plain: params[:article].inspect
		@article = Article.new(article_params)
		@article.user = current_user 
		if @article.save
			flash[:success] = "Posted successfully!" 
			redirect_to article_path(@article)
		else

			render 'new' 
		end 
		#	@article.save
		#	redirect_to article_path(@article) 
	end 

	def update 
		if @article.update(article_params)
			flash[:success] = "Updated successfully!"
			redirect_to article_path(@article)
		else
			render 'edit'
		end
	end 

	def show
	end

	def destroy
		@article.destroy

		flash[:danger] = "Succesfully deleted" 
		redirect_to articles_path
	end

	private
	def set_item
		@article = Article.find(params[:id])
	end

	def article_params
		params.require(:article).permit(:title, :description)
	end

	def require_same_user
		if current_user != @article.user and !current_user.admin?
			flash[:danger] = "You can only edit or delete your own posts" 
			redirect_to root_path 
		end

	end
end
