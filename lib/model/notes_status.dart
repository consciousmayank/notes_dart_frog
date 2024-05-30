enum NotesStatus {
  toDo,
  inProgress,
  paused,
  completed,
  none;
  

  String getName() => switch (name) {
  NotesStatus.toDo => 'to-do',
  NotesStatus.inProgress => 'in-progress',
  NotesStatus.paused => 'paused',
  NotesStatus.completed => 'completed',
  _ => 'none', // Underscore (_) represents the default case
};
}
