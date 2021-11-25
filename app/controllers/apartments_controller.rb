class ApartmentsController < ApplicationController

    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response 
   
    def index
        apartments = Apartment.all 
        render json: apartments, status: :ok
    end

    def show 
        apartment = find_apartment
        if apartment 
            render json: apartment, status: :created
        else
            render_not_found_response
        end
    end

    def create 
        apartment = Apartment.create!(apartment_params)
        if apartment.valid? 
            rende json: apartment, status: :ok
        else
            render_unprocessable_entity_response
        end
    end

    def update
        apartment = find_apartment
        apartment.update!(apartment_params)
        render json: apartment, status: :accepted 

    end

    def destroy
        apartment = find_apartment
        if apartment 
            apartment.destroy 
            head :no_content
        else
            render_not_found_response
        end
    end


private

    def find_apartment
        Apartment.find_by_id(params[:id])
    end

    def apartment_params
       params.permit(:number)
    end

    def render_not_found_response
        render json: {error: "Apartment Not Found"}, status: :not_found
    end

   
end
