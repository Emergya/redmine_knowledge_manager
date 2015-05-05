require 'dispatcher' unless Rails::VERSION::MAJOR >= 3

module KM
  unloadable
  module UserPatch
    def self.included(base) # :nodoc:
      base.extend(ClassMethods)
      base.send(:include, InstanceMethods)

      # Same as typing in the class
      base.class_eval do
        unloadable # Send unloadable so it will be reloaded in development

        has_many :user_knowledges, :dependent => :destroy
        has_many :knowledges, :through => :user_knowledges, :uniq => true
      end
    end

    module ClassMethods
      # Get users with specified knowledges
      def with_knowledges(knowledges)
        # AND
        #includes(:user_knowledges).where("user_knowledges.knowledge_id IN (?)", knowledges).having("COUNT(*) >= ?",knowledges.length)
        # OR
        includes(:user_knowledges).where("user_knowledges.knowledge_id IN (?)", knowledges)
      end
    end

    module InstanceMethods
      def main_knowledges
        self.knowledges.select{|k| k.main.present?}
      end
    end
  end
end

if Rails::VERSION::MAJOR >= 3
  ActionDispatch::Callbacks.to_prepare do
    require_dependency 'user'
    User.send(:include, KM::UserPatch)
  end
else
  Dispatcher.to_prepare do
    require_dependency 'user'
    User.send(:include, KM::UserPatch)
  end
end
