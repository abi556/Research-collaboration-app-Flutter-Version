import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/providers/project_providers.dart';
import '../../domain/entities/project.dart';
import '../../core/error/failures.dart';
import 'package:research_collaboration_app/features/professor/dashboard/providers/dashboard_providers.dart';

class ProfessorCreateProjectScreen extends ConsumerStatefulWidget {
  const ProfessorCreateProjectScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfessorCreateProjectScreen> createState() => _ProfessorCreateProjectScreenState();
}

class _ProfessorCreateProjectScreenState extends ConsumerState<ProfessorCreateProjectScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _requirementController = TextEditingController();
  final List<String> _requirements = [];

  DateTime? _startDate;
  DateTime? _endDate;
  DateTime? _deadline;

  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _deadlineController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _requirementController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _deadlineController.dispose();
    super.dispose();
  }

  Future<void> _pickDate(TextEditingController controller, void Function(DateTime) onPicked) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      controller.text = picked.toIso8601String().split('T').first; // yyyy-MM-dd for display
      onPicked(picked);
    }
  }

  bool _validateForm() {
    if (_titleController.text.trim().isEmpty ||
        _descriptionController.text.trim().isEmpty ||
        _requirements.isEmpty ||
        _startDate == null ||
        _endDate == null ||
        _deadline == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields and add at least one requirement.')),
      );
      return false;
    }
    return true;
  }

  Future<void> _createProject() async {
    if (!_validateForm()) return;
    setState(() => _isLoading = true);
    try {
      final project = Project(
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        requirements: _requirements,
        startDate: _startDate!.toUtc().toIso8601String(),
        endDate: _endDate!.toUtc().toIso8601String(),
        deadline: _deadline!.toUtc().toIso8601String(),
        professorId: 1, // TODO: Replace with actual professorId
      );
      await ref.read(createProjectProvider).call(project);
      ref.invalidate(professorProjectsProvider);
      if (mounted) {
        Navigator.of(context).pop(true); // Optionally pass true for success
      }
    } catch (e) {
      String errorMsg;
      if (e is ServerFailure && e.message != null) {
        errorMsg = e.message!;
      } else {
        errorMsg = e.toString();
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create project: $errorMsg')),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          children: [
            Image.asset('assets/images/collabrix_logo.png', height: 32, width: 32, errorBuilder: (_, __, ___) => const Icon(Icons.science)),
            const SizedBox(width: 8),
            const Text('Collabrix', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Icon(Icons.science, color: Colors.black, size: 24),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Create New Research Project', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 4),
                const Text('Post a new Research opportunity for students', style: TextStyle(fontSize: 14)),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Project  Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 2),
                      const Text('Basic information about your reasearch project', style: TextStyle(fontSize: 13)),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _titleController,
                        decoration: const InputDecoration(
                          hintText: 'Enter a descriptive  Project title',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        ),
                      ),
                      const SizedBox(height: 18),
                      const Text('Project Description', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      TextField(
                        controller: _descriptionController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          hintText: 'provide a detailed description of the research project , its goals and expected outcomes',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        ),
                      ),
                      const SizedBox(height: 18),
                      const Text('Requirements', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _requirementController,
                              decoration: const InputDecoration(
                                hintText: 'Add a requirement',
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                              ),
                              onSubmitted: (value) {
                                final trimmed = value.trim();
                                if (trimmed.isNotEmpty && !_requirements.contains(trimmed)) {
                                  setState(() {
                                    _requirements.add(trimmed);
                                    _requirementController.clear();
                                  });
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            onPressed: () {
                              final trimmed = _requirementController.text.trim();
                              if (trimmed.isNotEmpty && !_requirements.contains(trimmed)) {
                                setState(() {
                                  _requirements.add(trimmed);
                                  _requirementController.clear();
                                });
                              }
                            },
                            child: const Text('Add'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: _requirements.map((req) => Chip(
                          label: Text(req),
                          onDeleted: () {
                            setState(() {
                              _requirements.remove(req);
                            });
                          },
                        )).toList(),
                      ),
                      const SizedBox(height: 18),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Start date', style: TextStyle(fontWeight: FontWeight.bold)),
                                const SizedBox(height: 6),
                                TextField(
                                  controller: _startDateController,
                                  readOnly: true,
                                  onTap: () => _pickDate(_startDateController, (picked) => setState(() => _startDate = picked)),
                                  decoration: const InputDecoration(
                                    hintText: 'yyyy-MM-dd',
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                    suffixIcon: Icon(Icons.calendar_today),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('End date', style: TextStyle(fontWeight: FontWeight.bold)),
                                const SizedBox(height: 6),
                                TextField(
                                  controller: _endDateController,
                                  readOnly: true,
                                  onTap: () => _pickDate(_endDateController, (picked) => setState(() => _endDate = picked)),
                                  decoration: const InputDecoration(
                                    hintText: 'yyyy-MM-dd',
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                    suffixIcon: Icon(Icons.calendar_today),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      const Text('Application Deadline', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      TextField(
                        controller: _deadlineController,
                        readOnly: true,
                        onTap: () => _pickDate(_deadlineController, (picked) => setState(() => _deadline = picked)),
                        decoration: const InputDecoration(
                          hintText: 'yyyy-MM-dd',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          suffixIcon: Icon(Icons.calendar_today),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: _isLoading ? null : _createProject,
                    child: const Text('Create', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.1),
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
} 