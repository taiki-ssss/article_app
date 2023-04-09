class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]

  def index
    # @articles = Article.preload(:comments)
    @articles = Article.all
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
      redirect_to article_url(@article), flash: { success: "記事を作成しました。" }
    else
      flash.now[:danger] = "入力内容にエラーがあります。"
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.js   { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @article.update(article_params)
      redirect_to article_url(@article), flash: { success: "記事を更新しました。" }
    else
      flash.now[:danger] = "入力内容にエラーがあります。"
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.js   { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path, flash: { success: "記事を削除しました。" }
  end

  private
    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :content,:status)
    end
end
