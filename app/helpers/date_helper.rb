module DateHelper
  def format_date(date)
    date.strftime("%d %b %y") if date.present?
  end

  def format_by_month(date)
    date.strftime("%b %y") if date.present?
  end

  def format_by_time(date)
    date.strftime("%l:%M %p") if date.present?
  end
end
