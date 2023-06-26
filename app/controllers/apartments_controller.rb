class ApartmentsController < ApplicationController
    before_action :set_apartment, only: [:show, :update, :destroy]
  
    def index
      @apartments = Apartment.all
      render json: @apartments
    end
  
    def show
      render json: @apartment
    end
  
    def create
      @apartment = Apartment.new(apartment_params)
  
      if @apartment.save
        render json: @apartment, status: :created
      else
        render json: @apartment.errors, status: :unprocessable_entity
      end
    end
  
    def update
      if @apartment.update(apartment_params)
        render json: @apartment
      else
        render json: @apartment.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @apartment.destroy
      if @apartment.destroyed?
        render json: { message: "Apartment was successfully deleted." }
      else
        render json: { message: "Apartment could not be deleted." }, status: :unprocessable_entity
      end
    end
  
    private
  
    def set_apartment
      @apartment = Apartment.find(params[:id])
    end
  
    def apartment_params
      params.require(:apartment).permit(:number)
    end
  end
  