# spec/controllers/topics_controller_spec.rb

require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe 'kannan' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    it 'renders the show template' do
      product = Product.create(
        name: 'visanth',
        prize: 10.0,
        # title: 'Sample Topic',
        # description: 'Sample description',
        # author: 'John Doe',
        # content: 'Sample content'
      )

      get :show, params: { id: product.id }
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #edit' do
    it 'renders the edit template' do
      product = Product.create(
        name: 'visanth',
        prize: 100.0,
      )

      get :edit, params: { id: product.id }
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST #create' do
    it 'redirects to the show page after successful creation' do
      post :create, params: {
        product: {
          name: 'visanth',
          prize: 100.0,
          # title: 'Sample Topic',
          # description: 'Sample description',
          # author: 'John Doe',
          # content: 'Sample content'
        }
      }
      expect(response).to redirect_to(assigns(:product))
    end
  end
  #======================================http status code====================
  describe 'GET #index' do
    it 'returns a successful HTTP status code (200)' do
      get :index
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #show' do
    it 'returns a successful HTTP status code (200)' do
      product = Product.create(
        name: 'visanth',
        prize: 100.0,
        # title: 'Sample Topic',
        # description: 'Sample description',
        # author: 'John Doe',
        # content: 'Sample content'
      )

      get :show, params: { id: product.id }
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #new' do
    it 'returns a successful HTTP status code (200)' do
      get :new
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #edit' do
    it 'returns a successful HTTP status code (200)' do
      product= Product.create(
        name: 'visanth',
        prize: 100.0,

      )

      get :edit, params: { id: product.id }
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_params) do
        {
          product: {
            name:'visanth',
            prize:100.0,
          }
        }
      end

      it 'redirects to the show page after successful creation' do
        post :create, params: valid_params
        expect(response).to have_http_status(302) # 302 for redirect
      end

      it 'creates a new topic in the database' do
        expect { post :create, params: valid_params }.to change(Product, :count).by(1)
      end
    end

    context 'with invalid parameters' do
      # Add tests for invalid parameters if needed.
    end
  end
  # ... additional tests for other controller actions (update, destroy) ...

  # =============================flash notice=======================
  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_params) do
        {
          product: {
            name:'visanth',
            prize: 25.5,
          }
        }
      end

      it 'creates a new topic in the database' do
        expect { post :create, params: valid_params }.to change(Product, :count).by(1)
      end

      it 'redirects to the show page after successful creation' do
        post :create, params: valid_params
        expect(response).to redirect_to(assigns(:product))
        expect(flash[:notice]).to eq('Product was successfully created.') # ==
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) do
        {
          product: {
            name: '',
            prize: 25.25,
            # title: '', # Empty title to trigger validation error
            # description: 'Sample description',
            # author: 'John Doe',
            # content: 'Sample content'
          }
        }
      end

      it 'does not create a new topic in the database' do
        expect { post :create, params: invalid_params }.not_to change(Product, :count)
      end

      it 're-renders the new template with a flash alert' do
        post :create, params: invalid_params
        expect(response).to render_template(:new)
        expect(flash[:alert]).to eq('Product could not be created. Please fix the errors.')
      end
    end
  end



end