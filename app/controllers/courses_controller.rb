class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :update, :destroy]
  before_action :authenticate_admin, only: [:create, :update, :destroy]

  # GET /courses
  def index
    if params[:teacher_id]
      @courses = Course.teacher(params[:teacher_id])
    elsif params[:categories]
      @category_ids = params[:categories].split(',')
      @courseslist = []
      @category_ids.each do |id|
        Course.all.each do |course| 
          if course.categories.include?(Category.find(id))
            @courseslist << course
          end
        end
      end
      @courses = @courseslist.uniq
    else @courses = Course.all
    end
    render json: @courses
  end

  # GET /courses/1
  def show
    render json: @course
  end

  # POST /courses
  def create
    @course = Course.new(course_params)

    if @course.save
      render json: @course, status: :created, location: @course
    else
      render json: @course.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /courses/1
  def update
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
      params.require(:course).permit(:title, :content, :categories)
    end

end
