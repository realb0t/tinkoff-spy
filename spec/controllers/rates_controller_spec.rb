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
      before do
        RR.stub.proxy(Rails.cache).fetch(:rates_current_stats, expires_in: 5.minutes).yields { |data|
          data
        }
        get :current, format: 'json'
      end

      it { should respond_with(:success) }
      it { response.body.should == Stats.represent.to_json }
    end

  end

end
