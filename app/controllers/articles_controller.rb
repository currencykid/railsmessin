class ArticlesController < ApplicationController
	before_action :set_item , only: [:edit, :update, :show, :destroy]

	
	def index
		@articles = Article.all 
	end 

	def new
		
		@article = Article.new  # Article is the class name
	end

	def edit
	end


	def create 
	# 	render plain: params[:article].inspect
	@article = Article.new(article_params)
		if @article.save
			flash[:notice] = "Posted successfully!" 
			redirect_to article_path(@article)
		else

			render 'new' 
		end 
	#	@article.save
	#	redirect_to article_path(@article) 
	end 

	def update 
		if @article.update(article_params)
			flash[:notice] = "Updated successfully!"
			redirect_to article_path(@article)
		else
			render 'edit'
		end
	end 

	def show
	end

	def destroy
		@article.destroy
		
		flash[:notice] = "Succesfully deleted" 
		redirect_to articles_path
	end

	private
	def set_item
		@article = Article.find(params[:id])
	end

		def article_params
			params.require(:article).permit(:title, :description)
		end
end
