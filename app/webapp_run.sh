python3 manage.py makemigrations student
python manage.py migrate
python3 manage.py createsuperuser --noinput --email django_admin@djangoapp.com
python3 manage.py runserver 0:8000
