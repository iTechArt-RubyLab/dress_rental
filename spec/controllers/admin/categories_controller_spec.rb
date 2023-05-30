require 'rails_helper'
RSpec.describe Admin::CategoriesController, type: :controller do
  let(:admin) { create(:user, :admin) }
  before { sign_in admin }

  describe 'GET #new' do
    it 'assigns a new category instance variable' do
      get :new

      expect(assigns(:category)).to be_a_new(Category)
    end

    it 'renders the new template' do
      get :new

      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context 'when valid parameters are passed' do
      let(:category_params) { { category: attributes_for(:category) } }

      it 'creates a new category instance' do
        expect { post :create, params: category_params }.to change(Category, :count).by(1)
      end

      it 'redirects to the category page with a success message' do
        post :create, params: category_params

        expect(response).to redirect_to category_path(Category.last)
        expect(flash[:notice]).to eq 'Category was successfully created.'
      end
    end

    context 'when invalid parameters are passed' do
      let(:category_params) { { category: attributes_for(:category, name: '') } }

      it 'does not create a new category instance' do
        expect { post :create, params: category_params }.to_not change(Category, :count)
      end

      it 'renders the new template with an error message' do
        post :create, params: category_params

        expect(response).to render_template :new
        expect(flash.now[:error]).to eq 'Could not save the changes.'
      end
    end
  end

  describe 'GET #edit' do
    let(:category) { create(:category) }

    it 'assigns the requested category instance variable' do
      get :edit, params: { id: category.id }

      expect(assigns(:category)).to eq category
    end

    it 'renders the edit template' do
      get :edit, params: { id: category.id }

      expect(response).to render_template :edit
    end
  end

  describe 'PUT #update' do
    let(:category) { create(:category) }

    context 'when valid parameters are passed' do
      let(:category_params) { { id: category.id, category: attributes_for(:category, name: 'New name') } }

      it 'updates the category instance' do
        put :update, params: category_params

        category.reload

        expect(category.name).to eq('New name')
      end

      it 'redirects to the category page with a success message' do
        put :update, params: category_params

        expect(response).to redirect_to category_path(category)
        expect(flash[:notice]).to eq 'Category successfully updated.'
      end
    end

    context 'when invalid parameters are passed' do
      let(:category_params) { { id: category.id, category: attributes_for(:category, name: '') } }

      it 'does not update the category instance' do
        put :update, params: category_params

        category.reload

        expect(category.name).to_not eq('')
      end

      it 'renders the edit template with an error message' do
        put :update, params: category_params

        expect(response).to render_template :edit
        expect(flash.now[:error]).to eq 'Could not save the changes.'
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:category) { create(:category) }

    it 'destroys the requested category instance' do
      expect { delete :destroy, params: { id: category.id } }.to change(Category, :count).by(-1)
    end

    it 'redirects to the categories page with a success message' do
      delete :destroy, params: { id: category.id }

      expect(response).to redirect_to categories_path
      expect(flash[:notice]).to eq 'Category was successfully destroyed.'
    end
  end
end
