class ChatController < WebsocketRails::BaseController
  def initialize_session
    # perform application setup here
    controller_store[:message_count] = 0
  end
  
  def awesomeness_approval
    if message[:awesomeness] > 5
      trigger_success {:message => 'awesome level is sufficient'}
    else
      trigger_failure {:message => 'awesome level is insufficient'}
    end
  end
end