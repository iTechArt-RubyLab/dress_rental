require 'rails_helper'
RSpec.describe CommentsController, type: :controller do
  let(:user) { create(:user) }
  let(:salon) { create(:salon) }

  context 'when user is not logged in' do
    describe 'POST #create' do
      it 'redirects to sign in page' do
        post :create, params: { salon_id: salon.id, comment: attributes_for(:comment) }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'DELETE #destroy' do
      let!(:comment) { create(:comment, user:, salon:) }

      it 'redirects to sign in page' do
        delete :destroy, params: { salon_id: salon.id, id: comment.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  context 'when user is logged in' do
    before { sign_in(user) }

    describe 'POST #create' do
      context 'with valid attributes' do
        it 'creates a new comment' do
          expect do
            post :create, params: { salon_id: salon.id, comment: attributes_for(:comment) }
          end.to change(Comment, :count).by(1)
        end

        it 'assigns a newly created @comment as @comment' do
          post :create, params: { salon_id: salon.id, comment: attributes_for(:comment) }
          expect(assigns(:comment)).to be_a(Comment)
          expect(assigns(:comment)).to be_persisted
        end

        it 'redirects to the salon page' do
          post :create, params: { salon_id: salon.id, comment: attributes_for(:comment) }
          expect(response).to redirect_to(salon_path(salon))
        end
      end

      context 'with invalid attributes' do
        it 'does not create a new comment' do
          expect do
            post :create, params: { salon_id: salon.id, comment: attributes_for(:comment, content: '') }
          end.to_not change(Comment, :count)
        end

        it 'assigns a newly created but unsaved @comment as @comment' do
          post :create, params: { salon_id: salon.id, comment: attributes_for(:comment, content: '') }
          expect(assigns(:comment)).to be_a_new(Comment)
        end

        it 're-renders the salon page with an error message' do
          post :create, params: { salon_id: salon.id, comment: attributes_for(:comment, content: '') }
          expect(response).to redirect_to(salon_path(salon))
          expect(flash[:notice]).to eq 'Could not save the comment!'
        end
      end
    end

    describe 'DELETE #destroy' do
      let!(:comment) { create(:comment, user:, salon:) }

      it 'deletes the specified comment' do
        expect do
          delete :destroy, params: { salon_id: salon.id, id: comment.id }
        end.to change(Comment, :count).by(-1)
      end

      it 'redirects to the salon page with a success message' do
        delete :destroy, params: { salon_id: salon.id, id: comment.id }
        expect(response).to redirect_to(salon_path(salon))
        expect(flash[:notice]).to eq 'Comment was successfully destroyed'
      end
    end

    describe 'GET #edit' do
      let!(:comment) { create(:comment, user:, salon:) }

      it 'renders the edit template' do
        get :edit, params: { salon_id: salon.id, id: comment.id }
        expect(response).to render_template :edit
      end

      it 'assigns the requested comment as @comment' do
        get :edit, params: { salon_id: salon.id, id: comment.id }
        expect(assigns(:comment)).to eq(comment)
      end
    end

    describe 'PUT #update' do
      let!(:comment) { create(:comment, user:, salon:) }

      context 'with valid attributes' do
        it 'updates the specified comment' do
          put :update,
              params: { salon_id: salon.id, id: comment.id, comment: attributes_for(:comment, content: 'New content') }
          expect(comment.reload.content).to eq('New content')
        end

        it 'redirects to the salon page' do
          put :update,
              params: { salon_id: salon.id, id: comment.id, comment: attributes_for(:comment, content: 'New content') }
          expect(response).to redirect_to(salon_path(salon))
        end
      end

      context 'with invalid attributes' do
        it 'does not update the specified comment' do
          put :update, params: { salon_id: salon.id, id: comment.id, comment: attributes_for(:comment, content: '') }
          expect(comment.reload.content).to_not eq('')
        end

        it 'redirects to the salon page with an error message' do
          put :update, params: { salon_id: salon.id, id: comment.id, comment: attributes_for(:comment, content: '') }
          expect(response).to redirect_to(salon_path(salon))
          expect(flash[:notice]).to eq 'Could not update the comment!'
        end
      end
    end
  end
end
