class SectionsController < QuestionsController
  before_action :set_section, only: %i[edit update destroy]
  before_action :set_question

  def new
    @section = Section.new
  end

  def create
    @section = @question.sections.new(section_params)
    if @question.save
      respond_to do |format|
        format.html { redirect_to questions_path }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @section.update(section_params)
      respond_to do |format|
        format.html { redirect_to questions_path }
        format.turbo_stream
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @section.destroy
      respond_to do |format|
        format.html { redirect_to questions_path_path }
        format.turbo_stream
      end
    else
      redirect_to questions_path_path, status: :unprocessable_entity
    end
  end


  private

  def section_params
    params.require(:section).permit(:title)
  end

  def set_section
    @section = Section.find params[:id]
  end
end
