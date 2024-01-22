import 'package:flutter/material.dart';
import 'package:primeiro/Tarefa.dart';
import 'package:primeiro/task_dao.dart';


class Formulario extends StatefulWidget {
  const Formulario({Key? key, required this.taskContext}): super(key: key);
  ///É obrigatório ter o parametro taskContext nessa classe

  final BuildContext taskContext;

  @override
  State<Formulario> createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {

  TextEditingController imagemController = TextEditingController();
  TextEditingController dificuldadeController = TextEditingController();
  TextEditingController nomeController = TextEditingController();

  ///chave global de estado de formulário. Tudo que está dentro do form e for um validador ele vai estar de olho
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
          appBar: AppBar(
            title: Text("Cadastro"),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Container(
                height: 650,
                width: 375,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.green,
                  border: Border.all(width: 2),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Cadastro", style: TextStyle(fontSize: 40, color: Colors.white70),),
                    ///Preencher nome completo
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        validator: (String? value){
                          if(value != null && value.isEmpty){
                            return 'Insira o nome';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        controller: nomeController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Nome completo:",
                            fillColor: Colors.white70,
                            filled: true
                        ),
                      ),
                    ),

                    ///Preencher dificuldade
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        validator: (value){
                          if(value!.isEmpty || int.parse(value) > 5 || int.parse(value) < 1) {
                            return 'Insira a dificuldade entre 1 e 5';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        controller: dificuldadeController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Dificuldade:",
                            fillColor: Colors.white70,
                            filled: true
                        ),
                      ),
                    ),

                    ///Preencher imagem
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        onChanged: (text){
                          setState(() {

                          });
                        },
                        validator: (String? value){
                          if(value!.isEmpty){
                            return 'Insira uma URL';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.url,
                        controller: imagemController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Imagem:",
                            fillColor: Colors.white70,
                            filled: true
                        ),
                      ),
                    ),
                    ///Onde aparece a imagem
                    Container(
                      height: 190,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          imagemController.text, fit: BoxFit.cover,
                          ///nÃO DEU CERTO o errorbuilder!!!!
                        ),
                      ),
                    ),

                    ///Botão de adicionar
                    ElevatedButton(onPressed:
                        () async {
                      if(_formKey.currentState!.validate()) {
                        // print(imagemController.text);
                        // print(int.parse(dificuldadeController.text));
                        // print(nomeController.text);
                        await TaskDao().save(Task(nomeController.text,imagemController.text, int.parse(dificuldadeController.text)));
                        ///Função de criar nova tarefa
                        ///SnackBar mostra uma mensagem quando todos os campos são validados
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar
                          (content: Text('Nova tarefa criada'),));
                        Navigator.pop(context);
                      }
                    }, child: Text("Adicionar"),)
                  ],),
              ),
            ),
          )
      ),
    );
  }
}