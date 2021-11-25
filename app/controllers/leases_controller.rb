class LeasesController < ApplicationController

    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response


    def index 
        leases = Lease.all 
        render json: leases, status: :ok
    end

    def create
        lease = Lease.create!(lease_params)
        if lease.valid?
            render json: lease, status: :ok
        else
            render_unprocessable_entity_response
        end
    end

    def destroy
        lease = find_lease
        if lease
            lease.destroy
            head :no_content
        else
            render_not_found_response
        end
    end

    private 
    
    def lease_params
        params.permit(:apartment_id, :tenant_id, :rent)
    end

    def render_not_found_response
        render json: {error: "Lease not found"}, status: :not_found
    end


end
