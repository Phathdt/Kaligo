class HotelService
  attr_reader :params, :destination, :suppliers, :data

  NUMBER_THREAD_ACTIVE = 5
  CACHING_TIME = 300

  def initialize(params)
    @params = params
    @destination = params[:destination]
    @suppliers = params[:suppliers]&.split(/,/)

    @data = []
  end

  def perform
    res = $redis.hget('hotels', cache_key)

    res = JSON.parse(res) if res

    # check redis data is blank or expired
    if res.nil? || (res['created_at'] + CACHING_TIME < Time.current.to_i)
      hotels = fetch_data

      hash = { data: hotels, created_at: Time.current.to_i }
      $redis.hset('hotels', cache_key, hash.to_json)

      hotels
    else
      res['data']
    end
  end

  private

  def fetch_data
    set_hotel_names

    query_data

    process_data
  end

  def cache_key
    t = params

    "#{t[:checkin] || 0}:#{t[:checkout] || 0}:#{t[:destination] || 0}:#{t[:guest] || 0}:#{t[:suppliers] || 0}"
  end

  def query_data
    supplier_data.each_slice(NUMBER_THREAD_ACTIVE).each do |t|
      threads =
        t.map do |supplier, url|
          query_supplier(supplier, url)
        end

      threads.each(&:join)
    end
  end

  def process_data
    data.sort_by { |h| h[:id] }
      .group_by { |h| h[:id] }
      .map { |_, v| v.min_by { |h| h[:price] } }
  end

  def query_supplier(supplier, url)
    Thread.new do
      res = JSON.parse RestClient.get(url)

      res.each do |hotel_name, price|
        next if hotel_names.exclude? hotel_name

        @data << {
          id: hotel_name,
          price: price,
          supplier: supplier,
        }
      end
    rescue StandardError => e
      Rails.logger.info(e)
    end
  end

  def offers
    @offers ||=
      begin
        offers = Offer.joins(:hotel).where(hotels: { location: destination })
        offers = offers.joins(:supplier).where(suppliers: { name: suppliers }) if suppliers

        offers
      end
  end

  def set_hotel_names
    hotel_names
  end

  def hotel_names
    @hotel_names ||=
      Hotel.joins(:offers)
        .where(offers: { id: offers })
        .distinct
        .pluck(:name)
  end

  def supplier_data
    Supplier.joins(:offers)
      .where(offers: { id: offers })
      .pluck(:name, :url)
      .to_h
  end
end
