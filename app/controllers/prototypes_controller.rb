class PrototypesController < ApplicationController
  before_action :authenticate_user! ,only: [:new, :edit, :destroy]
  before_action :set_prototype, only: [:edit]
  before_action :move_to_index, except: [:new,:index, :show]

  def index
    @prototype = Prototype.all
  end

  def new
    @prototype = Prototype.new

  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
    redirect_to root_path
  else
    render :new
  end
  end

  def show
    @prototype = Prototype.new
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    @prototype = Prototype.new
    @prototype = Prototype.find(params[:id])
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
    redirect_to prototype_path
    else
      render :edit
    end
  end

  def destroy
    @prototype = Prototype.find(params[:id])
    @prototype.destroy
    redirect_to prototypes_path
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def move_to_index
      @prototype = Prototype.new
    unless current_user == @prototype.user
      redirect_to action: :index
    
    end
  end
    
 
end
