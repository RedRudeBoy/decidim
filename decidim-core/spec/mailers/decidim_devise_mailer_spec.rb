require "spec_helper"

RSpec.shared_examples "localised email" do
  let(:user) { build(:user, locale: locale ) }

  context "when the user has a custom locale" do
    let(:locale) { "ca" }

    it "uses the user's locale" do
      expect(mail.subject).to eq(subject)
      expect(mail.body.encoded).to match(body)
    end
  end

  context "otherwise" do
    let(:locale) { nil }

    it "uses the default locale" do
      expect(mail.subject).to eq(default_subject)
      expect(mail.body.encoded).to match(default_body)
    end
  end
end

module Decidim
  describe DecidimDeviseMailer, type: :mailer do
    describe "confirmation_instructions" do
      let(:mail) { described_class.confirmation_instructions(user, "foo", {}) }

      let(:subject) { "Instruccions de confirmació" }
      let(:body) { "Pots confirmar el correu electrònic del teu compte" }
      let(:default_subject) {"Confirmation instructions"}
      let(:default_body) {"You can confirm your account email through the link below"}

      include_examples "localised email"
    end

    describe "reset_password_instructions" do
      let(:mail) { described_class.reset_password_instructions(user, "foo", {}) }

      let(:subject) { "Instruccions de regeneració de contrasenya" }
      let(:body) { "Algú ha sol·licitat un enllaç per a canviar la teva contrasenya" }
      let(:default_subject) {"Reset password instructions"}
      let(:default_body) {"Someone has requested a link to change your password"}

      include_examples "localised email"
    end

    describe "password_change" do
      let(:mail) { described_class.password_change(user, {}) }

      let(:subject) { "Contrasenya canviada" }
      let(:body) { "Ens posem en contacte amb tu per notificar-te que la teva contrasenya ha estat canviada correctament" }
      let(:default_subject) {"Password Changed"}
      let(:default_body) {"contacting you to notify you that your password has been changed"}

      include_examples "localised email"
    end

    describe "invitation_instructions" do
      let(:mail) do
        user.invitation_created_at = Time.current
        described_class.invitation_instructions(user, "foo", {invitation_instructions: "organization_admin_invitation_instructions"})
      end

      let(:subject) { "T'han convidat a administrar #{user.organization.name}" }
      let(:body) { "Acceptar invitaci" }
      let(:default_subject) {"You've been invited to admin #{user.organization.name}"}
      let(:default_body) {"Accept invitation"}

      include_examples "localised email"
    end
  end
end
