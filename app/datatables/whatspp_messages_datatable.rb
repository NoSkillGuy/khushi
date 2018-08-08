class WhatsppMessagesDatatable
  delegate :params, to: :@view

  def initialize(view,user)
    @view = view
    @user = user
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: WhatsppMessage.where(user_id: @user.id).count,
      iTotalDisplayRecords: whatspp_messages.total_entries,
      aaData: data
    }
  end

private

  def data
    whatspp_messages.map do |wm|
      [
        wm.created_at,
        wm.user.first_name,
        wm.user.phone_number,
        wm.events.pluck(:category).sort.join(','),
        wm.data
      ]
    end
  end

  def whatspp_messages
    @whatspp_messages ||= fetch_whatspp_messages
  end

  def fetch_whatspp_messages
    if sort_column == 'user' || sort_column == 'phone_number' || sort_column == 'event_category'
      whatspp_messages = WhatsppMessage.where(user_id: @user.id)
    else
      whatspp_messages = WhatsppMessage.where(user_id: @user.id).order("#{sort_column} #{sort_direction}")
    end
    whatspp_messages = whatspp_messages.page(page).per_page(per_page)
    if params[:sSearch].present?
      whatspp_messages = whatspp_messages.includes(:events).where("data like :search", search: "%#{params[:sSearch]}%")
    end
    whatspp_messages
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

