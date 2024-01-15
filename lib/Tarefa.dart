import 'package:flutter/material.dart';
import 'package:primeiro/Formulario.dart';
import 'package:primeiro/task_dao.dart';


class Tarefa extends StatefulWidget {
  const Tarefa({Key? key}) : super (key: key);

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
        actions: [
          IconButton(onPressed: () {
            setState(() {});
          }, icon: Icon(Icons.refresh, color: Colors.green,))
        ],
        title: Text('Flutter: Primeiros passos'),
      ),
      body: Padding(
          padding: EdgeInsets.only(top: 8, bottom: 100),
          child: FutureBuilder<List<Task>?>(
              future: TaskDao().findAll(), builder: (context, snapshot) {
            ///esse tipo de ListView.builder só constroe as tarefas que aparecem na
            ///tela e quando vocês escrola pra baixo ele vai construindo as outras
            List<Task>? itens = snapshot.data;

            ///snapshot é responsavel pelos dados
            ///
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Center(
                  child: Column(
                    children: const [
                      CircularProgressIndicator(),
                      Text('Carregando'),
                    ],
                  ),
                );
              case ConnectionState.waiting:
                return Center(
                  child: Column(
                    children: const [
                      CircularProgressIndicator(),
                      Text('Carregando'),
                    ],
                  ),
                );
                break;
              case ConnectionState.active:
                return Center(
                  child: Column(
                    children: const [
                      CircularProgressIndicator(),
                      Text('Carregando'),
                    ],
                  ),
                );
                break;
              case ConnectionState.done:
                if (snapshot.hasData && itens != null) {
                  ///verifica se o snapshot tem dados e se ele não é null
                  if (itens.isNotEmpty) {
                    return ListView.builder(
                        itemCount: itens.length,
                        itemBuilder: (BuildContext context, int index) {
                          final Task tarefa = itens[index];
                          return tarefa;
                        });
                  }

                  ///return para caso o itens esteja vazio e não tenha nenhuma tarefa adicionada
                  return Center(
                    child: Column(
                      children: [
                        Icon(Icons.error_outline),
                        Text("NENHUMA TAREFA")
                      ],
                    ),
                  );
                }
                return Text('erro ao carregar tarefas');
            }
          })),

      ///Future pega as informações no banco de dados e o builder constroe elas na tela
      floatingActionButton:
      Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(
          onPressed: () {
            setState(() {
              opacidade = !opacidade;
            });
          },

          ///! quer dizer o contrário
          backgroundColor: Colors.white,
          child: Icon(Icons.remove_red_eye, color: Colors.green),
        ),
        FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (contextNew) => Formulario(taskContext: context)
                )
            ).then((value) =>
                setState(() =>
                {
                  print("Regarregando...")
                }));

            ///com o push vamos pra tela de formulario e quando voltarmos o then ele recarrega a página e a tarefa aparece sem precisar da hot reload
          },
          backgroundColor: Colors.white70,
          child: Icon(
            Icons.arrow_forward,
            color: Colors.green,
          ),
        ),
      ]),
    );
  }
}

class Task extends StatefulWidget {
  final String nome;
  final String foto;
  final int dificuldade;

  Task(this.nome, this.foto, this.dificuldade, {super.key});

  int nivel =
  0; //é antes do @override por que se for depois toda vez que a função ocorrer ele reinicia a função e zera o nível
  //o nível está na classe Task pois se estivesse na classe _TaskState quando rolasse a tela e uma tarefa saisse da tela ela reinicia e o nivel
  //volta a ser zero
  @override
  State<Task> createState() => _TaskState();
// State<Task> createState1() => _TotalState();
}

class _TaskState extends State<Task> {
  bool AssestOrNet() {
    if (widget.foto.contains('http')) {
      return false;
    }
    return true;
  }


  Future dialogo(BuildContext context) {
    return showDialog(context: context,
        builder: (context) =>
            AlertDialog(content: Text('Tem certeza que deseja excluir?'),
                actions: [
                TextButton(onPressed: () {
                  Navigator.of(context).pop(false);
                }, child: Text('Sim')),
                TextButton(onPressed: () {
                  Navigator.of(context).pop(true);
                }, child: Text('Não'))],
    );
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
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.white70,
                    ),
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
                            child: AssestOrNet()
                                ? Image.asset(
                              widget.foto,
                              fit: BoxFit.cover,
                            )
                                : Image.network(
                              widget.foto,
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
                                Icon(Icons.star,
                                    size: 15,
                                    color: (widget.dificuldade >= 1)
                                        ? Colors.green
                                        : Colors.green[80]),
                                Icon(Icons.star,
                                    size: 15,
                                    color: (widget.dificuldade >= 2)
                                        ? Colors.green
                                        : Colors.green[80]),
                                Icon(Icons.star,
                                    size: 15,
                                    color: (widget.dificuldade >= 3)
                                        ? Colors.green
                                        : Colors.green[80]),
                                Icon(Icons.star,
                                    size: 15,
                                    color: (widget.dificuldade >= 4)
                                        ? Colors.green
                                        : Colors.green[80]),
                                Icon(Icons.star,
                                    size: 15,
                                    color: (widget.dificuldade >= 5)
                                        ? Colors.green
                                        : Colors.green[80]),
                              ],
                            ),
                          ],
                        ),

                        Column(

                          children: [
                            ElevatedButton(onPressed: () {
                              setState(() {
                                dialogo(context).then((value) =>{
                                if (value == true){
                                TaskDao().delete(widget.nome)
                                }
                                });
                              });
                            }, child: Text('Excluir')),
                            ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    widget
                                        .nivel++; //usa o nivel com o widget. por que ele esta na classe task e nao na _taskstate
                                  });
                                  print(widget.nivel);
                                },
                                child: Icon(Icons.arrow_drop_up)),
                          ],
                        ),


                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        child: LinearProgressIndicator(
                            color: Colors.indigo,
                            value: (widget.dificuldade > 0)
                                ? (widget.nivel / widget.dificuldade) / 10
                                : 1

                          ///Se a dificuldade for maior que 0 a gente faz (nivel/dificuldade) / 10 se não nós mudamos a dificuldade para 1
                        ),
                        width: 200,
                      ),
                      Text(
                        "Nível: ${widget.nivel}",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              )
            ],
          )),
    );
  }
}
