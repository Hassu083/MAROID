import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maroid/app_State.dart';


class RegisterFile extends StatefulWidget {
  const RegisterFile({Key? key}) : super(key: key);

  @override
  State<RegisterFile> createState() => _RegisterFileState();
}

class _RegisterFileState extends State<RegisterFile> {
  List<TextEditingController> registers = [];
  bool loading = true;
  
  @override
  void initState() {
    setState(() {
      loading=true;
    });
    Future.delayed(const Duration(seconds: 0),(){
      for (int i = 0; i<MyInheritedWidget.of(context)!.registers.length;i++){
        registers.add(TextEditingController(text: MyInheritedWidget.of(context)!.registers[MyInheritedWidget.of(context)!.registers.keys.toList()[i]].toString() ));
      }
    });
    Future.delayed(const Duration(seconds: 1),(){
      setState(() {
        loading = false;
      });
    });
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register File'),
        actions: [
          GestureDetector(
            onTap: (){
              setState(() {
                for (int i = 0; i<MyInheritedWidget.of(context)!.registers.length;i++){
                  registers[i] = TextEditingController(text: '0');
                  MyInheritedWidget.of(context)!.registers[MyInheritedWidget.of(context)!.registers.keys.toList()[i]] = 0;
                }
              });
            },
            child: const Padding(
              padding:  EdgeInsets.all(8.0),
              child: Icon(Icons.exposure_zero),
            ),
          )
        ],
      ),
      body: !loading? SingleChildScrollView(
        scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: DataTable(
              columns: ['Register','Value','HexaDecimal','Binary'].map((e) => DataColumn(label: Text(e,style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 15),))).toList(),
              rows: List.generate(MyInheritedWidget.of(context)!.registers.length,
                      (index){
                return DataRow(
                  cells: [
                    DataCell(Text(MyInheritedWidget.of(context)!.registers.keys.toList()[index],style: GoogleFonts.athiti(fontSize: 25,fontWeight: FontWeight.bold),),),
                    DataCell(Container(
                      width: 100,
                      height: 45,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8),
                      decoration: BoxDecoration(
                          color: Colors.white30,
                          border:
                          Border.all(color: Colors.black38)),
                      child: Center(
                        child: TextField(
                          controller: registers[index],
                          style: GoogleFonts.arimo(fontSize: 20),
                          onChanged: (newValue) {
                            setState(() {
                              MyInheritedWidget.of(context)!.registers[MyInheritedWidget.of(context)!.registers.keys.toList()[index]] = int.parse(newValue);
                            });
                          },
                          decoration: const InputDecoration(
                              border: InputBorder.none),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),),
                    DataCell(Text(int.parse(registers[index].text).toRadixString(16),style: GoogleFonts.athiti(fontSize: 25,fontWeight: FontWeight.bold),),),
                    DataCell(Text(int.parse(registers[index].text).toRadixString(2),style: GoogleFonts.athiti(fontSize: 25,fontWeight: FontWeight.bold),),),
                  ]
                );
                      }),
            ),
          ),
      ):const Center(child: CircularProgressIndicator(),),
    );
  }
}
