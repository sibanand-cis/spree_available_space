class Spree::Admin::AvailableSpacesController <  Spree::Admin::BaseController

# def index
# 	@bookings_date = Array.new
# 	@booking_rate = Array.new
# 	@bookings =Spree::Booking.where('pickup_date BETWEEN ? AND ? AND rating IS NOT NULL', DateTime.now.in_time_zone.beginning_of_month, DateTime.now.in_time_zone.end_of_month)
# 	@bookings.each do |booking|
# 		@bookings_date << booking.pickup_date
# 		@booking_rate << booking.rating
# 		end	unless @bookings.blank?
# end	

# end
def index
        @bookings_date = Array.new
        @booking_rate = Array.new
        if !params[:search].blank? 
        if !params[:search]["start_date"].blank? && !params[:search]["end_date"].blank?
         @bookings =Spree::Booking.where(:pickup_date => (params[:search]["start_date"].to_date)..(params[:search]["end_date"].to_date)).where("rating is not null")
        else
         @bookings = []
        end  
     end             
        @bookings.each do |booking|
        @bookings_date << booking.pickup_date
        @booking_rate << booking.rating
         end unless @bookings.blank?
      end        
    end
