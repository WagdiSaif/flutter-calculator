# calculator

A new Flutter project.

## Getting Started

Flutter Scientific Calculator
A feature-rich scientific calculator app built with Flutter, featuring advanced mathematical expression parsing and a clean, intuitive interface.

# Features
## Core Functions
Basic arithmetic: +, -, ×, ÷
Power operations: x^y, x^-1
Square root & nested roots: √x
Factorials: n!
Percentages: smart context-aware handling
Parentheses: automatic balancing
## Scientific Functions
Trigonometric: sin, cos, tan (degree mode)
Inverse trig: sin⁻¹, cos⁻¹, tan⁻¹
Logarithms: log, ln
Constants: π, e

## Smart Parsing
Converts display symbols to evaluable expressions
Handles implicit multiplication: 2π, 2.ln(2)
Auto-closes parentheses: sin(30 → sin(30)
Nested function support: sin(cos(30))
Factorial-exponent precedence: 9!^2 → (9!)^2
Percentage inside expressions: 5!%2, (2+3)^(2%)
## User Interface
Clean, modern layout
Light/Dark theme toggle
Scrollable calculation history
expression formatting
# Screenshots
<div align="center">
  <img src="screenshots/simple_mode_dark.png" width="200" alt="Light Mode"/>
  <img src="screenshots/scientific_mode_dark.png" width="200" alt="Dark Mode"/>
   <img src="screenshots/simple_mode_light.png" width="200" alt="Dark Mode"/>
     <img src="screenshots/scientific_mode_light.png" width="200" alt="Dark Mode"/>
       <img src="screenshots/history.png" width="200" alt="Dark Mode"/>


</div>

## Installation
# Clone the repository
https://github.com/WagdiSaif/flutter-calculator.git

# Navigate to project folder
cd flutter-calculator

# Install dependencies
flutter pub get

# Run the app
flutter run

# Key Implementation Highlights
Uses GrammerParser for parsing expressions
Custom handling for precision, roots, and angles
Smart percentage & factorial-exponent evaluation
Auto parentheses and implicit multiplication detection
Supports nested functions and mixed operations

# License
This project is licensed under the MIT License – see the LICENSE file for details.
