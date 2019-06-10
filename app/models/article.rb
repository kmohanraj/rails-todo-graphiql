class Article < ApplicationRecord
	validates :title, :desc, presence: true
end
