# README

# Patients Doctors App

Backend application built with Ruby on Rails for managing patients and doctors with BMR and BMI calculations.  

## Features:

- CRUD for patients and doctors
- Many-to-many relationship between patients and doctors
- Filtering and pagination for patient lists
- BMR calculation using formulas: Mifflin–St. Jeor and Harris–Benedict
- BMR calculation history
- BMI calculation via external API
- Containerized with Docker Compose + PostgreSQL

---
## Ruby Version

ruby 3.4.5

---

## System Dependencies

- Docker
- Docker Compose
- PostgreSQL (15) — runs in Docker container

---

## Configuration

- Database settings are configured via `docker-compose.yml`.

---
## Quick Start

### 1. Clone the repository
```bash
git clone https://github.com/ginormousnut/backend-app-Ruby-on-Rails.git
cd backend-app-Ruby-on-Rails
```
### 2. Run command line
```bash
docker-compose -f docker-compose.yml up -d
```
