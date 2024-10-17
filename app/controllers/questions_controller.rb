class QuestionsController < ApplicationController
  before_action :set_question, only: %i[update edit]
  def index
  end

  def new
    @question = Question.new
  end

  def tree
    @question = Question.first
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      respond_to do |format|
        format.html { redirect_to questions_path }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @question.update(question_params)
      respond_to do |format|
        format.html { redirect_to questions_path }
        format.turbo_stream
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def edit
  end

  private

  def set_question
    @question = Question.find params[:id]
  end

  def question_params
    params.require(:question).permit(:name, :title, :description, :body, :footer, :answer, :question_type, :parent_id)
  end
end
