class QuestionsController < ApplicationController
  def index
  end

  def new
    @question = Question.new
  end

  def tree
    @question = Question.first
  end
end
