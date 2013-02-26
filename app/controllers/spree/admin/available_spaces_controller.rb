class Spree::Admin::AvailableSpacesController <  Spree::Admin::BaseController

def index
	@all_bookings = 0 
	@bookings_date = Array.new
	@booking_rate = Array.new
	@bookings =Spree::Booking.where('created_at BETWEEN ? AND ? AND rating IS NOT NULL', DateTime.now.in_time_zone.beginning_of_month, DateTime.now.in_time_zone.end_of_month)
	@bookings.each do |booking|
		@bookings_date << booking.created_at.strftime("%d-%m-%Y")
		@booking_rate << booking.rating
		end	unless @bookings.blank?
end	


end