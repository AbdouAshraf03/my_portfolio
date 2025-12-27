class Project {
  final String title;
  final String description;
  final List<String> technologies;
  final String? codeUrl;
  final String? demoUrl;
  final ProjectColor color;

  const Project({
    required this.title,
    required this.description,
    required this.technologies,
    this.codeUrl,
    this.demoUrl,
    this.color = ProjectColor.purple,
  });
}

enum ProjectColor { purple, cyan, pink }

final List<Project> sampleProjects = [
  const Project(
    title: 'Stadium Eye — Flutter Mobile Application',
    description: ''' 
Flutter-based mobile application for sports match analysis and reporting.
Built structured reporting features allowing users to create, view, and manage match observations with image capture and
cloud storage integration
        ''',
    technologies: [
      'Flutter',
      'API (Auth, Storage)',
      'Clean Architecture',
      'Bloc',
      'Git',

      'Figma',
      'GitHub',
      'Localization(i18n)',
    ],
    color: ProjectColor.purple,
  ),

  const Project(
    title: 'BMO OS — Custom Linux Distribution',
    description: '''
Collaborated with a 4 developers Built a custom Linux operating system from scratch using
Linux From Scratch (LFS) and Beyond Linux From Scratch (BLFS).
Authored and maintained 400+ Bash automation scripts to build, configure, and manage
BLFS packages and system components.
Automated toolchain setup, kernel compilation, system libraries, and user-space package
installation.
Established structured, reproducible build workflows with documented processes and Gitbased version control.

''',
    technologies: [
      'LFS',
      'BLFS',
      'Bash Scripting',
      'GNU Toolchain',
      'Linux Kernel',
      'System Libraries',
      'Git',
      'GitHub',
      'Build Automation',
      'Linux System Internals',
    ],
    codeUrl: 'https://github.com/AbdouAshraf03/bmo-os',
    color: ProjectColor.pink,
  ),

  const Project(
    title: 'EduReserve — Flutter App',
    description: '''
Flutter-based booking system utilizing Supabase, reducing average user waiting time by
65% and streamlining course reservation management.
''',
    technologies: [
      'Flutter',
      'Supabase',
      'Bloc',
      'BitBucket',
      'Git',
      'BitBucket pipline (CI/CD)',
      'Figma',
    ],
    color: ProjectColor.cyan,
  ),

  const Project(
    title: 'Almeeqaty — Flutter App',
    description: '''
Collaborated with a 4 flutter and mobile developers to develop a prayer times and time
visualization app that resets the day at sunset (Maghrib).
''',
    technologies: ['Flutter', 'Firebase', 'Bloc', 'Clean Architecture'],
    demoUrl:
        'https://play.google.com/store/apps/details?id=com.almeeqaty.almeeqaty',
    color: ProjectColor.pink,
  ),

  const Project(
    title: 'Education-app — Flutter App',
    description: '''
Developed a Flutter app to help a teacher sell and manage educational videos for students.
Integrated an AI-powered assistance page to help students navigate content, answer FAQs,
and improve learning experience.
''',
    technologies: ['Flutter', 'Firebase', 'Git', 'Figma', 'GitHub'],
    codeUrl: 'https://github.com/AbdouAshraf03/education-app',
    color: ProjectColor.purple,
  ),

  const Project(
    title: 'Inventory — Flutter App',
    description: '''
Designed and developed an inventory management application for retail markets to track products, monitor stock levels,and detect upcoming expiration dates.
Implemented automated expiry warnings to reduce product waste and improve inventory turnover. 
Focused on clean architecture, usability, and efficient data handling.
''',
    technologies: ['Flutter', 'Supabase', 'Git', 'Figma', 'GitHub'],
    codeUrl: 'https://github.com/AbdouAshraf03/inventory_app',
    color: ProjectColor.cyan,
  ),
];
