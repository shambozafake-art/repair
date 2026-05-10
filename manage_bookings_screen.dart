import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';

class ManageBookingsScreen extends StatefulWidget {
  const ManageBookingsScreen({super.key});

  @override
  State<ManageBookingsScreen> createState() => _ManageBookingsScreenState();
}

class _ManageBookingsScreenState extends State<ManageBookingsScreen> {
  String _filter = 'all';

  final List<Map<String, dynamic>> _bookings = [
    {
      'id': 'BK-001',
      'name': 'Chinedu Okafor',
      'phone': '+234 801 234 5678',
      'service': 'Bathroom Renovation',
      'location': 'Lekki, Lagos',
      'date': 'Jan 20, 2024',
      'time': '10:00 AM',
      'status': 'pending',
      'description': 'Need complete bathroom renovation including tiling, plumbing, and shower installation.',
    },
    {
      'id': 'BK-002',
      'name': 'Amina Bello',
      'phone': '+234 802 345 6789',
      'service': 'Gate Installation',
      'location': 'Ikeja, Lagos',
      'date': 'Jan 18, 2024',
      'time': '2:00 PM',
      'status': 'accepted',
      'description': 'Install new security gate for compound entrance.',
    },
    {
      'id': 'BK-003',
      'name': 'Tunde Adeyemi',
      'phone': '+234 803 456 7890',
      'service': 'House Painting',
      'location': 'Surulere, Lagos',
      'date': 'Jan 15, 2024',
      'time': '9:00 AM',
      'status': 'in_progress',
      'description': 'Exterior painting for 4-bedroom duplex.',
    },
    {
      'id': 'BK-004',
      'name': 'Ngozi Eze',
      'phone': '+234 804 567 8901',
      'service': 'Interior Decoration',
      'location': 'Victoria Island',
      'date': 'Jan 10, 2024',
      'time': '11:00 AM',
      'status': 'completed',
      'description': 'Living room and master bedroom decoration.',
    },
    {
      'id': 'BK-005',
      'name': 'Kunle Johnson',
      'phone': '+234 805 678 9012',
      'service': 'Plumbing Repairs',
      'location': 'Yaba, Lagos',
      'date': 'Jan 22, 2024',
      'time': 'Any Time',
      'status': 'pending',
      'description': 'Leaking pipe under kitchen sink needs urgent repair.',
    },
    {
      'id': 'BK-006',
      'name': 'Fatima Ibrahim',
      'phone': '+234 806 789 0123',
      'service': 'Ceiling Repairs',
      'location': 'Ikorodu, Lagos',
      'date': 'Jan 12, 2024',
      'time': '8:00 AM',
      'status': 'cancelled',
      'description': 'POP ceiling repair in living room and dining area.',
    },
  ];

  List<Map<String, dynamic>> get filteredBookings {
    if (_filter == 'all') return _bookings;
    return _bookings.where((b) => b['status'] == _filter).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending': return AppColors.pending;
      case 'accepted': return AppColors.accepted;
      case 'in_progress': return AppColors.inProgress;
      case 'completed': return AppColors.completed;
      case 'cancelled': return AppColors.cancelled;
      default: return AppColors.textSecondary;
    }
  }

  void _updateStatus(Map<String, dynamic> booking, String newStatus) {
    setState(() => booking['status'] = newStatus);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Booking \${booking['id']} marked as \$newStatus')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Bookings'),
      ),
      body: Column(
        children: [
          // Filter Chips
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildFilterChip('All', 'all'),
                _buildFilterChip('Pending', 'pending'),
                _buildFilterChip('Accepted', 'accepted'),
                _buildFilterChip('In Progress', 'in_progress'),
                _buildFilterChip('Completed', 'completed'),
                _buildFilterChip('Cancelled', 'cancelled'),
              ],
            ),
          ),

          // Bookings List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredBookings.length,
              itemBuilder: (context, index) {
                return _buildBookingCard(filteredBookings[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String value) {
    final isSelected = _filter == value;
    return GestureDetector(
      onTap: () => setState(() => _filter = value),
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.textSecondary,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _buildBookingCard(Map<String, dynamic> booking) {
    final statusColor = _getStatusColor(booking['status']);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
          ),
        ],
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              (booking['name'] as String)[0],
              style: TextStyle(
                color: statusColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
        title: Text(
          booking['name'],
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 2),
            Text(
              booking['service'],
              style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    (booking['status'] as String).toUpperCase(),
                    style: TextStyle(
                      fontSize: 10,
                      color: statusColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  booking['id'],
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                ),
              ],
            ),
          ],
        ),
        children: [
          const Divider(),
          _buildDetailRow(Icons.phone, 'Phone', booking['phone']),
          _buildDetailRow(Icons.location_on, 'Location', booking['location']),
          _buildDetailRow(Icons.calendar_today, 'Date', booking['date']),
          _buildDetailRow(Icons.access_time, 'Time', booking['time']),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.description, size: 18, color: AppColors.textSecondary),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    booking['description'],
                    style: const TextStyle(fontSize: 13, color: AppColors.textSecondary, height: 1.5),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Action Buttons
          if (booking['status'] == 'pending') ...[
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _updateStatus(booking, 'accepted'),
                    icon: const Icon(Icons.check, size: 18),
                    label: const Text('Accept'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.completed,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _updateStatus(booking, 'cancelled'),
                    icon: const Icon(Icons.close, size: 18),
                    label: const Text('Reject'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.error,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ] else if (booking['status'] == 'accepted') ...[
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _updateStatus(booking, 'in_progress'),
                icon: const Icon(Icons.play_arrow, size: 18),
                label: const Text('Mark as In Progress'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.inProgress,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ] else if (booking['status'] == 'in_progress') ...[
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _updateStatus(booking, 'completed'),
                icon: const Icon(Icons.check_circle, size: 18),
                label: const Text('Mark as Completed'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.completed,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],

          const SizedBox(height: 8),

          // WhatsApp Button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.chat_bubble_outline, size: 18),
              label: const Text('Contact on WhatsApp'),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF25D366),
                side: const BorderSide(color: Color(0xFF25D366)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColors.textSecondary),
          const SizedBox(width: 8),
          Text(
            '\$label: ',
            style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
