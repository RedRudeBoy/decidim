# frozen_string_literal: true
module Decidim
  # Interaction between a user and an organization is done via a
  # ParticipatoryProcess. It's a unit of action from the Organization point of
  # view that groups several features (proposals, debates...) distributed in
  # steps that get enabled or disabled depending on which step is currently
  # active.
  class ParticipatoryProcess < ApplicationRecord
    belongs_to :organization,
               foreign_key: "decidim_organization_id",
               class_name: Decidim::Organization,
               inverse_of: :participatory_processes
    has_many :steps,
             -> { order(position: :asc) },
             foreign_key: "decidim_participatory_process_id",
             class_name: Decidim::ParticipatoryProcessStep,
             dependent: :destroy,
             inverse_of: :participatory_process
    has_one :active_step,
            -> { where(active: true) },
            foreign_key: "decidim_participatory_process_id",
            class_name: Decidim::ParticipatoryProcessStep,
            dependent: :destroy,
            inverse_of: :participatory_process
    has_many :attachments,
             foreign_key: "decidim_participatory_process_id",
             class_name: Decidim::ParticipatoryProcessAttachment,
             dependent: :destroy,
             inverse_of: :participatory_process

    attr_readonly :active_step

    validates :slug, presence: true
    validates :slug, uniqueness: { scope: :organization }

    mount_uploader :hero_image, Decidim::HeroImageUploader
    mount_uploader :banner_image, Decidim::BannerImageUploader

    # Scope to return only the published processes.
    #
    # Returns an ActiveRecord::Relation.
    def self.published
      where.not(published_at: nil)
    end

    # Scope to return only the promoted processes.
    #
    # Returns an ActiveRecord::Relation.
    def self.promoted
      where(promoted: true)
    end

    # Checks whether the process has been published or not.
    #
    # Returns a boolean.
    def published?
      published_at.present?
    end

    # All the attachments that are photos for this porcess.
    #
    # Returns an Array<Attachment>
    def photos
      @photos ||= attachments.select(&:photo?)
    end

    # All the attachments that are documents for this porcess.
    #
    # Returns an Array<Attachment>
    def documents
      @documents ||= attachments.select(&:document?)
    end
  end
end
