class ArticlesController < ApplicationController
	def index
	end 

	def new

			@article = Article.new  # Article is the class name
	end

	def edit
		@article = Article.find(params[:id]) 
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
		@article = Article.find(params[:id])
		if @article.update(article_params)
			flash[:notice] = "Updated successfully!"
			redirect_to article_path(@article)
		else
			render 'edit'
		end
	end 

	def show
		@article = Article.find(params[:id]) 
	end

	private
		def article_params
			params.require(:article).permit(:title, :description)
		end
end
