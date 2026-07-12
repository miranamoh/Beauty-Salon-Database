#1. CREATE DATABASE
create database BeautySalon;
show databases;
use BeautySalon;

#2. CREATE TABLES 
create table Customer (
    Customer_ID int primary key,            # Customer ID (Primary Key)
    Customer_name varchar(50),
    Phone varchar(10) unique,
    Email varchar(50) unique,
    Join_date date
);

create table Products (
    Product_ID int primary key,             #Product ID (Primary Key)
    Product_name varchar(50),
    Brand varchar(50),
    Price decimal(10,2),
    Stock int check (stock >= 0)
);

create table Appointments (
    Appointment_ID int primary key,        #Appointment ID (Primary Key)
    Customer_ID int,
    Product_ID int,
    Service_type varchar(50),
    Service_price decimal(10,2),  
    Date_time datetime,
    foreign key (Customer_ID) references Customer(Customer_ID),
    foreign key (Product_ID) references Products(Product_ID)
);


#3.INSERT DATA 
insert into Customer values 
(1, 'Mirana mohammad', '051234678', 'mirana@email.com', '2025-12-15'),
(2, 'Amasi ALsahbi', '059876432', 'amasi@email.com', '2025-12-20'),
(3, 'Razan Allehyani', '054478393', 'razan@email.com', '2025-12-10'),
(4, 'Noura Hassan', '051268366', 'noura@email.com', '2025-12-05');
select * from Customer;

insert into Products values 
(1, 'Shampoo', 'L''Oreal', 65.40, 50),   
(2, 'Conditioner', 'Kerastase', 85.55, 50),
(3, 'Hair Serum', 'Moroccanoil', 120.00, 25),
(4, 'Nail Polish', 'OPI', 69.99, 100),
(5, 'Shampoo Pro', 'L''Oreal', 88.50, 30),
(6, 'Conditioner Plus', 'Kerastase', 95.00, 20),
(7, 'Nail Polish limited', 'OPI', 89.99, 100);
select * from Products;

insert into Appointments values 
(1, 1, 1, 'Haircut',100.00, '2025-01-15 11:00:00'),        #Customer 1 buys product 1 (Shampoo)
(2, 2, 3, 'Hair Coloring',550.00, '2025-01-16 17:00:00'),  #Customer 2 buys product 3 (Hair Serum)
(3, 3, 2, 'Manicure', 80.99,'2025-01-17 15:00:00'),       #Customer 3 buys product 2 (Conditioner)
(4, 4, 4, 'Facial',350.00, '2025-01-18 13:00:00');
select * from Appointments;

#4. AGGREGATE FUNCTION 1: COUNT 
select count(*) as total_appointments from Appointments;    #count: counts number of rows

# AGGREGATE FUNCTION 2: MAX, MIN with GROUP BY
#show highest and lowest price for each brand (grouped by brand)

select brand, max(price) as max_price, min(price) as min_price 
from Products 
group by brand;       # group by: groups results by brand

# 5. JOIN OPERATION
#Join all three tables to show complete appointment informations
select c.Customer_name, a.Service_type, a.Service_price,  a.Date_time, p.Product_name,
p.Price as Product_price,(a.Service_price + p.Price) as Total_amount # We Calculated total
from Appointments a
join Customer c on a.Customer_ID = c.Customer_ID
join Products p on a.Product_ID = p.Product_ID;

# 6. SUBQUERY
#Find customers who purchased products with price > 80
select Customer_name, Phone
from Customer
where Customer_ID in (          #where in: to search within a list
    select Customer_ID          #First inner query
    from Appointments
    where Product_ID in (
        select Product_ID       #FSecond inner query
        from Products
        where Price > 80        # Products with price more than 80
    )
);

#7. CREATE VIEW
#Create view for high-priced services 
create view expensive_services as 
select * 
from Appointments 
where Service_price > 250;

# Show the expensive services view
select * from expensive_services;


create view Appointments_detail as
select a.appointment_id,c.Customer_name, c.Phone, a.Service_type,a.Service_price, a.Date_time,
p.Product_name as product_pruchased,p.price as product_price,(a.service_price + p.price) as total_paid
from Appointments a
join Customer c on a.Customer_ID = c.Customer_ID
join Products p on a.Product_ID = p.Product_ID;

#8. SHOW VIEW
select * from appointments_detail

