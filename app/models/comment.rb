class Comment < ActiveRecord::Base
    belongs_to :post
    validates :comment, length:{maximum:200}
end
