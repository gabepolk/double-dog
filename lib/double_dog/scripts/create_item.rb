module DoubleDog
  class CreateItem < TransactionScript

    def run(params)
      return failure(:not_admin) unless admin_session?(params[:session_id])
      return failure(:invalid_name) unless valid_attribute?(params[:name], 1)
      return failure(:invalid_price) unless valid_price?(params[:price])

      item = DoubleDog.db.create_item(:name => params[:name], :price => params[:price])
      return success(:item => item)
    end

    def valid_price?(price)
      price != nil && price >= 0.50
    end

  end
end
