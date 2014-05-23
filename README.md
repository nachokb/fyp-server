## Find Your Pet
### (by K.I.S.S.)

- [Initial Idea](https://docs.google.com/a/inakanetworks.com/document/d/1k6FhajekNjMhLei1u_4JP8VCTYHMPcjvjc5k1ABQg58/edit#heading=h.r0dbw92pl076)

The goal of this app is to help the owner find their lost dog or cat.
Every owner who lost a pet will be able to add a lost report in the system giving specific information about it such as color, age, size, gender, photo, place where it was lost.
When someone finds a lost pet or sees it, will be able to access the application and search for it. 
If someone sees a lost pet, they will be able to fill a “seen report” with the description, photo and place where they last saw it.
If someone finds a lost pet, they will be able to fill a “found report” with the same info.
When someone reports a seen or found pet that matches the description of your lost pet, you get a notification and you can see the reports associated to your report.
When you enter the mobile app it will show you the list of pets that are lost and reported last seen in that area.


### API Endpoints
http://find-your-pet.herokuapp.com/

GET /reports # shows all reports, probably sorted or filteres by geolocation

POST /reports # hey, I've lost a pet

GET /reports/XYZ/candidates # shows sightings which our super AI thinks might match report XYZ

GET /sightings # shows all sightings, probably sorted or filtered by geolocation

POST /sightings # hey, I've found a Philosoraptor!

GET /sightings/ZYX/candidates # shows reports which our super AI thinks might match sighting ZYX
