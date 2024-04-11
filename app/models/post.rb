class Post < ApplicationRecord

   has_one_attached :image

   belongs_to :user
   belongs_to :genre
   has_many :comments, dependent: :destroy
   has_many :favorites, dependent: :destroy
   validates :title, presence: true
   validates :introduction, presence: true
   validates :review, presence: true 
   
  def favorite_count
    favorite.count
  end
   
    def get_image(width, height)

      unless image.attached?

        file_path = Rails.root.join('app/assets/images/title_dot1.jpg')

        image.attach(io: File.open(file_path), filename: 'title_dot1.jpg', content_type: 'image/jpeg')

      end

      image.variant(resize_to_limit: [width, height]).processed

    end
end
