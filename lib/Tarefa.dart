import 'package:flutter/material.dart';
import 'package:primeiro/Formulario.dart';
import 'package:primeiro/data.dart';

class Tarefa extends StatefulWidget {
  const Tarefa({super.key});

  @override
  State<Tarefa> createState() => _TarefaState();
}

class _TarefaState extends State<Tarefa> {
  bool opacidade = true;

  get children => null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter: Primeiros passos'),
      ),
      body:
      AnimatedOpacity(
        opacity: opacidade ? 1 : 0,
        duration: Duration(milliseconds: 1000),
        child:
          ListView(
              children: TaskInherite.of(context).taskList,
            padding: EdgeInsets.only(top: 8, bottom: 100),
          ),

      ),
      floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [FloatingActionButton(onPressed: ()
          { setState(() {
            opacidade = !opacidade;
          });
          },
            ///! quer dizer o contrário
            backgroundColor: Colors.white,
            child: Icon(Icons.remove_red_eye, color: Colors.green),
          ),
            FloatingActionButton(onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder:(contextNew) => Formulario(taskContext: context)));
            },
              backgroundColor: Colors.white70,
              child: Icon(Icons.arrow_forward, color: Colors.green,),),
          ]
      ),
    );
  }
}


class Task extends StatefulWidget {
  final String nome;
  final String foto;
  final int dificuldade;

  Task(this.nome,this.foto, this.dificuldade,{super.key});

  int nivel = 0; //é antes do @override por que se for depois toda vez que a função ocorrer ele reinicia a função e zera o nível
  //o nível está na classe Task pois se estivesse na classe _TaskState quando rolasse a tela e uma tarefa saisse da tela ela reinicia e o nivel
  //volta a ser zero
  @override
  State<Task> createState() => _TaskState();
  // State<Task> createState1() => _TotalState();
}


class _TaskState extends State<Task> {


  bool AssestOrNet(){
    if(widget.foto.contains('http')){
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.green),

                ///Color não pode ser usado junto com decoration sem estar dentro do BoxDecoration
                height: 140,
              ),
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration
                      (borderRadius: BorderRadius.circular(4),
                      color: Colors.white70,),
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.grey),
                          width: 72,
                          height: 100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),

                            ///ClipRRect para arredondar a imagem pois o decoration não arredonda
                            ///os filhos então ele só arredondou os container
                            child: AssestOrNet() ? Image.asset(widget.foto, fit: BoxFit.cover,) :
                            Image.network(widget.foto,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                width: 200,
                                child: Text(
                                  widget.nome,
                                  style: TextStyle(fontSize: 24),
                                  overflow: TextOverflow.ellipsis,
                                )),
                            Row(
                              children: [
                                Icon(Icons.star, size: 15,
                                    color: (widget.dificuldade >= 1) ? Colors
                                        .green : Colors.green[80]),
                                Icon(Icons.star, size: 15,
                                    color: (widget.dificuldade >= 2) ? Colors
                                        .green : Colors.green[80]),
                                Icon(Icons.star, size: 15,
                                    color: (widget.dificuldade >= 3) ? Colors
                                        .green : Colors.green[80]),
                                Icon(Icons.star, size: 15,
                                    color: (widget.dificuldade >= 4) ? Colors
                                        .green : Colors.green[80]),
                                Icon(Icons.star, size: 15,
                                    color: (widget.dificuldade >= 5) ? Colors
                                        .green : Colors.green[80]),
                              ],
                            ),
                          ],
                        ),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                widget.nivel++; //usa o nivel com o widget. por que ele esta na classe task e nao na _taskstate
                              });
                              print(widget.nivel);
                            },
                            child: Icon(Icons.arrow_drop_up))
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        child:
                        LinearProgressIndicator(
                            color: Colors.indigo,
                            value: (widget.dificuldade > 0) ?
                            (widget.nivel / widget.dificuldade) / 10 : 1

                          ///Se a dificuldade for maior que 0 a gente faz (nivel/dificuldade) / 10 se não nós mudamos a dificuldade para 1
                        ), width: 200,),
                      Text(
                        "Nível: ${widget.nivel}",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              )
            ],
          )

      ),
    );
  }
}


