## Python Identifiers
A Python identifier is a name used to identify a variable, function, class, module or other object. An identifier starts with a letter A to Z or a to z or an underscore (_) followed by zero or more letters, underscores and digits (0 to 9).

Python does not allow punctuation characters such as @, $, and % within identifiers. Python is a case sensitive programming language. Thus, Manpower and manpower are two different identifiers in Python.

Here are naming conventions for Python identifiers:

- Class names start with an uppercase letter. All other identifiers start with a lowercase letter.

- Starting an identifier with a single leading underscore indicates that the identifier is private.

- Starting an identifier with two leading underscores indicates a strong private identifier.

- If the identifier also ends with two trailing underscores, the identifier is a language-defined special name.

## Reserved Words
The following list shows the Python keywords. These are reserved words and you cannot use them as constants or variables or any other identifier names. All the Python keywords contain lowercase letters only.
They are: `and, exec, not, as, finally, or, assert, for, pass, break, from, print, class, global, raise, continue, if, return, def, import, try, del, in, while, elif, is, with, else, lambda, yield, except`.

## Lines and Indentation
Python does not use braces({}) to indicate blocks of code for class and function definitions or flow control. Blocks of code are denoted by line indentation, which is rigidly enforced.

The number of spaces in the indentation is variable, but all statements within the block must be indented the same amount. For example:
```python
if True:
   print ("True")
else:
   print ("False")
```
### The following example has various statement blocks:

Note: Do not try to understand the logic at this point of time. Just make sure you understood the various blocks even 
if they are without braces.
```python
#!/usr/bin/python3
import sys

file_finish = "end"
file_text = ""
contents=[]

file_name=input("Enter filename: ")
if len(file_name) == 0:
   print("Please enter filename")
   sys.exit()

try:
   # open file stream
   file = open(file_name, "w")

except IOError:
   print ("There was an error writing to", file_name)
   sys.exit()

print ("Enter '", file_finish,)
print ("' When finished")

while file_text != file_finish:
   file_text = input("Enter text: ")
   contents.append(file_text)

   if file_text == file_finish:
      # close the file
      file.close()
      break

print(contents)
data = ' '.join([str(elem) for elem in contents])  
print(data)
file.write(data)
file.close()
file_name = input("Enter filename: ")

if len(file_name) == 0:
   print ("Next time please enter something")
   sys.exit()

try:
   file = open(file_name, "r")

except IOError:
   print ("There was an error reading file")
   sys.exit()
file_text = file.read()
file.close()
print (file_text)
```

## Multi-Line Statements
Statements in Python typically end with a new line. Python, however, allows the use of the line continuation character ( \\ ) to denote that the line should continue. For example:
```python
total = 1 + \
   2 + \
   3
```
## Quotation in Python
Python accepts single ('), double (") and triple (''' or """) quotes to denote string literals, as long as the same type of quote starts and ends the string.

The triple quotes are used to span the string across multiple lines. For example, all the following are legal:
```python
word = 'word'
sentence = "This is a sentence."
paragraph = """This is a paragraph. It is
made up of multiple lines and sentences."""
```
## Comments in Python
A hash sign (#) that is not inside a string literal is the beginning of a comment. All characters after the #, up to the end of the physical line, are part of the comment and the Python interpreter ignores them.
```python
#!/usr/bin/python3
# First comment
print ("Hello, Python!") # second comment
```
