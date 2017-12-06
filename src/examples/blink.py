# Import des modules
import RPi.GPIO as GPIO
import time

# Initialisation de la numerotation et des E/S
GPIO.setmode(GPIO.BOARD)
GPIO.setup(3, GPIO.OUT, initial = GPIO.HIGH)

# On fait clignoter la LED
while True:
    GPIO.output(3, not GPIO.input(3))
    time.sleep(0.001)