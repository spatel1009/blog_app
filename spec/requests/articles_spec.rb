require 'rails_helper'

RSpec.describe 'Articles', type: :request do

  before do
    @john = User.create(email: 'test@test.com', password: 'password')
    @sohel = User.create(email: 'test1@test.com', password: 'password1')
    @article = Article.create!(title: 'Title One', body: 'Body 1', user: @john)
  end

  describe 'Get /articles/:id/edit' do
    context 'with non-signed in user' do
      before { get "/articles/#{@article.id}/edit" }

      it 'redirects to the sign in page' do
        expect(response.status).to eq 302
        flash_message = 'You need to sign in or sign up before continuing.'
        expect(flash[:alert]).to eq flash_message
      end
    end

    context 'with signed in user who is non-owner' do
      before do
        login_as(@sohel)
        get "/articles/#{@article.id}/edit"
      end

      it 'redirects to the home page' do
        expect(response.status).to eq 302
        flash_message = 'You can only edit your own article.'
        expect(flash[:alert]).to eq flash_message
      end
    end

    context 'with signed in user who is owner' do
      before do
        login_as(@john)
        get "/articles/#{@article.id}/edit"
      end

      it 'successfully goes to edit page' do
        expect(response.status).to eq 200

      end
    end
  end

  describe 'Delete /articles/:id' do
    context 'with non-signed in user' do
      before { delete "/articles/#{@article.id}" }

      it 'redirects to the sign in page' do
        expect(response.status).to eq 302
        flash_message = 'You need to sign in or sign up before continuing.'
        expect(flash[:alert]).to eq flash_message
      end
    end

    context 'with signed in user who is non-owner' do
      before do
        login_as(@sohel)
        delete "/articles/#{@article.id}"
      end

      it 'redirects to the home page' do
        expect(response.status).to eq 302
        flash_message = 'You can only delete your own article.'
        expect(flash[:alert]).to eq flash_message
      end
    end

    context 'with signed in user who is owner' do
      before do
        login_as(@john)
        delete "/articles/#{@article.id}"
      end

      it 'successfully deletes articles' do
        flash_message = 'Article has been deleted'
        expect(flash[:success]).to eq flash_message

      end
    end
  end

  describe 'Get /articles/:id' do
    context 'with existing article' do
      before { get "/articles/#{@article.id}" }

      it 'handles exisiting article' do
        expect(response.status).to eq 200
      end
    end

    context 'with non-existing article' do
      before { get "/articles/xxxx" }

      it 'handles non-exisiting article' do
        expect(response.status).to eq 302
        flash_message = "The article you are looking for could not be found!"
        expect(flash[:alert]).to eq flash_message
      end
    end
  end

end