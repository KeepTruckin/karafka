# frozen_string_literal: true

require 'karafka/pro/base_consumer'
require 'karafka/pro/contracts/base'
require 'karafka/pro/contracts/consumer_group'
require 'karafka/pro/contracts/consumer_group_topic'

RSpec.describe_current do
  subject(:check) { described_class.new.call(config) }

  let(:consumer) { Class.new(Karafka::Pro::BaseConsumer) }
  let(:config) { { topics: [{ consumer: consumer }] } }

  context 'when config is valid' do
    it { expect(check).to be_success }
  end

  context 'when consumer inherits from the base consumer' do
    let(:consumer) { Class.new(Karafka::BaseConsumer) }

    it { expect(check).not_to be_success }
  end

  context 'when there are no topics' do
    let(:config) { {} }

    it { expect(check).to be_success }
  end
end
