module ListSorting
  module Controller
    def paginate(model, options = {})
      klass = model.to_s.classify.constantize
      options = options.reverse_merge(:page => params[:page] || 1)
      options[:order] = params[:sort] unless params[:sort].blank?
      klass.paginate options
    end
  end

  module Helper
    def sort_link(label, field, options = {})
      default = options.delete(:default) || false
      if (current = (params[:sort] == field)) or (params[:sort].blank? and default)
        field = ActiveRecord::Base.__send__(:reverse_sql_order, field).gsub(/\sASC$/i, '')
      elsif default and not params[:sort].blank?
        field = nil   # link would lead to default sorting
      end
      options[:class] = current ? 'current-sort ' + ((field =~ /DESC$/i) ? 'desc' : 'asc') : ''
      link_to label, url_for(:sort => field), options
    end
  end
end
