# Python CRUD (Create, Read, Update & Delete)

The PostgreSQL can be integrated with Python using psycopg2 module. psycopg2 is a PostgreSQL database adapter for the Python programming language. psycopg2 was written with the aim of being very small and fast, and stable as a rock. You do not need to install this module separately because it is shipped, by default, along with Python version 2.5.x onwards.

To use psycopg2 module, you must first create a Connection object that represents the database and then optionally you can create cursor object which will help you in executing all the SQL statements.

### Connecting to Database:

The following python code shows how to connect to an existing database. If the database does not exist, then it will be created and finally a database object will be returned.

```python
import psycopg2

conn = psycopg2.connect(database="student_db", user = "postgres", password = "postgres", host = "postgres-service", port = "5432")

print("Opened database successfully")
```
<b>INSERT</b> Operation:

The following python program shows how we can create records in our student table
```python
cur = conn.cursor()

cur.execute("INSERT INTO student (first_name, last_name, age, phone_number) VALUES ('Paul', 'Smith', 17, 7894561114)");

cur.execute("INSERT INTO student VALUES ('Allen', 'Texas',  25, 8994506101)");

cur.execute("INSERT INTO student (phone_number, last_name, age, first_name) VALUES (8541112478, 'Banks',  20, 'Samuel')");

cur.execute("INSERT INTO student VALUES ('John', 'Manning',  60, 9587774877)");

conn.commit()
print("Records created successfully");
conn.close()
```

<b>SELECT</b> Operation:

The following python program shows how we can fetch and display records from our student table created in the above example

```python
import psycopg2

conn = psycopg2.connect(database="student_db", user = "postgres", password = "postgres", host = "postgres-service", port = "5432")
cur = conn.cursor()

cur.execute("SELECT first_name, last_name, age, phone_number FROM student;")
rows = cur.fetchall()
for row in rows:
   print("FIRST NAME = ", row[0])
   print("LAST NAME = ", row[1])
   print("AGE = ", row[2])
   print("PHONE = ", row[3])

print("Operation done successfully")
conn.close()
```

<b>DELETE</b> Operation:

The following python code shows how we can use the DELETE statement to delete any record and then fetch and display the remaining records from our student table

```python
import psycopg2

conn = psycopg2.connect(database="student_db", user = "postgres", password = "postgres", host = "postgres-service", port = "5432")
print("Opened database successfully")

cur = conn.cursor()

cur.execute("DELETE from STUDENT where age = 20;")
conn.commit()
print("Total number of rows deleted :", cur.rowcount)
cur.execute("SELECT first_name, last_name, age, phone_number FROM student;")
rows = cur.fetchall()
for row in rows:
   print("FIRST NAME = ", row[0])
   print("LAST NAME = ", row[1])
   print("AGE = ", row[2])
   print("PHONE = ", row[3])

print("Operation done successfully")
conn.close()
```