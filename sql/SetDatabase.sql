-- CREATE TYPES --
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

-- CREATE TABLES -- 
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
/

-- POPULATE PROCEDURES --
-- POPULATE PLANTS --
create or replace
procedure POPULATE_PLANTS(no_plants in number) as 
i number;
begin 
  delete from Plants;
  i := 0;
  loop 
    IF i > no_plants/2 THEN
       INSERT INTO Plants VALUES (
        i,                                                        --plant_id
        'g',                                                      --plant_type
        DBMS_RANDOM.STRING('A', TRUNC(DBMS_RANDOM.value(5,40))),  -- common name
        DBMS_RANDOM.STRING('A', TRUNC(DBMS_RANDOM.value(4,40))),  -- scientific name
        floor(DBMS_RANDOM.VALUE(0,2)),                            -- exotic (random between 0 and 1)
        CASE round(dbms_random.value(1,2))                        -- garden (random between 'g' and 'a')
              WHEN 1 THEN 'G'
              WHEN 2 THEN 'A'
        END, 
        DBMS_RANDOM.VALUE(0,400),                                 -- in_stock
        DBMS_RANDOM.VALUE(1.00, 40.00),                           -- price
        PRICES_NT(                                                
          PRICE_TY(DBMS_RANDOM.VALUE(1.00, 40.00), 
            (SELECT TO_DATE( TRUNC( DBMS_RANDOM.VALUE(TO_CHAR(DATE '2020-01-01','J') ,TO_CHAR(DATE '2020-01-20','J') ) ),'J' ) FROM DUAL),
            (SELECT TO_DATE( TRUNC( DBMS_RANDOM.VALUE(TO_CHAR(DATE '2020-01-01','J') ,TO_CHAR(DATE '2020-01-20','J') ) ),'J' ) FROM DUAL)
          ),
          PRICE_TY(DBMS_RANDOM.VALUE(1.00, 40.00), 
            (SELECT TO_DATE( TRUNC( DBMS_RANDOM.VALUE(TO_CHAR(DATE '2020-01-01','J') ,TO_CHAR(DATE '2020-01-20','J') ) ),'J' ) FROM DUAL),
            (SELECT TO_DATE( TRUNC( DBMS_RANDOM.VALUE(TO_CHAR(DATE '2020-01-01','J') ,TO_CHAR(DATE '2020-01-20','J') ) ),'J' ) FROM DUAL)
          ),
          PRICE_TY(DBMS_RANDOM.VALUE(1.00, 40.00), 
            (SELECT TO_DATE( TRUNC( DBMS_RANDOM.VALUE(TO_CHAR(DATE '2020-01-01','J') ,TO_CHAR(DATE '2020-01-20','J') ) ),'J' ) FROM DUAL),
            (SELECT TO_DATE( TRUNC( DBMS_RANDOM.VALUE(TO_CHAR(DATE '2020-01-01','J') ,TO_CHAR(DATE '2020-01-20','J') ) ),'J' ) FROM DUAL)
          ),
          PRICE_TY(DBMS_RANDOM.VALUE(1.00, 40.00), 
            (SELECT TO_DATE( TRUNC( DBMS_RANDOM.VALUE(TO_CHAR(DATE '2020-01-01','J') ,TO_CHAR(DATE '2020-01-20','J') ) ),'J' ) FROM DUAL),
            (SELECT TO_DATE( TRUNC( DBMS_RANDOM.VALUE(TO_CHAR(DATE '2020-01-01','J') ,TO_CHAR(DATE '2020-01-20','J') ) ),'J' ) FROM DUAL)
          ),
          PRICE_TY(DBMS_RANDOM.VALUE(1.00, 40.00), 
            (SELECT TO_DATE( TRUNC( DBMS_RANDOM.VALUE(TO_CHAR(DATE '2020-01-01','J') ,TO_CHAR(DATE '2020-01-20','J') ) ),'J' ) FROM DUAL),
            (SELECT TO_DATE( TRUNC( DBMS_RANDOM.VALUE(TO_CHAR(DATE '2020-01-01','J') ,TO_CHAR(DATE '2020-01-20','J') ) ),'J' ) FROM DUAL)
          )
        ),                                                        --old prices
        DBMS_RANDOM.VALUE(0,400),                                 --number_sold
        NULL                                                      --colors
       );
     ELSE 
        INSERT INTO Plants VALUES (
        i, --plant_id
        'f', --plant_type
        DBMS_RANDOM.STRING('A', TRUNC(DBMS_RANDOM.value(5,40))), -- common name
        DBMS_RANDOM.STRING('A', TRUNC(DBMS_RANDOM.value(4,40))), -- scientific name
        floor(DBMS_RANDOM.VALUE(0,2)), -- exotic (random between 0 and 1)
        CASE round(dbms_random.value(1,2)) 
              WHEN 1 THEN 'G'
              WHEN 2 THEN 'A'
        END, 
        DBMS_RANDOM.VALUE(0,400),
        DBMS_RANDOM.VALUE(1.00, 40.00),
        PRICES_NT(
          PRICE_TY(DBMS_RANDOM.VALUE(1.00, 40.00), 
            (SELECT TO_DATE( TRUNC( DBMS_RANDOM.VALUE(TO_CHAR(DATE '2020-01-01','J') ,TO_CHAR(DATE '2020-01-20','J') ) ),'J' ) FROM DUAL),
            (SELECT TO_DATE( TRUNC( DBMS_RANDOM.VALUE(TO_CHAR(DATE '2020-01-01','J') ,TO_CHAR(DATE '2020-01-20','J') ) ),'J' ) FROM DUAL)
          ),
          PRICE_TY(DBMS_RANDOM.VALUE(1.00, 40.00), 
            (SELECT TO_DATE( TRUNC( DBMS_RANDOM.VALUE(TO_CHAR(DATE '2020-01-01','J') ,TO_CHAR(DATE '2020-01-20','J') ) ),'J' ) FROM DUAL),
            (SELECT TO_DATE( TRUNC( DBMS_RANDOM.VALUE(TO_CHAR(DATE '2020-01-01','J') ,TO_CHAR(DATE '2020-01-20','J') ) ),'J' ) FROM DUAL)
          ),
          PRICE_TY(DBMS_RANDOM.VALUE(1.00, 40.00), 
            (SELECT TO_DATE( TRUNC( DBMS_RANDOM.VALUE(TO_CHAR(DATE '2020-01-01','J') ,TO_CHAR(DATE '2020-01-20','J') ) ),'J' ) FROM DUAL),
            (SELECT TO_DATE( TRUNC( DBMS_RANDOM.VALUE(TO_CHAR(DATE '2020-01-01','J') ,TO_CHAR(DATE '2020-01-20','J') ) ),'J' ) FROM DUAL)
          ),
          PRICE_TY(DBMS_RANDOM.VALUE(1.00, 40.00), 
            (SELECT TO_DATE( TRUNC( DBMS_RANDOM.VALUE(TO_CHAR(DATE '2020-01-01','J') ,TO_CHAR(DATE '2020-01-20','J') ) ),'J' ) FROM DUAL),
            (SELECT TO_DATE( TRUNC( DBMS_RANDOM.VALUE(TO_CHAR(DATE '2020-01-01','J') ,TO_CHAR(DATE '2020-01-20','J') ) ),'J' ) FROM DUAL)
          ),
          PRICE_TY(DBMS_RANDOM.VALUE(1.00, 40.00), 
            (SELECT TO_DATE( TRUNC( DBMS_RANDOM.VALUE(TO_CHAR(DATE '2020-01-01','J') ,TO_CHAR(DATE '2020-01-20','J') ) ),'J' ) FROM DUAL),
            (SELECT TO_DATE( TRUNC( DBMS_RANDOM.VALUE(TO_CHAR(DATE '2020-01-01','J') ,TO_CHAR(DATE '2020-01-20','J') ) ),'J' ) FROM DUAL)
          )
        ),
        DBMS_RANDOM.VALUE(0,400),
        COLORS_VA(
        CASE round(dbms_random.value(1,7)) 
              WHEN 1 THEN 'red'
              WHEN 2 THEN 'yellow'
              WHEN 3 THEN 'blue'
              WHEN 4 THEN 'violet'
              WHEN 5 THEN 'white'
              WHEN 6 THEN 'pink'
              WHEN 7 THEN 'orange'
        END,
        CASE round(dbms_random.value(1,7)) 
              WHEN 1 THEN 'red'
              WHEN 2 THEN 'yellow'
              WHEN 3 THEN 'blue'
              WHEN 4 THEN 'violet'
              WHEN 5 THEN 'white'
              WHEN 6 THEN 'pink'
              WHEN 7 THEN 'orange'
        END,
        CASE round(dbms_random.value(1,9)) 
              WHEN 1 THEN 'red'
              WHEN 2 THEN 'yellow'
              WHEN 3 THEN 'blue'
              WHEN 4 THEN 'violet'
              WHEN 5 THEN 'white'
              WHEN 6 THEN 'pink'
              WHEN 7 THEN 'orange'
              WHEN 8 THEN NULL
              WHEN 9 THEN NULL
        END)
       );
     END IF;
     i := i + 1;
     exit when i >= no_plants;
  end loop;
