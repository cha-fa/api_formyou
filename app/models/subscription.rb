class Subscription < ApplicationRecord
  belongs_to :student, class_name: "User"
  belongs_to :promotion
end
