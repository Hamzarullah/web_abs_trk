package com.inkombizz.utils;

import com.inkombizz.system.model.Setup;
import java.util.Calendar;
import java.util.Date;

public class Globalize {
	
	public static double getPercentAmount(double percent, double amount) {
		return amount * (percent/100);
	}
	
	public static double getCOGS(double price, double discPercent, double discPercentHeader) {
		
		double subTotal = price - getPercentAmount(discPercent, price);
		
		return subTotal - getPercentAmount(discPercentHeader, subTotal);
	}
	
	public static double getSubTotal(double quantity, double price, double discountPercent) {
		double total = quantity * price; 
		return  total - (total * (discountPercent/100));
	}
	
	public static short getCell(String cellPosition) {
		short rValue = 0;
		
		cellPosition = cellPosition.toUpperCase();
		
		if (cellPosition.equals("A")) {rValue = 0;}
		else if (cellPosition.equals("B")) {rValue = 1;}
		else if (cellPosition.equals("C")) {rValue = 2;}
		else if (cellPosition.equals("D")) {rValue = 3;}
		else if (cellPosition.equals("E")) {rValue = 4;}
		else if (cellPosition.equals("F")) {rValue = 5;}
		else if (cellPosition.equals("G")) {rValue = 6;}
		else if (cellPosition.equals("H")) {rValue = 7;}
		else if (cellPosition.equals("I")) {rValue = 8;}
		else if (cellPosition.equals("J")) {rValue = 9;}
		else if (cellPosition.equals("K")) {rValue = 10;}
		else if (cellPosition.equals("L")) {rValue = 11;}
		else if (cellPosition.equals("M")) {rValue = 12;}
		else if (cellPosition.equals("N")) {rValue = 13;}
		else if (cellPosition.equals("O")) {rValue = 14;}
		else if (cellPosition.equals("P")) {rValue = 15;}
		else if (cellPosition.equals("Q")) {rValue = 16;}
		else if (cellPosition.equals("R")) {rValue = 17;}
		else if (cellPosition.equals("S")) {rValue = 18;}
		else if (cellPosition.equals("T")) {rValue = 19;}
		else if (cellPosition.equals("U")) {rValue = 20;}
		else if (cellPosition.equals("V")) {rValue = 21;}
		else if (cellPosition.equals("W")) {rValue = 22;}
		else if (cellPosition.equals("X")) {rValue = 23;}
		else if (cellPosition.equals("Y")) {rValue = 24;}
		else if (cellPosition.equals("Z")) {rValue = 25;}
		else if (cellPosition.equals("AA")) {rValue = 26;}
		else if (cellPosition.equals("AB")) {rValue = 27;}
		else if (cellPosition.equals("AC")) {rValue = 28;}
		else if (cellPosition.equals("AD")) {rValue = 29;}
		else if (cellPosition.equals("AE")) {rValue = 30;}
		else if (cellPosition.equals("AF")) {rValue = 31;}
		else if (cellPosition.equals("AG")) {rValue = 32;}
		else if (cellPosition.equals("AH")) {rValue = 33;}
		else if (cellPosition.equals("AI")) {rValue = 34;}
		else if (cellPosition.equals("AJ")) {rValue = 35;}
		else if (cellPosition.equals("AK")) {rValue = 36;}
		else if (cellPosition.equals("AL")) {rValue = 37;}
		else if (cellPosition.equals("AM")) {rValue = 38;}
		else if (cellPosition.equals("AN")) {rValue = 39;}
		else if (cellPosition.equals("AO")) {rValue = 40;}
		else if (cellPosition.equals("AP")) {rValue = 41;}
		else if (cellPosition.equals("AQ")) {rValue = 42;}
		else if (cellPosition.equals("AR")) {rValue = 43;}
		else if (cellPosition.equals("AS")) {rValue = 44;}
		else if (cellPosition.equals("AT")) {rValue = 45;}
		else if (cellPosition.equals("AU")) {rValue = 46;}
		else if (cellPosition.equals("AV")) {rValue = 47;}
		else if (cellPosition.equals("AW")) {rValue = 48;}
		else if (cellPosition.equals("AX")) {rValue = 49;}
		else if (cellPosition.equals("AY")) {rValue = 50;}
                else if (cellPosition.equals("AZ")) {rValue = 51;}
		else if (cellPosition.equals("BA")) {rValue = 52;}
		else if (cellPosition.equals("BB")) {rValue = 53;}
		else if (cellPosition.equals("BC")) {rValue = 54;}
		else if (cellPosition.equals("BD")) {rValue = 55;}
		else if (cellPosition.equals("BE")) {rValue = 56;}
		else if (cellPosition.equals("BF")) {rValue = 57;}
		else if (cellPosition.equals("BG")) {rValue = 58;}
		else if (cellPosition.equals("BH")) {rValue = 59;}
		else if (cellPosition.equals("BI")) {rValue = 60;}
		else if (cellPosition.equals("BJ")) {rValue = 61;}
		else if (cellPosition.equals("BK")) {rValue = 62;}
		else if (cellPosition.equals("BL")) {rValue = 63;}
		else if (cellPosition.equals("BM")) {rValue = 64;}
		else if (cellPosition.equals("BN")) {rValue = 65;}
		else if (cellPosition.equals("BO")) {rValue = 66;}
		else if (cellPosition.equals("BP")) {rValue = 67;}
		else if (cellPosition.equals("BQ")) {rValue = 68;}
		else if (cellPosition.equals("BR")) {rValue = 69;}
		else if (cellPosition.equals("BS")) {rValue = 70;}
		else if (cellPosition.equals("BT")) {rValue = 71;}
		else if (cellPosition.equals("BU")) {rValue = 72;}
		else if (cellPosition.equals("BV")) {rValue = 73;}
		else if (cellPosition.equals("BW")) {rValue = 74;}
		else if (cellPosition.equals("BX")) {rValue = 75;}
		else if (cellPosition.equals("BY")) {rValue = 76;}
		else if (cellPosition.equals("BZ")) {rValue = 77;}
		else if (cellPosition.equals("CA")) {rValue = 78;}
		else if (cellPosition.equals("CB")) {rValue = 79;}
		else if (cellPosition.equals("CC")) {rValue = 80;}
		else if (cellPosition.equals("CD")) {rValue = 81;}
		else if (cellPosition.equals("CE")) {rValue = 82;}
		else if (cellPosition.equals("CF")) {rValue = 83;}
		else if (cellPosition.equals("CG")) {rValue = 84;}
		else if (cellPosition.equals("CH")) {rValue = 85;}
		else if (cellPosition.equals("CI")) {rValue = 86;}
		else if (cellPosition.equals("CJ")) {rValue = 87;}
		else if (cellPosition.equals("CK")) {rValue = 88;}
		else if (cellPosition.equals("CL")) {rValue = 89;}
		else if (cellPosition.equals("CM")) {rValue = 90;}
		else if (cellPosition.equals("CN")) {rValue = 91;}
		else if (cellPosition.equals("CO")) {rValue = 92;}
		else if (cellPosition.equals("CP")) {rValue = 93;}
		else if (cellPosition.equals("CQ")) {rValue = 94;}
		else if (cellPosition.equals("CR")) {rValue = 95;}
		else if (cellPosition.equals("CS")) {rValue = 96;}
		else if (cellPosition.equals("CT")) {rValue = 97;}
		else if (cellPosition.equals("CU")) {rValue = 98;}
		else if (cellPosition.equals("CV")) {rValue = 99;}
		else if (cellPosition.equals("CW")) {rValue = 100;}
                else if (cellPosition.equals("CX")) {rValue = 101;}
		else if (cellPosition.equals("CY")) {rValue = 102;}
		else if (cellPosition.equals("CZ")) {rValue = 103;}
		else if (cellPosition.equals("DA")) {rValue = 104;}
		else if (cellPosition.equals("DB")) {rValue = 105;}
                else if (cellPosition.equals("DC")) {rValue = 106;}
                else if (cellPosition.equals("DD")) {rValue = 107;}
                else if (cellPosition.equals("DE")) {rValue = 108;}
                else if (cellPosition.equals("DF")) {rValue = 109;}
                else if (cellPosition.equals("DG")) {rValue = 110;}
                else if (cellPosition.equals("DH")) {rValue = 111;}
                else if (cellPosition.equals("DI")) {rValue = 112;}
                
		return rValue;
	}
        
