class HelloWorldJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    Rails.logger.info '👋 ¡Hola desde Sidekiq! Estoy funcionando.'
  end
end
