class Pin < ActiveRecord::Base
    belongs_to :user    #   --> (MM) You had belongs_to :user_id here instead, causing a name error in the pins_controller.rb file
end
