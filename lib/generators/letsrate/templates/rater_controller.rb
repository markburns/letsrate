class RaterController < ApplicationController
  def create
    if current_user.present?
      obj = eval "#{allowed_params[:klass]}.find(#{allowed_params[:id]})"
      if allowed_params[:dimension].present?
        obj.rate allowed_params[:score].to_i, current_user.id, "#{allowed_params[:dimension]}"
      else
        obj.rate allowed_params[:score].to_i, current_user.id
      end

      render :json => true
    else
      render :json => false
    end
  end

  private

  def allowed_params
    params.permit :rate, :dimension, :klass, :id, :score
  end
end
