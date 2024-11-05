package com.oti.thirtyone.enums;

public enum HolidayType {
    ANNUAL_HDR(1, "연가"),
    SUBSTITUTE_HDR(2, "대체휴무"),
    SICK_HDR(3, "병가");

    private final int code;
    private final String category;


    HolidayType(int code, String category) {
        this.code = code;
        this.category = category;
    }

    public static HolidayType fromCode(int code) {
        for (HolidayType type : HolidayType.values()) {
            if (type.code == code) {
                return type;
            }
        }
        throw new IllegalArgumentException("Invalid code: " + code);
    }

    public String getCategory() {
        return category;
    }

    public int getCode() {
        return code;
    }
}
