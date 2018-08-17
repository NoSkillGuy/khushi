class WhatsppMessagesDatatable
  delegate :params, to: :@view

  def initialize(view,user)
    @view = view
    @user = user
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: whatspp_messages.count,
      iTotalDisplayRecords: whatspp_messages.total_entries,
      aaData: data
    }
  end

private

  def data
    # whatspp_messages.map do |wm|
    #   [
    #     wm.created_at,
    #     # wm.user.first_name,
    #     # wm.user.phone_number,
    #     wm.events.pluck(:category).sort.join(','),
    #     wm.data
    #   ]
    # end
    whatspp_messages
    display_data = []
    whatspp_messages.each do |wm|
      temp_arr = []
      temp_arr.push wm.created_at.strftime('%Y/%m/%d %H:%M')
      temp_arr.push wm.user.first_name if @user.admin?
      temp_arr.push wm.user.phone_number if @user.admin?
      temp_arr.push wm.events.pluck(:category).sort.join(',')
      temp_arr.push wm.data
      display_data.push temp_arr
    end
    display_data
  end

  def whatspp_messages
    @whatspp_messages ||= fetch_whatspp_messages
  end

  def fetch_whatspp_messages
    if @user.admin?
      wms = WhatsppMessage.includes(:user, :events).all
      # wms = wms.where("data like :search", search: "%#{params[:sSearch_0]}%") if params[:sSearch_0].present?
      # wms = wms.where("data like :search", search: "%#{params[:sSearch_1]}%") if params[:sSearch_1].present?
      # wms = wms.where("data like :search", search: "%#{params[:sSearch_2]}%") if params[:sSearch_2].present?
      # wms = wms.where("data like :search", search: "%#{params[:sSearch_3]}%") if params[:sSearch_3].present?
      if params[:sSearch_1].present?
        user_ids = User.where('lower(first_name) like ?', "%#{params[:sSearch_1].downcase}%").ids
        wms = wms.where(user_id: user_ids)
      end
      if params[:sSearch_2].present?
        user_ids = User.where('phone_number like ?',"%#{params[:sSearch_2]}%").ids
        wms = wms.where(user_id: user_ids)
      end
      if params[:sSearch_3].present?
        temp = []
        wms.each do |wm|
          temp.push wm.id if wm.events.pluck(:category).join(',').include? params[:sSearch_3]
        end
        wms = WhatsppMessage.where(id: temp)
      end      
      wms = wms.where("data like :search", search: "%#{params[:sSearch_4]}%") if params[:sSearch_4].present?        
    else
      wms = WhatsppMessage.includes(:events).where(user_id: @user.id)
      
      # wms = wms.where("data like :search", search: "%#{params[:sSearch_1]}%") if params[:sSearch_1].present?
      if params[:sSearch_1].present?
        temp = []
        wms.each do |wm|
          temp.push wm.id if wm.events.pluck(:category).join(',').include? params[:sSearch_1]
        end
        wms = WhatsppMessage.where(id: temp)
      end
      wms = wms.where("data like :search", search: "%#{params[:sSearch_2]}%") if params[:sSearch_2].present?
    end

    if params[:sSearch_0].present?
      # wms = wms.where("created_at like :search", search: "%#{params[:sSearch_0]}%") 
      dates = params[:sSearch_0].split('-')
      
      begin
          from_date = DateTime.parse(dates[0]+' +5:30').utc
          wms = wms.where('created_at >= ?', from_date)
      rescue StandardError
          
      end
      begin
          to_date = DateTime.parse(dates[1]+' +5:30').utc
          wms = wms.where('created_at < ?', to_date)
      rescue StandardError
          
      end
    end


    if sort_column == 'user' || sort_column == 'phone_number' || sort_column == 'event_category'
      
    else
      wms = wms.order("#{sort_column} #{sort_direction}")
    end
    wms = wms.page(page).per_page(per_page)
    
    wms
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[created_at user phone_number event_category data]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end

