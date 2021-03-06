# frozen_string_literal: true
require "decidim/translatable_attributes"

module Decidim
  module System
    # A form object used to create organizations from the system dashboard.
    #
    class RegisterOrganizationForm < UpdateOrganizationForm
      include TranslatableAttributes

      mimic :organization

      attribute :organization_admin_email, String
      attribute :organization_admin_name, String
      attribute :available_locales, Array
      attribute :default_locale, String

      validates :organization_admin_email, :organization_admin_name, :name, :host, presence: true
      validates :available_locales, presence: true
      validates :default_locale, presence: true
      validates :default_locale, inclusion: { in: :available_locales }

      translatable_attribute :description, String
    end
  end
end