        public static String createdSuratJalanNo(String enumTransactionType, Setup setup, Date transactionDate, String refNo, String deliveryType) {
		
		String autoNo = "";
                int u = DateUtils.getMonth(transactionDate);
		String month = IntegerToRomanNumeral(u);
		String year = DateUtils.getYearRight(transactionDate);
		
		if (enumTransactionType.equals("BTO")) {
			autoNo = "/" + setup.getCompanyAcronym() + "/SJ/" + month + "/" + year;   
		}
		else if (enumTransactionType.equals("BTOK")) {
			autoNo = "/" + setup.getCompanyAcronym() + "/KS/" + month + "/" + year;   
		}
                else if (enumTransactionType.equals("SJB")) {
			autoNo = "/" + setup.getCompanyAcronym() + "/SJB/" + month + "/" + year;   
		}
		else if (enumTransactionType.equals("BTOP")) {
			
//			if (deliveryType.equals(EnumDeliveryType.WAREHOUSE.toString())) {
//				autoNo = "/PD/" + month + "/" + year;
//			}
//			else {
//				autoNo = "/RM/STAR/" + month + "/" + year;
//			}   
		}
		
		return refNo + autoNo ;
	}
        
        public static String IntegerToRomanNumeral(int input) {
            
            if (input < 1 || input > 3999)
                return "Invalid Roman Number Value";
            
            String s = "";
            
            while (input >= 1000) {
                s += "M";
                input -= 1000;        
            }
            while (input >= 900) {
                s += "CM";
                input -= 900;
            }
            while (input >= 500) {
                s += "D";
                input -= 500;
            }
            while (input >= 400) {
                s += "CD";
                input -= 400;
            }
            while (input >= 100) {
                s += "C";
                input -= 100;
            }
            while (input >= 90) {
                s += "XC";
                input -= 90;
            }
            while (input >= 50) {
                s += "L";
                input -= 50;
            }
            while (input >= 40) {
                s += "XL";
                input -= 40;
            }
            while (input >= 10) {
                s += "X";
                input -= 10;
            }
            while (input >= 9) {
                s += "IX";
                input -= 9;
            }
            while (input >= 5) {
                s += "V";
                input -= 5;
            }
            while (input >= 4) {
                s += "IV";
                input -= 4;
            }
            while (input >= 1) {
                s += "I";
                input -= 1;
            }    
            return s;
        }
}