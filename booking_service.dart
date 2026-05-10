import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/booking_model.dart';
import 'supabase_service.dart';

class BookingService {
  static final _table = SupabaseService.client.from('bookings');

  static Future<List<BookingModel>> getAllBookings() async {
    final response = await _table.select().order('created_at', ascending: false);
    return (response as List).map((json) => BookingModel.fromJson(json)).toList();
  }

  static Future<List<BookingModel>> getBookingsByStatus(String status) async {
    final response = await _table.select().eq('status', status).order('created_at', ascending: false);
    return (response as List).map((json) => BookingModel.fromJson(json)).toList();
  }

  static Future<BookingModel?> getBookingById(String id) async {
    final response = await _table.select().eq('id', id).single();
    return response != null ? BookingModel.fromJson(response) : null;
  }

  static Future<BookingModel> createBooking(BookingModel booking) async {
    final response = await _table.insert(booking.toJson()).select().single();
    return BookingModel.fromJson(response);
  }

  static Future<void> updateBookingStatus(String id, String status) async {
    await _table.update({
      'status': status,
      'updated_at': DateTime.now().toIso8601String(),
    }).eq('id', id);
  }

  static Future<void> deleteBooking(String id) async {
    await _table.delete().eq('id', id);
  }

  static Future<int> getBookingsCount() async {
    final response = await _table.select('id').count();
    return response.count ?? 0;
  }

  static Future<int> getPendingBookingsCount() async {
    final response = await _table.select('id').eq('status', 'pending').count();
    return response.count ?? 0;
  }

  static Future<int> getCompletedBookingsCount() async {
    final response = await _table.select('id').eq('status', 'completed').count();
    return response.count ?? 0;
  }
}
