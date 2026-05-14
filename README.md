# Weatherapp

![Ruby](https://img.shields.io/badge/Ruby_on_Rails-0d1117?style=flat-square&logo=rubyonrails&logoColor=58a6ff)
![HTML](https://img.shields.io/badge/HTML-0d1117?style=flat-square&logo=html5&logoColor=58a6ff)
![Docker](https://img.shields.io/badge/Docker-0d1117?style=flat-square&logo=docker&logoColor=58a6ff)

A full-stack weather web application built with Ruby on Rails. Enter a location and get current weather conditions pulled from a live API, served through a clean and responsive interface. Containerized with Docker and deployable with Kamal.

---

### Features

- 🌤 &nbsp;Live weather data fetched from an external weather API
- 🗺 &nbsp;Location-based search
- 🐳 &nbsp;Fully containerized with Docker
- 🚀 &nbsp;Production-ready deployment with Kamal
- 🧪 &nbsp;Test suite included

---

### Getting Started

**Prerequisites:** Ruby, Bundler, Docker (optional)

**1. Clone the repo**
```bash
git clone https://github.com/pauloshabtewold/Weatherapp.git
cd Weatherapp
```

**2. Install gems**
```bash
bundle install
```

**3. Set up the database**
```bash
rails db:create db:migrate
```

**4. Configure your weather API key**

Add your key to the credentials or environment config:
```bash
WEATHER_API_KEY=your_key_here
```

**5. Start the server**
```bash
bin/dev
```

App runs at `http://localhost:3000`

---

### Running with Docker

```bash
docker build -t weatherapp .
docker run -p 3000:3000 weatherapp
```

---

### Project Structure

```
Weatherapp/
├── app/            # Rails MVC (models, views, controllers)
├── config/         # Routes, credentials, environments
├── db/             # Schema and migrations
├── test/           # Test suite
├── Dockerfile      # Container definition
└── .kamal/         # Kamal deployment config
```

---

### Built by [Paulos Habtewold](https://github.com/pauloshabtewold) · [LinkedIn](https://www.linkedin.com/in/paulos-habtewold-7b6b72235/)
