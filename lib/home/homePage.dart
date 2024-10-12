import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maroid/entity/program.dart';
import 'package:maroid/entity/service.dart';
import 'package:maroid/home/action.dart';

import '../app_State.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> instructions = [
    'choose',
    'add',
    'sub',
    'slt',
    'addi',
    'slti',
    'lw',
    'sw',
    'beq',
    'bne',
    'j'
  ];
  List<List<String>> output = [];
  bool showOutput = false;
  bool saving = false;
  TextEditingController filename = TextEditingController(text: 'untitled');
  List<String> code = [];
  List<TextEditingController> codeRegister = [];
  int currentInstruction = -1;
  bool files = false;
  Map<String, List<int>> jump = {};
  List<Program> programs = [];

  List<String> get completeCodeWithoutLabel {
    List<String> list = [];
    for (int i = 0; i < code.length; i++) {
      list.add('${code[i]} ${codeRegister[i].text}');
    }
    return list;
  }

  execute() {
    output = [];
    int i = 0;
    while (i < code.length) {
      List<String> outputStatement = [];
      if (code[i] == 'add') {
        String rd = codeRegister[i].text.split(',')[0].trim();
        String rs1 = codeRegister[i].text.split(',')[1].trim();
        String rs2 = codeRegister[i].text.split(',')[2].trim();
        outputStatement.add('$rd = $rs1 + $rs2');
        outputStatement.add(
            '$rd = ${MyInheritedWidget.of(context)!.registers[rs1]} + ${MyInheritedWidget.of(context)!.registers[rs2]}');
        MyInheritedWidget.of(context)!.registers[rd] =
            MyInheritedWidget.of(context)!.registers[rs1]! +
                MyInheritedWidget.of(context)!.registers[rs2]!;
        MyInheritedWidget.of(context)!
            .updateRegisterFile(MyInheritedWidget.of(context)!.registers);
        outputStatement
            .add('$rd = ${MyInheritedWidget.of(context)!.registers[rd]}');
      } else if (code[i] == 'addi') {
        String rd = codeRegister[i].text.split(',')[0].trim();
        String rs1 = codeRegister[i].text.split(',')[1].trim();
        String imm = codeRegister[i].text.split(',')[2].trim();
        outputStatement.add('$rd = $rs1 + imm');
        outputStatement.add(
            '$rd = ${MyInheritedWidget.of(context)!.registers[rs1]} + $imm');
        MyInheritedWidget.of(context)!.registers[rd] =
            MyInheritedWidget.of(context)!.registers[rs1]! + int.parse(imm);
        MyInheritedWidget.of(context)!
            .updateRegisterFile(MyInheritedWidget.of(context)!.registers);
        outputStatement
            .add('$rd = ${MyInheritedWidget.of(context)!.registers[rd]}');
      } else if (code[i] == 'sub') {
        String rd = codeRegister[i].text.split(',')[0].trim();
        String rs1 = codeRegister[i].text.split(',')[1].trim();
        String rs2 = codeRegister[i].text.split(',')[2].trim();
        outputStatement.add('$rd = $rs1 - $rs2');
        outputStatement.add(
            '$rd = ${MyInheritedWidget.of(context)!.registers[rs1]} - ${MyInheritedWidget.of(context)!.registers[rs2]}');
        MyInheritedWidget.of(context)!.registers[rd] =
            MyInheritedWidget.of(context)!.registers[rs1]! -
                MyInheritedWidget.of(context)!.registers[rs2]!;
        MyInheritedWidget.of(context)!
            .updateRegisterFile(MyInheritedWidget.of(context)!.registers);
        outputStatement
            .add('$rd = ${MyInheritedWidget.of(context)!.registers[rd]}');
      } else if (code[i] == 'beq') {
        String rs1 = codeRegister[i].text.split(',')[0].trim();
        String rs2 = codeRegister[i].text.split(',')[1].trim();
        outputStatement.add('$rs1 == $rs2');
        outputStatement.add(
            '${MyInheritedWidget.of(context)!.registers[rs1]} == ${MyInheritedWidget.of(context)!.registers[rs2]}');
        bool cond = MyInheritedWidget.of(context)!.registers[rs1]! ==
            MyInheritedWidget.of(context)!.registers[rs2]!;
        if (cond) {
          i = jump[codeRegister[i].text.split(',')[2].trim()]![0];
          outputStatement.add('Jump to ${i * 4}');
          continue;
        }
      } else if (code[i] == 'slt') {
        String rd = codeRegister[i].text.split(',')[0].trim();
        String rs1 = codeRegister[i].text.split(',')[1].trim();
        String rs2 = codeRegister[i].text.split(',')[2].trim();
        outputStatement.add('$rd = $rs1 < $rs2');
        outputStatement.add(
            '$rd = ${MyInheritedWidget.of(context)!.registers[rs1]} < ${MyInheritedWidget.of(context)!.registers[rs2]}');
        MyInheritedWidget.of(context)!.registers[rd] =
            MyInheritedWidget.of(context)!.registers[rs1]! <
                    MyInheritedWidget.of(context)!.registers[rs2]!
                ? 1
                : 0;
        MyInheritedWidget.of(context)!
            .updateRegisterFile(MyInheritedWidget.of(context)!.registers);
        outputStatement
            .add('$rd = ${MyInheritedWidget.of(context)!.registers[rd]}');
      } else if (code[i] == 'j') {
        i = jump[codeRegister[i].text.trim()]![0];
        outputStatement.add('Jump to ${i * 4}');
        continue;
      } else if (code[i] == 'slti') {
        String rd = codeRegister[i].text.split(',')[0].trim();
        String rs1 = codeRegister[i].text.split(',')[1].trim();
        String imm = codeRegister[i].text.split(',')[2].trim();
        outputStatement.add('$rd = $rs1 < imm');
        outputStatement.add(
            '$rd = ${MyInheritedWidget.of(context)!.registers[rs1]} < $imm');
        MyInheritedWidget.of(context)!.registers[rd] =
            MyInheritedWidget.of(context)!.registers[rs1]! < int.parse(imm)
                ? 1
                : 0;
        print(MyInheritedWidget.of(context)!.registers[rd]);
        MyInheritedWidget.of(context)!
            .updateRegisterFile(MyInheritedWidget.of(context)!.registers);
        outputStatement
            .add('$rd = ${MyInheritedWidget.of(context)!.registers[rd]}');
      } else if (code[i] == 'lw') {
        String rd = codeRegister[i].text.split(',')[0].trim();
        String rs1 = codeRegister[i]
            .text
            .split(',')[1]
            .trim()
            .split('(')[1]
            .split(')')[0];
        String imm = codeRegister[i].text.split(',')[1].trim().split('(')[0];
        outputStatement.add('$rd = Mem[$rs1 + $imm]');
        String address =
            (MyInheritedWidget.of(context)!.registers[rs1]! + int.parse(imm))
                .toString();
        outputStatement.add('$rd = Mem[$address]');
        MyInheritedWidget.of(context)!.registers[rd] =
            MyInheritedWidget.of(context)!.dataMemory[address]!;
        outputStatement
            .add('$rd = ${MyInheritedWidget.of(context)!.registers[rd]}');
        MyInheritedWidget.of(context)!
            .updateRegisterFile(MyInheritedWidget.of(context)!.registers);
      } else if (code[i] == 'bne') {
        String rs1 = codeRegister[i].text.split(',')[0].trim();
        String rs2 = codeRegister[i].text.split(',')[1].trim();
        outputStatement.add('$rs1 != $rs2');
        outputStatement.add(
            '${MyInheritedWidget.of(context)!.registers[rs1]} != ${MyInheritedWidget.of(context)!.registers[rs2]}');
        bool cond = MyInheritedWidget.of(context)!.registers[rs1]! !=
            MyInheritedWidget.of(context)!.registers[rs2]!;
        // execute.bne(codeRegister[i].text.split(',')[0].trim(), codeRegister[i].text.split(',')[1].trim());
        if (cond) {
          i = jump[codeRegister[i].text.split(',')[2].trim()]![0];
          outputStatement.add('Jump to ${i * 4}');
          continue;
        }
      } else if (code[i] == 'sw') {
        String rs2 = codeRegister[i].text.split(',')[0].trim();
        String rs1 = codeRegister[i]
            .text
            .split(',')[1]
            .trim()
            .split('(')[1]
            .split(')')[0];
        String imm = codeRegister[i].text.split(',')[1].trim().split('(')[0];
        outputStatement.add('Mem[$rs1 + $imm] = $rs2');
        String address =
            (MyInheritedWidget.of(context)!.registers[rs1]! + int.parse(imm))
                .toString();
        outputStatement.add('Mem[$address] = $rs2');
        print('addreeess$address');
        MyInheritedWidget.of(context)!.dataMemory[address] =
            MyInheritedWidget.of(context)!.registers[rs2]!;
        outputStatement.add(
            'Mem[$address] = ${MyInheritedWidget.of(context)!.registers[rs2]}');
        MyInheritedWidget.of(context)!
            .updateDataMemory(MyInheritedWidget.of(context)!.dataMemory);
      }else{
        outputStatement.add('error');
        showDialog(context: context,
            builder: (context){
              return AlertDialog(
                title: Text('Error'),
                content: Text('Error found'),
                actions: [
                  TextButton(onPressed: (){
                    Navigator.pop(context);
                  }, child: Text('Ok'))
                ],
              );
            });
        break;
      }
      output.add(outputStatement);
      i++;
    }
    setState(() {
      showOutput = true;
    });
  }

  loadFile(Program program) {
    Map<String, List<int>> jumpData = {};
    List<String> codeData = [];
    List<TextEditingController> codeRegisterData = [];
    List<String> instruction = program.instructions.split('+');
    instruction = instruction.getRange(1, instruction.length).toList();
    for (int i = 0; i < instruction.length; i++) {
      List<String> inst =
          instruction[i].split('/').map((e) => e.trim()).toList();
      if (!instructions.contains(inst.first) && inst.length > 1) {
        if (!jumpData.keys.toList().contains(inst.first)) {
          jumpData.addAll({
            inst.first: [i]
          });
        } else {
          jumpData[inst.first]!.add(i);
        }
        inst = inst.getRange(1, inst.length).toList();
      }
      codeData.add(inst.first.split(' ').first.trim());
      codeRegisterData.add(TextEditingController(
          text: inst.first
              .split(' ')
              .getRange(1, inst.first.split(' ').length)
              .join(' ')
              .trim()));
    }
    setState(() {
      jump = jumpData;
      code = codeData;
      codeRegister = codeRegisterData;
    });
  }

  List<String> get completeCodeWithLabel {
    List<String> list = completeCodeWithoutLabel;
    for (String i in jump.keys) {
      for (int j in jump[i]!) {
        list[j] = "$i/${list[j]}";
      }
    }
    return list;
  }

  updateJump() {
    List<String> labels = [];
    for (int i = 0; i < code.length; i++) {
      if (code[i] == 'beq' || code[i] == 'bne') {
        String label = codeRegister[i].text.split(',')[2].trim();
        labels.add(label);
        if (!jump.containsKey(label)) {
          jump.addAll({label: []});
        }
      } else if (code[i] == 'j') {
        String label = codeRegister[i].text.trim();
        labels.add(label);
        if (!jump.containsKey(label)) {
          jump.addAll({label: []});
        }
      }
    }
    for (String i in jump.keys) {
      if (!labels.contains(i.toString())) {
        jump.remove(i);
      }
    }
  }

  getFiles() async {
    try {
      programs = await (await LocalDbService.programDao).findAllPrograms();
    } catch (e) {
      print(e);
    } finally {
      print(programs);
    }
  }

  save() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('File Name'),
            content: Row(
              children: [
                saving
                    ? const Padding(
                        padding: EdgeInsets.all(4),
                        child: CircularProgressIndicator(),
                      )
                    : const SizedBox(
                        width: 0,
                        height: 0,
                      ),
                Container(
                  width: 100,
                  height: 45,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                      color: Colors.white30,
                      border: Border.all(color: Colors.black38)),
                  child: Center(
                    child: TextField(
                      controller: filename,
                      style: GoogleFonts.arimo(fontSize: 20),
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                ),
                Container(
                  width: 50,
                  height: 45,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                      color: Colors.white30,
                      border: Border.all(color: Colors.black38)),
                  child: const Center(child: Text('.roid')),
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () async {
                    setState(() {
                      saving = false;
                    });
                    String program = '';
                    for (String i in completeCodeWithLabel) {
                      program = '$program+$i';
                    }
                    Program actualProgram = Program(
                        DateTime.now().millisecondsSinceEpoch,
                        filename.text,
                        program);
                    (await LocalDbService.programDao)
                        .insertProgram(actualProgram);
                  },
                  child: const Text('Save'))
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 0), () {
      getFiles();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "M. A. roid",
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                height: 40,
                color: Colors.black12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyAction(
                        ontap: () {
                          setState(() {
                            files = !files;
                          });
                        },
                        icon: Icons.folder),
                    MyAction(
                        ontap: () {
                          for (var i in codeRegister) {
                            if (i.text.contains('label')) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const AlertDialog(
                                      title: Text('Error'),
                                      content: Text('First change label'),
                                    );
                                  });
                              return;
                            }
                          }
                          setState(() {
                            codeRegister.add(TextEditingController(
                                text: 'a place for registers'));
                            code.add('choose');
                            currentInstruction += 1;
                          });
                        },
                        icon: Icons.add),
                    MyAction(
                        ontap: () {
                          setState(() {
                            if (code.isNotEmpty) {
                              if (currentInstruction == code.length - 1 &&
                                  currentInstruction != -1) {
                                currentInstruction -= 1;
                              }
                              for (String i in jump.keys.toList()) {
                                if (jump[i]!.contains(code.length - 1)) {
                                  jump[i]!.remove(code.length - 1);
                                }
                              }
                              code.removeAt(code.length - 1);
                              codeRegister.removeAt(codeRegister.length - 1);
                            }
                          });
                        },
                        icon: Icons.cut),
                    MyAction(
                        ontap: () {
                          if (currentInstruction - 1 != -2) {
                            setState(() {
                              currentInstruction -= 1;
                            });
                          }
                        },
                        icon: Icons.arrow_upward),
                    MyAction(
                        ontap: () {
                          if (currentInstruction < code.length - 1) {
                            setState(() {
                              currentInstruction += 1;
                            });
                          }
                        },
                        icon: Icons.arrow_downward),
                    MyAction(ontap: execute, icon: Icons.play_arrow),
                    MyAction(ontap: save, icon: Icons.save)
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                height: 40,
                color: Colors.white,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                height: 20,
                color: Colors.black12,
              ),
              Expanded(
                child: ListView.separated(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                    itemBuilder: (widget, index) {
                      return Container(
                        width: double.infinity,
                        height: 100,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            border: index == currentInstruction
                                ? Border.all(color: Colors.black38)
                                : null,
                            boxShadow: index == currentInstruction
                                ? [
                                    BoxShadow(
                                        color: Colors.grey.shade600,
                                        spreadRadius: 1,
                                        blurRadius: 15)
                                  ]
                                : null,
                            color: index == currentInstruction
                                ? Colors.white
                                : null),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "In [ ]:",
                              style: GoogleFonts.lato(
                                  color: Colors.black38,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                  letterSpacing: 2),
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 45,
                              child: Row(
                                children: [
                                  Container(
                                    width: 90,
                                    height: 45,
                                    decoration: BoxDecoration(
                                        color: Colors.white30,
                                        border:
                                            Border.all(color: Colors.black38)),
                                    child: Center(
                                      child: DropdownButton(
                                          value: code[index],
                                          items:
                                              instructions.map((String items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: Text(items),
                                            );
                                          }).toList(),
                                          onChanged: (newValue) {
                                            setState(() {
                                              if (newValue
                                                  .toString()
                                                  .contains('i')) {
                                                codeRegister[index].text =
                                                    'rs1, rs2, imm';
                                              } else if (newValue.toString() ==
                                                      'lw' ||
                                                  newValue.toString() == 'sw') {
                                                codeRegister[index].text =
                                                    'rs2, imm(rs1)';
                                              } else if (newValue.toString() ==
                                                  'j') {
                                                codeRegister[index].text =
                                                    'label';
                                              } else if (newValue
                                                      .toString()
                                                      .contains('b') &&
                                                  !newValue
                                                      .toString()
                                                      .contains('s')) {
                                                codeRegister[index].text =
                                                    'rs1, rs2, label';
                                              } else if (newValue.toString() ==
                                                  'jr') {
                                                codeRegister[index].text = 'ra';
                                              } else {
                                                codeRegister[index].text =
                                                    'rd, rs1, rs2';
                                              }
                                              code[index] = newValue.toString();
                                            });
                                          }),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width: 200,
                                    height: 45,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    decoration: BoxDecoration(
                                        color: Colors.white30,
                                        border:
                                            Border.all(color: Colors.black38)),
                                    child: Center(
                                      child: TextField(
                                        controller: codeRegister[index],
                                        style: GoogleFonts.arimo(fontSize: 20),
                                        onChanged: (newValue) {
                                          if (code[index] == 'beq' ||
                                              code[index] == 'bne') {}
                                          if (code[index] == 'j') {}
                                        },
                                        decoration: const InputDecoration(
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (widget, index) {
                      return const Divider();
                    },
                    itemCount: code.length),
              ),
            ],
          ),
          if (showOutput)
            SizedBox.expand(
              child: DraggableScrollableSheet(
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return Container(
                      padding: const EdgeInsets.all(8),
                      decoration:  BoxDecoration(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(20)),
                        border: Border.all(color: Colors.black,width: 2),
                        color: Colors.white
                      ),
                  child: Column(
                    children: [
                      Row(children: [
                        Expanded(child: Container()),
                        GestureDetector(
                          onTap:(){
                            setState(() {
                              showOutput = false;
                            });
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                            ),
                            child: const Center(child: Icon(Icons.cancel_outlined,color: Colors.white,)),
                          ),
                        )
                      ],),
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context,index){
                              return ExpansionTile(title: Text(output[index][0],style: GoogleFonts.adamina(color: Colors.black),),
                                
                                children: List.generate(output[index].length, (i) => Text(output[index][i],style: GoogleFonts.adamina(color: Colors.black)),
                              )
                              );
                            },
                            separatorBuilder: (context,index){
                              return const Divider(color: Colors.black,);
                            },
                            itemCount: output.length
                        ),
                      ),
                    ],
                  ),
                  );
                },
              ),
            ),
          if (files)
            SizedBox.expand(
              child: DraggableScrollableSheet(
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20)),
                        border: Border.all(color: Colors.black,width: 2),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade600,
                              spreadRadius: 1,
                              blurRadius: 15)
                        ]),
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: programs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () => loadFile(programs[index]),
                          child: Container(
                            width: double.infinity,
                            height: 100,
                            margin: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Center(
                              child: ListTile(
                                title: Text('${programs[index].fileName}.roid'),
                                subtitle: Text(
                                  programs[index].instructions,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                leading: Image.asset('mips.png'),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
        ],
      ),
      floatingActionButton: code.contains('j') ||
              code.contains('beq') ||
              code.contains('bne')
          ? FloatingActionButton(
              child: const Center(
                  child: Icon(
                Icons.adjust,
                color: Colors.white,
              )),
              backgroundColor: Colors.black,
              onPressed: markLabel,
            )
          : null,
    );
  }

  markLabel() {
    updateJump();
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return Dialog(
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade600,
                        spreadRadius: 1,
                        blurRadius: 15)
                  ]),
              child: DefaultTabController(
                length: jump.length,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  child: Scaffold(
                    appBar: AppBar(
                      bottom: TabBar(
                        tabs: jump.keys.toList().map((e) {
                          return Tab(
                            text: e,
                          );
                        }).toList(),
                      ),
                    ),
                    body: TabBarView(
                        children: jump.keys.toList().map((e) {
                      return ListView.separated(
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: Checkbox(
                                value: jump[e]!.contains(index) ? true : false,
                                onChanged: (newValue) {
                                  if (jump[e]!.contains(index)) {
                                    setState(() {
                                      jump[e]!.remove(index);
                                    });
                                  } else {
                                    setState(() {
                                      jump[e]!.add(index);
                                    });
                                  }
                                  Navigator.pop(context);
                                },
                              ),
                              title: Text(completeCodeWithoutLabel[index]),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider();
                          },
                          itemCount: completeCodeWithoutLabel.length);
                    }).toList()),
                  ),
                ),
              )),
        );
      },
    );
  }
}