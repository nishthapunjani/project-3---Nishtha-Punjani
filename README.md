# project-3---Nishtha-Punjani  https://onecompiler.com/postgresql/4463zr2v4
Project: Event Management System using PostgreSQL. Objective: To develop the application that allows users to create and manage events, track attendees, and handle event registrations efficiently. The project will include the following tasks:


-- 1.Database Creation

CREATE TABLE Events (
  Event_Id VARCHAR (10) PRIMARY KEY,
  Event_Name VARCHAR (100),
  Event_Date Date,
  Event_Location VARCHAR (100),
  Event_Description VARCHAR (100)
);
CREATE TABLE Attendees (
  Attendee_Id VARCHAR (10) PRIMARY KEY,
  Attendee_Name VARCHAR (100),
  Attendee_Phone NUMERIC(10, 0),
  Attendee_Email VARCHAR(100),
  Attendee_City VARCHAR (100)
);
CREATE TABLE Registrations (
    Registration_id SERIAL PRIMARY KEY, 
    Event_Id VARCHAR(10),
    Attendee_Id VARCHAR(10),           
    Registration_Date DATE,
    Registration_Amount NUMERIC(10, 0),

    FOREIGN KEY (Event_Id) REFERENCES Events(Event_Id),
    FOREIGN KEY (Attendee_Id) REFERENCES Attendees(Attendee_Id)
);

-- 2.Data Creation

INSERT INTO Events (Event_Id, Event_Name, Event_Date, Event_Location, Event_Description) 
VALUES ('E01', 'Tech Conference 2025', '2025-11-25', 'Bangalore', 'tech conference on AI and ML'),
('E02', 'Marketing Workshop', '2025-11-05', 'Mumbai', 'A 2-day digital marketing intensive'),
('E03', 'Startup Pitch Day', '2025-11-18', 'DELHI', 'Showcasing top new startups'),
('E04', 'Cloud Computing Seminar', '2025-12-15', 'Pune', 'Deep dive into AWS and Azure platforms'),
('E05', 'Design Thinking Meetup', '2025-12-7', 'Hyderabad', 'Creative problem-solving session');

INSERT INTO Attendees (Attendee_Id, Attendee_Name, Attendee_Phone, Attendee_Email, Attendee_City) 
VALUES ('A11', 'Rahul', 9876543210, 'rahul.amazon.com', 'Bangalore'),
('A12', 'Priya', 9123456789, 'priya.amazon.com', 'Mumbai'),
('A13', 'Amit', 9988776655, 'amit.amazon.com', 'DELHI'),
('A14', 'Neha', 9001122334, 'neha.amazon.com', 'Pune'),
('A15', 'Vikram', 8899001122, 'vikram.amazon.com', 'Hyderabad');

INSERT INTO Registrations (Event_Id, Attendee_Id, Registration_Date, Registration_Amount) 
VALUES ('E01', 'A11', '2025-09-20', 1000.00), -- Rahul registered for Tech Conference
('E01', 'A12', '2025-09-21', 1000.00), -- Priya registered for Tech Conference
('E02', 'A12', '2025-10-15', 800.00),  -- Priya also registered for Marketing Workshop
('E03', 'A13', '2025-10-30', 600.00),   -- Amit registered for the  Pitch Day
('E04', 'A14', '2025-11-01',900.00),  -- Neha registered for Cloud Seminar
('E05', 'A15', '2025-11-10', 500.00);  -- Vikram registered for Design Meetup

SELECT * FROM Events;
SELECT * FROM Attendees;
SELECT * FROM Registrations;

-- 3. Manage Event Details a) Inserting a new event.

INSERT INTO Events (Event_Id, Event_Name, Event_Date, Event_Location, Event_Description) 
VALUES ('E06', 'Data Science Bootcamp', '2026-01-15', 'Chennai', 'A training session on Python');

--b) Updating an event's information.

UPDATE Events
SET 
    Event_Location = 'Bangalore',
    Event_Description = 'A 2-day digital marketing intensive, moved to a new city.'
WHERE 
    Event_Id = 'E02';

-- c) Deleting an event.


ALTER TABLE Registrations DROP CONSTRAINT registrations_event_id_fkey;

ALTER TABLE Registrations 
ADD CONSTRAINT registrations_event_id_fkey 
FOREIGN KEY (Event_Id) REFERENCES Events(Event_Id) ON DELETE CASCADE;

DELETE FROM Events WHERE Event_Id = 'E05';

SELECT * FROM Events;
SELECT * FROM Attendees;
SELECT * FROM Registrations;

-- 4) Manage Track Attendees & Handle Events :  a) Inserting a new attendee.

INSERT INTO Attendees (Attendee_Id, Attendee_Name, Attendee_Phone, Attendee_Email, Attendee_City) 
VALUES ('A16', 'Suresh Menon', 7654327898, 'suresh.amazon.com', 'Chennai');


-- b) Registering an attendee for an event.
INSERT INTO Registrations (Event_Id, Attendee_Id, Registration_Date, Registration_Amount) 
VALUES ('E01', 'A16', CURRENT_DATE, 1000.00);

SELECT * FROM Events;
SELECT * FROM Attendees;
SELECT * FROM Registrations;

 -- 5.Develop queries to retrieve event information, generate attendee lists, and calculate event attendance statistics
SELECT 
    E.Event_Name, 
    E.Event_Date, 
    R.Registration_Amount,
    A.Attendee_Name
FROM 
    Registrations R
JOIN
    Events E ON R.Event_Id = E.Event_Id
JOIN 
    Attendees A ON R.Attendee_Id = A.Attendee_Id
ORDER BY 
    Event_Date ASC;
    
SELECT
    Attendee_City,
    COUNT(Attendee_Id) AS Number_of_Attendees
FROM
    Attendees
GROUP BY
    Attendee_City
ORDER BY
    Number_of_Attendees DESC;




