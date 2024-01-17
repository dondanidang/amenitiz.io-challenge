# frozen_string_literal: true

class ApplicationService
  # Use this method if the service can't raise an error.
  def self.call(*args, **kwargs)
    new(*args, **kwargs).send(:call)
  end

  # Use this method if the service can raise an error.
  def self.call!(*args, **kwargs)
    new(*args, **kwargs).send(:call!)
  end
end
