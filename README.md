# Plantsdom

This is the documentation of the final project for the Database Systems course of the “Computer Science” master degree, held in University of Bari “A. Moro”. The project is based on the specifications of the written exam. 

This project is developed in Java and interfaces with the Oracle 11g DBMS. It uses object-relational features (who the hell uses them, by the way?). 

To set the project up, you have to first run the SQL script SetDatabase on an empty database: this will create all the types, procedures, triggers, and even populate the tables with random data.
Then, you have to change the credentials in the Config.java file according to your DB user.

Also, you have to add the additional JARs to the project from the external-jars archive. In Eclipse you have to right click on your project > Properties > Choose Java Build Path > Libraries tab > Click Add External JARs...
And then add all the jars from the external-jars archive.
