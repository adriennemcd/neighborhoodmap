class Post < ActiveRecord::Base
	belongs_to :user
	belongs_to :question
	accepts_nested_attributes_for :question
	has_attached_file :image, :styles => { :large => "600x600>", :medium => "300x300>", :thumb => "100x100>" }
	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]
	scope :by_question, -> {where(question_id: '3') }
	def self.search(search)
		if search
			where('question_id LIKE ?', "%#{search}%")
		else
			all
		end
	end
end
