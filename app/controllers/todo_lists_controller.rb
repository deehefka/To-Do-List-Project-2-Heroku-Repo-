class TodoListsController < OpenReadController
  before_action :set_todo_list, only: %i[show update destroy]

  # GET /todo_lists
  def index
    @todo_lists = current_user.todo_lists

    render json: @todo_lists
  end

  # GET /todo_lists/1
  def show
    render json: @todo_list
  end

  # POST /todo_lists
  def create
    # binding.pry
    @todo_list = current_user.todo_lists.new(todo_list_params)

    if @todo_list.save
      render json: @todo_list, status: :created, location: @todo_list
    else
      render json: @todo_list.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /todo_lists/1
  def update
    if @todo_list.update(todo_list_params)
      render json: @todo_list
    else
      render json: @todo_list.errors, status: :unprocessable_entity
    end
  end

  # DELETE /todo_lists/1
  def destroy
    @todo_list.destroy
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_todo_list
    @todo_list = current_user.todo_lists.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def todo_list_params
    params.require(:todo_list).permit(:title, :description, :user_i)
  end

  private :set_todo_list, :todo_list_params
end
