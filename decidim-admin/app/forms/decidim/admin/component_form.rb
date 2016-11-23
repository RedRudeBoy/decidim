# frozen_string_literal: true
module Decidim
  module Admin
    # A form object used to create participatory processes from the admin
    # dashboard.
    #
    class ComponentForm < Rectify::Form
      include TranslatableAttributes

      mimic :component

      translatable_attribute :name, String
      translatable_validates :name, presence: true

      attribute :component_type, String
      attribute :feature_id, Integer

      validates :component_type, presence: true
      validates :feature_id, presence: true
    end
  end
end
