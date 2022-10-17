class AddressesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :load_address, only: %i[show edit update destroy]

  def index
    @addresses = Address.all
  end

  def show
  end

  def new
    @address = Address.new
  end

  def edit
  end

  def create
    @addresses = Address.all

    if @addresses.count == 0
      @address = Address.create(address_params)
      help_create(@address)
    else
      redirect_to addresses_path, notice: 'The address already exists'
    end
  end

  def update
    if @address.update(address_params)
      redirect_to addresses_path
    else
      render :edit
    end
  end

  def destroy
    @address.destroy
    redirect_to addresses_path
  end

  private

  def help_create(address)
    if address.save
      redirect_to addresses_path, notice: 'Your address successfully created.'
    else
      render :new
    end
  end

  def load_address
    @address = Address.find(params[:id])
  end

  def address_params
    params.require(:address).permit(:address)
  end
end
