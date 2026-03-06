-- *****************************************************************
-- Place any customer test data into this file. 
--
-- All sql statements that goes here should be defined in a update-safe way, ie. the final script should be able 
-- to run against the database any number of times and should produce the same output.
--
-- This file should finish with a database commit; at least at the end of the file.
--
-- *****************************************************************

DECLARE 

strCountry_ID VARCHAR(2);

BEGIN

strCountry_ID := $(countryId);

---defect fix 452
-- *******************************************
-- Address Types
-- *******************************************
DELETE FROM com_code_value
  WHERE organization_id = &1 AND
        category = 'ADDRESS_TYPE' AND
        code IN ('HOME', 'WORK', 'VACATION', 'OTHER');

INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'ADDRESS_TYPE', 'HOME', 'Home', 10, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'ADDRESS_TYPE', 'WORK', 'Work', 20, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'ADDRESS_TYPE', 'VACATION', 'Vacation', 30, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'ADDRESS_TYPE', 'OTHER', 'Other', 40, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');

-- *****************************
-- Customer Account State Codes
-- *****************************
DELETE FROM com_code_value
  WHERE organization_id = &1 AND
        category = 'CUST_ACCOUNT_STATE' AND
        code IN ('ABANDONED', 'CLOSED', 'DELINQUENT', 'IN_PROGRESS', 'INACTIVE', 'NEW', 'OPEN',
            'OVERDUE', 'PENDING', 'READY_TO_PICKUP', 'REFUNDABLE');

INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'CUST_ACCOUNT_STATE', 'ABANDONED', 'Abandoned', 100, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'CUST_ACCOUNT_STATE', 'CLOSED', 'Closed', 60, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'CUST_ACCOUNT_STATE', 'DELINQUENT', 'Delinquent', 90, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'CUST_ACCOUNT_STATE', 'IN_PROGRESS', 'In Progress', 40, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'CUST_ACCOUNT_STATE', 'INACTIVE', 'Inactive', 110, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'CUST_ACCOUNT_STATE', 'NEW', 'New', 10, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'CUST_ACCOUNT_STATE', 'OPEN', 'Open', 20, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'CUST_ACCOUNT_STATE', 'OVERDUE', 'Overdue', 80, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'CUST_ACCOUNT_STATE', 'PENDING', 'Pending', 30, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'CUST_ACCOUNT_STATE', 'READY_TO_PICKUP', 'Ready To Pickup', 50, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'CUST_ACCOUNT_STATE', 'REFUNDABLE', 'Refundable', 70, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');

-- ******************************
-- Customer Contact Preferences
-- ******************************
DELETE FROM com_code_value
  WHERE organization_id = &1 AND
        category = 'CUSTOMER_CONTACT_PREF' AND
        code IN ('HOME', 'WORK', 'BUSINESS', 'MOBILE', 'EMAIL', 'FAX');

INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'CUSTOMER_CONTACT_PREF', 'HOME', 'Home Phone', 10, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'CUSTOMER_CONTACT_PREF', 'BUSINESS', 'Work Phone', 20, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'CUSTOMER_CONTACT_PREF', 'MOBILE', 'Mobile Phone', 30, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'CUSTOMER_CONTACT_PREF', 'EMAIL', 'Email', 40, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');

--XSTORE-3171: customer group removal for AU
-- ******************************
-- Customer Groups
-- ******************************

