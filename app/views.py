from django.shortcuts import render
import requests


def hello_world(request):
    return render(request, "app/hello.html")


def random_user_profile(request):
    response = requests.get("https://randomuser.me/api/")
    data = response.json()["results"][0]
    context = {
        "name": f"{data['name']['title']} {data['name']['first']} {data['name']['last']}",
        "email": data["email"],
        "picture": data["picture"]["large"],
        "gender": data["gender"],
        "phone": data["phone"],
        "location": {
            "city": data["location"]["city"],
            "country": data["location"]["country"],
        },
    }
    return render(request, "app/profile.html", context)


def current_weather(request):
    city = request.GET.get("city", "Recife")
    response = requests.get(f"https://wttr.in/{city}?format=j1")
    data = response.json()
    current = data["current_condition"][0]
    context = {
        "city": city.title(),
        "temp_celsius": current["temp_C"],
        "feels_like": current["FeelsLikeC"],
        "humidity": current["humidity"],
        "wind_speed": current["windspeedKmph"],
        "description": current["weatherDesc"][0]["value"],
    }
    return render(request, "app/weather.html", context)