end;
/

-- POPULATE CUSTOMERS --
create or replace procedure POPULATE_CUSTOMERS(no_customers in number) as 
i number;
begin 
  delete from Customers;
  i := 0;
  loop 
    IF i >= no_customers/3 THEN -- Insert retailers
       INSERT INTO Customers VALUES (
       DBMS_RANDOM.STRING('x', 15),   -- vat_number
        'r',                                                      -- type
        DBMS_RANDOM.STRING('A', TRUNC(DBMS_RANDOM.value(5,40))),  -- retailer name
        DBMS_RANDOM.STRING('A', TRUNC(DBMS_RANDOM.value(5,40))),  -- address
        PURCHASES_NT()                                            -- Purchases
        );
     ELSE  -- Insert privates
        INSERT INTO Customers VALUES (
        DBMS_RANDOM.STRING('x', 20),  -- tax_number
        'p',                                                      -- type
        DBMS_RANDOM.STRING('A', TRUNC(DBMS_RANDOM.value(5,10))) || DBMS_RANDOM.STRING('A', TRUNC(DBMS_RANDOM.value(5,20))),  -- customer name
        DBMS_RANDOM.STRING('A', TRUNC(DBMS_RANDOM.value(5,40))),  -- address
        PURCHASES_NT()                                            -- Purchases
       );
     END IF;
     i := i + 1;
     exit when i >= no_customers;
  end loop;
