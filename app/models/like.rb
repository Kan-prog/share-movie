class Like < Favorite
  def self.ranking
    self.group(:review_id).order('count_review_id DESC').limit(10).count(:review_id)
  end
end
