// import 'package:flutter/material.dart';
//
// void main() {
//   runApp( Desafio());
// }
//
// class Desafio extends StatelessWidget {
//   const Desafio({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'Flutter Demo',
//         theme: ThemeData(
//           colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
//           useMaterial3: true,
//         ),
//         home: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Linha(),
//             Linha(icone: Icons.people),
//             Linha()
//           ],
//
//         )
//     );
//   }
// }
//
// class Linha extends StatefulWidget {
//   final Icon? icone;
//
//   const Linha(this.icone, {super.key});
//
//   @override
//   State<Linha> createState() => LinhaInsere();
// }
//
//
// class LinhaInsere extends State<Linha> {
//
//   @override
//   Widget build(BuildContext context) {
//     var icone;
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(4.0),
//             child: Container(decoration: BoxDecoration(border: Border.all(width: 3), borderRadius: BorderRadius.circular(12),
//                 color: Colors.cyanAccent), height: 140, width: 100,),
//           ),
//           Container(decoration: BoxDecoration(border: Border.all(width: 3),borderRadius: BorderRadius.circular(12),
//               color: Colors.deepOrange), height: 140, width: 100, child: icone,),
//           Padding(
//             padding: const EdgeInsets.all(5.0),
//             child: Container(decoration: BoxDecoration(border: Border.all(width: 3), borderRadius: BorderRadius.circular(12),
//                 color: Colors.pink), height: 140, width: 100,),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
