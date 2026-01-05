create database if not exists sales;

drop table sales;
create table sales
(
    purchase_number int auto_increment,
    date_of_purchase date,
	customer_id int,
	item_code varchar(10),
primary key (purchase_number)
);

alter table sales
add foreign key (customer_id) references customers(customer_id) on delete cascade;

alter table sales
drop foreign key sales_ibfk_1;


drop table customers;

create table customers
(

customer_id int,
first_name varchar(255),
last_name varchar(255),
email_address varchar(255),
no_of_complaints int,
primary key(customer_id),
unique key(email_address)
);

create table items
(
item_code varchar(255),
items varchar(255),
unit_price numeric(10,2),
company_id varchar(255),
primary key(item_code)
);

create table companies
(
company_id varchar(255),
company_name varchar(255),
headquater_phone_number int(12),
primary key(company_id)

);

drop table companies;



drop table customers;

create table customers
(

customer_id int,
first_name varchar(255),
last_name varchar(255),
email_address varchar(255),
no_of_complaints int,
primary key(customer_id)
);

alter table customers
add unique key (email_address);

# to drop unique key
alter table customers
drop index email_address;

drop table customers;

create table customers
(
customer_id int auto_increment,
first_name varchar(255),
last_name varchar(255),
email_address varchar(255),
number_of_complaints int,
primary key(customer_id)
);

alter table customers
add column gender enum('M','F') AFTER last_name;

insert into customers
(first_name,
last_name,
gender,
email_address,
number_of_complaints)
values
('John',
'Mackinley',
'M',
'john.mackinley@365datascience.com',
0);

drop table customers;


create table customers
(
customer_id int auto_increment,
first_name varchar(255),
last_name varchar(255),
email_address varchar(255),
number_of_complaints int default 0,
primary key(customer_id) 
);

drop table customers;

create table customers
(
customer_id int auto_increment,
first_name varchar(255),
last_name varchar(255),
email_address varchar(255),
number_of_complaints int,
primary key(customer_id)
);


#use "change column" not add and remember to write twice column name if you don't want to change column name.
alter table customers
change column number_of_complaints number_of_complaints int default 0;

insert into customers
(first_name,
last_name,
gender)
values('peter','figaro','M')
;

select*from customers;

delete from customers where customer_id = 1;

truncate table customers;

alter table customers
alter column number_of_complaints drop default;

drop table companies;

create table companies
(company_id int auto_increment,
company_name varchar(255) default 0,
headquaters_phone_number varchar(255),
primary key(company_id),
unique key(headquaters_phone_number)
);

alter table companies
change column company_name company_name varchar(255) not null; 

alter table companies
modify company_name varchar(255) null;

insert into companies(headquaters_phone_number,company_name)
values('+1 (202) 555-1096','company-A');

#for specifically dropping the not null constraints
alter table companies
modify headquaters_phone_number varchar(255) null;

alter table companies
change column headquaters_phone_number headquaters_phone_number varchar(255) not null;

drop database employees;