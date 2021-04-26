drop trigger supplies_auto_increment_id;
drop trigger plants_insert_check_type;
drop trigger increase_plants_in_stock;
drop trigger decrease_plants_in_stock;
/
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