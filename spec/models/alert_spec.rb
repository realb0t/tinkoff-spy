require 'rails_helper'

RSpec.describe Alert, type: :model do
  subject { build(:alert) }

  it { should be_valid }

  it { should have_db_column(:currency).of_type(:string).with_options(null: false) }
  it { should have_db_column(:deal_type).of_type(:string).with_options(null: false) }
  it { should have_db_column(:sign).of_type(:string).with_options(null: false) }
  it { should have_db_column(:value).of_type(:float).with_options(null: false, default: 0.0, unsign: true) }
  it { should have_db_column(:email).of_type(:string).with_options(null: false) }

  it { should validate_presence_of(:currency) }
  it { should validate_presence_of(:deal_type) }
  it { should validate_presence_of(:sign) }
  it { should validate_presence_of(:value) }
  it { should validate_presence_of(:email) }
  it { should validate_inclusion_of(:currency).in_array(%w(EUR USD)) }
  it { should validate_inclusion_of(:deal_type).in_array(%w(buy sell)) }
  it { should validate_inclusion_of(:sign).in_array(%w(more less)) }
  it { should validate_numericality_of(:value).is_greater_than(0) }

  it "should be valid model with valid email" do
    build(:alert, email: "mail@example.com").should be_valid
  end

  it "should not be valid model without valid email" do
    build(:alert, email: "example.com").should_not be_valid
  end

  describe "Scope" do

    let(:def_cond) { { currency: 'USD', deal_type: 'sell' } }
    let(:cond)     { def_cond.merge( sign: sign ) } 
    let(:cur)      { cond[:currency] }
    let(:deal)     { cond[:deal_type] }
    let(:scope)    { Alert.by(cur, deal, sign, cur_val) }

    context "сondition with sign \"more\" and value 5" do

      let(:sign)    { 'more' }
      let(:cur_val) { 5 }

      it "should be include with value 4" do
        alert = create(:alert, cond.merge({ value: 4 }))
        scope.should include(alert) 
      end

      it "should not be include with value 6" do
        alert = create(:alert, cond.merge({ value: 6 }))
        scope.should_not include(alert) 
      end

      it "should not be include with value 5" do
        alert = create(:alert, cond.merge({ value: 5 }))
        scope.should_not include(alert) 
      end

    end

    context "сondition with sign \"less\" and value 3" do

      let(:sign)    { 'less' }
      let(:cur_val) { 3 }

      it "should be include with value 4" do
        alert = create(:alert, cond.merge({ value: 4 }))
        scope.should include(alert) 
      end

      it "should not be include with value 2" do
        alert = create(:alert, cond.merge({ value: 2 }))
        scope.should_not include(alert) 
      end

      it "should not be include with value 3" do
        alert = create(:alert, cond.merge({ value: 3 }))
        scope.should_not include(alert) 
      end

    end
  end
end
