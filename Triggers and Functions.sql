use synthea;
Show tables;
Select *
FROM clinical_data

#Inserting new data into the synthea database 
INSERT INTO clinical_data (patientUID, lastname, systolic,
diastolic) VALUES (3434345, 'Jean', 125, 72);

# systolic trigger
delimiter $$
CREATE TRIGGER qualitySystolic_2 BEFORE INSERT ON clinical_data
FOR EACH ROW
BEGIN
IF NEW.systolic >= 420 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'ERROR: Systolic BP MUST BE BELOW 300 mg!';
END IF;
END; $$
delimiter $$

## testing to see if systolic  trigger works
INSERT INTO clinical_data (patientUID, lastname, systolic,
diastolic) VALUES (343434, 'Williams', 500, 70);

Error Code: 1644. ERROR: Systolic BP MUST BE BELOW 300 mg!

# Function 

DELIMITER $$
CREATE FUNCTION ProcedureCost(
    cost DECIMAL(10,2)
)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
DECLARE procedureCost VARCHAR(20);
IF cost > 10000 THEN
SET procedureCost = 'high';

ELSEIF (cost >= 1000 AND
credit <= 5000) THEN
SET procedureCost = 'medium';

ELSEIF cost < 1000 THEN
SET procedureCost = 'low';
END IF;
-- return the procedure cost category
RETURN (procedureCost);
END$$
DELIMITER ;


