create table customers(
customer_id varchar2(15) primary key,
customer_name varchar2(15) not null,
contact_name varchar2(15) unique,
address varchar2(15) not null,
city varchar2(15) not null,
postal_code varchar2(15) not null,
country varchar2(15) not null
);

create table employees(
employee_id varchar2(15) primary key,
last_name varchar2(15) not null,
first_name varchar2(15) not null,
birth_date varchar2(15),
photo varchar2(15) not null,
notes varchar2(15)
);

create table shippers(
shipper_id varchar2(15) primary key,
shipper_name varchar2(15) not null,
phone varchar2(15) not null
);

create table orders(
order_id number primary key,
customer_id varchar2(15) not null,
employee_id varchar2(15) not null,
order_date date default sysdate,
shipper_id varchar2(15) not null,
constraint orders_fk_customers foreign key(customer_id)
references customers(customer_id),
constraint orders_fk_employees foreign key(employee_id)
references employees(employee_id),
constraint orders_fk_shippers foreign key(shipper_id)
references shippers(shipper_id)
);
--------------------------------------------------------------------------------
create table suppliers(
supplier_id varchar2(15) primary key,
supplier_name varchar2(15) not null,
contact_name varchar2(15) unique,
address varchar2(15) not null,
city varchar2(15) not null,
postal_code varchar2(15) not null,
country varchar2(15) not null,
phone varchar2(15) not null
);

create sequence category_id
start with 1000
increment by 1;

create table categories(
category_id number primary key,
category_name varchar2(15) not null,
description varchar2(15) not null
);

create sequence product_id
start with 1000
increment by 1;

create table products(
product_id number primary key,
product_name varchar2(15) not null,
supplier_id varchar2(15) not null,
category_id number not null,
unit varchar2(15),
price number,
constraint products_fk_suppliers foreign key(supplier_id) 
references suppliers(supplier_id),
constraint products_fk_categories foreign key(category_id) 
references categories(category_id)
);
--------------------------------------------------------------------------------
create sequence order_detail_id
start with 1000
increment by 1;

create table order_details(
order_detail_id number primary key,
order_id number not null,
product_id number not null,
quantity number,
constraint order_details_fk_products foreign key(product_id)
references products(product_id),
constraint order_details_fk_orders foreign key(order_id)
references orders(order_id)
);

-- 실행
select * from tab;

drop table products;

alter table Test
add test2 varchar2(10);

alter table test
drop column test2;

alter table member
add primary key(id);


insert into order_details(art_seq, title, content, regdate, id)
values(art_seq.nextval,'지우보라','메롱',sysdate,'hong');
