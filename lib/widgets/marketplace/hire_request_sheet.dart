import 'package:flutter/material.dart';
import 'package:zoko_marketplace/core/theme/zoko_colors.dart';
import 'package:zoko_marketplace/core/theme/zoko_theme.dart';
import 'package:zoko_marketplace/models/professional_model.dart';
import 'package:zoko_marketplace/services/hire_request_service.dart';

class HireRequestSheet extends StatefulWidget {
  const HireRequestSheet({super.key, required this.professional});

  final ProfessionalModel professional;

  @override
  State<HireRequestSheet> createState() => _HireRequestSheetState();
}

class _HireRequestSheetState extends State<HireRequestSheet> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _budgetController = TextEditingController();
  final _deadlineController = TextEditingController();
  final _hireRequestService = const HireRequestService();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _budgetController.dispose();
    _deadlineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardPadding = MediaQuery.viewInsetsOf(context).bottom;
    final themeColors = ZokoThemeColors.of(context);

    return Padding(
      padding: EdgeInsets.only(bottom: keyboardPadding),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 720),
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
        decoration: BoxDecoration(
          color: themeColors.canvas,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Request a hire',
                      style: TextStyle(
                        color: themeColors.text,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.close_rounded, color: themeColors.text),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                'Zoko admin will review this request, contact ${widget.professional.name}, confirm charges, and invoice you.',
                style: TextStyle(
                  color: themeColors.mutedText,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 20),
              _RequestField(
                controller: _titleController,
                label: 'Project title',
                icon: Icons.title_rounded,
              ),
              const SizedBox(height: 14),
              _RequestField(
                controller: _descriptionController,
                label: 'Describe the work',
                icon: Icons.notes_rounded,
                maxLines: 4,
              ),
              const SizedBox(height: 14),
              _RequestField(
                controller: _budgetController,
                label: 'Estimated budget',
                icon: Icons.payments_outlined,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 14),
              _RequestField(
                controller: _deadlineController,
                label: 'Preferred deadline',
                icon: Icons.event_available_rounded,
              ),
              const SizedBox(height: 14),
              const _PictureAttachmentBox(),
              const SizedBox(height: 22),
              FilledButton.icon(
                onPressed: _submitRequest,
                icon: const Icon(Icons.notifications_active_rounded),
                label: const Text('Notify Zoko admin'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitRequest() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _hireRequestService.createRequest(
      professional: widget.professional,
      projectTitle: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      budget: _budgetController.text.trim(),
      deadline: _deadlineController.text.trim(),
    );

    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Hire request sent to Zoko admin for review.'),
      ),
    );
  }
}

class _PictureAttachmentBox extends StatelessWidget {
  const _PictureAttachmentBox();

  @override
  Widget build(BuildContext context) {
    final themeColors = ZokoThemeColors.of(context);

    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Picture upload will be connected with file storage.'),
          ),
        );
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: themeColors.card,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: themeColors.border,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: ZokoColors.teal.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.add_photo_alternate_rounded,
                color: ZokoColors.teal,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Add reference pictures',
                    style: TextStyle(
                      color: themeColors.text,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Upload samples, sketches, screenshots, or inspiration.',
                    style: TextStyle(
                      color: themeColors.mutedText,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.upload_rounded, color: ZokoColors.green),
          ],
        ),
      ),
    );
  }
}

class _RequestField extends StatelessWidget {
  const _RequestField({
    required this.controller,
    required this.label,
    required this.icon,
    this.maxLines = 1,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String label;
  final IconData icon;
  final int maxLines;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    final themeColors = ZokoThemeColors.of(context);

    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: TextStyle(color: themeColors.text),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Required';
        }
        return null;
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: themeColors.card,
        labelText: label,
        labelStyle: TextStyle(color: themeColors.mutedText),
        prefixIcon: Icon(icon, color: ZokoColors.teal),
      ),
    );
  }
}
