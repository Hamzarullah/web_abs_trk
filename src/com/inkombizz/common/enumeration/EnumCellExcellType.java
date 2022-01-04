package com.inkombizz.common.enumeration;

public class EnumCellExcellType {
    public enum Enum_CellExcellType {
	NUMERIC(0), 
	STRING(1), 
	FORMULA(2), 
	BLANK(3), 
	BOOLEAN(4),
	ERROR(5);
	
	private final int enum_CellExcellType;

	Enum_CellExcellType(int enum_CellExcellType) {
		this.enum_CellExcellType = enum_CellExcellType;
	}

	public int getEnum_CellExcellTypeAsInt() {
		return enum_CellExcellType;
	}

	public String getEnum_CellExcellTypeAsString() {
		return String.valueOf(enum_CellExcellType);
	}

	public static Enum_CellExcellType convertIntToEnum_CellExcellType(int iEnum_CellExcellType) {
		for (Enum_CellExcellType enum_CellExcellType : Enum_CellExcellType.values()) {
			if (enum_CellExcellType.getEnum_CellExcellTypeAsInt() == iEnum_CellExcellType) {
				return enum_CellExcellType;
			}
		}
		return null;
	}

	public static Enum_CellExcellType convertStringToEnum_CellExcellType(String inputEnum_CellExcellType) {
		for (Enum_CellExcellType enum_CellExcellType : Enum_CellExcellType.values()) {
			if (enum_CellExcellType.getEnum_CellExcellTypeAsString().equals(inputEnum_CellExcellType)) {
				return enum_CellExcellType;
			}
		}
		return null;
	}

	public static int convertEnum_CellExcellTypeToInt(Enum_CellExcellType inputEnum_CellExcellType) {
		for (Enum_CellExcellType enum_CellExcellType : Enum_CellExcellType.values()) {
			if (enum_CellExcellType.getEnum_CellExcellTypeAsInt() == inputEnum_CellExcellType.getEnum_CellExcellTypeAsInt()) {
				return enum_CellExcellType.getEnum_CellExcellTypeAsInt();
			}
		}
		return -1;
	}

	public static String convertEnum_CellExcellTypeToString(Enum_CellExcellType inputEnum_CellExcellType) {
		for (Enum_CellExcellType enum_CellExcellType : Enum_CellExcellType.values()) {
			if (enum_CellExcellType.getEnum_CellExcellTypeAsInt() == inputEnum_CellExcellType.getEnum_CellExcellTypeAsInt()) {
				return enum_CellExcellType.getEnum_CellExcellTypeAsString();
			}
		}
		return null;
	}
}

    
}
