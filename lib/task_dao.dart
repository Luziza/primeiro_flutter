import 'package:primeiro/Database.dart';
import 'package:primeiro/Tarefa.dart';
import 'package:sqflite/sqflite.dart';

class TaskDao {
  static const String tabelasql = 'CREATE TABLE $_tablename('
      '$_nome TEXT,'
      '$_dificuldade INTEGER,'
      '$_imagem TEXT,'
      '$_nivel INTEGER';

  /// _ quer dizer que é privado
  static const String _tablename = 'taskTable';
  static const String _nome = 'nome';
  static const String _dificuldade = 'dificuldade';
  static const String _imagem = 'imagem';
  static const String _nivel = 'nivel';


  //----------------------------------------------------SAVE---------------------------------------------//



  ///Salvar a tarefa
  save(Task tarefa) async {
    final Database banco = await getDataBase();
    var itemExiste = await find(tarefa.nome);
    Map<String, dynamic> taskMap = toMap(tarefa); ///recebe a tarefa e transformar em mapa

    ///usamos a função find que criamos pra ver se a tarefa já foi criada antes
    if (itemExiste.isEmpty) {
      print('Não existia');
      return await banco.insert(_tablename, taskMap); ///se a tarefa não existe ela insere no banco
      ///o values(o taskMap) requer informação tipo mapa
    } else {
      print('já existia');
      return await banco.update(
        _tablename, taskMap, where: '$_nome = ?', whereArgs: [tarefa.nome],); ///se a tarefa existe ela faz um, update na tabela com os
      ///valores novos onde o nome é substituido pelo nome da tarefa antiga
    }
  }

  ///converter as tarefas em mapa pro banco de dados aceitar
  Map<String, dynamic> toMap(Task tarefa ///vai pedir a Task e o nome vai ser tarefa
  ){
    final Map<String, dynamic> mapaTarefas = Map(); ///Criou um mapa vazio
    mapaTarefas[_nome] = tarefa.nome;
    mapaTarefas[_dificuldade] = tarefa.dificuldade;
    mapaTarefas[_imagem] = tarefa.foto;
    mapaTarefas[_nivel] = tarefa.nivel;///adiciona esses 3 valores no mapa de tarefas
    return mapaTarefas;
  }


  //--------------------------------------------------FINDALL---------------------------------------------------------------------------------//
  ///Metódo que procura todas as tarefas, retorna lista de tarefas e como demora
  ///um pouco ela é tipo future que retorna uma lista de tasks
  Future<List<Task>> findAll() async {
    final Database banco = await getDataBase();

    ///o banco recebe o método getDataBase pra achar o caminho onde está o banco
    final List<Map<String, dynamic>> resultado = await banco.query(_tablename);

    ///O query le do banco de dados a tabela _tablename
    ///O mapa recebe a key e o value. A key é o tipo que é STRING e o value é dynamic pois o nome, dificuldade e imagem são alteraveis
    return toList(resultado);

    ///A função retorna uma lista de objetos e não de mapas, então vamos fazer uma função que coverte mapa pra lista
  }

  List<Task> toList(List<Map<String, dynamic>> listaTarefas) {
    final List<Task> tarefas = [];

    ///lista de tarefas vazias onde vamos adicionar os mapas convertidos em tarefas
    ///o for verifica cada linha do mapa na lista de tarefas
    for (Map<String, dynamic> linha in listaTarefas) {
      ///
      final Task tarefa = Task(
          linha[_nome], linha[_imagem], linha[_dificuldade], linha[_nivel]);
      tarefas.add(tarefa);
    }
    print('Lista de tarefas $tarefas');
    return tarefas;
  }

  //-------------------------------------------------------FIND-----------------------------------------------------//
  ///Métodos que procura a tarefa a partir do nome
  Future<List<Task>> find(String nomeTarefa) async {
    final Database banco = await getDataBase();

    ///Abrindo o banco novamente
    final List<Map<String, dynamic>> resultado = await banco.query(
        _tablename ,where: '$_nome = ?',

        ///a ? é usada para comparar a informação do banco e a que queremos que seja comparada
        whereArgs: [nomeTarefa,]

      ///É o que estamos buscando
    );
    print('Tarefa encontrada ${toList(resultado)}');
    return toList(resultado);

    ///Como esta em mapa usa a toList que criamos
  }

  //-------------------------------------------------DELETE------------------------------------------------//
  ///Método que deleta a tarefa
  delete(String nomeTarefa) async {
    final Database banco = await getDataBase();
    return banco.delete(_tablename, where: '$_nome = ?', whereArgs: [nomeTarefa],);
    ///dele a partir da tabela _tablename no local onde tem os nomes onde ve se
    ///o nomeTarefa é o mesmo nome dado ao métodos delete, e se é igual ele apaga
  }
}

//-------------------------------------------UPDATE----------------------------------------------------------//

