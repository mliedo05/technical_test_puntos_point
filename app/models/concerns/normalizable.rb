module Normalizable
  extend ActiveSupport::Concern

  class_methods do
    def normalize_name(attribute = :name)
      before_validation do
        value = send(attribute)
        send("#{attribute}=", value.to_s.strip.downcase.capitalize) if value.present?
      end
    end
  end
end
