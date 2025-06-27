from django.urls import path
from . import views

urlpatterns = [
    path('', views.hello_world, name='hello_world'),
    path('profile/', views.random_user_profile, name='random_user_profile'),
    path('weather/', views.current_weather, name='current_weather'),
]
