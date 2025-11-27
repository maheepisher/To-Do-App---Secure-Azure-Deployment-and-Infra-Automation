const express = require('express');
const bodyParser = require('body-parser');
const path = require('path');
const app = express();
const PORT = process.env.PORT || 8080;

app.use(bodyParser.json());
app.use(express.static(path.join(__dirname, 'public')));

let todos = [
  { id: 1, text: 'Sample task', done: false }
];

app.get('/api/todos', (req, res) => {
  res.json(todos);
});

app.post('/api/todos', (req, res) => {
  const { text } = req.body;
  if (!text) return res.status(400).json({ error: 'text is required' });
  const newTodo = { id: Date.now(), text, done: false };
  todos.push(newTodo);
  res.json(newTodo);
});

app.post('/api/todos/:id/toggle', (req, res) => {
  const id = Number(req.params.id);
  const t = todos.find(x => x.id === id);
  if (!t) return res.status(404).json({ error: 'not found' });
  t.done = !t.done;
  res.json(t);
});

app.listen(PORT, () => {
  console.log(`To-Do sample app listening on port ${PORT}`);
});
