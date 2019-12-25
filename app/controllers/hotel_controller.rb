class HotelController < ApplicationController
  def search
    res = HotelService.new(hotel_params).perform

    render json: MultiJson.dump(res)
  end

  private

  def hotel_params
    params.permit(:checkin, :checkout, :destination, :guests, :suppliers)
  end
end
