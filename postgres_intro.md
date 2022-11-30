# Introduction to Postgres:
## What is Postgres?
PostgreSQL is one of the most advanced general-purpose object-relational database management system and is open-source. Being an open-source software, it's source code is available under PostgreSQL license, a liberal open source license. Anyone with the right skills is free to use, modify, and distribute PostgreSQL in any form.
### <b>Point to remember: Every query ends with a ';'.</b>

## CRUD Operations via CLI
The four most common operations performed with SQL are Create, Read, Update and Delete. Collectively these four operations are often referred to as CRUD. In any application that involves user interaction when these four operations are always there.

To Run any operations; you need to log in to psql terminal in the docker container created in the previous exercise:
```
docker exec -it postgres-container bash
```

```
psql -U postgres -d student_db
```

Here, <br>
-U is the user parameter and we are logging in using the default postgres user <br>
-d is followed by the database name

You would have gotten an error saying `student_db` does not exist. This is ok because we need to create a new DB. So run `psql -U postgres` to exec into Postgres shell. Then you can do `\l` to list all the available databases.

Now create a new database by running the create database command:
```
create database student_db;
```
Once DB is created you can use that DB by running the `\c student_db` command.
```
postgres=# create database student_db;
CREATE DATABASE
postgres=# \c student_db
You are now connected to database "student_db" as user "postgres".
student_db=# 
```
# Describe
First let us see what tables our database has by running:
```
\dt
```
Since there are no tables in our DB it says did not find any relations. So lets create a table.
```
create table student (first_name varchar(20) not null, last_name varchar(20), age int, phone_number numeric);
```
To get the description of the table we can run `\d student` command.


# Create (Insert)
To insert records into the table you use the Insert Command
```sql
INSERT INTO student (first_name, last_name, age, phone_number) VALUES ('John', 'Smith', 18, '1234553');
```
Note that you did not specify the primary keys explicitly. You will see it's effects in a moment.

# Reading/Viewing the data from the table
This is probably something you will do a lot in your journey. For now, let's see how is the table student is holding up.

This is generally called a select query, and the generic structure of a select query looks like

```
SELECT first_name,last_name,age,phone_number FROM student;
```
If you want to just see the names of the students you can do so by

```
SELECT first_name,last_name FROM student;
```

You can specify as many column names as possible which you may want to see in your results provided they exist in the table. If you run `select name from student;` you will run into error as the column 'name' does exist in the table. 


# Updating a record in the table
You will now see how you can update a specific record in the table.

The general structure of an update query in SQL looks like the following:

```
UPDATE table
SET column1 = value1,
    column2 = value2 ,...
WHERE
 condition;
```
You are going to update the record where first_name = "John" and set the age to 20. You will then verify if the record is updated. The query for doing this would be:
```
UPDATE student SET age = 20 WHERE first_name = 'John';
```
Let's see if your update query had the intended effect by running a select query:

# Deleting a record in the table
The general structure of a delete query in SQL looks like following:
```
DELETE FROM table
WHERE condition;
```

You are going to delete the record where first_name = "John" and then verify if the record is deleted. Following the structure, you can see that the following query should be able to do that:

```
DELETE FROM student WHERE first_name = 'John';
```

Keep in mind that the keywords are not case-sensitive in SQL, but the data is case-sensitive. This is why you see a mixture of upper case and lower case in the queries.

Let's see if the intended record was deleted from the table or not. And <b>yes</b>, it indeed deleted the intended record.

