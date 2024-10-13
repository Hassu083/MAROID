import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              width: double.infinity,
              height: 400,
              decoration: BoxDecoration(
                  color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade600,
                      spreadRadius: 1,
                      blurRadius: 15
                  )
                ]
              ),
              child: Column(
                children:  [
                  const SizedBox(height: 80,),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, '/home');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text('Create New File',style: GoogleFonts.almendra(
                        fontWeight: FontWeight.bold,
                        fontSize: 30
                      ),),
                    ),
                  ),
                  const Divider(),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, '/registerFile');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text('Register File',style: GoogleFonts.almendra(
                          fontWeight: FontWeight.bold,
                          fontSize: 30
                      ),),
                    ),
                  ),
                  const Divider(),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, '/datamemory');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text('Data Memory',style: GoogleFonts.almendra(
                          fontWeight: FontWeight.bold,
                          fontSize: 30
                      ),),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: -50,
              child: Container(child: Image.asset('assets/mips.png',),
              width: 180,
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(1000))
              ),),
            ),
          ],
        ),
      ),
    );
  }
}
