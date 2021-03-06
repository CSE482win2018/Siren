require 'spec_helper'

describe JsonApi::Token do
  describe "as_json" do
    it "should return correct attributes" do
      d = Device.create
      d.generate_token!
      u = User.new(user_name: 'fred')
      hash = JsonApi::Token.as_json(u, d)
      expect(hash.keys.sort).to eq(['access_token', 'scopes', 'token_type', 'user_id', 'user_name'])
      expect(hash['access_token']).to eq(d.token)
      expect(hash['token_type']).to eq('bearer')
      expect(hash['user_name']).to eq('fred')
    end
    
    it "should include scopes data" do
      d = Device.create
      d.developer_key_id = 1
      d.settings['permission_scopes'] = ['a', 'b']
      d.generate_token!
      u = User.new(user_name: 'fred')
      hash = JsonApi::Token.as_json(u, d)
      expect(hash.keys.sort).to eq(['access_token', 'scopes', 'token_type', 'user_id', 'user_name'])
      expect(hash['access_token']).to eq(d.token)
      expect(hash['scopes']).to eq(['a', 'b'])
    end
  end
end
