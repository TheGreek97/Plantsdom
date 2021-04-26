drop trigger supplies_auto_increment_id;
drop trigger plants_insert_check_type;
drop trigger increase_plants_in_stock;
drop trigger decrease_plants_in_stock;

drop table Customers;
drop table Supplies;
drop table Suppliers;
drop sequence supply_seq;
drop table Plants;

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

drop procedure populate_customers;
drop procedure populate_plants;
drop procedure populate_purchases;
drop procedure populate_suppliers;
drop procedure populate_supplies;

drop procedure register_sale;
drop procedure register_supply;
drop procedure update_price;
