require "./spec_helper"
require "../../src/models/shodan_info.cr"

describe ShodanInfo do
  Spec.before_each do
    ShodanInfo.clear
  end
end
