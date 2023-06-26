class LeasesController < ApplicationController
    before_action :set_lease, only: [:show, :destroy]
  
    def index
      @leases = Lease.all
      render json: @leases
    end
  
    def show
      render json: @lease
    end
  
    def create
      @lease = Lease.new(lease_params)
  
      if @lease.save
        render json: @lease, status: :created
      else
        render json: @lease.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @lease.destroy
      if @lease.destroyed?
        render json: { message: "Lease was successfully deleted." }
      else
        render json: { message: "Lease could not be deleted." }, status: :unprocessable_entity
      end
    end
  
    private
  
    def set_lease
      @lease = Lease.find(params[:id])
    end
  
    def lease_params
      params.require(:lease).permit(:rent, :apartment_id, :tenant_id)
    end
  end
  