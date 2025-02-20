# frozen_string_literal: true

module Karafka
  module Processing
    module Jobs
      # The main job type. It runs the executor that triggers given topic partition messages
      # processing in an underlying consumer instance.
      class Consume < Base
        # @return [Array<Rdkafka::Consumer::Message>] array with messages
        attr_reader :messages

        # @param executor [Karafka::Processing::Executor] executor that is suppose to run a given
        #   job
        # @param messages [Karafka::Messages::Messages] karafka messages batch
        # @param coordinator [Karafka::Processing::Coordinator] processing coordinator
        # @return [Consume]
        def initialize(executor, messages, coordinator)
          @executor = executor
          @messages = messages
          @coordinator = coordinator
          @created_at = Time.now
          super()
        end

        # Runs the before consumption preparations on the executor
        def before_call
          executor.before_consume(@messages, @created_at, @coordinator)
        end

        # Runs the given executor
        def call
          executor.consume
        end

        # Runs any error handling and other post-consumption stuff on the executor
        def after_call
          executor.after_consume
        end
      end
    end
  end
end
