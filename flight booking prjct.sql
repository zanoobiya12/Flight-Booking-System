CREATE DATABASE FlightBookingSystem;

USE FlightBookingSystem;



CREATE TABLE Airline (
    airline_id INT PRIMARY KEY,
    airline_name VARCHAR(100),
    confirmation_number VARCHAR(20)
);

CREATE TABLE Airport (
    airport_id INT PRIMARY KEY,
    airport_name VARCHAR(100),
    airport_code CHAR(3) UNIQUE,
    city VARCHAR(50)
);

CREATE TABLE Flight (
    flight_id INT PRIMARY KEY,
    airline_id INT,
    flight_number VARCHAR(20),
    departure_airport_id INT,
    arrival_airport_id INT,
    departure_time TIME,
    arrival_time TIME,
    duration VARCHAR(20),
    distance_miles INT,
    FOREIGN KEY (airline_id) REFERENCES Airline(airline_id),
    FOREIGN KEY (departure_airport_id) REFERENCES Airport(airport_id),
    FOREIGN KEY (arrival_airport_id) REFERENCES Airport(airport_id)
);

CREATE TABLE Booking (
    booking_id INT PRIMARY KEY,
    confirmation_number VARCHAR(20),
    booking_date DATE,
    total_amount DECIMAL(10,2)
);

CREATE TABLE Passenger (
    passenger_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
    
    
);CREATE TABLE Ticket (
    ticket_id INT PRIMARY KEY,
    booking_id INT,
    passenger_id INT,
    flight_id INT,
    ticket_number VARCHAR(20) UNIQUE,
    travel_date DATE,
    travel_class VARCHAR(20),
    price DECIMAL(10,2),
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id),
    FOREIGN KEY (passenger_id) REFERENCES Passenger(passenger_id),
    FOREIGN KEY (flight_id) REFERENCES Flight(flight_id)
);



SELECT * FROM Airline;
SELECT * FROM Airport;
SELECT * FROM Flight;
SELECT * FROM Booking;
SELECT * FROM Passenger;
SELECT * FROM Ticket;

INSERT INTO Airline
VALUES (1, 'Alaska Airlines', 'TAEGKX');

INSERT INTO Airport
VALUES
(1, 'Los Angeles Intl Airport', 'LAX', 'Los Angeles'),
(2, 'San Francisco Intl Airport', 'SFO', 'San Francisco');

INSERT INTO Flight
VALUES
(1, 1, '1490', 1, 2, '08:20:00', '09:35:00', '1h 15m', 236),
(2, 1, '1473', 2, 1, '14:00:00', '15:15:00', '1h 15m', 236);

INSERT INTO Booking
VALUES
(1, 'TAEGKX', '2019-04-05', 756.20);

INSERT INTO Passenger
VALUES
(1, 'John', 'Smith'),
(2, 'Jennifer', 'Smith');

INSERT INTO Ticket
VALUES
(1, 1, 1, 1, '0177200658', '2019-04-05', 'Economy', 357.60),
(2, 1, 2, 1, '0178410326', '2019-04-05', 'Economy', 357.60);

SELECT * FROM Airline;
SELECT * FROM Airport;
SELECT * FROM Flight;
SELECT * FROM Booking;
SELECT * FROM Passenger;
SELECT * FROM Ticket;


SELECT 
    p.first_name,
    p.last_name,
    t.ticket_number,
    f.flight_number,
    t.travel_date,
    t.travel_class,
    t.price
FROM Passenger p
JOIN Ticket t
    ON p.passenger_id = t.passenger_id
JOIN Flight f
    ON t.flight_id = f.flight_id;
    
SELECT
    a1.city AS departure_city,
    a2.city AS arrival_city,
    f.flight_number,
    f.departure_time,
    f.arrival_time,
    f.distance_miles
FROM Flight f
JOIN Airport a1
    ON f.departure_airport_id = a1.airport_id
JOIN Airport a2
    ON f.arrival_airport_id = a2.airport_id;
    
    SELECT
    b.confirmation_number,
    p.first_name,
    p.last_name,
    t.ticket_number,
    t.price,
    b.total_amount
FROM Booking b
JOIN Ticket t
    ON b.booking_id = t.booking_id
