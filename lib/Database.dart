import 'package:primeiro/task_dao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

///Método tipo Future é quando o método precisa se conectar com algo de fora, como pos
///exemplo um banco da dados e é tipo Database
Future<Database> getDataBase()
  async{
  ///Path é o local no aparelho onde o banco de dados vai ser salvo
  final String path = join(
      await getDatabasesPath(), 'task.db'
  );
      ///O getDatabasesPath procura no dispositivo o caminho perfeito pra salvar arquivos
      ///task.db é o nome do banco
  return openDatabase(path, onCreate: (db, version){
                            ///se o caminho não existir ele irá criar
    db.execute(TaskDao.tabelasql);}, version: 1);
}
