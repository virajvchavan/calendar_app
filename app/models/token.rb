class Token < ApplicationRecord
  belongs_to :user

  def expired?
    expires_at <= Time.now.to_i
  end
end
