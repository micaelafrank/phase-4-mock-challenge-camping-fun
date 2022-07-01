class ActivitiesController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :no_record_found
rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

    def index
        activities = Activity.all
        render json: activities
    end

    def destroy
        activity = find_activity
        activity.destroy
        head :no_content
    end

    private

    def find_activity
        Activity.find(params[:id])
    end

    def no_record_found
        render json: {error: "Activity not found"}, status: :not_found
    end

    def record_invalid(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

end
