# Movie Review App
Our COMP 440 Final Project! Here's how to run it locally depending on your operating system. :)

## Prerequisites

Before running the application, make sure you have the following installed:

- Python 3.x
- pip

## MySQL Database

1. Install MySQL server on your machine if not already installed.
2. Create a new database named `comp440`.
3. Execute the SQL script provided in `comp440_db_05162024.sql` to create the necessary tables and populate them with some data.

## Running the Application

### Windows

1. Open Command Prompt.
2. Navigate to the directory where `app.py` is located.
3. Install the required Python packages: `pip install flask mysql-connector-python`
4. Run the Flask application: `python3 app.py`
5. Access the application at `http://localhost:5000` in your web browser.

### macOS and Ubuntu
1. Open Terminal.
2. Navigate to the directory where `app.py` is located.
3. Install required Python packages: `pip install flask mysql-connector-python`
4. Run the Flask application: `python3 app.py`
5. Access the application at `http://localhost:5000` in your web browser.
