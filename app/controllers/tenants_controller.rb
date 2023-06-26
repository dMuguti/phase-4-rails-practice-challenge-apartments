class TenantsController < ApplicationController
    before_action :set_tenant, only: [:show, :update, :destroy]
  
    def index
      @tenants = Tenant.all
      render json: @tenants
    end
  
    def show
      render json: @tenant
    end
  
    def create
      @tenant = Tenant.new(tenant_params)
  
      if @tenant.save
        render json: @tenant, status: :created
      else
        render json: @tenant.errors, status: :unprocessable_entity
      end
    end
  
    def update
      if @tenant.update(tenant_params)
        render json: @tenant
      else
        render json: @tenant.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @tenant.destroy
      if @tenant.destroyed?
        render json: { message: "Tenant was successfully deleted." }
      else
        render json: { message: "Tenant could not be deleted." }, status: :unprocessable_entity
      end
    end
  
    private
  
    def set_tenant
      @tenant = Tenant.find(params[:id])
    end
  
    def tenant_params
      params.require(:tenant).permit(:name, :age)
    end
  end
  