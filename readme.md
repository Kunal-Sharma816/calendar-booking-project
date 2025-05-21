# 📅 Calendar Booking Application

This is a full-stack **Calendar Booking App** built using:

- 🚀 **Node.js (Express)** + **MongoDB Atlas** for the backend  
- 💙 **Flutter** for the frontend

The app allows users to:

- ✅ Create new bookings if the time slot is available  
- 📋 View all bookings  
- 🔍 Search bookings by booking ID  
- 🏢 Filter bookings based on meeting room ID  

---

## 📁 Project Structure

- backend/ # Express.js API
- booking_app/ # Flutter frontend


---

## 🔧 Backend Setup (Node.js + MongoDB Atlas)

### 📌 Prerequisites

- Node.js (v18+ recommended)
- Express.js latest-versions
- MongoDB Atlas database URI- "go for .env_example"
- Postman for API testing

### 📦 Installation

```bash
cd backend
npm install



🔐 Eniroment setup 

PORT = 3000
MONGO_URI = mongodbAtlas in .env_example


``` run-command
npm run dev


### API-END points

- GET request getAllBookings = "MONGO_URI/bookings"
- GET request getBookingById = "MONGO_URI/bookings/:bookingId"
- POST request createBooking = "MONGO_URI/bookings"
- GET request getBookingByRoomId = "MONGO_URI/bookings/room/meetingRoomId"


### Flutter - frontend 

``` run commnads
- flutter run -d chrome

