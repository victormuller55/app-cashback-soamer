import 'package:app_cashback_soamer/widgets/scaffold.dart';
import 'package:flutter/material.dart';

class RecompensasScreen extends StatefulWidget {
  const RecompensasScreen({super.key});

  @override
  State<RecompensasScreen> createState() => _RecompensasScreeenState();
}

class _RecompensasScreeenState extends State<RecompensasScreen> {

    Widget _body(){
      return ListView(
        children:[
          container(
            height:100,
            width: MediaQuery.of(context).size.width,
            radius: BorderRadius.circular(10),
            colors: Colors.gray.shade300,
            child: Column(
              children:[
                text("Cashbacks via PIX podem demorar até 3 dias para serem depositados na conta do usuário, representando apenas 40% do valor dos pontos acumulados.")
                Row(
                  children:[
                    text("R\$00,00"),
                    elevatedButtonText("Solicitar valor",onPressed: ()=>{})
                  ]
                )
              ]
            )
          ),
          SizedBox(
            height: 180,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: cardsMaisTrocados,
            ),
          ),
          SizedBox(
            height: 180,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: cardsMaisTrocados,
            ),
          ),
          SizedBox(
            height: 180,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: cardsMaisTrocados,
            ),
          ),
        ]
      );
    }

  @override
  Widget build(BuildContext context) {
    return scaffold(body:_body(), title: "Recompensas");
  }
}
