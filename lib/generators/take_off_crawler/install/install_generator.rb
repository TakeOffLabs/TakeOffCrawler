require 'rails/generators/migration'

module TakeOffCrawler
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      include Rails::Generators::Migration
      include Rails::Generators::Model
      
      source_root File.expand_path('../templates', __FILE__)
      desc "add the migration and model for Link"

      def self.next_migration_number(path)
        unless @prev_migration_nr
          @prev_migration_nr = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
        else
          @prev_migration_nr += 1
        end
        @prev_migration_nr.to_s
      end

      def copy_migration
        migration_template "create_links.rb", "db/migrate/create_links.rb"
      end
      
      def copy_model
        template "link.rb", "app/models/link.rb"
      end
    end
  end
end