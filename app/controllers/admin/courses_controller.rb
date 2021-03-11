class Admin::CoursesController < Admin::BaseController
  before_action :set_course, only: [:show, :update, :destroy]

  # GET /courses
  def index
      @courses = Course.all
    render json: @courses
  end

  # GET /courses/1
  def show
    render json: @course
  end

  # POST /courses
  def create
    @course = Course.new(course_params)
    params[:category_ids].each do |id|
      @course.categories << Category.find(id)
    end
    if @course.save
      render json: @course, status: :created, location: @course
    else
      render json: @course.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /courses/1
  def update
    params[:category_ids].each do |id|
      @course.categories << Category.find(id)
    end
    if @course.update(course_params)
      render json: @course
    else
      render json: @course.errors, status: :unprocessable_entity
    end
  end

  # DELETE /courses/1
  def destroy
    @course.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def course_params
      params.require(:course).permit(:title, :content, :teacher_id, :category_ids)
    end

end
