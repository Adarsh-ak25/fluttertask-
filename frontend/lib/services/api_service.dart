import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/note.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:5000/api/notes';

  // GET all notes
  Future<List<Note>> getNotes() async {
    try {
      print('Fetching all notes from $baseUrl');
      final response = await http.get(Uri.parse(baseUrl));

      print('GET /api/notes - Status: ${response.statusCode}');

      if (response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(response.body);
        List<Note> notes = jsonList.map((json) => Note.fromJson(json)).toList();
        print('Fetched ${notes.length} notes');
        return notes;
      } else {
        throw Exception('Failed to load notes: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching notes: $e');
      throw Exception('Error fetching notes: $e');
    }
  }

  // POST create a new note
  Future<Note> createNote(String title, String content) async {
    try {
      print('Creating new note: $title');
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'title': title,
          'content': content,
        }),
      );

      print('POST /api/notes - Status: ${response.statusCode}');

      if (response.statusCode == 201) {
        final note = Note.fromJson(json.decode(response.body));
        print('Note created with ID: ${note.id}');
        return note;
      } else {
        throw Exception('Failed to create note: ${response.statusCode}');
      }
    } catch (e) {
      print('Error creating note: $e');
      throw Exception('Error creating note: $e');
    }
  }

  // PUT update a note
  Future<Note> updateNote(String id, String title, String content) async {
    try {
      print('Updating note with ID: $id');
      final response = await http.put(
        Uri.parse('$baseUrl/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'title': title,
          'content': content,
        }),
      );

      print('PUT /api/notes/$id - Status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final note = Note.fromJson(json.decode(response.body));
        print('Note updated: ${note.title}');
        return note;
      } else if (response.statusCode == 404) {
        throw Exception('Note not found');
      } else {
        throw Exception('Failed to update note: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating note: $e');
      throw Exception('Error updating note: $e');
    }
  }

  // DELETE a note
  Future<void> deleteNote(String id) async {
    try {
      print('Deleting note with ID: $id');
      final response = await http.delete(Uri.parse('$baseUrl/$id'));

      print('DELETE /api/notes/$id - Status: ${response.statusCode}');

      if (response.statusCode == 200) {
        print('Note deleted successfully');
      } else if (response.statusCode == 404) {
        throw Exception('Note not found');
      } else {
        throw Exception('Failed to delete note: ${response.statusCode}');
      }
    } catch (e) {
      print('Error deleting note: $e');
      throw Exception('Error deleting note: $e');
    }
  }
}