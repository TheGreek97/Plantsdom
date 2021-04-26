-- POPULATE PLANTS --
create or replace
procedure POPULATE_PLANTS(no_plants in number) as 
i number;
begin 
  delete from Plants;
  i := 1;
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
        floor(DBMS_RANDOM.VALUE(0,2)),                           -- exotic (random between 0 and 1)
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
     exit when i > no_plants;
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
                      (SELECT REF(a) FROM Plants a WHERE a.plant_id = ROUND(DBMS_RANDOM.VALUE(1,plants_number+1))),
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
                      (SELECT REF(a) FROM Plants a WHERE a.plant_id = ROUND(DBMS_RANDOM.VALUE(1,plants_number+1))),
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
                      (SELECT REF(a) FROM Plants a WHERE a.plant_id = ROUND(DBMS_RANDOM.VALUE(1,plants_number+1))),
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
            (SELECT REF(a) FROM Plants a WHERE a.plant_id = ROUND (DBMS_RANDOM.VALUE(1, plants_number+1))),
            DBMS_RANDOM.VALUE(0,30),
            DBMS_RANDOM.VALUE(0.0,200),
            DBMS_RANDOM.STRING('A', TRUNC(DBMS_RANDOM.value(3,10)))
           ),
           Plant_Purchased_TY(
            (SELECT REF(a) FROM Plants a WHERE a.plant_id = ROUND (DBMS_RANDOM.VALUE(1, plants_number+1))),
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
exec populate_plants (800);
/
exec populate_customers (1200);
/
exec populate_purchases (30);
/
exec populate_suppliers (500);
/
exec POPULATE_SUPPLIES(10800);


