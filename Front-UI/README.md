# OKAPI animal care workspace

A lightweight browser-based frontend prototype for the OKAPI animal care project.

## Run it

Open `index.html` in a browser. No build step or package installation is required.

## Current scope

- Responsive overview, animal directory, medical records, and appointment screens.
- Search the animal directory and medical records.
- Add an animal to the demo directory; changes persist in this browser using `localStorage`.
- Sample data is intentionally used throughout the interface.

This is a frontend-only prototype. It does **not** connect to MySQL or the Java DAO classes. The Java project currently
has no HTTP API for browser requests. To use live data, add a Java backend API that calls the DAOs and returns JSON,
then replace the demo data in `app.js` with requests to those endpoints.
