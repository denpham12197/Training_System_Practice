class Course < ApplicationRecord
  has_many :user_course
  has_many :subject
end
