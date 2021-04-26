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
-- Op 3
SELECT * FROM Plants WHERE in_stock>0;
/
-- Op 4
SELECT t.* 
FROM TABLE 
  (SELECT Purchases FROM Customers WHERE identification_number = 'FM1A5SQ0ESBAKS4') t;
/
-- Op 5
SELECT * FROM plants ORDER BY (number_sold) DESC;
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
SELECT * FROM plants WHERE common_name LIKE ('%partial_name%');