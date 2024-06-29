import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_app/feature/project/widgets/old/custom_icon.dart';


class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        
        Text(
          'projects',
          style: GoogleFonts.pacifico(
            fontSize: 40,

          ),
          
        ),
        const Spacer(),
        const CustomSearchIcon(),
      ],
    );
  }
}

