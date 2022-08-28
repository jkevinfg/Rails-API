require "rails_helper"

RSpec.describe "Posts", type: :request do 
    
    #context: db is empty
    describe "GET /post" do 
        before { get '/post' }

        it "should return ok" do
            payload = JSON.parse(response.body)
            expect(payload).to be_empty
            expect(response).to have_http_status(200)
        end
    end

    # with data in the db
    describe "with data in the DB" do 
        before { get '/post' }

        let(:posts) { create_list(:post, 10, published: true) }
        it "should return all the published posts" do 
            payload = JSON.parse(response.body)
            expect(payload.size).to eq(posts.size) 
            expect(response).to have_http_status(200)
        end
    end

    #show
    describe "GET /post/{id}" do 
        let(:post) { create(:post) }
        
        it "should return a post" do
            get "/post/#{post.id}"
            payload = JSON.parse(response.body)
            expect(payload).to_not be_empty
            expect(payload["id"]).to eq(post.id)
            expect(response).to have_http_status(200)
        end
    end
end