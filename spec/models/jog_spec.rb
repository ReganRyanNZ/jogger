require 'rails_helper'

describe 'Jog' do
  before {
    @user = FactoryGirl.build :user
    @jog = FactoryGirl.build :jog, user: @user
  }

  subject { @jog }

  it { is_expected.to respond_to(:time) }
  it { is_expected.to respond_to(:distance) }
  it { is_expected.to respond_to(:date) }
  it { is_expected.to respond_to(:user) }

  it { is_expected.to be_valid }

end