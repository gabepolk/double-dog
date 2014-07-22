module DoubleDog
  class CreateOrder < TransactionScript

    def run(params)
      user = DoubleDog.db.get_user_by_session_id(params[:session_id])
      return failure(:invalid_session) if user.nil?
      return failure(:no_items_ordered) unless valid_attribute?(params[:items], 1)

      order = DoubleDog.db.create_order(employee_id: user.id, items: params[:items])
      return success(order: order)
    end

  end
end
