class Spree::Admin::AvailableSpacesController <  Spree::Admin::BaseController


  def index
      @bookings_data = {}
      @booking_rate = []

      start_date = ((params[:search].blank? ? Time.now.beginning_of_month : (params[:search][:start_date].blank? ? Time.now.beginning_of_month : params[:search][:start_date]))).to_date.strftime "%Y-%m-%d"

       
      end_date = ((params[:search].blank? ? Time.now.end_of_month : (params[:search][:end_date].blank? ? Time.now.end_of_month : params[:search][:end_date])) ).to_date.strftime "%Y-%m-%d"

      if Rails.env == "development"
       @bookings = Spree::Booking.find_by_sql("SELECT IFNULL(sum( rating ),0) as total_space,filter_date.id as day FROM spree_bookings RIGHT JOIN (select adddate(\"#{start_date}\", numslist.id) as id from (SELECT n1.col_i + n10.col_i*10 + n100.col_i*100 AS id FROM nums n1 cross join nums as n10 cross join nums as n100) as numslist where adddate(\"#{start_date}\", numslist.id) <= \"#{end_date}\" ) filter_date ON (DATE_FORMAT(spree_bookings.pickup_date,'%Y-%m-%d') = filter_date.id) GROUP BY filter_date.id")
      else
        @bookings = Spree::Booking.find_by_sql("SELECT  filter_date.id as day,coalesce(sum(users.id),0) as total_space FROM  users  RIGHT JOIN ( select \"#{start_date}\"::date + cast(numlist.id::text || ' days' as interval) as  id  from (SELECT n1.i + n10.i*10 + n100.i*100 AS id FROM num n1 cross join num as n10 cross join num as n100) as numlist where (select \"#{start_date}\"::date + cast(numlist.id::text || ' days' as interval)) <= \"#{end_date}\"::date ) filter_date ON ( users.reated_at::date  = filter_date.id) GROUP BY filter_date.id")        
      end        
      @bookings.each do |booking|        
        @bookings_data[booking.day.to_s] = booking.total_space.to_i
      end unless @bookings.blank?                   
  end        
end
