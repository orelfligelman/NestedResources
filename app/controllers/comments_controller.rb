class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
		post = Post.find(params[:post_id])
    @comments = post.comments

		respond_to do |format|
			format.html
			format.xml {render :xml => @comments}
		end
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
		post = Post.find(params[:post_id])
		@comment = post.comments.find(params[:id])
		respond_to do |format|
			format.html
			format.xml {render :xml => @comment}
		end
  end

  # GET /comments/new
  def new
   post = Post.find(params[:post_id])
		@comment = post.comments.build

		respond_to do |format|
			format.html
			format.xml {render :xml => @comment}
		end
  end

  # GET /comments/1/edit
  def edit
		post = Post.find(params[:post_id])
		@comment = post.comments.find(params{:id})
  end

  # POST /comments
  # POST /comments.json
  def create
		post = Post.find(params[:post_id])
		@comment = post.comments.create(params[:comment].permit(:commenter,:body)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to [@comment.post, @comment] notice: 'Comment was successfully created.' }
        format.xml {render :xml => @comment, :status => :created, :location => [@comment.post, @comemnt]}
				format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :action => "new" } #do we need to specify :action => or just the action we want to take?
        # format.json { render json: @comment.errors, status: :unprocessable_entity }
				format.xml {render :xml => @comment.errors, :status => :unprocessable_entity}
			end
			#what happened to json?
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
		post = Post.find(params[:post_id] #there is a comments_id as well,right?)
		@comment = post.comments.create(params[:comment].permit(:commenter, :body))
    respond_to do |format|
      # if @comment.update(comment_params)
			if @comment.update_attributes(params[:comment].permit(:commenter, :body))
        # format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
				format.html { redirect_to([@comment.post, @comment], :notice => 'Comment was successfully updated.') }
        # format.json { render :show, status: :ok, location: @comment }
				format.xml  { head :ok }
			else
        # format.html { render :edit }
				format.html { render :action => "edit" }
        # format.json { render json: @comment.errors, status: :unprocessable_entity }
				format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
		post = Post.find(params[:post_id]
		@comment = post.comments.find(params[:id])
		puts @comment
		@comment.destroy
    respond_to do |format|
      # format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
			format.html {redirect_to(post_comments_url)}
      # format.json { head :no_content }
			format.xml  { head :ok }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:commenter, :body, :post_id)
    end
end
