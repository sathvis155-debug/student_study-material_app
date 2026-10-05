import 'package:flutter/material.dart';

void main() {
  runApp(const StudentStudyMaterialApp());
}

class StudentStudyMaterialApp extends StatelessWidget {
  const StudentStudyMaterialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Study Material App',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFFF5F7FB),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

// -------------------- DATA MODEL --------------------

class StudyMaterial {
  final String title;
  final String subject;
  final String description;
  final String icon;

  StudyMaterial({
    required this.title,
    required this.subject,
    required this.description,
    required this.icon,
  });
}

// -------------------- SAMPLE DATA --------------------

final List<StudyMaterial> materials = [
  StudyMaterial(
    title: 'Introduction to Programming',
    subject: 'Computer Science',
    description:
        'Learn the basics of programming, algorithms, variables, loops and functions.',
    icon: '💻',
  ),
  StudyMaterial(
    title: 'Data Structures',
    subject: 'Computer Science',
    description:
        'Study arrays, linked lists, stacks, queues, trees and graphs.',
    icon: '🧑‍💻',
  ),
  StudyMaterial(
    title: 'Mathematics - Algebra',
    subject: 'Mathematics',
    description:
        'Important algebra concepts including equations, expressions and formulas.',
    icon: '📐',
  ),
  StudyMaterial(
    title: 'Physics - Mechanics',
    subject: 'Physics',
    description:
        'Learn motion, force, energy, momentum and Newton’s laws.',
    icon: '⚛️',
  ),
  StudyMaterial(
    title: 'Organic Chemistry',
    subject: 'Chemistry',
    description:
        'Introduction to hydrocarbons, functional groups and organic reactions.',
    icon: '🧪',
  ),
  StudyMaterial(
    title: 'English Grammar',
    subject: 'English',
    description:
        'Improve grammar skills with nouns, verbs, tenses and sentence structure.',
    icon: '📖',
  ),
];

// -------------------- HOME PAGE --------------------

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  String searchText = '';

  List<StudyMaterial> get filteredMaterials {
    if (searchText.isEmpty) {
      return materials;
    }

    return materials.where((material) {
      return material.title.toLowerCase().contains(
                searchText.toLowerCase(),
              ) ||
          material.subject.toLowerCase().contains(
                searchText.toLowerCase(),
              );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        title: const Text(
          'Student Study Material',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('No new notifications'),
                ),
              );
            },
          ),
        ],
      ),

      // -------------------- BODY --------------------

      body: selectedIndex == 0
          ? buildHome()
          : selectedIndex == 1
              ? buildSubjects()
              : buildProfile(),

      // -------------------- BOTTOM NAVIGATION --------------------

      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book),
            label: 'Subjects',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  // -------------------- HOME --------------------

  Widget buildHome() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Hello, Student! 👋',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          const Text(
            'What would you like to study today?',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15,
            ),
          ),

          const SizedBox(height: 20),

          // Search box
          TextField(
            onChanged: (value) {
              setState(() {
                searchText = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Search study materials...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 25),

          // Progress Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Colors.indigo,
                  Colors.deepPurple,
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Learning Progress',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15),
                LinearProgressIndicator(
                  value: 0.65,
                  backgroundColor: Colors.white30,
                  color: Colors.white,
                ),
                SizedBox(height: 10),
                Text(
                  '65% completed',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          const Text(
            'Study Materials',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          filteredMaterials.isEmpty
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Text(
                      'No study materials found.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredMaterials.length,
                  itemBuilder: (context, index) {
                    final material = filteredMaterials[index];

                    return buildMaterialCard(material);
                  },
                ),
        ],
      ),
    );
  }

  // -------------------- MATERIAL CARD --------------------

  Widget buildMaterialCard(StudyMaterial material) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(15),

        leading: CircleAvatar(
          radius: 28,
          backgroundColor: Colors.indigo.shade50,
          child: Text(
            material.icon,
            style: const TextStyle(fontSize: 25),
          ),
        ),

        title: Text(
          material.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),

        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(
            material.subject,
            style: TextStyle(
              color: Colors.indigo.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
        ),

        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MaterialDetailPage(
                material: material,
              ),
            ),
          );
        },
      ),
    );
  }

  // -------------------- SUBJECTS --------------------

  Widget buildSubjects() {
    final subjects = [
      ['Computer Science', '💻', Colors.blue],
      ['Mathematics', '📐', Colors.orange],
      ['Physics', '⚛️', Colors.purple],
      ['Chemistry', '🧪', Colors.green],
      ['English', '📖', Colors.red],
    ];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Subjects',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          Expanded(
            child: GridView.builder(
              itemCount: subjects.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 1.1,
              ),
              itemBuilder: (context, index) {
                final subject = subjects[index];

                return Card(
                  elevation: 2,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${subject[0]} selected',
                          ),
                        ),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          subject[1] as String,
                          style: const TextStyle(fontSize: 40),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          subject[0] as String,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // -------------------- PROFILE --------------------

  Widget buildProfile() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 55,
            backgroundColor: Colors.indigo,
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: 60,
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            'Student Profile',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Keep learning and keep growing! 📚',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 25),

          ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Profile editing coming soon!'),
                ),
              );
            },
            icon: const Icon(Icons.edit),
            label: const Text('Edit Profile'),
          ),
        ],
      ),
    );
  }
}

// -------------------- DETAIL PAGE --------------------

class MaterialDetailPage extends StatelessWidget {
  final StudyMaterial material;

  const MaterialDetailPage({
    super.key,
    required this.material,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Study Material'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                material.icon,
                style: const TextStyle(fontSize: 80),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              material.title,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 7,
              ),
              decoration: BoxDecoration(
                color: Colors.indigo.shade50,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                material.subject,
                style: TextStyle(
                  color: Colors.indigo.shade700,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Description',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              material.description,
              style: const TextStyle(
                fontSize: 16,
                height: 1.6,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Study material opened successfully!',
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.menu_book),
                label: const Text(
                  'Start Studying',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
