import 'package:brick_core/core.dart';
import 'package:brick_supabase/src/runtime_supabase_column_definition.dart';
import 'package:brick_supabase/src/supabase_model.dart';
import 'package:brick_supabase/src/supabase_provider.dart';

/// Constructors that convert app models to and from Supabase
abstract mixin class SupabaseAdapter<TModel extends SupabaseModel> implements Adapter<TModel> {
  /// Used for upserts; forwards to Supabase's `defaultToNull`
  bool get defaultToNull;

  /// A dictionary that connects field names to Supabase columns.
  Map<String, RuntimeSupabaseColumnDefinition> get fieldsToSupabaseColumns;

  /// Used for upserts; forwards to Supabase's `ignoreDuplicates`
  bool get ignoreDuplicates;

  /// Used for upserts; forwards to Supabase's `onConflict`
  String? get onConflict;

  /// Declared by the [SupabaseSerializable] `tableName` property
  String get tableName;

  /// Unique fields that map to Supabase columns (using [fieldsToSupabaseColumns])
  /// used to target upsert and delete operations.
  Set<String> get uniqueFields;

  Future<TModel> fromSupabase(
    Map<String, dynamic> input, {
    required SupabaseProvider provider,
    ModelRepository<SupabaseModel>? repository,
  });

  Future<Map<String, dynamic>> toSupabase(
    TModel input, {
    required SupabaseProvider provider,
    ModelRepository<SupabaseModel>? repository,
  });
}
