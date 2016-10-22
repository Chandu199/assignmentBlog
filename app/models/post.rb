class Post < ActiveRecord::Base
    belongs_to :user
    has_many :likes
    has_many :comments , dependent: :destroy
    validates :title ,presence: true,length: {minimum: 4, maximum:20}
    validates :user_id, presence: true
    validates :description, presence: true,length:{minimum:10, maximum:200}
    def self.search(search)
      where("title LIKE ?", "%#{search}%") 
      where("description LIKE ?", "%#{search}%")
    end
   
    def thumbs_up_total
        self.likes.where(like: true).size
    end
    
    def thumbs_down_total
        self.likes.where(like: false).size
    end
end
