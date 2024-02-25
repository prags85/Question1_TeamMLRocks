import 'dart:math';
import 'package:scaven/Untitled-1.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ScavengerHuntApp());
}

class ScavengerHuntApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scavenger Hunt',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
      },
    );
  }
}

class LoginPage extends StatelessWidget {
  final List<String> preMadeUsers = ['user1', 'user2', 'user3']; // Pre-made users

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Perform login logic
            String randomUser = preMadeUsers[Random().nextInt(preMadeUsers.length)];
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TaskPage(user: randomUser),
              ),
            );
          },
          child: Text('Login'),
        ),
      ),
    );
  }
}


class TaskPage extends StatelessWidget {
  final String user;
  final Random random = Random();

  TaskPage({required this.user});

  List<String> tasks = [
 'Writing a formal email to a client.',
 'Creating a to-do list or schedule in a word processor or spreadsheet.',
 'Coding a simple program or script.',
 'Composing a blog post or article.',
 'Updating a social media status or profile.',
 'Conducting research online.',
 'Participating in an online discussion forum or chat.',
 'Sending a message through a messaging platform.',
 'Editing a document for grammar and style.',
' Writing a resume or cover letter.',
 'Creating a presentation using presentation software.',
 'Planning a trip and making reservations online.',
 'Taking notes during a meeting or lecture.',
 'Collaborating on a document with colleagues.',
 'Conducting an online survey or poll.',
 'Ordering food or groceries online.',
 'Managing finances through online banking or budgeting software.',
 'Writing a review for a product or service.',
 'Creating and managing a personal or professional website.',
 'Engaging in online learning through courses or tutorials.',
  ];

  @override
  Widget build(BuildContext context) {
    String task = tasks[random.nextInt(tasks.length)];
    return Scaffold(
      appBar: AppBar(
        title: Text('Scavenger Hunt'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome, $user!',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'Your task:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              task,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to task submission page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TaskSubmissionPage(task: task),
                  ),
                );
              },
              child: Text('Submit Task'),
            ),
          ],
        ),
      ),
    );
  }
}
class _HomePageState extends State<HomePage> {
  Database? _database;

  @override
  void initState() {
    super.initState();
    _openDatabase();
  }

  Future<void> _openDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'example.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE users(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
        );
      },
      version: 1,
    );
  }

  Future<void> _insertData() async {
    await _database!.insert(
      'users',
      {'name': 'John Doe', 'age': 30},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> _getUsers() async {
    return await _database!.query('users');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter SQLite Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                await _insertData();
              },
              child: Text('Insert Data'),
            ),
            ElevatedButton(
              onPressed: () async {
                List<Map<String, dynamic>> users = await _getUsers();
                print(users);
              },
              child: Text('Get Users'),
            ),
          ],
        ),
      ),
    );
  }
}


class TaskSubmissionPage extends StatelessWidget {
  final String task;

  TaskSubmissionPage({required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Submit Task'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Task: $task',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            // Text and image submission widgets can be added here
            // For simplicity, let's assume just text submission
            TextField(
              decoration: InputDecoration(
                labelText: 'Enter your submission',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement submission logic (saving to database, etc.)
                // For now, let's just navigate back to task page
                Navigator.pop(context);
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

