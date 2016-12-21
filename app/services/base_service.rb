class BaseService
  include ActiveModel::Model
  include ActiveModel::Validations

  extend ActiveModel::Callbacks
  include ActiveModel::Validations::Callbacks
  define_model_callbacks :run

  include Rails.application.routes.url_helpers

  def errors=(errs)
    errs.full_messages.each { |msg| errors.add(:base, msg) }
  end
end
