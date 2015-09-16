require 'rails_helper'

RSpec.describe AlertsController, type: :controller do

  render_views

  context "POST create" do

    let(:alert_params) { alert.attributes }

    context "Not json request" do
      let(:alert) { build :alert }
      before { post :create, alert: alert_params }

      it { response.status.should == 406 }
      it { JSON.parse(response.body)['error'].should_not be_nil }
    end

    context "Posting valid Alert" do
      let(:alert) { build(:alert) }
      subject { post :create, alert: alert_params, format: 'json' }

      it { subject.should redirect_to(action: :show, id: Alert.last.id, format: :json) }
      it { -> { subject }.should change(Alert,:count).by(1) }
    end

    context "Posting invalid Alert" do
      let(:alert) { build(:alert, email: 'example.com') }
      before { post :create, alert: alert_params, format: 'json' }

      it { Alert.should_not be_exist }
      it { JSON.parse(response.body)['error'].should_not be_nil }
      it { response.status.should == 400 }
    end

  end

  context "GET show" do

    context "Not json request" do
      let(:alert) { create :alert }
      before { get :show, id: alert.id }

      it { response.status.should == 406 }
      it { JSON.parse(response.body)['error'].should_not be_nil }
    end

    context "Exist alert" do
      let(:alert) { create :alert }
      before { get :show, id: alert.id, format: 'json' }

      it { should respond_with(:success) }
      it { assigns(:alert).should be_a_kind_of(Alert) }
      it { JSON.parse(response.body)['error'].should be_nil }
    end

    context "Not exist alert" do
      before { get :show, id: 'foo', format: 'json' }

      it { should_not respond_with(:success) }
      it { JSON.parse(response.body)['error'].should_not be_nil }
    end

  end

end
