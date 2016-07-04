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
        has_many :knowledges, -> {distinct}, :through => :user_knowledges
      end
    end

    module ClassMethods
      # Get users with specified knowledges
      def with_knowledges(knowledges,users)
        users = allowed.collect{|u| u.id} if users.empty?
        # AND
        #includes(:user_knowledges).where("user_knowledges.knowledge_id IN (?)", knowledges).having("COUNT(*) >= ?",knowledges.length)
        # OR
        joins(:user_knowledges).where("user_knowledges.knowledge_id IN (?) AND users.id IN (?)", knowledges, users)
      end
    end

    module InstanceMethods
      def main_knowledges
        self.knowledges.select{|k| k.main.present?}
      end

      def other_knowledges
        self.knowledges.reject{|k| k.main.present?}
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
