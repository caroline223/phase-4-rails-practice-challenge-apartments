class TenantsController < ApplicationController

rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response


    def index 
        tenants = Tenant.all 
        render json: tenants, status: :ok
    end

    def show
        tenant = find_tenant
        if tenant 
            render json: tenant, status: :ok
        else
            render_not_found_response
        end
    end

    def update
        tenant = find_tenant
        tenant.update!(tenant_params)
        render json: tenant, status: :accepted
    end

    def create 
        tenant = Tenant.create!(tenant_params)  
        if tenant.valid?
            render json: tenant, status: :created
        else
            render_unprocessable_entity_response
        end 
    end

    def destroy
        tenant = find_tenant
        if tenant 
            tenant.destroy
            head :no_content
        else
            render_not_found_response
        end
    end

    private

    def find_tenant
        Tenant.find_by_id(params[:id])
    end

    def tenant_params
        params.permit(:name, :age)
    end


    def render_not_found_response
        render json: {error: "Tenant Not Found"}, status: :not_found
    end


end
