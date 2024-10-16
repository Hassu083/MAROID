import 'package:flutter/material.dart';

class MyInheritedWidget extends InheritedWidget{
  MyStatefulWidgetState state;
  MyInheritedWidget({Key? key, required Widget child,required this.state}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static MyStatefulWidgetState? of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>()?.state;

}

class MyStatefulWidget extends StatefulWidget {
  Widget child;
  MyStatefulWidget({Key? key,required this.child}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => MyStatefulWidgetState();
}

class MyStatefulWidgetState extends State<MyStatefulWidget> {

  Map<String,int> registers = {
    's0':0,'s1':0,'s2':0,'s3':0,'s4':0,'s5':0,'s6':0,
    't0':0,'t1':0,'t2':0,'t4':0,'t5':0,'t6':0,
    't7':0,'t8':0,'t9':0
  };

  Map<String,int> dataMemory = {'0': 0, '4': 0, '8': 0, '12': 0, '16': 0, '20': 0, '24': 0, '28': 0, '32': 0,
    '36': 0, '40': 0, '44': 0, '48': 0, '52': 0, '56': 0, '60': 0, '64': 0, '68': 0, '72': 0, '76': 0, '80': 0,
    '84': 0, '88': 0, '92': 0, '96': 0, '100': 0, '104': 0, '108': 0, '112': 0, '116': 0, '120': 0, '124': 0,
    '128': 0, '132': 0, '136': 0, '140': 0, '144': 0, '148': 0, '152': 0, '156': 0, '160': 0, '164': 0, '168': 0,
    '172': 0, '176': 0, '180': 0, '184': 0, '188': 0, '192': 0, '196': 0, '200': 0, '204': 0, '208': 0, '212': 0,
    '216': 0, '220': 0, '224': 0, '228': 0, '232': 0, '236': 0, '240': 0, '244': 0, '248': 0, '252': 0, '256': 0,
    '260': 0, '264': 0, '268': 0, '272': 0, '276': 0, '280': 0, '284': 0, '288': 0, '292': 0, '296': 0, '300': 0,
    '304': 0, '308': 0, '312': 0, '316': 0, '320': 0, '324': 0, '328': 0, '332': 0, '336': 0, '340': 0, '344': 0,
    '348': 0, '352': 0, '356': 0, '360': 0, '364': 0, '368': 0, '372': 0, '376': 0, '380': 0, '384': 0, '388': 0,
    '392': 0, '396': 0, '400': 0, '404': 0, '408': 0, '412': 0, '416': 0, '420': 0, '424': 0, '428': 0, '432': 0,
    '436': 0, '440': 0, '444': 0, '448': 0, '452': 0, '456': 0, '460': 0, '464': 0, '468': 0, '472': 0, '476': 0,
    '480': 0, '484': 0, '488': 0, '492': 0, '496': 0, '500': 0, '504': 0, '508': 0, '512': 0, '516': 0, '520': 0,
    '524': 0, '528': 0, '532': 0, '536': 0, '540': 0, '544': 0, '548': 0, '552': 0, '556': 0, '560': 0, '564': 0,
    '568': 0, '572': 0, '576': 0, '580': 0, '584': 0, '588': 0, '592': 0, '596': 0, '600': 0, '604': 0, '608': 0,
    '612': 0, '616': 0, '620': 0, '624': 0, '628': 0, '632': 0, '636': 0, '640': 0, '644': 0, '648': 0, '652': 0,
    '656': 0, '660': 0, '664': 0, '668': 0, '672': 0, '676': 0, '680': 0, '684': 0, '688': 0, '692': 0, '696': 0,
    '700': 0, '704': 0, '708': 0, '712': 0, '716': 0, '720': 0, '724': 0, '728': 0, '732': 0, '736': 0, '740': 0,
    '744': 0, '748': 0, '752': 0, '756': 0, '760': 0, '764': 0, '768': 0, '772': 0, '776': 0, '780': 0, '784': 0,
    '788': 0, '792': 0, '796': 0, '800': 0, '804': 0, '808': 0, '812': 0, '816': 0, '820': 0, '824': 0, '828': 0,
    '832': 0, '836': 0, '840': 0, '844': 0, '848': 0, '852': 0, '856': 0, '860': 0, '864': 0, '868': 0, '872': 0,
    '876': 0, '880': 0, '884': 0, '888': 0, '892': 0, '896': 0, '900': 0, '904': 0, '908': 0, '912': 0, '916': 0,
    '920': 0, '924': 0, '928': 0, '932': 0, '936': 0, '940': 0, '944': 0, '948': 0, '952': 0, '956': 0, '960': 0,
    '964': 0, '968': 0, '972': 0, '976': 0, '980': 0, '984': 0, '988': 0, '992': 0, '996': 0, '1000': 0};


  updateRegisterFile(Map<String,int> file)=>setState((){
    registers = file;
  });

  updateDataMemory(Map<String,int> memory)=>setState((){
    dataMemory = memory;
  });

  @override
  Widget build(BuildContext context) {
    return MyInheritedWidget(child: widget.child, state: this);
  }
}