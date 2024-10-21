class NotificationJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Example task
    puts "Performing a background job with arguments: #{args.inspect}"
  end
end
