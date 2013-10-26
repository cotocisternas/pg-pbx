class CdrsDatatable
  delegate :current_ability, :params, :h, :link_to, :convert_seconds_to_time, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Cdr.count,
      iTotalDisplayRecords: cdrs.total_entries,
      aaData: data
    }
  end

  private
  
    def data
      cdrs.map do |cdr|
        [
          h(cdr.calldate.strftime("%e/%m/%Y")),
          h(cdr.calldate.strftime("%I:%M%p")),
          h(cdr.clid.split("<").first),
          h(cdr.src),
          h(cdr.dst),
          h(cdr.lastapp),
          h(cdr.lastdata.split("@").second),
          convert_seconds_to_time(cdr.duration),
          convert_seconds_to_time(cdr.billsec),
          h(cdr.disposition)
        ]
      end
    end
  
    def cdrs
      @cdrs ||= fetch_cdrs
    end
  
    def fetch_cdrs
      cdrs = Cdr.accessible_by(current_ability, :index).order('calldate DESC')
      cdrs = cdrs.page(page).per_page(per_page)
      if params[:sSearch].present?
        cdrs = cdrs.where("clid like :search or src like :search or dst like :search or disposition like :search", search: "%#{params[:sSearch]}%")
      end
      cdrs
    end
  
    def page
      params[:iDisplayStart].to_i/per_page + 1
    end
  
    def per_page
      params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
    end
  
    def sort_column
      columns = %w[calldate]
      columns[params[:iSortCol_0].to_i]
    end
  
    def sort_direction
      params[:sSortDir_0] == "DESC" ? "DESC" : "ASC"
    end
end