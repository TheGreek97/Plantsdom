drop table Customers;
drop table Supplies;
drop table Suppliers;
drop sequence supply_seq;
drop table Plants;

CREATE TABLE Customers OF Customer_TY(
  identification_number   PRIMARY KEY NOT NULL,
  customer_name           NOT NULL,
  address                 NOT NULL
)NESTED TABLE Purchases STORE AS Purchases_tab;
/
CREATE TABLE Plants OF Plant_TY(
    plant_id              PRIMARY KEY NOT NULL,
    plant_type            DEFAULT 0   NOT NULL,
    common_name           NOT NULL,
    scientific_name       NOT NULL,
    exotic                DEFAULT 0   NOT NULL,
    garden                DEFAULT 'G' NOT NULL,
    in_stock              DEFAULT 0   NOT NULL,
    current_price         DEFAULT 0   NOT NULL,
    number_sold           DEFAULT 0   NOT NULL        
)NESTED TABLE Old_prices STORE AS Old_pricesNT_TAB;
/
CREATE TABLE Suppliers OF Supplier_TY(
     code            PRIMARY KEY NOT NULL,
     supplier_name   NOT NULL,
     address         NOT NULL,
     tax_number      NOT NULL
);
/
CREATE TABLE Supplies OF Supply_TY(
     supply_id       NOT NULL,
     total_paid      NOT NULL,
     purchase_date   NOT NULL,
     supplier_id     NOT NULL,
     FOREIGN KEY (supplier_id) REFERENCES Suppliers(code) ON DELETE CASCADE 
) NESTED TABLE Plants_supplied STORE AS Plants_suppliedNT_TAB;
/
ALTER TABLE Supplies ADD (
  CONSTRAINT supplies_pk PRIMARY KEY (supply_id));
/
CREATE SEQUENCE supply_seq START WITH 1;
