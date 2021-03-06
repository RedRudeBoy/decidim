# frozen_string_literal: true
module Decidim
  # An example implementation of an AuthorizationHandler to be used in tests.
  class DummyAuthorizationHandler < AuthorizationHandler
    attribute :document_number, String
    attribute :birthday, Date

    validates :document_number, presence: true
    validate :valid_document_number

    def authorized?
      valid?
    end

    def metadata
      super.merge(document_number: document_number)
    end

    private

    def valid_document_number
      errors.add(:document_number, :invalid) unless document_number.to_s.end_with?("X")
    end
  end
end
