require 'rails_helper'

describe ProductsController do
  describe 'GET #index' do
    # インスタンス変数は期待した値になるか
    it "populates an array of products ordered by created_at DESC" do
      products = create_list(:product, 10)
      get :index
      expect(assigns(:products)).to match(products.sort{ |a, b| b.created_at <=> a.created_at })
    end

    # it "renders the :index template" do
    #   get :index
    #   expect(response).to render_template :index
    # end
    
    # 正常なレスポンスか？
    it "responds successfully" do
      get :index
      expect(response).to be_success
    end
    # 200レスポンスが返ってきているか？
    it "returns a 200 response" do
      get :index
      expect(response).to have_http_status "200"
    end
  end

end