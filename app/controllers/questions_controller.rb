class QuestionsController < ApplicationController
  before_action :set_question, only: %i[update edit destroy]
  def index
  end

  def new
    @parent = Question.find_by(id: params[:parent_id])
    @question = Question.new(parent: @parent, section_id: params[:section_id])
    @question.build_header
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
      @question.build_header unless @question.header.present?
      @parent = @question.parent
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
      @question.build_header unless @question.header.present?
      @parent = @question.parent
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @question.destroy
      respond_to do |format|
        format.html { redirect_to questions_path_path }
        format.turbo_stream
      end
    else
      redirect_to questions_path_path, status: :unprocessable_entity
    end
  end

  def edit
    @parent = @question.parent
    @question.build_header unless @question.header
  end

  private

  def set_question
    @question = Question.find params[:question_id].presence || params[:id]
  end

  def question_params
    params.require(:question).permit(
      :name,
      :title,
      :description,
      :body,
      :footer,
      :answer,
      :question_type,
      :parent_id,
      :section_id,
      :button,
      :file,
      header_attributes: [ :text, :header_type, :file, :id, :_destroy ]
    )
  end
end
