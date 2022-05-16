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
    expect(response).to have_http_status(200)
    expect(cat.name).to eq('Cat Woman')
    expect(cat.age).to eq(28)
    expect(cat.enjoys).to eq('Prowling in the night')
    expect(cat.image).to eq('https://img.washingtonpost.com/rf/image_1484w/WashingtonPost/Content/Blogs/celebritology/Images/Film_Review_Dark_Knight_Rises-085d2-4549.jpg?uuid=ryK-otD1EeGt8tVushDNzQ')
  end
end

describe "PATCH /update" do
  it 'can update an existing cat' do
    cat_params = {
      cat: {
        name: 'Cat Woman',
        age: 28,
        enjoys: 'Prowling in the night',
        image: 'https://img.washingtonpost.com/rf/image_1484w/WashingtonPost/Content/Blogs/celebritology/Images/Film_Review_Dark_Knight_Rises-085d2-4549.jpg?uuid=ryK-otD1EeGt8tVushDNzQ'
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
  describe 'Cat create request validations' do
    it "doesn't create a cat without a name" do
      cat_params = {
        cat: {
          age: 28,
          enjoys: 'Prowling in the night',
          image: 'https://img.washingtonpost.com/rf/image_1484w/WashingtonPost/Content/Blogs/celebritology/Images/Film_Review_Dark_Knight_Rises-085d2-4549.jpg?uuid=ryK-otD1EeGt8tVushDNzQ'
        }
      }
      post '/cats', params: cat_params
      expect(response).to have_http_status(422)

      json = JSON.parse(response.body)
      expect(json['name']).to include "can't be blank"
    end
    it "doesn't create a cat without an age" do
      cat_params = {
        cat: {
          name: 'Cat Woman',
          enjoys: 'Prowling in the night',
          image: 'https://img.washingtonpost.com/rf/image_1484w/WashingtonPost/Content/Blogs/celebritology/Images/Film_Review_Dark_Knight_Rises-085d2-4549.jpg?uuid=ryK-otD1EeGt8tVushDNzQ'
        }
      }
      post '/cats', params: cat_params
      expect(response).to have_http_status(422)

      json = JSON.parse(response.body)
      expect(json['age']).to include "can't be blank"
    end
    it "doesn't create a cat without an enjoys" do
      cat_params = {
        cat: {
          name: 'Cat Woman',
          age: 28,
          image: 'https://img.washingtonpost.com/rf/image_1484w/WashingtonPost/Content/Blogs/celebritology/Images/Film_Review_Dark_Knight_Rises-085d2-4549.jpg?uuid=ryK-otD1EeGt8tVushDNzQ'
        }
      }
      post '/cats', params: cat_params
      expect(response).to have_http_status(422)

      json = JSON.parse(response.body)
      expect(json['enjoys']).to include "can't be blank"
    end
    it "does not update a cat with enjoys being less than 10 characters" do
      Cat.create(
        name: 'Cat Woman',
        age: 28,
        enjoys: 'Prowling in the night',
        image: 'https://img.washingtonpost.com/rf/image_1484w/WashingtonPost/Content/Blogs/celebritology/Images/Film_Review_Dark_Knight_Rises-085d2-4549.jpg?uuid=ryK-otD1EeGt8tVushDNzQ'
      )
  catwoman=Cat.first
      cat_params = {
        cat: {
          name:"Cat Woman",
          age: 28,
          enjoys: "Prowling",
          image: 'https://img.washingtonpost.com/rf/image_1484w/WashingtonPost/Content/Blogs/celebritology/Images/Film_Review_Dark_Knight_Rises-085d2-4549.jpg?uuid=ryK-otD1EeGt8tVushDNzQ'
        }
      }
      patch "/cats/#{catwoman.id}", params: cat_params
      cat = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(cat['enjoys']).to include "is too short (minimum is 10 characters)"
    end
    it "doesn't create a cat without an image" do
      cat_params = {
        cat: {
          name: 'Cat Woman',
          age: 28,
          enjoys: 'Prowling in the night'
        }
      }
      post '/cats', params: cat_params
      expect(response).to have_http_status(422)

      json = JSON.parse(response.body)
      expect(json['image']).to include "can't be blank"
    end
  end
end
