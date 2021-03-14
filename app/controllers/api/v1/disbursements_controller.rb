module Api::V1
  class DisbursementsController < ApplicationController
    api :GET, '/disbursements', 'Get the disbursements for a given merchant on a given week'
    param :week, :number, required: true
    param :year, :number, required: true
    param :merchant_id, :number
    def index
      data = DisbursementService.get(week: params[:week], year: params[:year], merchant_id: params[:merchant_id])
      render json: { data: data }, status: :ok
    end
  end
end
