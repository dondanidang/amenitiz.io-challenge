# frozen_string_literal: true

class ApplicationPresenter
  def self.build_view(*args, **kwargs)
    new(*args, **kwargs).send(:build_view)
  end
end
