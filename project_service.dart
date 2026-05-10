import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/project_model.dart';
import 'supabase_service.dart';

class ProjectService {
  static final _table = SupabaseService.client.from('projects');

  static Future<List<ProjectModel>> getAllProjects({bool onlyPublished = true}) async {
    var query = _table.select();
    if (onlyPublished) {
      query = query.eq('is_published', true);
    }
    final response = await query.order('created_at', ascending: false);
    return (response as List).map((json) => ProjectModel.fromJson(json)).toList();
  }

  static Future<ProjectModel?> getProjectById(String id) async {
    final response = await _table.select().eq('id', id).single();
    return response != null ? ProjectModel.fromJson(response) : null;
  }

  static Future<ProjectModel> createProject(ProjectModel project) async {
    final response = await _table.insert(project.toJson()).select().single();
    return ProjectModel.fromJson(response);
  }

  static Future<void> updateProject(ProjectModel project) async {
    await _table.update(project.toJson()).eq('id', project.id);
  }

  static Future<void> deleteProject(String id) async {
    await _table.delete().eq('id', id);
  }

  static Future<void> togglePublishStatus(String id, bool isPublished) async {
    await _table.update({'is_published': isPublished}).eq('id', id);
  }

  static Future<int> getProjectsCount() async {
    final response = await _table.select('id').count();
    return response.count ?? 0;
  }
}
