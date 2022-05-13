require 'rails_helper'

RSpec.describe Cat, type: :model do
  it "must contain a name" do
    cat = Cat.create age:4, enjoys:"Chewing on bags", image:"https://upload.wikimedia.org/wikipedia/commons/3/38/Adorable-animal-cat-20787.jpg"
    p cat.errors[:name]
    expect(cat.errors[:name]).to_not be_empty
  end
  it "must contain an age" do
    cat = Cat.create name:"Mr. Stark", enjoys:"Chewing on bags", image:"https://upload.wikimedia.org/wikipedia/commons/3/38/Adorable-animal-cat-20787.jpg"
    p cat.errors[:age]
    expect(cat.errors[:age]).to_not be_empty
  end
  it "must contain an enjoys" do
    cat = Cat.create name:"Mr. Stark", age:4, image:"https://upload.wikimedia.org/wikipedia/commons/3/38/Adorable-animal-cat-20787.jpg"
    p cat.errors[:enjoys]
    expect(cat.errors[:enjoys]).to_not be_empty
  end
  it "must contain an image" do
    cat = Cat.create name:"Mr. Stark", age:4, enjoys:"Chewing on bags"
    p cat.errors[:image]
    expect(cat.errors[:image]).to_not be_empty
  end
  it "enjoys must be at least 10 characters long" do
    cat = Cat.create name:"Mr. Stark", age:4, enjoys:"Chewing on bags", image:"https://upload.wikimedia.org/wikipedia/commons/3/38/Adorable-animal-cat-20787.jpg"
    p cat.errors[:enjoys]
    expect(cat.errors[:enjoys]).to_not be_empty
  end
end