end;
/

-- POPULATE CUSTOMER'S PURCHASES
create or replace
procedure POPULATE_PURCHASES (max_no_purchases in number) as 
j number;
plants_number number;
begin
  select count (plant_id) into plants_number from plants;
  for i IN (select identification_number from Customers) LOOP 
      for j IN 1..DBMS_RANDOM.VALUE(1,max_no_purchases) loop
        INSERT INTO table (select k.Purchases from Customers k where k.identification_number = i.identification_number)
        VALUES(
              PURCHASE_TY (
                PLANTS_PURCHASED_VA(
                     Plant_Purchased_TY(
                      (SELECT REF(a) FROM Plants a WHERE a.plant_id = ROUND(DBMS_RANDOM.VALUE(0,plants_number))),
                      DBMS_RANDOM.VALUE(0,30),
                      DBMS_RANDOM.VALUE(0.0,200),
                      CASE round(dbms_random.value(1,7)) 
                            WHEN 1 THEN 'red'
                            WHEN 2 THEN 'yellow'
                            WHEN 3 THEN 'blue'
                            WHEN 4 THEN 'violet'
                            WHEN 5 THEN 'white'
                            WHEN 6 THEN 'pink'
                            WHEN 7 THEN 'orange'
                      END
                      ),
                      Plant_Purchased_TY(
                      (SELECT REF(a) FROM Plants a WHERE a.plant_id = ROUND(DBMS_RANDOM.VALUE(0,plants_number))),
                      DBMS_RANDOM.VALUE(0,30),
                      DBMS_RANDOM.VALUE(0.0,200),
                      CASE round(dbms_random.value(1,7)) 
                            WHEN 1 THEN 'red'
                            WHEN 2 THEN 'yellow'
                            WHEN 3 THEN 'blue'
                            WHEN 4 THEN 'violet'
                            WHEN 5 THEN 'white'
                            WHEN 6 THEN 'pink'
                            WHEN 7 THEN 'orange'
                      END
                      ),
                      Plant_Purchased_TY(
                      (SELECT REF(a) FROM Plants a WHERE a.plant_id = ROUND(DBMS_RANDOM.VALUE(0,plants_number))),
                      DBMS_RANDOM.VALUE(0,30),
                      DBMS_RANDOM.VALUE(0.0,200),
                      CASE round(dbms_random.value(1,7)) 
                            WHEN 1 THEN 'red'
                            WHEN 2 THEN 'yellow'
                            WHEN 3 THEN 'blue'
                            WHEN 4 THEN 'violet'
                            WHEN 5 THEN 'white'
                            WHEN 6 THEN 'pink'
                            WHEN 7 THEN 'orange'
                      END
                      )
                ),
                (SELECT TO_DATE( TRUNC( DBMS_RANDOM.VALUE(TO_CHAR(DATE '2020-01-01','J') ,TO_CHAR(DATE '2020-01-20','J') ) ),'J' ) FROM DUAL)
              )
          );
    end loop;
  end loop;
