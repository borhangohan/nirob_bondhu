// import 'package:flutter/material.dart';
// import 'home_screen.dart'; // <-- UPDATE FILENAME
// import '../utils/app_colors.dart';
// import '../utils/app_text_styles.dart';
// import '../utils/text_content.dart';
// import '../widgets/intents.dart';
//
// class SetupScreen extends StatelessWidget {
//   final PageController _pageController = PageController();
//
//   // FIX: Updated constructor syntax
//   SetupScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // ... rest of the code is the same
//     return Scaffold(
//       backgroundColor: AppColors.primaryBackground,
//       body: PageView(
//         controller: _pageController,
//         physics: const NeverScrollableScrollPhysics(), // Disable swiping
//         children: [
//           _buildCaregiverPage(context),
//           _buildPermissionsPage(context),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildCaregiverPage(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(24.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Text(TextContent.caregiverTitle, style: AppTextStyles.heading, textAlign: TextAlign.center),
//           Text(TextContent.caregiverSubtitle, style: AppTextStyles.body.copyWith(color: AppColors.secondaryText)),
//           const SizedBox(height: 40),
//           TextField(
//             style: AppTextStyles.body,
//             keyboardType: TextInputType.phone,
//             decoration: InputDecoration(
//               filled: true,
//               fillColor: Colors.white.withOpacity(0.1),
//               border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
//               hintText: "Enter phone number",
//               hintStyle: AppTextStyles.body.copyWith(color: AppColors.secondaryText),
//             ),
//           ),
//           const SizedBox(height: 20),
//           Text(TextContent.caregiverNote, style: AppTextStyles.body.copyWith(fontSize: 16), textAlign: TextAlign.center),
//           Text(TextContent.caregiverNoteSubtitle, style: AppTextStyles.body.copyWith(fontSize: 14, color: AppColors.secondaryText), textAlign: TextAlign.center),
//           const SizedBox(height: 60),
//           CustomLargeButton(
//             text: TextContent.saveButton,
//             onPressed: () {
//               _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
//             },
//             backgroundColor: AppColors.buttonBackground,
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildPermissionsPage(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(24.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Text(TextContent.permissionsTitle, style: AppTextStyles.heading),
//           const SizedBox(height: 40),
//           // Using simple switches to represent the yes/no choice
//           SwitchListTile(
//             title: Text(TextContent.voicePermission, style: AppTextStyles.body),
//             value: true, // Dummy value
//             onChanged: (val) {},
//             activeColor: AppColors.glowingCircle,
//           ),
//           SwitchListTile(
//             title: Text(TextContent.movementPermission, style: AppTextStyles.body),
//             value: true, // Dummy value
//             onChanged: (val) {},
//             activeColor: AppColors.glowingCircle,
//           ),
//           const SizedBox(height: 60),
//           CustomLargeButton(
//             text: TextContent.continueButton,
//             onPressed: () {
//               Navigator.pushAndRemoveUntil(
//                 context,
//                 MaterialPageRoute(builder: (context) => const HomeScreen()),
//                     (route) => false,
//               );
//             },
//             backgroundColor: AppColors.buttonBackground,
//           ),
//         ],
//       ),
//     );
//   }
// }