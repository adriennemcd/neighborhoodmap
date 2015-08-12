class Post < ActiveRecord::Base
	belongs_to :user
	belongs_to :question
	accepts_nested_attributes_for :question
	has_attached_file :image, :styles => { :large => "600x600>", :medium => "300x300>", :thumb => "100x100>" }
	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]
	scope :by_question1, -> { where(question_id: '1') }
	scope :by_question2, -> { where(question_id: '2') }
	scope :by_question3, -> { where(question_id: '3') }
	scope :by_question4, -> { where(question_id: '4') }
	scope :by_question5, -> { where(question_id: '5') }
	scope :by_question6, -> { where(question_id: '6') }
	scope :by_question7, -> { where(question_id: '7') }
end
