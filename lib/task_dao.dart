
import 'package:primeiro/Database.dart';
import 'package:primeiro/Tarefa.dart';
import 'package:sqflite/sqflite.dart';

class TaksDao{

static const String tabelasql = 'CREATE TABLE $_tablename('
    '$_nome TEXT,'
    '$_dificuldade INTEGER,'
    '$_imagem TEXT)';

/// _ quer dizer que é privado
static const String _tablename = 'taskTable';
static const String _nome = 'nome';
static const String _dificuldade = 'dificuldade';
static const String _imagem = 'imagem';

  ///Salvar a tarefa
  save(Task tarefa) async {}

  ///Metódo que procura todas as tarefas, retorna lista de tarefas e como demora
///um pouco ela é tio future que retorna uma lista de tasks
  Future<List<Task>> findAll() async {
    final Database banco = await getDataBase(); ///o banco recebe o método getDataBase pra achar o caminho onde está o banco
    final List<Map<String, dynamic>> resultado = banco.query(_tablename); ///O query le do banco de dados a tabela _tablename
    ///O mapa recebe a key e o value. A key é o tipo que é STRING e o value é dynamic pois o nome, dificuldade e imagem são alteraveis
    return toList(resultado);
        ///A função retorna uma lista de objetos e não de mapas, então vamos fazer uma função que coverte mapa pra lista
  }

  List<Task> toList(List<Map<String, dynamic>> listaTarefas){
    final List<Task> tarefas = []; ///lista de tarefas vazias onde vamos adicionar os mapas convertidos em tarefas
    ///o for verifica cada linha do mapa na lista de tarefas
    for (Map<String, dynamic> linha in listaTarefas){
      ///
      final Task tarefa = Task(linha[_nome], linha[_imagem], linha[_dificuldade]);
      tarefas.add(tarefa);
    }
    print('Lista de tarefas $tarefas');
    return tarefas;
  }

  ///Métodos que procura a tarefa a partir do nome
  Future<List<Task>> Find(String nomeTarefa) async {
    final Database banco = await getDataBase(); ///Abrindo o banco novamente
    final List<Map<String, dynamic>> resultado = banco.query(
        _tablename where: '$_nome = ?', ///a ? é usada para comparar a informação do banco e a que queremos que seja comparada
      whereArgs: [nomeTarefa,]; ///É o que estamos buscando
    );
    print('Tarefa encontrada ${toList(result)}');
    return toList(result); ///Como esta em mapa usa a toList que criamos
  }

  ///Método que deleta a tarefa
  delete(String nomeTarefa) async {}
}