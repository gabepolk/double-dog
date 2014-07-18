module DoubleDog
  class Script

    def admin_session?(session_id)
      user = DoubleDog.db.get_user_by_session_id(session_id)
      user && user.admin?
    end

    def valid_attribute?(attribute, num)
      # attribute != nil && (attribute.class == Float ? attribute  >= num : attribute.length >= num)
      attribute != nil && attribute.length >= num
    end

    private

      def failure(error_name)
        return :success? => false, :error => error_name
      end

      def success(data)
        return data.merge(:success? => true)
      end

  end
end
