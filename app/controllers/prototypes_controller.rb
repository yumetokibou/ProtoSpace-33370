class PrototypesController < ApplicationController
  before_action :authenticate_user! ,only: [:new, :edit, :destroy]
  before_action :set_prototype, only: [:edit,:destroy]
  before_action :move_to_index, except: [:new,:index, :show, :create, :edit, :destroy, :update]

  def index
    @prototype = Prototype.includes(:user)
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

    if @prototype.destroy
      redirect_to root_path
    end
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
