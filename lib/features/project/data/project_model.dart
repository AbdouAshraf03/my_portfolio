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

// Sample projects data
final List<Project> sampleProjects = [
  // const Project(
  //   title: 'AI-Powered Dashboard',
  //   description:
  //       'Real-time analytics dashboard with ML-powered insights and predictive analytics. Built with React, TypeScript, and TensorFlow.js.',
  //   technologies: ['React', 'TypeScript', 'TensorFlow.js', 'D3.js'],
  //   codeUrl: 'https://github.com',
  //   demoUrl: 'https://demo.com',
  //   color: ProjectColor.purple,
  // ),
  // const Project(
  //   title: 'E-Commerce Platform',
  //   description:
  //       'Full-stack e-commerce solution with payment integration, inventory management, and real-time order tracking.',
  //   technologies: ['Next.js', 'Node.js', 'PostgreSQL', 'Stripe'],
  //   codeUrl: 'https://github.com',
  //   demoUrl: 'https://demo.com',
  //   color: ProjectColor.cyan,
  // ),
  // const Project(
  //   title: 'Social Media App',
  //   description:
  //       'Modern social networking platform with real-time messaging, story features, and advanced privacy controls.',
  //   technologies: ['Flutter', 'Firebase', 'Node.js', 'MongoDB'],
  //   codeUrl: 'https://github.com',
  //   demoUrl: 'https://demo.com',
  //   color: ProjectColor.pink,
  // ),
  // const Project(
  //   title: 'Developer Tools Suite',
  //   description:
  //       'Collection of productivity tools for developers including code snippets manager, API tester, and regex builder.',
  //   technologies: ['React', 'Electron', 'TypeScript', 'Monaco Editor'],
  //   codeUrl: 'https://github.com',
  //   demoUrl: 'https://demo.com',
  //   color: ProjectColor.purple,
  // ),
];
