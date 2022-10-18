import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'entry.g.dart';

/// A single entry in the journal.
///
/// This class is used to represent a single entry in the journal.
/// It contains the title, body, and date of the entry.
/// It also contains a unique ID for the entry and a user ID for the user who
/// created the entry.
@immutable
@JsonSerializable()
class Entry extends Equatable {
  /// {@macro entry}
  const Entry({
    required this.id,
    required this.title,
    required this.body,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
  });

  /// fromJson constructor.
  factory Entry.fromJson(Map<String, dynamic> json) => _$EntryFromJson(json);

  /// The id of an Entry.
  ///
  /// Defaults to an empty string.
  final int id;

  /// The title of an Entry.
  ///
  /// Defaults to an empty string.
  final String title;

  /// The body of an Entry.
  ///
  /// Defaults to an empty string.
  final String body;

  /// The created date of an Entry.
  ///
  /// Defaults to an empty string.
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  /// The updated date of an Entry.
  ///
  /// Defaults to an empty string.
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  /// The user id of an Entry.
  ///
  /// Defaults to an empty string.
  @JsonKey(name: 'user_id')
  final String userId;

  @override
  List<Object?> get props => [id, title, body, createdAt, updatedAt, userId];

  /// toJson method.
  Map<String, dynamic> toJson() => _$EntryToJson(this);
}
