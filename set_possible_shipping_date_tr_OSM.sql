CREATE OR REPLACE FUNCTION calculate_shipping_date()
RETURNS TRIGGER AS $$
BEGIN 
    NEW.possible_shipping_date := NEW.order_date + interval '3 days';
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER set_possible_shipping_date
BEFORE INSERT ON ORDER_DETAILS
FOR EACH ROW
EXECUTE FUNCTION calculate_shipping_date();