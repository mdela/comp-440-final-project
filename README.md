# Development Setup

## Linux/MacOS

### Install and configure MySQL:
1. ```sudo apt update```
2. ```sudo apt install mysql-server```
3. You may need to configure your root password; otherwise you'll likely get an "access denied" error. 
4. ```sudo apt install mysql-workbench-community```
5. In Workbench, choose either Local instance 3306 as your connection, or create a new one.
6. Create new schema and name it whatever you want (I used "comp440").
7. In comp440_db.sql, right before the first SQL query, add the line ```USE comp440;``` (or whatever you named your schema), and run the script to generate all the tables.

### Install and configure Flask and MySQL connector:

8. ```pip install flask```
9. ```pip install mysql-connector-python```

### Final touches:

10. In app.py, in the ```get_db_connection``` method, make sure ```user```, ```password```, and ```database``` are correct.
11. ```python3 app.py``` will start the app.
12. Point your browser to ```localhost:5000``` :)