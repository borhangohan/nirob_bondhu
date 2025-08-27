// import 'package:flutter/material.dart';
// import 'setup_screen.dart'; // Make sure this matches the new filename
// import '../utils/app_colors.dart';
// import '../utils/app_text_styles.dart';
// import '../utils/text_content.dart'; // <-- FIX: ADD THIS IMPORT
//
// class WelcomeScreen extends StatelessWidget {
//   // FIX: Updated constructor syntax
//   const WelcomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.primaryBackground,
//       body: InkWell(
//         onTap: () {
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => SetupScreen()),
//           );
//         },
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(TextContent.appName, style: AppTextStyles.heading.copyWith(fontSize: 40)),
//               const SizedBox(height: 40),
//               const Icon(Icons.favorite, color: AppColors.glowingCircle, size: 80),
//               const SizedBox(height: 40),
//               Text(TextContent.welcomeMessage, style: AppTextStyles.heading),
//               Text(TextContent.welcomeSubtitle, style: AppTextStyles.body.copyWith(color: AppColors.secondaryText)),
//               const SizedBox(height: 100),
//               Text(TextContent.tapToStart, style: AppTextStyles.body),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }