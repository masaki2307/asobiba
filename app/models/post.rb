class Post < ApplicationRecord

   has_one_attached :image

   belongs_to :user, dependent: :destroy
   belongs_to :genre, dependent: :destroy

   validates :title, presence: true
   validates :introduction, presence: true

    def get_image(width, height)

      unless image.attached?

        file_path = Rails.root.join('app/assets/images/default-image.jpg')

        image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')

      end

      image.variant(resize_to_limit: [width, height]).processed

    end
end
