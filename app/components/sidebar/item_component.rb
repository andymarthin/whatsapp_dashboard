# frozen_string_literal: true

class Sidebar::ItemComponent < ViewComponent::Base
  attr_reader :url, :text, :url_type
  def initialize(url:, text:, url_type: nil)
    @url = url
    @text = text
    @url_type = url_type
    super
  end

  private

  def link_classes
    classes = "flex items-center w-full p-2 text-base text-gray-900 transition duration-75 rounded-lg group hover:bg-gray-100 dark:text-gray-200 dark:hover:bg-gray-700"
    classes += " #{active_class}" if is_active_link?(url, url_type)
    classes
  end

  def active_class
    "bg-gray-100 dark:bg-gray-700"
  end

  def is_active_link?(url, condition = nil)
    return false if url == "#"

    @is_active_link ||= {}
    @is_active_link[[ url, condition ]] ||= begin
      original_url = url
      url = Addressable::URI.parse(url).path
      path = request.original_fullpath
      case condition
      when :inclusive, nil
        path.match(/^#{Regexp.escape(url).chomp('/')}(\/.*|\?.*)?$/).present?
      when :exclusive
        path.match(/^#{Regexp.escape(url)}\/?(\?.*)?$/).present?
      when :exact
        path == original_url
      when Regexp
        path.match(condition).present?
      when Array
        controllers = [ *condition[0] ]
        actions = [ *condition[1] ]
        (controllers.blank? || controllers.member?(params[:controller])) &&
          (actions.blank? || actions.member?(params[:action])) ||
          controllers.any? do |controller, action|
            params[:controller] == controller.to_s && params[:action] == action.to_s
          end
      when TrueClass
        true
      when FalseClass
        false
      when Hash
        condition.all? do |key, value|
          params[key].to_s == value.to_s
        end
      end
    end
  end
end
