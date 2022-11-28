class SpicesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    # GET /spices
    def index 
        render json: Spice.all, except: [:created_at, :updated_at]  
    end

    def create
        spice = Spice.create(spice_params)
        render json: spice, status: 201
    end

    def update
        spice = find_spice
        Spice.update(rating: spice.rating = 1)
        render json: spice
    end

    def destroy
        spice = find_spice
        spice.destroy
        head :no_content
    end

    private

    def find_spice
        Spice.find(params[:id])
    end

    def render_not_found_response
        render json: {error: "content not found"}, status: :not_found
    end

    def spice_params
        params.permit(:title, :image, :description, :notes, :rating)
    end
    
end
