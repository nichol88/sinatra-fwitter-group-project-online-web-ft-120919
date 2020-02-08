class AddTimestampsToTweets < ActiveRecord::Migration[6.0]
  def change
    add_timestamps :tweets, null: :false
  end
end
