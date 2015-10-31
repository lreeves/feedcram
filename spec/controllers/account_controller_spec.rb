require 'rails_helper'

RSpec.describe AccountController, type: :controller do
  describe 'POST upload' do
    let(:opml_file) { fixture_file_upload('opml/feedly.opml', 'text/xml') }
    let(:user) { User.create(email: 'test@example.com', password: 'password') }

    it 'processes the uploaded OPML file' do
      post :upload, { opml: opml_file }, { user_id: user.id }

      expect(Feed.count).to eq 3
      expect(user.feeds.count).to eq 3
    end
  end
end
