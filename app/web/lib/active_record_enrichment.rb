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

    #
    # Get a random record
    #
    def random
      db = ActiveRecord::Base.connection.adapter_name
      if db == 'MySQL'
        find(:first, :order => 'rand()')
      elsif db == 'PostgreSQL'
        find(:first, :order => 'random()')  # not efficient because pg fetches all records
      else
        raise "Getting a random is not supported for #{db}"
      end
    end
  end
end

class ActiveRecord::Base
  include ActiveRecordEnrichment
end
