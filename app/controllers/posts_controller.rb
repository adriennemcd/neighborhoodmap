class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all
    @question_options = Question.all.map{|q| [ q.description, q.id] }
    if params[:search]
      @postFilt = Post.search(params[:search]).order("created_at DESC")
      @hash = Gmaps4rails.build_markers(@postFilt) do |post, marker|
        marker.lat post.latitude
        marker.lng post.longitude
        marker.title post.id.to_s
        marker.json({
        title:     post.title,
        question: post.question.description,
        description: post.description,
        image: post.image.url(:thumb),
        id: post.id
        })
      end
    else
      @postFilt = Post.all.order('created_at DESC')
      @hash = Gmaps4rails.build_markers(@postFilt) do |post, marker|
        marker.lat post.latitude
        marker.lng post.longitude
        marker.title post.id.to_s
        marker.json({
        title:     post.title,
        question: post.question.description,
        description: post.description,
        image: post.image.url(:thumb),
        id: post.id
        })
      end
    end
  end

  def sort
    @post = Post.relationships.build(:question_id => params[:id])
    render(:partial => "info", :locals => { :post => post }) 
  end

  def show
    @hash = Gmaps4rails.build_markers(@post) do |post, marker|
      marker.lat post.latitude
      marker.lng post.longitude
    end
  end

  def new
    @post = current_user.posts.build
  end

  def edit
  end

  def create
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to posts_path, notice: "Not authorized to edit this post" if @post.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :description, :image, :address, :latitude, :longitude, :question_id)
    end
end
