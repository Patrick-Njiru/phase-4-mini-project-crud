class SpicesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    def index
        spices = Spice.all
        render json: spices, status: :ok
    end

    def create 
        spice = Spice.create(spice_params)
        render json: spice, status: :created
    end

    def update 
        #find the id
        spice = find_spice
        #update
        spice.update(spice_params)
        #render json data 
        render json: spice, status: :accepted
    end

    def destroy
        spice = find_spice
        spice.destroy
        head :no_content
    end

    private 

    def spice_params
        params.permit(:title, :description, :image, :notes, :rating)
    end

    def render_not_found_response
        render json: {error: "Spice not found"}, status: :not_found
    end

    def find_spice
        Spice.find(params[:id])
    end
end