JOIN Passenger p
    ON t.passenger_id = p.passenger_id;
    
    SELECT
    f.flight_number,
    a1.airport_code AS departure,
    a2.airport_code AS arrival,
    f.departure_time,
    f.arrival_time,
    f.duration,
    f.distance_miles
FROM Flight f
JOIN Airport a1
    ON f.departure_airport_id = a1.airport_id
JOIN Airport a2
    ON f.arrival_airport_id = a2.airport_id;
    
SELECT
    b.confirmation_number,
    p.first_name,
    p.last_name,
    t.ticket_number,
    al.airline_name,
    f.flight_number,
    a1.airport_code AS departure,
    a2.airport_code AS arrival,
    t.travel_date,
    t.travel_class,
    f.departure_time,
    f.arrival_time,
    t.price,
    b.total_amount
FROM Booking b
JOIN Ticket t
    ON b.booking_id = t.booking_id
JOIN Passenger p
    ON t.passenger_id = p.passenger_id
JOIN Flight f
    ON t.flight_id = f.flight_id
JOIN Airline al
    ON f.airline_id = al.airline_id
JOIN Airport a1
    ON f.departure_airport_id = a1.airport_id
JOIN Airport a2
    ON f.arrival_airport_id = a2.airport_id;
    
    
    
    CREATE TABLE Booking_Flight (
    booking_flight_id INT PRIMARY KEY,
    booking_id INT,
    flight_id INT,
    travel_date DATE,
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id),
    FOREIGN KEY (flight_id) REFERENCES Flight(flight_id)
);

INSERT INTO Booking_Flight
(booking_flight_id, booking_id, flight_id, travel_date)
VALUES
(1, 1, 1, '2019-04-05'),
(2, 1, 2, '2019-04-07');
select*from BOOKING_FLIGHT;

SELECT
    b.confirmation_number,
    p.first_name,
    p.last_name,
    bf.travel_date,
    f.flight_number,
    a1.airport_code AS departure,
    a2.airport_code AS arrival,
    al.airline_name,
    f.departure_time,
    f.arrival_time
FROM Booking b
JOIN Ticket t
    ON b.booking_id = t.booking_id
JOIN Passenger p
    ON t.passenger_id = p.passenger_id
JOIN Booking_Flight bf
    ON b.booking_id = bf.booking_id
JOIN Flight f
    ON bf.flight_id = f.flight_id
JOIN Airport a1
    ON f.departure_airport_id = a1.airport_id
JOIN Airport a2
    ON f.arrival_airport_id = a2.airport_id
JOIN Airline al
    ON f.airline_id = al.airline_id
WHERE b.booking_id = 1;

SELECT*FROM PASSENGER;



SELECT *
FROM Flight
WHERE departure_airport_id = (
    SELECT airport_id
    FROM Airport
    WHERE airport_code = 'LAX'
);

SELECT
    flight_number,
    distance_miles,
    departure_time,
    arrival_time
FROM Flight
ORDER BY distance_miles ASC;


SELECT 
    *
FROM
    FLIGHT
ORDER BY DISTANCE_MILES DESC
LIMIT 1;

SELECT 
    *
FROM
    FLIGHT
ORDER BY DISTANCE_MILES ASC
LIMIT 1;

SELECT 
    COUNT(*) AS TOTAL_FLIGHTS
FROM
    FLIGHT;
    
    SELECT *
FROM Flight
WHERE departure_airport_id = (
    SELECT airport_id
    FROM Airport
    WHERE airport_code = 'LAX'
);

SELECT *
FROM Flight
WHERE arrival_airport_id = (
    SELECT airport_id
    FROM Airport
    WHERE airport_code = 'SFO'
);

SELECT 
    p.first_name,
    p.last_name,
    b.confirmation_number,
    t.ticket_number,
    f.flight_number,
    al.airline_name,
    t.travel_date,
    t.travel_class,
    t.price
FROM Passenger p
JOIN Ticket t
    ON p.passenger_id = t.passenger_id
JOIN Booking b
    ON t.booking_id = b.booking_id
JOIN Flight f
    ON t.flight_id = f.flight_id
JOIN Airline al
    ON f.airline_id = al.airline_id;
    
    SELECT COUNT(*) AS total_passengers
FROM Passenger;

