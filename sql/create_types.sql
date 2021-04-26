drop type Customer_TY;
drop type Purchases_NT;

drop type Supply_TY;
drop type Plants_supplied_NT;
drop type Supplier_TY;

drop type Purchase_TY;
drop type Plants_Purchased_VA;
drop type Plant_Purchased_TY;

drop type Plant_TY;
drop type Colors_VA;
drop type Prices_NT;
drop type Price_TY;

drop type int_varray;
drop type money_varray;

create type Price_TY as object (
    amount        decimal(5,2),
    start_date    DATE,
    ending_date   DATE 
);
/
create type Prices_NT AS TABLE OF Price_TY;
/
create or replace type Colors_VA as VARRAY (10) OF VARCHAR(10);
/
create or replace type Plant_TY as OBJECT(
    plant_id              integer,
    plant_type            char(1),      -- 'g' = is a green plant, 'f' = is a flowery plant
    common_name           varchar2(40),
    scientific_name       varchar2(60),
    exotic                number(1),    -- 0 = is not exotic, 1 = is exotic 
    garden                char(1),      -- 'A' for apartment and 'G' for garden 
    in_stock              integer,
    current_price         decimal(6, 2),
    Old_prices            Prices_NT,
    number_sold           integer,
    Colors                Colors_VA 
) FINAL;
/
create or replace type Plant_Purchased_TY as object(
    Plant       REF Plant_TY,
    quantity    integer,
    paid        decimal(6,2),
    color       varchar2(10)
) FINAL;
/
create or replace type Plants_Purchased_VA as VARRAY (20) OF Plant_Purchased_TY;
/
create type Purchase_TY as object (
    Plants_purchased    Plants_Purchased_VA,
    dateTime            date
);
/
create type Purchases_NT AS TABLE OF Purchase_TY;
/
CREATE or REPLACE type Customer_TY as OBJECT(
    identification_number     varchar2(20),
    customer_type             char,         -- 'p' = private individual, 'r'= retailer
    customer_name             varchar2(40),
    address                   varchar2(40),
    Purchases                 Purchases_NT
)FINAL;
/
CREATE or REPLACE type Supplier_TY as object (
    code              integer,
    supplier_name     varchar2(40),
    address           varchar2(40),
    tax_number        varchar2(20)
);
/
CREATE or REPLACE type Plants_supplied_NT AS TABLE OF Plant_Purchased_TY;
/
CREATE or REPLACE type Supply_TY as object (
    supply_id         int,
    total_paid        decimal(6,2),
    purchase_date     date,
    arrival_date      date,
    Supplier_id       integer,
    Plants_supplied   Plants_supplied_NT
);
/
CREATE or REPLACE type int_varray as VARRAY(200) of int;
/
CREATE or REPLACE type money_varray as VARRAY(200) of decimal(6,2);
/