ENV["ENGINE_NAME"] = File.dirname(File.dirname(__FILE__)).split("/").last
require "decidim/test/base_spec_helper"

RSpec.configure do |config|
  config.include ProcessesMenuLinksHelpers
end