IF(strCountry_ID != 'AU' && strCountry_ID != 'NZ')
THEN
execute immediate DELETE FROM com_code_value WHERE organization_id = &1 AND category = 'CUSTOMER_GROUPS' AND code IN ('DEFAULT', 'ELITE', 'EMPLOYEE', 'EMPLOYEE_FAMILY');
execute immediate INSERT INTO com_code_value (organization_id, category, code, description, sort_order, image_url, rank, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'CUSTOMER_GROUPS', 'DEFAULT', 'Normal Level', 1, 'res/graphics/badge-bronze.png', 4, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
execute immediate INSERT INTO com_code_value (organization_id, category, code, description, sort_order, image_url, rank, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'CUSTOMER_GROUPS', 'ELITE', 'Elite Program Member', 2, 'res/graphics/badge-platinum.png', 1, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
execute immediate INSERT INTO com_code_value (organization_id, category, code, description, sort_order, image_url, rank, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'CUSTOMER_GROUPS', 'EMPLOYEE', 'Employee', 3, 'res/graphics/badge-gold.png', 2, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
execute immediate INSERT INTO com_code_value (organization_id, category, code, description, sort_order, image_url, rank, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'CUSTOMER_GROUPS', 'EMPLOYEE_FAMILY', 'Employee Family', 4, 'res/graphics/badge-silver.png', 3, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
END IF;
--XSTORE-3171: customer group removal for AU
-- *************************
-- Employee Groups
-- *************************
DELETE FROM com_code_value
  WHERE organization_id = &1 AND
        category = 'EMPLOYEE_GROUP' AND
        code IN ('DEFAULT');

INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'EMPLOYEE_GROUP', 'DEFAULT', 'Default', 10, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');

-- **************************
-- Organization Types
-- **************************
DELETE FROM com_code_value
  WHERE organization_id = &1 AND
        category = 'ORGANIZATION_TYPE' AND
        code IN ('Default', 'CLUB', 'COMPANY', 'SCHOOL');

INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'ORGANIZATION_TYPE', 'Default', 'Default', 10, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'ORGANIZATION_TYPE', 'CLUB', 'CLUB', 40, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'ORGANIZATION_TYPE', 'COMPANY', 'COMPANY', 20, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'ORGANIZATION_TYPE', 'SCHOOL', 'SCHOOL', 30, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');

-- **************************
-- Employee Roles
-- **************************
DELETE FROM com_code_value
  WHERE organization_id = &1 AND
        category = 'EMPLOYEE_ROLE' AND
        code IN ('DEFAULT');

INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'EMPLOYEE_ROLE', 'DEFAULT', 'Default', 10, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');

-- *************************
-- Employee Status
-- *************************
DELETE FROM com_code_value
  WHERE organization_id = &1 AND
        category = 'EMPLOYEE_STATUS' AND
        code IN ('A', 'I', 'T');

INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'EMPLOYEE_STATUS', 'A', 'Active', 10, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'EMPLOYEE_STATUS', 'I', 'Inactive', 20, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'EMPLOYEE_STATUS', 'T', 'Terminated', 30, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');

-- **********************
-- Employee Types
-- **********************
DELETE FROM com_code_value
  WHERE organization_id = &1 AND
        category = 'EMPLOYEE_TYPE' AND
        code IN ('DEFAULT');

INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'EMPLOYEE_TYPE', 'DEFAULT', 'Default', 10, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');

-- *******************
-- Gender
-- *******************
DELETE FROM com_code_value
  WHERE organization_id = &1 AND
        category = 'GENDER' AND
        code IN ('F', 'M');

INSERT INTO com_code_value (organization_id, category, code, description, sort_order, image_url, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'GENDER', 'F', 'Female', 20, 'res/graphics/avatar-female.png', GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, image_url, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'GENDER', 'M', 'Male', 10, 'res/graphics/avatar-male.png', GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');

-- ****************************
-- Gift Registry Address Types
-- ****************************
DELETE FROM com_code_value
  WHERE organization_id = &1 AND
        category = 'GIFT_REGISTRY_ADDRESS_TYPE' AND
        code IN ('VENUE', 'BEFORE_EVENT', 'AFTER_EVENT');

INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'GIFT_REGISTRY_ADDRESS_TYPE', 'VENUE', 'Venue', 10, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'GIFT_REGISTRY_ADDRESS_TYPE', 'BEFORE_EVENT', 'Before Event', 20, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'GIFT_REGISTRY_ADDRESS_TYPE', 'AFTER_EVENT', 'After Event', 30, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');

-- ***************************
-- Gift Registry Event Types
-- ***************************
DELETE FROM com_code_value
  WHERE organization_id = &1 AND
        category = 'GIFT_REGISTRY_EVENT_TYPE' AND
        code IN ('BABY_SHOWER', 'WEDDING_SHOWER');

INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'GIFT_REGISTRY_EVENT_TYPE', 'BABY_SHOWER', 'Baby Shower', 10, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'GIFT_REGISTRY_EVENT_TYPE', 'WEDDING_SHOWER', 'Wedding Shower', 20, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');

-- *******************
-- Insurance Plans
-- *******************
DELETE FROM com_code_value
  WHERE organization_id = &1 AND
        category = 'INSURANCE_PLAN' AND
        code IN ('P', 'G');

INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'INSURANCE_PLAN', 'P', 'P', 1, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'INSURANCE_PLAN', 'G', 'G', 2, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');

commit;
-- *******************************************
-- Employee Task Types
-- *******************************************
DELETE FROM com_code_value WHERE organization_id = &1 AND category = 'EMPLOYEE_TASK_TYPE';

INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'EMPLOYEE_TASK_TYPE', 'GENERAL', 'General', 10, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'EMPLOYEE_TASK_TYPE', 'MAILING', 'Mailing', 20, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'EMPLOYEE_TASK_TYPE', 'DISPLAY', 'Display', 30, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'EMPLOYEE_TASK_TYPE', 'HOUSEKEEPING', 'Housekeeping', 40, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'EMPLOYEE_TASK_TYPE', 'RECEIVING', 'Receiving', 50, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'EMPLOYEE_TASK_TYPE', 'SHIPPING', 'Shipping', 60, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'EMPLOYEE_TASK_TYPE', 'COUNT', 'Count', 70, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'EMPLOYEE_TASK_TYPE', 'APPOINTMENT', 'Appointment', 80, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'EMPLOYEE_TASK_TYPE', 'TASK', 'Task', 70, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');

-- *******************************************
-- Employee Task Visibility
-- *******************************************
DELETE FROM com_code_value WHERE organization_id = &1 AND category = 'EMPLOYEE_TASK_VISIBILITY';

INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'EMPLOYEE_TASK_VISIBILITY', 'STORE', 'Store', 10, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'EMPLOYEE_TASK_VISIBILITY', 'EMPLOYEE_GROUP', 'Employee Group', 20, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'EMPLOYEE_TASK_VISIBILITY', 'EMPLOYEE', 'Employee', 30, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');

-- *******************************************
-- Employee Groups
-- *******************************************
DELETE FROM com_code_value WHERE organization_id = &1 AND category = 'EMPLOYEE_GROUP';

INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'EMPLOYEE_GROUP', 'FRONT_ROOM', 'Front Room', 10, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'EMPLOYEE_GROUP', 'BACK_ROOM', 'Back Room', 20, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'EMPLOYEE_GROUP', 'TOP_EMPLOYEES', 'Top Employees', 30, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'EMPLOYEE_GROUP', 'OPENING_STAFF', 'Opening Staff', 40, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'EMPLOYEE_GROUP', 'CLOSING_STAFF', 'Closing Staff', 50, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');


-- *****************************
-- Inventory Bucket state codes
-- *****************************
DELETE FROM com_code_value
  WHERE organization_id = &1 AND
        category = 'INV_BUCKET_SYSTEM' AND
        code in ('SHIPPED', 'SOLD');

INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'INV_BUCKET_SYSTEM', 'SHIPPED', 'Shipped', 0, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'INV_BUCKET_SYSTEM', 'SOLD', 'Sold', 0, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');

-- ***************************************************
-- Inventory Bucket Tracking Method Codes
-- ***************************************************
DELETE FROM com_code_value
  WHERE organization_id = &1 AND
        category = 'INV_BUCKET_TRACKING_METHOD' AND
        code IN ('ALL');

INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'INV_BUCKET_TRACKING_METHOD', 'ALL', 'All', 10, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');

-- **************************************
-- Inventory Locator Distance selections
-- **************************************
DELETE FROM com_code_value
  WHERE organization_id = &1 AND
        category = 'INVENTORY_LOCATOR_DISTANCES' AND
        code IN ('5', '10', '15', '20', '30', '40', '50', '60', '70', '80', '90', '100', '120', '130', '140', '150');

commit;

-- ****************************
-- Item Group Codes
-- ****************************
DELETE FROM com_code_value
  WHERE organization_id = &1 AND
        category = 'ITEM_GROUP' AND
        code IN ('FL', 'FR', 'GP');

INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'ITEM_GROUP', 'FL', 'Fluids', 1, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'ITEM_GROUP', 'FR', 'Flares', 2, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'ITEM_GROUP', 'GP', 'Gasket Repair', 3, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');

-- **********************
-- Marital Status Codes
-- **********************
DELETE FROM com_code_value
  WHERE organization_id = &1 AND
        category = 'MARITAL_STATUS' AND
        code IN ('M', 'S');

INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'MARITAL_STATUS', 'M', 'Married', 10, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'MARITAL_STATUS', 'S', 'Single', 20, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');

-- ****************************
-- Module Names
-- ****************************
DELETE FROM com_code_value
  WHERE organization_id = &1 AND
        category = 'MODULE_NAME' AND
        code IN ('SALE', 'RETURN', 'TENDER', 'CUSTOMER', 'EMPLOYEE', 'INVENTORY', 'OTHER');

INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'MODULE_NAME', 'SALE', 'Sale', 10, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'MODULE_NAME', 'RETURN', 'Return', 20, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'MODULE_NAME', 'TENDER', 'Tendering', 30, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'MODULE_NAME', 'CUSTOMER', 'Customer', 40, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'MODULE_NAME', 'EMPLOYEE', 'Employee', 50, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'MODULE_NAME', 'INVENTORY', 'Inventory', 60, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'MODULE_NAME', 'OTHER', 'Other', 70, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');

-- ******************************
-- Party Property Displays
-- ******************************
DELETE FROM com_code_value
  WHERE organization_id = &1 AND
        category = 'PARTY_PROPERTY_DISPLAY' AND
        code IN ('PROMPT_TO_JOIN_LOYALTY', 'LIFETIME_ITEMS_RTN_PROP', 'LIFETIME_ITEMS_SOLD_PROP', 'LIFETIME_TRANS_PROP', 'LIFETIME_RTN_AMT_PROP', 'LIFETIME_SALE_AMT_PROP');

INSERT INTO com_code_value (organization_id, category, code, description, sort_order, hidden_flag, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'PARTY_PROPERTY_DISPLAY', 'PROMPT_TO_JOIN_LOYALTY', 'Prompt to join loyalty program?', 10, 1, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, hidden_flag, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'PARTY_PROPERTY_DISPLAY', 'LIFETIME_ITEMS_RTN_PROP', 'Lifetime return items count', 20, 0, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, hidden_flag, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'PARTY_PROPERTY_DISPLAY', 'LIFETIME_ITEMS_SOLD_PROP', 'Lifetime sold items count', 30, 0, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, hidden_flag, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'PARTY_PROPERTY_DISPLAY', 'LIFETIME_TRANS_PROP', 'Lifetime transaction count', 40, 0, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, hidden_flag, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'PARTY_PROPERTY_DISPLAY', 'LIFETIME_RTN_AMT_PROP', 'Lifetime return amount', 50, 0, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, hidden_flag, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'PARTY_PROPERTY_DISPLAY', 'LIFETIME_SALE_AMT_PROP', 'Lifetime sale amount', 60, 0, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');

-- ************************
-- Pay Status
-- ************************
DELETE FROM com_code_value
  WHERE organization_id = &1 AND
        category = 'PAY_STATUS' AND
        code IN ('H', 'S');

INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'PAY_STATUS', 'H', 'Hourly', 10, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'PAY_STATUS', 'S', 'Salaried', 20, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');

-- *****************************
-- Private Credit Account Types
-- *****************************
DELETE FROM com_code_value
  WHERE organization_id = &1 AND
        category = 'PRIVATE_CREDIT_ACCOUNT_TYPE' AND
        code IN ('STD', 'EXT', 'DEF');

INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'PRIVATE_CREDIT_ACCOUNT_TYPE', 'STD', 'Standard Account', 8, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'PRIVATE_CREDIT_ACCOUNT_TYPE', 'EXT', 'Extended Payment Plan', 8, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'PRIVATE_CREDIT_ACCOUNT_TYPE', 'DEF', 'Deferred Billing Plan', 8, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');

-- *************************************
-- Private Credit Primary Id Type Codes
-- *************************************
DELETE FROM com_code_value
  WHERE organization_id = &1 AND
        category = 'PRIVATE_CREDIT_PRIMARY_ID_TYPE' AND
        code IN ('DL', 'PS', 'SS');

INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'PRIVATE_CREDIT_PRIMARY_ID_TYPE', 'DL', 'Drivers License', 8, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'PRIVATE_CREDIT_PRIMARY_ID_TYPE', 'PS', 'Passport', 8, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'PRIVATE_CREDIT_PRIMARY_ID_TYPE', 'SS', 'Social Security Card', 8, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');

-- ***************************************
-- Private Credit Secondary ID Type Codes
-- ***************************************
DELETE FROM com_code_value
  WHERE organization_id = &1 AND
        category = 'PRIVATE_CREDIT_SECOND_ID_TYPE' AND
        code IN ('NONE', 'MC', 'AX', 'VS');

INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'PRIVATE_CREDIT_SECOND_ID_TYPE', 'NONE', '<None>', 0, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'PRIVATE_CREDIT_SECOND_ID_TYPE', 'MC', 'Mastercard', 10, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'PRIVATE_CREDIT_SECOND_ID_TYPE', 'VS', 'VISA', 20, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'PRIVATE_CREDIT_SECOND_ID_TYPE', 'AX', 'American Express', 30, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');

-- **********************************
-- Salutation
-- **********************************
DELETE FROM com_code_value
  WHERE organization_id = &1 AND
        category = 'SALUTATION';

-- *************************
-- Telephone Type Codes
-- *************************
DELETE FROM com_code_value
  WHERE organization_id = &1 AND
        category = 'TELEPHONE_TYPE' AND
        code IN ('Home', 'Work', 'Mobile', 'WorkFax');

INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'TELEPHONE_TYPE', 'Home', 'Home', 10, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'TELEPHONE_TYPE', 'Work', 'Work', 20, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'TELEPHONE_TYPE', 'Mobile', 'Mobile', 30, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'TELEPHONE_TYPE', 'WorkFax', 'Fax', 40, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');

-- ************************************
-- Locate Item Lookup Distances
-- ************************************
DELETE FROM com_code_value
  WHERE organization_id = &1 AND
        category = 'LOCATE_ITEM_DISTANCES' AND
        code IN ('5', '10', '25', '50', '100', '200');

INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'LOCATE_ITEM_DISTANCES', '5', '5', 5, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'LOCATE_ITEM_DISTANCES', '10', '10', 10, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'LOCATE_ITEM_DISTANCES', '25', '25', 20, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'LOCATE_ITEM_DISTANCES', '50', '50', 30, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'LOCATE_ITEM_DISTANCES', '100', '100', 40, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'LOCATE_ITEM_DISTANCES', '200', '200', 50, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');

-- *******************************************
-- Work Order Properties
-- *******************************************
DELETE FROM com_code_value
  WHERE organization_id = &1 AND
        category = 'WORK_ORDER_PRIORITIES' AND
        code IN ('WOP1', 'WOP2', 'WOP3');

INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'WORK_ORDER_PRIORITIES', 'WOP1', 'Normal', 10, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'WORK_ORDER_PRIORITIES', 'WOP2', 'Priority', 20, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO com_code_value (organization_id, category, code, description, sort_order, create_date, create_user_id, update_date, update_user_id) VALUES (&1, 'WORK_ORDER_PRIORITIES', 'WOP3', 'Urgent', 30, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');


commit;
-- *******************************************
-- Prompt for phone number
-- *******************************************
DELETE FROM com_trans_prompt_properties 
  WHERE organization_id = &1 AND 
        trans_prompt_property_code = 'PHONE_NUMBER' AND
        effective_date = '1900-01-01';
        
INSERT INTO com_trans_prompt_properties (organization_id, trans_prompt_property_code, effective_date, expiration_date, sort_order, prompt_mthd_code, prompt_edit_pattern, validation_rule_key, transaction_state, create_date, create_user_id, update_date, update_user_id)
  VALUES (&1, 'PHONE_NUMBER', '1900-01-01', '2008-01-01', 10, 'PHONEENTRY', '###-###-####', 'transPropPhoneNumberRules', 'PRE_TENDER', GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');

-- *******************************************
-- Prompt for postal code
-- *******************************************
DELETE FROM com_trans_prompt_properties 
  WHERE organization_id = &1 AND 
        trans_prompt_property_code = 'POSTAL_CODE' AND
        effective_date = '1900-01-01';

INSERT INTO com_trans_prompt_properties (organization_id, trans_prompt_property_code, effective_date, expiration_date, sort_order, transaction_state, create_date, create_user_id, update_date, update_user_id)
  VALUES (&1, 'POSTAL_CODE', '1900-01-01', '2008-01-01', 30, 'POST_TENDER', GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
 ---added default workstation for mpos ids
DELETE FROM loc_wkstn WHERE organization_id = &1 AND rtl_loc_id = &2 AND wkstn_id Between 100 And 110;
INSERT INTO loc_wkstn (organization_id, rtl_loc_id, wkstn_id, create_date, create_user_id, update_date, update_user_id) VALUES (&1, &2, 100, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO loc_wkstn (organization_id, rtl_loc_id, wkstn_id, create_date, create_user_id, update_date, update_user_id) VALUES (&1, &2, 101, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO loc_wkstn (organization_id, rtl_loc_id, wkstn_id, create_date, create_user_id, update_date, update_user_id) VALUES (&1, &2, 102, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO loc_wkstn (organization_id, rtl_loc_id, wkstn_id, create_date, create_user_id, update_date, update_user_id) VALUES (&1, &2, 103, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO loc_wkstn (organization_id, rtl_loc_id, wkstn_id, create_date, create_user_id, update_date, update_user_id) VALUES (&1, &2, 104, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO loc_wkstn (organization_id, rtl_loc_id, wkstn_id, create_date, create_user_id, update_date, update_user_id) VALUES (&1, &2, 105, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA'); 
INSERT INTO loc_wkstn (organization_id, rtl_loc_id, wkstn_id, create_date, create_user_id, update_date, update_user_id) VALUES (&1, &2, 106, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO loc_wkstn (organization_id, rtl_loc_id, wkstn_id, create_date, create_user_id, update_date, update_user_id) VALUES (&1, &2, 107, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO loc_wkstn (organization_id, rtl_loc_id, wkstn_id, create_date, create_user_id, update_date, update_user_id) VALUES (&1, &2, 108, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA');
INSERT INTO loc_wkstn (organization_id, rtl_loc_id, wkstn_id, create_date, create_user_id, update_date, update_user_id) VALUES (&1, &2, 109, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA'); 
INSERT INTO loc_wkstn (organization_id, rtl_loc_id, wkstn_id, create_date, create_user_id, update_date, update_user_id) VALUES (&1, &2, 110, GETUTCDATE(), 'BASEDATA', GETUTCDATE(), 'BASEDATA'); 
commit;
 
commit;