const express = require('express');
const cors = require('cors');
const { v4: uuidv4 } = require('uuid');

const app = express();
const PORT = 5000;

// Middleware
app.use(cors());
app.use(express.json());

// In-memory storage for notes
let notes = [];

// GET /api/notes - Read all notes
app.get('/api/notes', (req, res) => {
  console.log('GET /api/notes - Fetching all notes');
  console.log(`Total notes: ${notes.length}`);
  res.json(notes);
});

// POST /api/notes - Create a new note
app.post('/api/notes', (req, res) => {
  const { title, content } = req.body;
  
  console.log('POST /api/notes - Creating new note');
  console.log(`Title: ${title}`);
  
  const newNote = {
    id: uuidv4(),
    title: title || 'Untitled',
    content: content || '',
    timestamp: new Date().toISOString()
  };
  
  notes.push(newNote);
  console.log(`Note created with ID: ${newNote.id}`);
  
  res.status(201).json(newNote);
});

// PUT /api/notes/:id - Update a note
app.put('/api/notes/:id', (req, res) => {
  const { id } = req.params;
  const { title, content } = req.body;
  
  console.log(`PUT /api/notes/${id} - Updating note`);
  
  const noteIndex = notes.findIndex(note => note.id === id);
  
  if (noteIndex === -1) {
    console.log(`Note with ID ${id} not found`);
    return res.status(404).json({ error: 'Note not found' });
  }
  
  notes[noteIndex] = {
    ...notes[noteIndex],
    title: title || notes[noteIndex].title,
    content: content || notes[noteIndex].content,
    timestamp: new Date().toISOString()
  };
  
  console.log(`Note updated: ${notes[noteIndex].title}`);
  res.json(notes[noteIndex]);
});

// DELETE /api/notes/:id - Delete a note
app.delete('/api/notes/:id', (req, res) => {
  const { id } = req.params;
  
  console.log(`DELETE /api/notes/${id} - Deleting note`);
  
  const noteIndex = notes.findIndex(note => note.id === id);
  
  if (noteIndex === -1) {
    console.log(`Note with ID ${id} not found`);
    return res.status(404).json({ error: 'Note not found' });
  }
  
  const deletedNote = notes.splice(noteIndex, 1)[0];
  console.log(`Note deleted: ${deletedNote.title}`);
  
  res.json({ message: 'Note deleted successfully', note: deletedNote });
});

// Start server
app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
  console.log('Notes API ready to accept requests');
});