SELECT COUNT(*) AS total_bookings
FROM Booking;

SELECT AVG(price) AS average_ticket_price
FROM Ticket;

SELECT MAX(price) AS highest_ticket_price
FROM Ticket;

SELECT MIN(price) AS lowest_ticket_price
FROM Ticket;


SELECT SUM(price) AS total_revenue
FROM Ticket;

SELECT 
    travel_class,
    COUNT(*) AS total_tickets
FROM Ticket
GROUP BY travel_class;

SELECT 
    travel_class,
    AVG(price) AS average_price
FROM Ticket
GROUP BY travel_class;

SELECT 
    travel_class,
    SUM(price) AS total_revenue
FROM Ticket
GROUP BY travel_class;

SELECT 
    al.airline_name,
    COUNT(t.ticket_number) AS tickets_sold
FROM Airline al
JOIN Flight f
    ON al.airline_id = f.airline_id
JOIN Ticket t
    ON f.flight_id = t.flight_id
GROUP BY al.airline_name;

SELECT 
    al.airline_name,
    SUM(t.price) AS total_revenue
FROM Airline al
JOIN Flight f
    ON al.airline_id = f.airline_id
JOIN Ticket t
    ON f.flight_id = t.flight_id
GROUP BY al.airline_name;

SELECT 
    al.airline_name,
    COUNT(t.ticket_number) AS tickets_sold
FROM Airline al
JOIN Flight f
    ON al.airline_id = f.airline_id
JOIN Ticket t
    ON f.flight_id = t.flight_id
GROUP BY al.airline_name
HAVING COUNT(t.ticket_number) > 5;

SELECT 
    al.airline_name,
    SUM(t.price) AS total_revenue
FROM Airline al
JOIN Flight f
    ON al.airline_id = f.airline_id
JOIN Ticket t
    ON f.flight_id = t.flight_id
GROUP BY al.airline_name
HAVING SUM(t.price) > 10000;



SELECT 
    p.first_name,
    p.last_name,
    b.confirmation_number,
    t.ticket_number,
    f.flight_number,
    al.airline_name
FROM Passenger p
JOIN Ticket t
    ON p.passenger_id = t.passenger_id
JOIN Booking b
    ON t.booking_id = b.booking_id
JOIN Flight f
    ON t.flight_id = f.flight_id
JOIN Airline al
    ON f.airline_id = al.airline_id;
    
    
    SELECT 
    p.passenger_id,
    p.first_name,
    p.last_name,
    t.ticket_number
FROM Passenger p
LEFT JOIN Ticket t
    ON p.passenger_id = t.passenger_id;
    
    
    SELECT 
    p.passenger_id,
    p.first_name,
    p.last_name
FROM Passenger p
LEFT JOIN Ticket t
    ON p.passenger_id = t.passenger_id
WHERE t.ticket_number IS NULL;


SELECT 
    p.first_name,
    p.last_name,
    b.confirmation_number,
    t.ticket_number,
    f.flight_number,
    al.airline_name,
    t.travel_date,
    t.travel_class,
    t.price
FROM Passenger p
JOIN Ticket t
    ON p.passenger_id = t.passenger_id
JOIN Booking b
    ON t.booking_id = b.booking_id
JOIN Flight f
    ON t.flight_id = f.flight_id
JOIN Airline al
    ON f.airline_id = al.airline_id
ORDER BY t.travel_date;


SELECT 
    ticket_number,
    travel_class,
    price
FROM Ticket
WHERE price > (
    SELECT AVG(price)
    FROM Ticket
);


SELECT 
    ticket_number,
    travel_class,
    price
FROM Ticket
WHERE price = (
    SELECT MAX(price)
    FROM Ticket
);


SELECT 
    p.first_name,
    p.last_name,
    t.ticket_number,
    t.price
FROM Passenger p
JOIN Ticket t
    ON p.passenger_id = t.passenger_id
WHERE t.price > (
    SELECT AVG(price)
    FROM Ticket
);


SELECT 
    ticket_number,
    travel_class,
    price,
    CASE
        WHEN price >= 10000 THEN 'Expensive'
        WHEN price >= 5000 THEN 'Moderate'
        ELSE 'Affordable'
    END AS price_category
FROM Ticket;

