# Blood-Bank-Management-System
# Project Name: National Blood Bank System 
The National Blood Bank Management System is designed to manage donor registration, blood donations, blood screening, blood inventory, hospital requests, and blood distribution. It provides a centralized database that helps keep accurate records and ensures blood is available and delivered efficiently when needed. 


Group members:
Kwantsimah Orleans Boham   
Amy Ruth Doe Addo   
Sean Arthur   
Lyse Claudia Irera   


Database Management System used 
MariaDB SQL 

Programming Language 
Python 
SQL

Technologies used:  
Python 3.11 - Backend programming language   
Flask	- Web application framework   
SQLAlchemy / Flask-SQLAlchemy - SQLAlchemy was used as the Python ORM for database interaction, while Flask-SQLAlchemy provided integration between SQLAlchemy and                                   the Flask application.   
Flask-Login - User authentication and session management   
Flask-WTF / WTForms	 - Web forms and form validation   
MariaDB	 - Relational database management system    
HTML/CSS/Jinja2	- Frontend and dynamic web pages   
Git/GitHub - Version control and source-code management  

How to install the application   
1. Clone the repository   
git clone https://github.com/itz-Amy/Blood-Bank-Management-System.git  
cd Blood-Bank-Management-System  

2.Create a virtual environment and activate it  
python -m venv .venv  
.venv\Scripts\Activate.ps1(Powershell activation)  or .venv\Scripts\activate(Command Shell)  

3. Install the required Python packages  
pip install -r requirements.txt  

4. Configure environment variables  
Create a .env file containing the application's configuration, including the Flask secret key and MariaDB database connection string  

   

How to create database:  
Import the create_database.sql file  
Import the create_tables.sql file  

How to populate the database   
Import the insert.sql file   
Import the triggers.sql file   
Import the views.sql file   
Import the procedures.sql file   

How to run the application  
We used the terminal to start a local Flask development server.  
Navigate to the project directory and run  - flask run   

Flask will start a local development server, typically at:  
http://127.0.0.1:5000  

Test account credentials  
U001 → Manager@123  
U002 → Phleb@123  
U003 → LabTech@123  
U004 → Hospital@123  

