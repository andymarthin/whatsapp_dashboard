# frozen_string_literal: true

class Sidebar::WrapperComponent < ViewComponent::Base
  renders_many :items, Sidebar::ItemComponent
end
