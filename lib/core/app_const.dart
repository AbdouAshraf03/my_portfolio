class AppConstants {
  // Personal Info
  static const String name = 'Abd-Elrahman Ashraf';
  static const String role = 'Flutter Dev';
  static const String location = 'Giza, Egypt';
  static const String status = 'Available for opportunities';

  // Commands
  static const List<String> availableCommands = [
    'about',
    'projects',
    'contact',
    'help',
    'clear',
    'fact',
  ];

  static const String helpMessage = '''
Available commands:
  about    - View information about me
  projects - Browse my projects
  contact  - Get in touch
  clear    - Clear terminal
  help     - Show this message
  fact     - Show a fact about this page
''';

  // Social Links
  static const String githubUrl = 'https://github.com/AbdouAshraf03';
  static const String linkedinUrl =
      'https://www.linkedin.com/in/abdelrahman-ashraf-3ab2b421a';
  static const String email = 'abdouashrat123@gmail.com';

  // Skills
  static const Map<String, double> skills = {
    'Flutter Development': 0.95,
    'UI/UX Design': 0.88,
    'Performance Optimization': 0.92,
  };

  // Tech Stack
  static const List<String> techStack = [
    'Flutter',
    'Restful API',
    'Python',
    'PostgreSQL',
    'Firebase',
    'AWS',
  ];
}
