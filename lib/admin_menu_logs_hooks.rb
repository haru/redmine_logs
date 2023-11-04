module RedminePluginWithAssets
  module Hooks
    class AdminMenuLogsHooks < Redmine::Hook::ViewListener
      include ActionView::Helpers::TagHelper

      def view_layouts_base_html_head(context = {})
        stylesheet_link_tag('logs', :plugin => 'redmine_logs')
      end
    end
  end
end