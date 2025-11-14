---

# 📌 **IOT Based Smart Surveillance System**

A Flutter + IoT based real-time surveillance and attendance tracking system using **RFID**, **Ultrasonic Sensor**, **IR Sensor**, and **GPS** for police personnel and field officers.

---

## 📖 **Overview**

The **IOT Based Smart Surveillance System** is designed to help government and private organizations monitor their field employees (e.g., police personnel) in real-time.
Each officer receives an **RFID card** and uses a **Flutter mobile application** to track duty assignments, update location, and mark attendance through IoT hardware.

The admin can assign duties, view attendance logs, track routes, and monitor employee performance directly through the application interface.


---

## 🎯 **Purpose**

* Ensure field officials actually visit assigned locations.
* Automate attendance using RFID-based presence marking.
* Enable real-time monitoring of personnel routes and locations.
* Improve transparency, accountability, and task management.


---

# 🧩 **System Architecture**

### **1. Mobile Application (Flutter)**

Built using:

* **Flutter**
* **Dart**
* **REST APIs**
* **MySQL database**


Features:

* Login for Admin/User
* Duty assignment & duty history
* Live location updates
* Admin control panel
* User feedback system
* UI includes drawer, tabs, sliders, lists, etc.


---

### **2. IoT Hardware Section**

The hardware setup includes:

* **Arduino Uno**
* **NodeMCU (ESP8266 WiFi)**
* **RFID Sensor**
* **IR Sensor**
* **Ultrasonic Sensor**
* **LCD Display**
* **Jump Wires & Breadboard**


Used for:

* Detecting officer presence (RFID)
* Object proximity (IR)
* Distance measuring (Ultrasonic)
* Displaying scanning results (LCD)

---

# 🔧 **Tools & Technologies**

### 🛠 Tools

* Android Studio
* VS Code
* XAMPP Server
* Arduino IDE
* FlutLab
* DartPad
* Postman
* Any Web Browser


### 💻 Technologies

* **Flutter MUI**
* **Dart**
* **MySQL**
* **IoT Sensors & Microcontrollers**


---

# 🧠 **System Features**

## 👨‍💼 Admin Features

* Admin login
* Create/manage users
* Assign duties dynamically
* Track live location
* Access user history and reports
* Receive real-time notifications of area scans
* Respond to user feedback


---

## 👮 User Features

* User login
* View assigned duties
* Scan RFID for attendance verification
* Update GPS location periodically
* View previous duty history
* Send feedback/complaints


---

# 🗂 **Database Structure**

Tables included:

* LOGIN_TABLE
* CARD_TABLE
* ROUTE_TABLE
* STOP_TABLE
* SCHEDULE_TABLE
* RFID_TABLE
* LOCATION_TABLE
* IR_TABLE
* ULTRASONIC_TABLE
  Each table contains fields like Login_Id, RFID_Value, Route_Id, etc.


---

# 🧬 **Flow Diagrams**

The documentation includes:

* Application Flowchart
* IoT Flowchart
* DFD (Context Level & Level 1)
* Use Case Diagram
* Activity Diagrams (Admin & User)
* ER Diagram
* Circuit Diagram


---

# 📲 **Flutter UI Screenshots**

Includes:

* Home Page
* Slider Gallery
* Drawer Menu
* Product Grid Pages
* Navigation Tabs (Home, Route, Contact)


---

# 📌 **Implementation Summary**

The system successfully integrates:

* IoT hardware for physical attendance,
* Flutter mobile application for real-time tracking,
* Web API backend for data handling,
* MySQL for structured data management.

The project improves surveillance, duty management, and employee monitoring.


---

# 🏁 **Conclusion**

This system delivers a practical and effective method for tracking field personnel.
Organizations can:

* monitor employee performance,
* assign tasks efficiently,
* verify presence using IoT,
* and ensure transparency in field operations.

It enhances productivity and accountability across all departments.


---

# 📚 **References**

* Arduino Documentation
* Robu Sensor Resources
* Make-IT Tutorials
* ScienceDirect


---

