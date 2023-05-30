module Admin
  class CategoriesController < AdminController
    before_action :set_category, only: %i[edit update destroy]

    def new
      @category = Category.new
    end

    def create
      @category = Category.new(category_params)

      if @category.save
        redirect_to category_path(@category), notice: 'Category was successfully created.'
      else
        render :new, status: :unprocessable_entity 
      end
    end

    def edit; end

    def update
      if @category.update(category_params)
        redirect_to @category, notice: 'Category successfully updated.'
      else
        render :edit
        flash.now[:error] = 'Could not save the changes.'
      end
    end

    def destroy
      @category.destroy

      redirect_to categories_path, notice: 'Category was successfully destroyed.'
    end

    private

    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name, :description)
    end
  end
end