SELECT 
    p.first_name,
    p.last_name,
    t.travel_class,
    CASE
        WHEN t.travel_class = 'First' THEN 'Premium Passenger'
        WHEN t.travel_class = 'Business' THEN 'Business Passenger'
        ELSE 'Economy Passenger'
    END AS passenger_category
FROM Passenger p
JOIN Ticket t
    ON p.passenger_id = t.passenger_id;
    
    
    
    SELECT
    ticket_number,
    price,
    CASE
        WHEN price >= 10000 THEN 'High Value Booking'
        WHEN price >= 5000 THEN 'Medium Value Booking'
        ELSE 'Low Value Booking'
    END AS booking_value
FROM Ticket;


SELECT
    p.first_name,
    p.last_name,
    f.flight_number,
    al.airline_name,
    t.travel_class,
    t.price,
    CASE
        WHEN t.price >= 10000 THEN 'Expensive'
        WHEN t.price >= 5000 THEN 'Moderate'
        ELSE 'Affordable'
    END AS ticket_category
FROM Passenger p
JOIN Ticket t
    ON p.passenger_id = t.passenger_id
JOIN Flight f
    ON t.flight_id = f.flight_id
JOIN Airline al
    ON f.airline_id = al.airline_id;
    
    
    CREATE VIEW flight_booking_details AS
SELECT 
    p.first_name,
    p.last_name,
    b.confirmation_number,
    t.ticket_number,
    f.flight_number,
    al.airline_name,
    t.travel_date,
    t.travel_class,
    t.price
FROM Passenger p
JOIN Ticket t
    ON p.passenger_id = t.passenger_id
JOIN Booking b
    ON t.booking_id = b.booking_id
JOIN Flight f
    ON t.flight_id = f.flight_id
JOIN Airline al
    ON f.airline_id = al.airline_id;
    
    SELECT *
FROM flight_booking_details;

SELECT *
FROM flight_booking_details
WHERE travel_class = 'Business';

SELECT *
FROM flight_booking_details
WHERE price > 10000;


SELECT
    airline_name,
    COUNT(*) AS total_bookings
FROM flight_booking_details
GROUP BY airline_name;

CREATE INDEX idx_passenger_last_name
ON Passenger(last_name);

CREATE INDEX idx_ticket_travel_date
ON Ticket(travel_date);

CREATE INDEX idx_flight_number
ON Flight(flight_number);

CREATE INDEX idx_airline_name
ON Airline(airline_name);

SHOW INDEX FROM Passenger;

SHOW INDEX FROM Ticket;

SHOW INDEX FROM Flight;

SELECT
    p.first_name,
    p.last_name,
    f.flight_number,
    al.airline_name,
    t.travel_class,
    t.price
FROM Passenger p
JOIN Ticket t
    ON p.passenger_id = t.passenger_id
JOIN Flight f
    ON t.flight_id = f.flight_id
JOIN Airline al
    ON f.airline_id = al.airline_id
WHERE t.price = (
    SELECT MAX(price)
    FROM Ticket
);

SELECT
    p.first_name,
    p.last_name,
    f.flight_number,
    al.airline_name,
    t.travel_class,
    t.price
FROM Passenger p
JOIN Ticket t
    ON p.passenger_id = t.passenger_id
JOIN Flight f
    ON t.flight_id = f.flight_id
JOIN Airline al
    ON f.airline_id = al.airline_id
WHERE t.price = (
    SELECT MIN(price)
    FROM Ticket
);

SELECT
    al.airline_name,
    SUM(t.price) AS total_revenue
FROM Airline al
JOIN Flight f
    ON al.airline_id = f.airline_id
JOIN Ticket t
    ON f.flight_id = t.flight_id
GROUP BY al.airline_name
ORDER BY total_revenue DESC
LIMIT 1;

SELECT
    p.passenger_id,
    p.first_name,
    p.last_name,
    COUNT(t.ticket_number) AS total_tickets
FROM Passenger p
JOIN Ticket t
    ON p.passenger_id = t.passenger_id
GROUP BY
    p.passenger_id,
    p.first_name,
    p.last_name
HAVING COUNT(t.ticket_number) > 1;

SELECT
    travel_class,
    COUNT(*) AS total_tickets
