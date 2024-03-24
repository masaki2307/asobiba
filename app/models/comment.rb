class Comment < ApplicationRecord
  
  belongs_to :user
  belongs_to :post
  validates :body, presence: {message: "以上は入力して下さい" }
  
end
