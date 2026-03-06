// $Id: RoFiscalRbcHelperTest.java 1322663 2021-08-04 09:01:23Z pkraak $
package orcs.country.ro.rbc;

import static org.junit.Assert.*;

import org.junit.Before;
import org.junit.Test;

/**
 * Unit Test for {@link RoFiscalRbcHelper}
 * <br>
 * Copyright (c) 2021 RGBU - ORC-S (Oracle Retail Consulting Store)
 *
 * @author pkraak
 * created 2021-07-20
 * @version $Revision: 1322663 $
 */
public class RoFiscalRbcHelperTest {

  RoFiscalRbcHelper roFiscalRbcHelper;

  @Before public void setup() {
    roFiscalRbcHelper = new RoFiscalRbcHelper();
  }

  @Test public void validateTaxID() {
    assertTrue(roFiscalRbcHelper.validateCNP("6000602016138"));
  }

  @Test public void validateCIF() {
    assertFalse(roFiscalRbcHelper.validateCIF(" 1234567897"));
    assertTrue(roFiscalRbcHelper.validateCIF("1234567897"));
    assertFalse(roFiscalRbcHelper.validateCIF(" 123456789"));
    assertTrue(roFiscalRbcHelper.validateCIF("123456789"));
    assertFalse(roFiscalRbcHelper.validateCIF("0"));
    assertTrue(roFiscalRbcHelper.validateCIF("RO00"));
    assertTrue(roFiscalRbcHelper.validateCIF("RO1234565"));
    assertFalse(roFiscalRbcHelper.validateCIF("12345678978"));
    assertFalse(roFiscalRbcHelper.validateCIF(" 12345678978"));
  }

  @Test public void validateCNP() {
    assertTrue(roFiscalRbcHelper.validateCNP("6000602016138"));
    assertFalse(roFiscalRbcHelper.validateCNP("60006020161389"));
    assertFalse(roFiscalRbcHelper.validateCNP("600060201613"));
  }
}