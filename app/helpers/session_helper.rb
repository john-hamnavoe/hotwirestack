module SessionHelper
  def search_session_hidden_field(search_session_token)
    if search_session_token
      hidden_field_tag :search_session, search_session_token
    end
  end
end
