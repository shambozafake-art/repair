import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_text_field.dart';

class AddProjectScreen extends StatefulWidget {
  const AddProjectScreen({super.key});

  @override
  State<AddProjectScreen> createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();

  String? _selectedService;
  DateTime? _dateCompleted;
  bool _isPublishing = false;

  final List<String> _services = [
    'House Decoration',
    'Interior Decoration',
    'Gate Fixing',
    'Gate Installation',
    'Welding Repairs',
    'Shower Installation',
    'Bathroom Fittings',
    'Plumbing Repairs',
    'Painting',
    'Tiling',
    'Ceiling Repairs',
    'General Maintenance',
  ];

  Future<void> _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (date != null) setState(() => _dateCompleted = date);
  }

  Future<void> _submit({bool publish = false}) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isPublishing = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isPublishing = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(publish ? 'Project published!' : 'Project saved as draft!')),
      );
      context.go('/admin/projects');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Project'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Upload Section
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border, style: BorderStyle.dashed),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _buildImageUpload('Before Photo'),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildImageUpload('After Photo'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildImageUpload('Additional Photos (Optional)'),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Project Details
              CustomTextField(
                label: 'Project Title *',
                hint: 'e.g. Modern Living Room Makeover',
                controller: _titleController,
                validator: (v) => v?.isEmpty ?? true ? 'Title is required' : null,
              ),
              const SizedBox(height: 16),

              CustomTextField(
                label: 'Description *',
                hint: 'Describe the work done...',
                controller: _descriptionController,
                maxLines: 4,
                validator: (v) => v?.isEmpty ?? true ? 'Description is required' : null,
              ),
              const SizedBox(height: 16),

              // Service Type
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Service Type *',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.border),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedService,
                        isExpanded: true,
                        hint: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text('Select service type'),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        items: _services.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                        onChanged: (v) => setState(() => _selectedService = v),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              CustomTextField(
                label: 'Location *',
                hint: 'e.g. Lekki, Lagos',
                controller: _locationController,
                validator: (v) => v?.isEmpty ?? true ? 'Location is required' : null,
              ),

              const SizedBox(height: 16),

              // Date Completed
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date Completed *',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: _selectDate,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.border),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_today, color: AppColors.textSecondary),
                          const SizedBox(width: 12),
                          Text(
                            _dateCompleted != null
                                ? DateFormat('MMM d, yyyy').format(_dateCompleted!)
                                : 'Select date',
                            style: TextStyle(
                              color: _dateCompleted != null ? AppColors.textPrimary : AppColors.textSecondary.withOpacity(0.6),
                            ),
                          ),
                          const Spacer(),
                          const Icon(Icons.arrow_drop_down, color: AppColors.textSecondary),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Materials Used
              CustomTextField(
                label: 'Materials Used (Optional)',
                hint: 'e.g. Premium Paint, LED Lights, Ceramic Tiles',
              ),

              const SizedBox(height: 32),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: 'Save as Draft',
                      onPressed: () => _submit(publish: false),
                      isOutlined: true,
                      isLoading: _isPublishing,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomButton(
                      text: 'Publish',
                      onPressed: () => _submit(publish: true),
                      isLoading: _isPublishing,
                      icon: Icons.publish,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageUpload(String label) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border, style: BorderStyle.dashed),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.cloud_upload_outlined, size: 32, color: AppColors.primary.withOpacity(0.5)),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(fontSize: 12, color: AppColors.textSecondary.withOpacity(0.7)),
          ),
        ],
      ),
    );
  }
}
