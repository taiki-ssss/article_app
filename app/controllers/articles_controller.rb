class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]

  include Paginatable

  def index
    @pagination = Article.order(updated_at: "DESC").search_page(params[:page], params[:per_page], :desc)
    @articles = @pagination[:records]
  end

  def show
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      render :create
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @article.update(article_params)
      redirect_to article_url(@article), flash: { success: "記事を更新しました。" }
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.js   { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @article.destroy
    render turbo_stream: turbo_stream.remove(@article)
  end

  private
    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :content,:status)
    end
end
