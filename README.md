
# ResQNet – Disaster Communication & Coordination Platform

## Overview

ResQNet is a disaster-response communication platform designed to help communities stay connected during emergencies. The system enables SOS reporting, community coordination, emergency messaging, resource sharing, and missing-person tracking through a centralized dashboard.

Built as a full-stack application using **Flutter**, **FastAPI**, and **SQLite**, ResQNet focuses on improving communication and situational awareness during disaster scenarios.

---

## Features

### Emergency Messaging

* Create and broadcast emergency messages
* Priority-based message delivery
* Message status tracking
* Multi-hop communication simulation

### SOS Alerts

* One-tap SOS alert generation
* Live alert monitoring
* Emergency response tracking

### Community Hubs

* Create and manage community support hubs
* Track member counts and hub status
* Community coordination during emergencies

### Knowledge Vault

* Store and access emergency preparedness resources
* Create and view informational articles
* Categorized disaster-management content

### Interactive Map

* Visualize safe zones
* Display community hubs
* View SOS alerts on map
* Real-time location awareness

### Missing Persons Registry

* Report missing individuals
* Track last known location
* Store identifying information
* Community-assisted search support

### Verified Organizations

* Display trusted organizations and agencies
* Verification status and trust levels

### Voice Capsules

* Store and share voice-based emergency communications
* Transcript support

---

## Tech Stack

### Frontend

* Flutter
* Dart

### Backend

* FastAPI
* Python

### Database

* SQLite
* SQLAlchemy ORM

### APIs & Libraries

* Flutter Map
* OpenStreetMap
* HTTP Package
* Pydantic

---

## Project Structure

frontend/
│
├── screens/
├── services/
├── widgets/
└── main.dart

backend/
│
├── models.py
├── schemas.py
├── database.py
├── routers/
└── main.py

## Installation

### Backend

```bash
cd backend

python -m venv venv

venv\Scripts\activate

pip install -r requirements.txt

uvicorn main:app --reload
```

Backend runs at:

```text
http://127.0.0.1:8000
```

---

### Frontend

```bash
cd frontend

flutter pub get

flutter run
```

---

## Demo Video

See the complete project demonstration:

```text
demo/ResQNet_Demo_Video.mp4
```

Or view it directly from the repository.

https://github.com/vidhigujarathi512-del/alienshoot

## Future Improvements

- Real Bluetooth/WiFi Direct device-to-device communication
- Automatic peer discovery and relay node formation
- End-to-end encrypted emergency messaging
- AI-powered resource allocation recommendations
- Live disaster heatmaps and risk prediction
- Cross-platform deployment (Android, iOS, Web)
- Satellite communication integration
- Advanced analytics dashboard for disaster response teams

---

## Team

**Vidhi Gujarathi**
IIIT Pune

---

## License

This project was developed for a Hackathon/Innovation Challenge and is intended for educational and demonstration purposes.


```md
# 🛰️ ResQNet
### Connecting Communities During Disasters
```

Looks much more hackathon-worthy 😎🚀.