end;
/
-- POPULATE SUPPLIERS --
create or replace procedure POPULATE_SUPPLIERS(no_suppliers in number) as 
i number;
begin 
  delete from Suppliers;
  i := 0;
  loop 
     INSERT INTO Suppliers VALUES (
      i,                                                        -- supplier code                                             -- Purchases
      DBMS_RANDOM.STRING('A', TRUNC(DBMS_RANDOM.value(5,40))),  -- supplier name
      DBMS_RANDOM.STRING('A', TRUNC(DBMS_RANDOM.value(5,40))),  -- address
      DBMS_RANDOM.STRING('A', TRUNC(DBMS_RANDOM.value(5,20)))   -- tax_number
      );
     i := i + 1;
     exit when i >= no_suppliers;
  end loop;
end;
/

-- POPULATE SUPPLIES --
create or replace procedure POPULATE_SUPPLIES(no_supplies in number) as 
i number;
plants_number number;
begin 
  delete from Supplies;
  select count (plant_id) into plants_number from plants;
  i := 0;
  loop 
    INSERT INTO Supplies VALUES (
        i,                                  -- supply code
        DBMS_RANDOM.VALUE(0.0,200),         -- total_paid
        (SELECT TO_DATE( TRUNC( DBMS_RANDOM.VALUE(TO_CHAR(DATE '2020-01-01','J') ,TO_CHAR(DATE '2020-01-30','J') ) ),'J' ) FROM DUAL), -- purchase_date
        (SELECT TO_DATE( TRUNC( DBMS_RANDOM.VALUE(TO_CHAR(DATE '2020-02-01','J') ,TO_CHAR(DATE '2020-02-20','J') ) ),'J' ) FROM DUAL),  -- arrival_date
        DBMS_RANDOM.VALUE(0,499), --supplier_id
        PLANTS_SUPPLIED_NT(
          Plant_Purchased_TY(
            (SELECT REF(a) FROM Plants a WHERE a.plant_id = ROUND (DBMS_RANDOM.VALUE(0, plants_number))),
            DBMS_RANDOM.VALUE(0,30),
            DBMS_RANDOM.VALUE(0.0,200),
            DBMS_RANDOM.STRING('A', TRUNC(DBMS_RANDOM.value(3,10)))
           ),
           Plant_Purchased_TY(
            (SELECT REF(a) FROM Plants a WHERE a.plant_id = ROUND (DBMS_RANDOM.VALUE(0, plants_number))),
            DBMS_RANDOM.VALUE(0,30),
            DBMS_RANDOM.VALUE(0.0,200),
            DBMS_RANDOM.STRING('A', TRUNC(DBMS_RANDOM.value(3,10)))
           )
        )                                   -- Purchases
    );
    i := i + 1;
    exit when i >= no_supplies;
  end loop;
end;
/

-- CREATE TRIGGERS --
create or replace
TRIGGER supplies_auto_increment_id 
BEFORE INSERT ON Supplies 
FOR EACH ROW
DECLARE
  cursor plants_s is select t.* from table (:new.plants_supplied)t;
  p plant_purchased_ty;
BEGIN
  SELECT supply_seq.NEXTVAL
  INTO   :new.supply_id
  FROM   dual;
  FOR p in plants_s LOOP
    if (p.Plant = NULL) then  
      RAISE ZERO_DIVIDE;
    end if;
  END LOOP;
  
  EXCEPTION WHEN ZERO_DIVIDE THEN
  DBMS_OUTPUT.put_line('ERROR: one or more plants do not exist');
