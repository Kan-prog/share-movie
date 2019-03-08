class RankingsController < ApplicationController
  def like
    @ranking_counts = Like.ranking
    @reviews = Review.find(@ranking_counts.keys)
  end
end
