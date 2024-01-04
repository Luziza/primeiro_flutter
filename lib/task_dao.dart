
import 'package:primeiro/Database.dart';
import 'package:primeiro/Tarefa.dart';

class TaksDao{

static const String tabelasql = 'CREATE TABLE $_tablename('
    '$_nome TEXT,'
    '$_dificuldade INTEGER,'
    '$_imagem TEXT)';

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
  }

  ///Métodos que procura a tarefa a partir do nome
  Future<List<Task>> Find(String nomeTarefa) async {}

  ///Método que deleta a tarefa
  delete(String nomeTarefa) async {}
}