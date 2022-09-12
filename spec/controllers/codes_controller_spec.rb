require 'rails_helper'

RSpec.describe CodesController, type: :controller do
  let(:code) { create(:code) }

  describe 'GET #index' do
    let(:codes) { create_list(:code, 3) }

    before { get :index }

    it 'populates an array all codes' do
      expect(assigns(:codes)).to match_array(codes)
    end

    it 'renders index view' do 
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    
    before { get :show, params: { id: code } }

    it 'assign the requested code to @code' do
      expect(assigns(:code)).to eq code
    end

    it 'renders show view' do      
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do

    before { get :new }
    
    it 'assign a new Code to @code' do
      expect(assigns(:code)).to be_a_new(Code)
    end

    it 'renders new view' do      
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    before { get :edit, params: { id: code } }

    it 'assign the requested code to @code' do
      expect(assigns(:code)).to eq code
    end

    it 'renders edit view' do      
      expect(response).to render_template :edit
    end
  end

   describe 'POST #create' do
     context 'with valid atributes' do
        it 'saves a new code in the database' do
          expect { post :create, params: { code: attributes_for(:code) } }.to change(Code, :count).by(1)
        end

        it 'redirects to show view' do
          post :create, params: { code: attributes_for(:code) }
          expect(response).to redirect_to assigns(:code)
        end
     end

     context 'with invalid atributes' do
       it 'does not save the code' do
         expect { post :create, params: { code: attributes_for(:code, :invalid) } }.to_not change(Code, :count)
       end 

       it 'redirects to new view' do
        post :create, params: { code: attributes_for(:code, :invalid) }
        expect(response).to render_template :new
      end
     end
   end

   describe 'PATCH #update' do
     context 'with valid attributes' do
       it 'assigns the requested code to @code' do
         patch :update, params: { id: code, code: attributes_for(:code) }
         expect(assigns(:code)).to eq code
       end
       it 'changes code attributes'do
         patch :update, params: { id: code, code: {code: '456'} }
         code.reload

         expect(code.code).to eq '456'
       end
       it 'redirects to updated question' do
         patch :update, params: { id: code, code: attributes_for(:code) }
         expect(response).to redirect_to code
       end
     end

     context 'with invalid attributes' do
       before { patch :update, params: { id: code, code: attributes_for(:code, :invalid) } }
       it 'does not change question' do
        
        code.reload
        expect(code.code).to eq '123'
       end

       it 're-renders edit view' do
        expect(response).to render_template :edit
       end
     end
   end

   describe 'DELETE #destroy' do
     it 'deletes the code ' do
      expect { delete :destroy, params: { id: code } }.to change(Code, :count).by(-1)
     end

     it 'redirect to index' do
      delete :destroy, params: { id: code }
      expect(response).to redirect_to codes_path
     end
   end

end
