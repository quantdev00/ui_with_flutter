const createDbQuery = """
CREATE TABLE "todo_table" (
	"todoId"	INTEGER NOT NULL,
	"todoText"	TEXT NOT NULL,
	"isChecked"	INTEGER NOT NULL,
	PRIMARY KEY("todoId" AUTOINCREMENT)
);
""";

const todoTableName = 'todo_table';
const dbName = 'todo.db';
const todoIdColumn = 'todoId';
const todoTextColumn = 'todoText';
const todoIsCheckedColumn = 'isChecked';
