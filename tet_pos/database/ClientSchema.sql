-- ***************************************************************************
-- Place any customer specific schema changes into this file
--
-- All sql statements that goes here should be defined in a update-safe way, ie. the final script should be able 
-- to run against the database any number of times and should produce the same output.
--
-- This file should finish with a database commit; at least at the end of the file.
--
-- ***************************************************************************

-- *************************************************************************** 
alter session set current_schema=$(DbSchema);
BEGIN dbms_output.put_line('--- CREATING sp_column_exists --- '); END;
/
CREATE OR REPLACE function sp_column_exists (
 table_name     varchar2,
 column_name    varchar2
) return boolean is
 v_count integer;
 v_exists boolean;
begin
select decode(count(*),0,0,1) into v_count
    from all_tab_columns
    where owner = upper('$(DbSchema)')
      and table_name = upper(sp_column_exists.table_name)
      and column_name = upper(sp_column_exists.column_name);
 if v_count = 1 then
   v_exists := true;
 else
   v_exists := false;
 end if;
 return v_exists;
end sp_column_exists;
/

BEGIN dbms_output.put_line('--- CREATING sp_table_exists --- '); END;
/
CREATE OR REPLACE function sp_table_exists (
  table_name varchar2
) return boolean is
  v_count integer;
  v_exists boolean;
begin
  select decode(count(*),0,0,1) into v_count
    from all_tables
    where owner = upper('$(DbSchema)')
      and table_name = upper(sp_table_exists.table_name);
  if v_count = 1 then
    v_exists := true;
  else
    v_exists := false;
  end if;
  return v_exists;
end sp_table_exists;
/
--
-- XSTORE-3211: TABLE: LEV_INVCTL_DOC_LINEITM_TAX
-- 
BEGIN IF SP_TABLE_EXISTS ('LEV_INVCTL_DOC_LINEITM_TAX') THEN
       dbms_output.put_line('  LEV_INVCTL_DOC_LINEITM_TAX already exists');
        EXECUTE IMMEDIATE 'DROP TABLE LEV_INVCTL_DOC_LINEITM_TAX';
    END IF;	
  EXECUTE IMMEDIATE 'CREATE TABLE LEV_INVCTL_DOC_LINEITM_TAX
	   (	ORGANIZATION_ID 			NUMBER(10,0) 		NOT NULL, 
            RTL_LOC_ID 					NUMBER(10,0) 		NOT NULL, 
            INVCTL_DOCUMENT_ID 			VARCHAR2(60 CHAR) 	NOT NULL, 
            DOCUMENT_TYPCODE 			VARCHAR2(60 CHAR) 	NOT NULL, 
            INVCTL_DOCUMENT_LINE_NBR 	NUMBER(10,0) 		NOT NULL, 
            INVENTORY_ITEM_ID 			VARCHAR2(60 CHAR),
            CGST_AMT 					NUMBER(17,6), 
            CGST_PERCENT 				VARCHAR2(60 CHAR), 
            SGST_AMT 					NUMBER(17,6), 
            SGST_PERCENT 				VARCHAR2(60 CHAR), 
            IGST_AMT 					NUMBER(17,6), 
            IGST_PERCENT 				VARCHAR2(60 CHAR),
            TAXABLE_AMT 				NUMBER(17,6),
            TOTAL_GST 					NUMBER(17,6), 
            NET_AMT 					NUMBER(17,6), 
            CREATE_DATE 				TIMESTAMP (6), 
            CREATE_USER_ID 				VARCHAR2(30 CHAR), 
            UPDATE_DATE 				TIMESTAMP (6), 
            UPDATE_USER_ID 				VARCHAR2(30 CHAR), 
            RECORD_STATE 				VARCHAR2(30 CHAR),
		CONSTRAINT PK_LEV_INVCTL_DOC_LINEITM_TAX PRIMARY KEY 
        (ORGANIZATION_ID, RTL_LOC_ID, INVCTL_DOCUMENT_ID, DOCUMENT_TYPCODE, INVCTL_DOCUMENT_LINE_NBR)
		USING INDEX
		TABLESPACE XSTORE_INDEX)
		TABLESPACE XSTORE_DATA';		
		DBMS_OUTPUT.PUT_LINE('  LEV_INVCTL_DOC_LINEITM_TAX created');
  EXECUTE IMMEDIATE 'GRANT SELECT,INSERT,UPDATE,DELETE ON LEV_INVCTL_DOC_LINEITM_TAX TO POSUSERS,DBAUSERS'; 
		DBMS_OUTPUT.PUT_LINE('  Grant completed.');  
END;
/

--
-- XSTORE-5734: TABLE: LEV_INV_PEDIMENTO_STOCK
-- 
BEGIN IF SP_TABLE_EXISTS ('LEV_INV_PEDIMENTO_STOCK') THEN
       dbms_output.put_line('  LEV_INV_PEDIMENTO_STOCK already exists');
        EXECUTE IMMEDIATE 'DROP TABLE LEV_INV_PEDIMENTO_STOCK';
    END IF;	
  EXECUTE IMMEDIATE 'CREATE TABLE LEV_INV_PEDIMENTO_STOCK
		(ORGANIZATION_ID      	NUMBER(10) NOT NULL,
         RTL_LOC_ID           	NUMBER(10) NOT NULL,
         ITEM_ID      	  	  	VARCHAR2(60 CHAR) NOT NULL,
         PEDIMENTO_NO      	  	VARCHAR2(30 CHAR) NOT NULL,
         PRIORITY	      	  	NUMBER(10, 0),		 
		 ITEM_UPC      	  	  	VARCHAR2(60 CHAR),
		 UNIT_COUNT				NUMBER(14, 4),
	     CREATE_DATE          	TIMESTAMP(6),
	     CREATE_USER_ID       	VARCHAR2(30 CHAR),
	     UPDATE_DATE          	TIMESTAMP(6),
	     UPDATE_USER_ID       	VARCHAR2(30 CHAR),
	     RECORD_STATE         	VARCHAR2(30 CHAR),
		CONSTRAINT pk_lev_inv_pedimento PRIMARY KEY(ORGANIZATION_ID, RTL_LOC_ID, ITEM_ID, PEDIMENTO_NO)
	    USING INDEX
		TABLESPACE XSTORE_INDEX)
		TABLESPACE XSTORE_DATA';		
		DBMS_OUTPUT.PUT_LINE('  LEV_INV_PEDIMENTO_STOCK created');
  EXECUTE IMMEDIATE 'GRANT SELECT,INSERT,UPDATE,DELETE ON LEV_INV_PEDIMENTO_STOCK TO POSUSERS,DBAUSERS'; 
		DBMS_OUTPUT.PUT_LINE('  Grant completed.');  
END;
/

-- LEAVE BLANK LINE BELOW



COMMIT;

SPOOL OFF;
