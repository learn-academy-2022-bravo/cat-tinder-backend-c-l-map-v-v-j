require 'rails_helper'

RSpec.describe "Cats", type: :request do
  describe "GET /index" do
    it "returns a list of all cats" do 
      Cat.create(
        name: "Cat Woman",
        age: 28,
        enjoys: "Prowling in the night",
        image:"https://img.washingtonpost.com/rf/image_1484w/WashingtonPost/Content/Blogs/celebritology/Images/Film_Review_Dark_Knight_Rises-085d2-4549.jpg?uuid=ryK-otD1EeGt8tVushDNzQ"
      )
      get '/cats'
      cat=JSON.parse(response.body)
      p cat
      expect(response).to have_http_status(200)
      expect(cat.length).to eq(1)
  end
end

  describe 'POST /create' do
  it 'creates a new cat' do
    cat_params = {
      cat: {
        name: "Cat Woman",
        age: 28,
        enjoys: "Prowling in the night",
        image:"https://img.washingtonpost.com/rf/image_1484w/WashingtonPost/Content/Blogs/celebritology/Images/Film_Review_Dark_Knight_Rises-085d2-4549.jpg?uuid=ryK-otD1EeGt8tVushDNzQ"
      }
    }
    post '/cats', params: cat_params
    cat = Cat.first

    update_cat_params = {
      cat: {
        name: "Cat Woman",
        age: 30,
        enjoys: "Prowling in the night",
        image:"https://img.washingtonpost.com/rf/image_1484w/WashingtonPost/Content/Blogs/celebritology/Images/Film_Review_Dark_Knight_Rises-085d2-4549.jpg?uuid=ryK-otD1EeGt8tVushDNzQ"
      }
    }
      patch "/cats/#{cat.id}", params: update_cat_params
      updated_cat = Cat.find(cat.id)
      expect(response).to have_http_status(200)
      expect(updated_cat.age).to eq(30)
    end
  end
end
