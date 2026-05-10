import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class ManageCommentsScreen extends StatefulWidget {
  const ManageCommentsScreen({super.key});

  @override
  State<ManageCommentsScreen> createState() => _ManageCommentsScreenState();
}

class _ManageCommentsScreenState extends State<ManageCommentsScreen> {
  final List<Map<String, dynamic>> _comments = [
    {
      'id': '1',
      'project': 'Modern Living Room Makeover',
      'user': 'John Doe',
      'comment': 'This looks amazing! How much did it cost?',
      'approved': true,
      'reply': 'Thank you! It depends on the room size. Please contact us for a quote.',
      'date': '2 hours ago',
    },
    {
      'id': '2',
      'project': 'Security Gate Installation',
      'user': 'Sarah Smith',
      'comment': 'Great work on the gate. Very professional installation.',
      'approved': true,
      'reply': null,
      'date': '5 hours ago',
    },
    {
      'id': '3',
      'project': 'Bathroom Renovation',
      'user': 'Mike Johnson',
      'comment': 'Can you do this type of work in Ikorodu?',
      'approved': false,
      'reply': null,
      'date': '1 day ago',
    },
    {
      'id': '4',
      'project': 'Kitchen Remodeling',
      'user': 'Lisa Brown',
      'comment': 'Beautiful kitchen! Love the color scheme.',
      'approved': false,
      'reply': null,
      'date': '2 days ago',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Comments'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _comments.length,
        itemBuilder: (context, index) {
          return _buildCommentCard(_comments[index]);
        },
      ),
    );
  }

  Widget _buildCommentCard(Map<String, dynamic> comment) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: CircleAvatar(
              backgroundColor: AppColors.primary.withOpacity(0.1),
              child: Text(
                (comment['user'] as String)[0],
                style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
              ),
            ),
            title: Row(
              children: [
                Text(
                  comment['user'],
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: comment['approved'] 
                        ? AppColors.completed.withOpacity(0.1) 
                        : AppColors.pending.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    comment['approved'] ? 'Approved' : 'Pending',
                    style: TextStyle(
                      fontSize: 10,
                      color: comment['approved'] ? AppColors.completed : AppColors.pending,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  'On: \${comment['project']}',
                  style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                ),
                const SizedBox(height: 4),
                Text(
                  comment['date'],
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                ),
              ],
            ),
            trailing: PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'approve') {
                  setState(() => comment['approved'] = true);
                } else if (value == 'unapprove') {
                  setState(() => comment['approved'] = false);
                } else if (value == 'delete') {
                  setState(() => _comments.remove(comment));
                }
              },
              itemBuilder: (context) => [
                if (!comment['approved'])
                  const PopupMenuItem(value: 'approve', child: Row(children: [Icon(Icons.check, size: 18, color: AppColors.completed), SizedBox(width: 8), Text('Approve')])),
                if (comment['approved'])
                  const PopupMenuItem(value: 'unapprove', child: Row(children: [Icon(Icons.unpublished, size: 18), SizedBox(width: 8), Text('Unapprove')])),
                const PopupMenuItem(value: 'reply', child: Row(children: [Icon(Icons.reply, size: 18), SizedBox(width: 8), Text('Reply')])),
                const PopupMenuItem(value: 'delete', child: Row(children: [Icon(Icons.delete, size: 18, color: AppColors.error), SizedBox(width: 8), Text('Delete', style: TextStyle(color: AppColors.error))])),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    comment['comment'],
                    style: const TextStyle(color: AppColors.textSecondary, height: 1.5),
                  ),
                ),
                if (comment['reply'] != null) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.primary.withOpacity(0.1)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.reply, size: 16, color: AppColors.primary),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Reply: \${comment['reply']}',
                            style: TextStyle(
                              color: AppColors.primary.withOpacity(0.8),
                              fontSize: 13,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
