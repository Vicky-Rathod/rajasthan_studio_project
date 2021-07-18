# Rajasthan Studio Interview Project

This project is built using Django-Rest-Framework and Flutter.


## Basic Purpose of project :
     


   :heavy_check_mark: Fetch Excel data of coaches as json
   

   :heavy_check_mark: Returns time interval in 30 mins time slot
   
   :heavy_check_mark: Create Appointment with coach.

## API URLS : 
   Fetch list of Coaches :
   1. https://rajasthanstudio.pythonanywhere.com/coach/coach-list/
   
   Fetches 30 min Time Interval of the particular coach. 

   2. https://rajasthanstudio.pythonanywhere.com/coach/coach/
  
   Create Appointment with the coach.

   3. https://rajasthanstudio.pythonanywhere.com/coach/appointment/

## Installation

Use the package manager [pip](https://pip.pypa.io/en/stable/) to install foobar.

```bash
pip install -r requirements.txt
```

## Steps to Test/Run Application
To run Django project :

1. First migrate the project, 
   
    a. To migrate open the backend folder and run the following command in the console
```bash
python manage.py makemigrations
```
```bash
python manage.py migrate
```

 2. Test the Application.
     
    a. run the following command in console :
```bash
python manage.py test
```
 3. Run the Application.
   
    a. run the following command in console :
```bash
python manage.py runserver
```

#   ScreenShots:


![alt text](https://rajasthanstudio.pythonanywhere.com/media/1.jpg)


![alt text](https://rajasthanstudio.pythonanywhere.com/media/2.jpg)


![alt text](https://rajasthanstudio.pythonanywhere.com/media/3.jpg)


![alt text](https://rajasthanstudio.pythonanywhere.com/media/4.jpg)

## Hard /  Confusing / Frustrating About the Task :
   a. One of the most hardest things was to decide whether to import excel to database or fetch it as it is.