FROM Ticket
GROUP BY travel_class
ORDER BY total_tickets DESC
LIMIT 1;

SELECT
    al.airline_name,
    SUM(t.price) AS total_revenue
FROM Airline al
JOIN Flight f
    ON al.airline_id = f.airline_id
JOIN Ticket t
    ON f.flight_id = t.flight_id
GROUP BY al.airline_name
HAVING SUM(t.price) > (
    SELECT AVG(airline_revenue)
    FROM (
        SELECT SUM(t2.price) AS airline_revenue
        FROM Flight f2
        JOIN Ticket t2
            ON f2.flight_id = t2.flight_id
        GROUP BY f2.airline_id
    ) AS revenue_table
);





SELECT
    p.passenger_id,
    CONCAT(p.first_name, ' ', p.last_name) AS passenger_name,
    b.confirmation_number,
    t.ticket_number,
    f.flight_number,
    al.airline_name,
    t.travel_date,
    t.travel_class,
    t.price
FROM Passenger p
JOIN Ticket t
    ON p.passenger_id = t.passenger_id
JOIN Booking b
    ON t.booking_id = b.booking_id
JOIN Flight f
    ON t.flight_id = f.flight_id
JOIN Airline al
    ON f.airline_id = al.airline_id
ORDER BY t.travel_date;


SELECT
    al.airline_name,
    COUNT(t.ticket_number) AS total_tickets,
    SUM(t.price) AS total_revenue,
    AVG(t.price) AS average_ticket_price
FROM Airline al
JOIN Flight f
    ON al.airline_id = f.airline_id
JOIN Ticket t
    ON f.flight_id = t.flight_id
GROUP BY al.airline_name
ORDER BY total_revenue DESC;


SELECT
    travel_class,
    COUNT(*) AS total_tickets,
    SUM(price) AS total_revenue,
    AVG(price) AS average_price
FROM Ticket
GROUP BY travel_class
ORDER BY total_revenue DESC;

SELECT
    p.passenger_id,
    p.first_name,
    p.last_name,
    COUNT(t.ticket_number) AS tickets_purchased,
    SUM(t.price) AS total_spent
FROM Passenger p
JOIN Ticket t
    ON p.passenger_id = t.passenger_id
GROUP BY
    p.passenger_id,
    p.first_name,
    p.last_name
ORDER BY total_spent DESC;

SELECT
    p.first_name,
    p.last_name,
    SUM(t.price) AS total_spent
FROM Passenger p
JOIN Ticket t
    ON p.passenger_id = t.passenger_id
GROUP BY
    p.passenger_id,
    p.first_name,
    p.last_name
ORDER BY total_spent DESC
LIMIT 3;

SELECT
    f.flight_number,
    al.airline_name,
    COUNT(t.ticket_number) AS tickets_sold
FROM Flight f
JOIN Airline al
    ON f.airline_id = al.airline_id
LEFT JOIN Ticket t
    ON f.flight_id = t.flight_id
GROUP BY
    f.flight_id,
    f.flight_number,
    al.airline_name
ORDER BY tickets_sold DESC;

DELIMITER //

CREATE PROCEDURE GetBookingDetails(IN bookingID INT)
BEGIN
    SELECT
        b.confirmation_number,
        p.first_name,
        p.last_name,
        t.ticket_number,
        f.flight_number,
        t.travel_date,
        t.travel_class,
        t.price
    FROM Booking b
    JOIN Ticket t
        ON b.booking_id = t.booking_id
    JOIN Passenger p
        ON t.passenger_id = p.passenger_id
    JOIN Flight f
        ON t.flight_id = f.flight_id
    WHERE b.booking_id = bookingID;
END //

DELIMITER ;

CALL GetBookingDetails(1);

SELECT
    (SELECT COUNT(*) FROM Passenger) AS total_passengers,
    (SELECT COUNT(*) FROM Booking) AS total_bookings,
    (SELECT COUNT(*) FROM Ticket) AS total_tickets,
    (SELECT SUM(price) FROM Ticket) AS total_revenue,
    (SELECT AVG(price) FROM Ticket) AS average_ticket_price,
    (SELECT MAX(price) FROM Ticket) AS highest_ticket_price,
    (SELECT MIN(price) FROM Ticket) AS lowest_ticket_price;
    
    

