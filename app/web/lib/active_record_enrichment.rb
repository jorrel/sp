#
# Active Record Enrichments
#
module ActiveRecordEnrichment
  def self.included(base)
    base.extend ActiveRecordEnrichment::ClassMethods
  end

  module ClassMethods
    #
    # Get the recent or the recent n records
    #
    def recent(*args)
      options = args.extract_options!
      options.reverse_update(:order => "#{quoted_table_name}.#{connection.quote_column_name(primary_key)} DESC")
      if n = args.first
        find :all, options.merge(:limit => n)
      else
        find :first, options
      end
    end
  end
end

class ActiveRecord::Base
  include ActiveRecordEnrichment
end
