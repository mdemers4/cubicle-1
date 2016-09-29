class SpacesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :ensure_logged_in, only: [:destroy, :edit, :update]

  def index
    @spaces = Space.all

    respond_to do |format|
      format.html
      format.json { render json: @spaces}
    end
  end

  def new
    @space = Space.new
  end

  def create
    @user = current_user
    @space = @user.owned_spaces.new(space_params)

    if @space.save!
      flash[:sucess] = 'New Space succesfully added'
      redirect_to spaces_path
    else
      flash[:notice] = "this didnt save "
      render :new
    end
  end

  def show
    @space = Space.find(params[:id])
  end

  def edit
    @space = Space.find(params[:id])
  end

  def update
    @user = current_user
    @space = Space.find(params[:id])
    if @space.update_attributes!(space_params)
      flash[:sucess] = 'project succesfully updated'
      redirect_to space_path(@space)
    else
      flash[:notice] = 'this didnt update'
      redirect_to root_path
    end
  end

  def destroy
    #important, if you destroy the space, you have to destroy the associated leases
    @space = Space.find(params[:id])
    Lease.where(space_id: @space.id).destroy_all
    @space.destroy
  end


  private

  def space_params
    params.require(:space).permit(:name,
                                  :description,
                                  :available_desks,
                                  :price,
                                  :user_id,
                                  :number,
                                  :street_name,
                                  :city,
                                  :province,
                                  :postal_code,
                                  images_attributes: [:id, :location_picture, :_destroy])
  end

  def ensure_logged_in
    @space = Space.find(params[:id])
    if current_user != User.find(@space.user_id)
      redirect_to spaces_path, notice: "you do not have access"
    end
  end


end
