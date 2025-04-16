import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amandeep Thakur | Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF0A84FF),
        colorScheme: ColorScheme.dark(
          primary: const Color(0xFF0A84FF),
          secondary: const Color(0xFF64D2FF),
          background: const Color(0xFF121212),
        ),
        scaffoldBackgroundColor: const Color(0xFF121212),
        fontFamily: GoogleFonts.poppins().fontFamily,
        textTheme: TextTheme(
          displayLarge: const TextStyle(
            fontSize: 72.0,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: GoogleFonts.poppins(
            fontSize: 30.0,
            fontWeight: FontWeight.w600,
          ),
          bodyLarge: GoogleFonts.poppins(
            fontSize: 18.0,
          ),
          bodyMedium: GoogleFonts.poppins(
            fontSize: 16.0,
          ),
        ),
      ),
      home: const PortfolioHomePage(),
    );
  }
}

class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({Key? key}) : super(key: key);

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  final ScrollController _scrollController = ScrollController();
  int _currentSection = 0;
  final List<String> _sections = ['Home', 'About', 'Experience', 'Skills', 'Projects', 'Education', 'Contact'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: kIsWeb && MediaQuery.of(context).size.width > 800
            ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _sections.map((section) {
            int index = _sections.indexOf(section);
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    _currentSection = index;
                  });
                },
                child: Text(
                  section,
                  style: TextStyle(
                    color: _currentSection == index
                        ? Theme.of(context).colorScheme.secondary
                        : Colors.white,
                    fontWeight: _currentSection == index
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
            );
          }).toList(),
        )
            : null,
      ),
      drawer: kIsWeb && MediaQuery.of(context).size.width <= 800
          ? Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: const Text(
                'Amandeep Thakur',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ..._sections.map((section) {
              int index = _sections.indexOf(section);
              return ListTile(
                title: Text(section),
                selected: _currentSection == index,
                onTap: () {
                  setState(() {
                    _currentSection = index;
                    Navigator.pop(context);
                  });
                },
              );
            }).toList(),
          ],
        ),
      )
          : null,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            _buildHeroSection(),
            _buildAboutSection(),
            _buildExperienceSection(),
            _buildSkillsSection(),
            _buildProjectsSection(),
            _buildEducationSection(),
            _buildContactSection(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final Uri emailLaunchUri = Uri(
            scheme: 'mailto',
            path: 'aman914501@gmail.com',
            queryParameters: {'subject': 'Contact from Portfolio Website'},
          );
          await launchUrl(emailLaunchUri);
        },
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: const Icon(Icons.email),
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF121212),
            Theme.of(context).primaryColor.withOpacity(0.4),
            const Color(0xFF121212),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 75,
            backgroundColor: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
            child: Text(
              'AT',
              style: TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          const SizedBox(height: 30),
          Text(
            'Amandeep Thakur',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: 42,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  color: Theme.of(context).primaryColor.withOpacity(0.5),
                  blurRadius: 10,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                'Software Engineer',
                textStyle: TextStyle(
                  fontSize: 24,
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.w500,
                ),
                speed: const Duration(milliseconds: 100),
              ),
            ],
            totalRepeatCount: 1,
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialButton(
                icon: Icons.code,
                url: 'https://github.com/amandeepthakur',
              ),
              _buildSocialButton(
                icon: Icons.business_center,
                url: 'https://linkedin.com/in/amandeepthakur0001',
              ),
              _buildSocialButton(
                icon: Icons.web,
                url: 'https://amandeepthakur.github.io/portfolio/',
              ),
            ],
          ),
          const SizedBox(height: 80),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                _scrollController.animateTo(
                  MediaQuery.of(context).size.height,
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeInOut,
                );
              },
              child: const Icon(
                Icons.keyboard_arrow_down,
                size: 40,
                color: Colors.white70,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton({required IconData icon, required String url}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: ElevatedButton(
        onPressed: () async {
          if (await canLaunchUrl(Uri.parse(url))) {
            await launchUrl(Uri.parse(url));
          }
        },
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(20),
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.7),
        ),
        child: Icon(icon, size: 30),
      ),
    );
  }

  Widget _buildAboutSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 80.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('About Me'),
          const SizedBox(height: 30),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (MediaQuery.of(context).size.width > 800)
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).primaryColor.withOpacity(0.7),
                          Theme.of(context).colorScheme.secondary.withOpacity(0.7),
                        ],
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.person,
                        size: 120,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ),
              if (MediaQuery.of(context).size.width > 800)
                const SizedBox(width: 40),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Software Engineer specializing in Flutter Development',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Detail-oriented, organized, and meticulous. Works at a fast pace to meet tight deadlines. Enthusiastic team player ready to contribute to company success.',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        _buildInfoItem(Icons.location_on, 'Ludhiana 141016, India'),
                        const SizedBox(width: 20),
                        _buildInfoItem(Icons.email, 'aman914501@gmail.com'),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        _buildInfoItem(Icons.phone, '+91 7009004695'),
                      ],
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Add download resume functionality
                      },
                      icon: const Icon(Icons.download),
                      label: const Text('Download Resume'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          color: Theme.of(context).colorScheme.secondary,
          size: 20,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _buildExperienceSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 80.0),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Experience'),
          const SizedBox(height: 30),
          _buildExperienceItem(
            company: 'NowFloats',
            position: 'Software Engineer [Flutter Developer]',
            duration: '06/2023 - Present',
            location: 'Hyderabad, India',
            responsibilities: [
              'Translating mobile app Zadinga features into a responsive and user-friendly desktop/web interface, enhancing cross-platform accessibility using FLUTTER framework.',
              'Managing Single Codebase for mobile & Desktop/Web with best coding practices & referring Figma Designs for UI.',
              'Collaborated closely with design and mobile development teams to ensure alignment with UI/UX and features.',
            ],
          ),
          const SizedBox(height: 40),
          _buildExperienceItem(
            company: 'Highradius',
            position: 'Software Engineer Trainee',
            duration: '01/2022 - 04/2022',
            location: '',
            responsibilities: [
              'Created AI Enabled Fintech B2B Cloud Application.',
              'Learnt Web Technologies(HTML, CSS, Javascript) & AI/ML.',
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceItem({
    required String company,
    required String position,
    required String duration,
    required String location,
    required List<String> responsibilities,
  }) {
    return Container(
      padding: const EdgeInsets.all(30),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            Colors.black.withOpacity(0.7),
            const Color(0xFF242424).withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                position,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 24,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  duration,
                  style: const TextStyle(
                    color: Colors.white70,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            company,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: 20,
            ),
          ),
          if (location.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              location,
              style: const TextStyle(
                color: Colors.white70,
              ),
            ),
          ],
          const SizedBox(height: 20),
          ...responsibilities.map((responsibility) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.arrow_right,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 24,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      responsibility,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildSkillsSection() {
    final List<Map<String, dynamic>> skills = [
      {'name': 'Flutter', 'level': 0.9},
      {'name': 'Dart', 'level': 0.9},
      {'name': 'Python', 'level': 0.8},
      {'name': 'C/C++', 'level': 0.8},
      {'name': 'Machine Learning', 'level': 0.7},
      {'name': 'SQL', 'level': 0.75},
      {'name': 'HTML/CSS', 'level': 0.7},
      {'name': 'Kotlin', 'level': 0.7},
      {'name': 'Android', 'level': 0.7},
      {'name': 'DSA', 'level': 0.8},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 80.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Skills'),
          const SizedBox(height: 50),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(context).size.width > 800 ? 3 : 1,
              childAspectRatio: 3.0,
              crossAxisSpacing: 30,
              mainAxisSpacing: 30,
            ),
            itemCount: skills.length,
            itemBuilder: (context, index) {
              return _buildSkillItem(
                skills[index]['name'],
                skills[index]['level'],
              );
            },
          ),
          const SizedBox(height: 60),
          Text(
            'Other Skills',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 30),
          Wrap(
            spacing: 15,
            runSpacing: 15,
            children: [
              'NumPy',
              'Pandas',
              'NLTK',
              'Scikit-Learn',
              'MS-Excel',
              'Tableau',
              'R',
              'Interpersonal Skill',
              'Self-Determined',
              'Time Management',
            ].map((skill) => _buildChip(skill)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillItem(String name, double level) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: [
            Colors.black.withOpacity(0.7),
            const Color(0xFF242424).withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 15),
          LinearProgressIndicator(
            value: level,
            backgroundColor: Colors.grey[800],
            valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).colorScheme.secondary,
            ),
            minHeight: 10,
            borderRadius: BorderRadius.circular(10),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Theme.of(context).primaryColor.withOpacity(0.3),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildProjectsSection() {
    final List<Map<String, dynamic>> projects = [
      {
        'title': 'Alzheimer\'s Disease Detection using ML',
        'duration': '02/2023 - 04/2023',
        'description':
        'Developed an AI model to classify Alzheimer\'s disease based on MRI images using Python, numpy, sklearn, matplotlib, etc library. Created a user-friendly web interface using Streamlit. Achieved high accuracy of average 98% using SVM & KNN.',
        'image': 'alzheimer',
        'url': '#',
      },
      {
        'title': 'Movie Recommendation System',
        'duration': '02/2023 - 03/2023',
        'description':
        'Used TMDB dataset and API call to request movie poster. Implemented in Python using various libraries such as Pandas, NumPy, NLTK, and Scikit-learn.',
        'image': 'movie',
        'url': 'https://aman-movie-recommender.streamlit.app/',
      },
      {
        'title': 'My Chat Bot',
        'duration': '11/2022',
        'description': 'Used KOTLIN & Implemented Text-to-Speech in it.',
        'image': 'chatbot',
        'url': '#',
      },
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 80.0),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Projects'),
          const SizedBox(height: 30),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(context).size.width > 800 ? 3 : 1,
              childAspectRatio: MediaQuery.of(context).size.width > 800 ? 0.8 : 1.2,
              crossAxisSpacing: 30,
              mainAxisSpacing: 30,
            ),
            itemCount: projects.length,
            itemBuilder: (context, index) {
              return _buildProjectItem(
                title: projects[index]['title'],
                duration: projects[index]['duration'],
                description: projects[index]['description'],
                image: projects[index]['image'],
                url: projects[index]['url'],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProjectItem({
    required String title,
    required String duration,
    required String description,
    required String image,
    required String url,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            Colors.black.withOpacity(0.7),
            const Color(0xFF242424).withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor.withOpacity(0.7),
                    Theme.of(context).colorScheme.secondary.withOpacity(0.7),
                  ],
                ),
              ),
              child: Center(
                child: Icon(
                  image == 'alzheimer'
                      ? Icons.health_and_safety
                      : image == 'movie'
                      ? Icons.movie
                      : Icons.chat,
                  size: 80,
                  color: Colors.white70,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    duration,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Text(
                      description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                    ),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () async {
                      if (url != '#' && await canLaunchUrl(Uri.parse(url))) {
                        await launchUrl(Uri.parse(url));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text('View Project'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEducationSection() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 80.0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    _buildSectionTitle('Education'),
    const SizedBox(height: 30),
    _buildEducationItem(
    degree: 'B. Tech CSE',
    institution: 'Lovely Professional University',
    duration: '07/2019 - 07/2023',
    grade: 'CGPA 8.28',
    ),
    const SizedBox(height: 40),
    _buildEducationItem(
    degree: 'Senior Secondary',
    institution: 'S.G.N International School',
    duration: '03/2018 - 03/2019',
    grade: 'Score 87.6%',
    ),
    const SizedBox(height: 60),
    Text(
    'Achievements',
    style: Theme.of(context).textTheme.titleLarge,
    ),
    const SizedBox(height: 30),
    _buildAchievementItem(
    title: 'Dean\'s List',
    description: 'In the Dean\'s List (i.e among TOP 10% Students in Lovely Professional University)',
    ),
    const SizedBox(height: 20),
    _buildAchievementItem(
    title: '10th Grades (03/2016 - 03/2017)',
    description: 'Got 10 CGPA in 10th grade',
    ),
    const SizedBox(height: 60),
    Text(
    'Certificates',
    style: Theme.of(context).textTheme.titleLarge,
    ),
    const SizedBox(height: 30),
    GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: MediaQuery.of(context).size.width > 800 ? 3 : 1,
    childAspectRatio: 1.5,
    crossAxisSpacing: 30,
    mainAxisSpacing: 30,
    ),
    itemCount: 3,
    itemBuilder: (context, index) {
    final List<Map<String, String>> certificates = [
    {
    'title': 'Machine Learning Specialization',
    'date': '11/2022',
    },
  {
    'title': 'Highway to HighRadius Internship Program',
  'date': '01/2022 - 04/2022',
  },
      {
        'title': 'Data Structures & Algorithms [DSA self paced- GFG]',
        'date': '06/2021 - 08/2021',
      },
    ];
    return _buildCertificateItem(
      title: certificates[index]['title']!,
      date: certificates[index]['date']!,
    );
    },
    ),
    ],
    ),
    );
  }

  Widget _buildEducationItem({
    required String degree,
    required String institution,
    required String duration,
    required String grade,
  }) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            Colors.black.withOpacity(0.7),
            const Color(0xFF242424).withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).primaryColor.withOpacity(0.2),
            ),
            child: Icon(
              Icons.school,
              size: 40,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          const SizedBox(width: 30),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  degree,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  institution,
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Chip(
                      label: Text(duration),
                      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
                      side: BorderSide.none,
                    ),
                    const SizedBox(width: 10),
                    Chip(
                      label: Text(grade),
                      backgroundColor: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                      side: BorderSide.none,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementItem({
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        border: Border.all(
          color: Theme.of(context).primaryColor.withOpacity(0.2),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.emoji_events,
            color: Theme.of(context).colorScheme.secondary,
            size: 30,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: const TextStyle(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCertificateItem({
    required String title,
    required String date,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: [
            Colors.black.withOpacity(0.7),
            const Color(0xFF242424).withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.workspace_premium,
            size: 50,
            color: Theme.of(context).colorScheme.secondary,
          ),
          const SizedBox(height: 20),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            date,
            style: const TextStyle(
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 15),
          OutlinedButton(
            onPressed: () {
              // Add view certificate functionality
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: Theme.of(context).colorScheme.secondary,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text('View Certificate'),
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 80.0),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Contact Me'),
          const SizedBox(height: 30),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (MediaQuery.of(context).size.width > 800)
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildContactItem(
                        icon: Icons.email,
                        title: 'Email',
                        value: 'aman914501@gmail.com',
                      ),
                      const SizedBox(height: 30),
                      _buildContactItem(
                        icon: Icons.phone,
                        title: 'Phone',
                        value: '+91 7009004695',
                      ),
                      const SizedBox(height: 30),
                      _buildContactItem(
                        icon: Icons.location_on,
                        title: 'Location',
                        value: 'Ludhiana 141016, India',
                      ),
                      const SizedBox(height: 50),
                      Text(
                        'Find me on',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          _buildSocialIconButton(
                            icon: Icons.code,
                            url: 'https://github.com/amandeepthakur',
                          ),
                          const SizedBox(width: 20),
                          _buildSocialIconButton(
                            icon: Icons.business_center,
                            url: 'https://linkedin.com/in/amandeepthakur0001',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              if (MediaQuery.of(context).size.width > 800)
                const SizedBox(width: 50),
              Expanded(
                flex: MediaQuery.of(context).size.width > 800 ? 2 : 1,
                child: Container(
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.7),
                        const Color(0xFF242424).withOpacity(0.7),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Send me a message',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Name',
                          filled: true,
                          fillColor: Colors.black.withOpacity(0.3),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                          filled: true,
                          fillColor: Colors.black.withOpacity(0.3),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Subject',
                          filled: true,
                          fillColor: Colors.black.withOpacity(0.3),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        maxLines: 5,
                        decoration: InputDecoration(
                          labelText: 'Message',
                          filled: true,
                          fillColor: Colors.black.withOpacity(0.3),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Add send message functionality
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Send Message',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 80),
          const Center(
            child: Text(
              '© 2025 Amandeep Thakur. All Rights Reserved.',
              style: TextStyle(
                color: Colors.white54,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).primaryColor.withOpacity(0.2),
          ),
          child: Icon(
            icon,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSocialIconButton({
    required IconData icon,
    required String url,
  }) {
    return ElevatedButton(
      onPressed: () async {
        if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrl(Uri.parse(url));
        }
      },
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(15),
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
      ),
      child: Icon(
        icon,
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                color: Theme.of(context).primaryColor.withOpacity(0.5),
                blurRadius: 10,
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        Container(
          width: 100,
          height: 4,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).colorScheme.secondary,
              ],
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
    );
  }
}