END;
/
-- POPULATION OF THE DB (Without the main triggers)
exec populate_plants (800);
/
exec populate_customers (1200);
/
exec populate_purchases (300);
/
exec populate_suppliers (500);
/
exec POPULATE_SUPPLIES(4000);
--
/
create or replace
TRIGGER plants_insert_check_type
BEFORE INSERT ON Plants 
FOR EACH ROW
BEGIN
  if :new.plant_type = 'f' AND (:new.Colors IS NULL OR :new.Colors(1) IS NULL)
  THEN 
      RAISE SUBSCRIPT_BEYOND_COUNT;
  ELSIF (:new.Colors IS NOT NULL AND 
    :new.plant_type = 'g' AND :new.Colors(1) IS NOT NULL)
  THEN 
      RAISE SUBSCRIPT_OUTSIDE_LIMIT;
  end if;
EXCEPTION 
 WHEN SUBSCRIPT_OUTSIDE_LIMIT THEN
  DBMS_OUTPUT.put_line('ERROR: a green plant cannot have a color!');
 WHEN OTHERS THEN
  DBMS_OUTPUT.put_line('ERROR: a flowery plant must have at least one color!');
END;
/
create or replace
TRIGGER decrease_plants_in_stock
AFTER Update ON Customers
FOR EACH ROW
DECLARE
  cursor p_cur is select pp.* from TABLE (:new.purchases) t, TABLE (t.plants_purchased) pp;
  p       plant_purchased_ty;
  pla     Plant_TY;
BEGIN
  RAISE ZERO_DIVIDE;
  FOR p in p_cur LOOP
      SELECT deref(p.plant) 
        INTO pla
        FROM DUAL;
      IF pla.in_stock - p.quantity < 0 THEN
        RAISE ZERO_DIVIDE;
      END IF;
      UPDATE Plants SET in_stock = pla.in_stock - p.quantity WHERE plant_id = pla.plant_id;
    END LOOP;
EXCEPTION WHEN ZERO_DIVIDE THEN
  DBMS_OUTPUT.put_line('ERROR: a flowery plant must have at least one color!');
END;
/
create or replace
TRIGGER increase_plants_in_stock
AFTER INSERT ON Supplies
FOR EACH ROW
DECLARE
  cursor plants_s is select t.plant, t.quantity from table (:new.plants_supplied) t;
  p     plant_purchased_ty;
  pla   Plant_TY;
BEGIN
    FOR p in plants_s LOOP
      SELECT deref(p.plant)
        INTO pla 
        FROM DUAL;
      UPDATE Plants SET in_stock = pla.in_stock + p.quantity WHERE plant_id = pla.plant_id;
      IF pla IS NULL THEN
         RAISE NO_DATA_FOUND;
      END IF;
    END LOOP;
EXCEPTION WHEN
  NO_DATA_FOUND THEN 
  DBMS_OUTPUT.PUT_LINE('One or more plants do not exist!');
END;
/
--Create procedures
-- Op 1
create or replace
PROCEDURE register_supply 
  (
  supplier_code     IN Supplies.supplier_id%TYPE,
  purch_date        IN Supplies.purchase_date%TYPE,
  arr_date          IN Supplies.arrival_date%TYPE,
  ids               IN int_varray, 
  quantities        IN int_varray,
  paid              IN money_varray,
  colors            IN colors_va,
  no_plants         IN int
  )
IS 
  i int;
  plants_purchased plants_supplied_nt := plants_supplied_nt (plant_purchased_ty(NULL, 0, 0, NULL));
  plant_id      REF plant_ty;
  tot_paid      Supplies.total_paid%TYPE := 0;
BEGIN
  plants_purchased.extend(no_plants-1, 1);
  
  FOR i IN 1..no_plants LOOP
    IF quantities(i) < 1 THEN
      tot_paid:= 1/0; --Throw exception
    END IF;
    SELECT REF(p) INTO plant_id FROM Plants p WHERE p.plant_id = ids(i);
    IF plant_id is NULL THEN
      RAISE NO_DATA_FOUND;
    END IF;
    plants_purchased(i) := Plant_Purchased_TY ( plant_id, quantities(i), paid(i)*quantities(i), colors(i) );
    tot_paid := tot_paid + paid(i)*quantities(i);
  END LOOP;
    
  INSERT INTO Supplies (supply_id, total_paid, purchase_date, arrival_date, supplier_id, plants_supplied) 
    VALUES ( 1, tot_paid, purch_date, arr_date, supplier_code, plants_purchased );
  
  EXCEPTION 
  WHEN NO_DATA_FOUND THEN 
    dbms_output.put_line('NO_DATA_FOUND ERROR: ref to a Plant that does not exist!');
  WHEN ZERO_DIVIDE THEN
    dbms_output.put_line('INSERT ERROR: quantities must be greater than 0!');
  WHEN OTHERS THEN
    dbms_output.put_line('GENERIC ERROR: it could be caused by an INTEGRITY CONSTRAINT VIOLATION (supplier does not exist)');
