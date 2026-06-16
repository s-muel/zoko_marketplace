import 'package:flutter/material.dart';
import 'package:zoko_marketplace/core/theme/zoko_colors.dart';
import 'package:zoko_marketplace/widgets/shared/responsive_page.dart';

class PostJobScreen extends StatefulWidget {
  const PostJobScreen({super.key});

  static const routeName = '/post-job';

  @override
  State<PostJobScreen> createState() => _PostJobScreenState();
}

class _PostJobScreenState extends State<PostJobScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post a job'),
        backgroundColor: ZokoColors.canvas,
        foregroundColor: ZokoColors.navy,
        elevation: 0,
      ),
      body: SafeArea(
        child: ResponsivePage(
          maxWidth: 760,
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: ZokoColors.softGrey),
                    boxShadow: [
                      BoxShadow(
                        color: ZokoColors.navy.withValues(alpha: 0.08),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Tell professionals what you need',
                        style: TextStyle(
                          color: ZokoColors.navy,
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Your job will appear under Hot Jobs for matching professionals.',
                        style: TextStyle(
                          color: ZokoColors.textGrey,
                          fontWeight: FontWeight.w600,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 22),
                      const _PostJobField(
                        label: 'Job title',
                        hintText: 'Example: Design a logo for my new brand',
                      ),
                      const SizedBox(height: 14),
                      const _PostJobField(
                        label: 'Category',
                        hintText: 'Design, Tech, Home, Business...',
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: const [
                          Expanded(
                            child: _PostJobField(
                              label: 'Budget',
                              hintText: 'GHS 500',
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: _PostJobField(
                              label: 'Deadline',
                              hintText: '2 weeks',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      const _PostJobField(
                        label: 'Job description',
                        hintText:
                            'Describe the work, preferred style, timeline, and any files you can provide.',
                        maxLines: 5,
                      ),
                      const SizedBox(height: 22),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: _submit,
                          icon: const Icon(Icons.publish_rounded),
                          label: const Text('Post job'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: ZokoColors.canvas,
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Job posted for professionals to view.')),
    );
    Navigator.of(context).pop();
  }
}

class _PostJobField extends StatelessWidget {
  const _PostJobField({
    required this.label,
    required this.hintText,
    this.maxLines = 1,
  });

  final String label;
  final String hintText;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return '$label is required';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        filled: true,
        fillColor: ZokoColors.canvas,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: ZokoColors.softGrey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: ZokoColors.softGrey),
        ),
      ),
    );
  }
}
