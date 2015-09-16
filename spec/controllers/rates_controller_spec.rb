require 'rails_helper'

RSpec.describe RatesController, type: :controller do

  render_views

  context "GET current" do

    context "Not json request" do
      before { get :current }

      it { response.status.should == 406 }
      it { JSON.parse(response.body)['error'].should_not be_nil }
    end

    context "With json format" do
      before { get :current, format: 'json' }

      it { should respond_with(:success) }
    end

  end

end