END;
/
-- Op 2
create or replace
PROCEDURE register_sale 
  (
  customer_code IN Customers.identification_number%TYPE,
  ids           IN int_varray, 
  quantities    IN int_varray,
  colors        IN colors_va,
  no_plants     IN int
  )
IS
  i int;
  plants_purchased plants_purchased_va := plants_purchased_va (plant_purchased_ty(NULL, 0, 0, NULL));
  plant_ref      REF plant_ty;
  plant_price    Plants.current_price%TYPE;
  no_available   Plants.in_stock%TYPE;
  no_sold        Plants.number_sold%TYPE;
BEGIN
  plants_purchased.extend(no_plants-1, 1);
  
  FOR i IN 1..no_plants LOOP
    
    SELECT REF(a), a.current_price, a.in_stock, a.number_sold INTO plant_ref, plant_price, no_available, no_sold
    FROM Plants a WHERE a.plant_id = ids(i);
    plants_purchased(i) := Plant_Purchased_TY ( plant_ref, quantities(i), plant_price*quantities(i), colors(i) );
    IF quantities(i) < 1 OR  no_available < quantities(i) THEN
      RAISE ZERO_DIVIDE;
    END IF; 
    UPDATE Plants SET in_stock = no_available - quantities(i), number_sold = no_sold+1 WHERE plant_id = ids(i);
  END LOOP;  

  INSERT INTO TABLE(
    SELECT c.Purchases
    FROM customers c
    WHERE c.identification_number= customer_code 
  )
  VALUES (
    PURCHASE_TY (
      plants_purchased,
      (SELECT SYSDATE FROM DUAL)
    )
  );
  
  EXCEPTION 
  WHEN NO_DATA_FOUND THEN 
    dbms_output.put_line('NO_DATA_FOUND ERROR: ref to a Plant that does not exist!');
  WHEN SUBSCRIPT_BEYOND_COUNT THEN 
    dbms_output.put_line('SUBSCRIPT_BEYOND_COUNT ERROR: this is due to either an unequal number of ids, quantities and colors, or a no_plants parameter too large.'); 
  WHEN ZERO_DIVIDE THEN
    dbms_output.put_line('INSERT ERROR: plant is not available in that quantity.');
  WHEN OTHERS THEN
    dbms_output.put_line('GENERIC ERROR: this may be caused by a customer identifier that does not exist!');
    
END;
/
-- Op 6
create or replace
PROCEDURE update_price 
  (
  p_id     IN Plants.plant_id%TYPE,
  new_price    IN Plants.current_price%TYPE
  )
IS 
  old_price   Plants.current_price%TYPE;
  last_end_date DATE;
BEGIN
  IF (new_price <= 0) THEN
    RAISE ZERO_DIVIDE;
  END IF;
  SELECT current_price INTO old_price
  FROM Plants where plant_id = p_id;
  
  UPDATE Plants SET current_price = new_price where plant_id = p_id;
  
  SELECT MAX(t.ending_date)
  INTO last_end_date
  FROM TABLE (SELECT Old_prices FROM Plants WHERE plant_id = p_id) t;
  
  INSERT INTO TABLE (SELECT Old_prices FROM Plants WHERE plant_id = p_id) 
    VALUES (old_price, last_end_date, (SELECT SYSDATE FROM DUAL));
    
  EXCEPTION 
  WHEN NO_DATA_FOUND THEN 
    dbms_output.put_line('NO_DATA_FOUND ERROR: ref to a Plant that does not exist!');
  WHEN ZERO_DIVIDE THEN
    dbms_output.put_line('INSERT ERROR: a price must be greater than 0!');
END;
/