package com.inkombizz.common.enumeration;

public class EnumMonth {

    public enum ENUM_Month {
        JANUARY,
        FEBRUARY,
        MARCH,
        APRIL,
        MAY,
        JUNE,
        JULY,
        AUGUST,
        SEPTEMBER,
        OCTOBER,
        NOVEMBER,
        DECEMBER    
    }

    public static String toString(int month, boolean isLocal)
    {
        String rValue = "";

        if (month == 1)
        {
            if (isLocal)
                rValue = "Januari";
            else
                rValue = "January";
        }

        else if (month == 2)
        {
             if (isLocal)
                rValue = "Februari";
            else
                rValue = "February";
        }

        else if (month == 3)
        {
            if (isLocal)
                rValue = "Maret";
            else
                rValue = "March";
        }

        else if (month == 4)
        {
            if (isLocal)
                rValue = "April";
            else
                rValue = "April";
        }

        else if (month == 5)
        {
            if (isLocal)
                rValue = "Mei";
            else
                rValue = "May";
        }

        else if (month == 6)
        {
            if (isLocal)
                rValue = "Juni";
            else
                rValue = "June";
        }

        else if (month == 7)
        {
            if (isLocal)
                rValue = "Juli";
            else
                rValue = "July";
        }

        else if (month == 8)
        {
            if (isLocal)
                rValue = "Agustus";
            else
                rValue = "August";
        }

        else if (month == 9)
        {
           rValue = "September";
        }

        else if (month == 10)
        {
           if (isLocal)
                rValue = "Oktober";
            else
                rValue = "October";
        }

        else if (month == 11)
        {
            rValue = "November";
        }

        else if (month == 12)
        {
            if (isLocal)
                rValue = "Desember";
            else
                rValue = "December";
        }

        return rValue;
    }

    public static String toRomawi(int month)
    {
        String rValue = "";

        if (month == 1)
        {
            rValue = "I";
        }

        else if (month == 2)
        {
            rValue = "II";
        }

        else if (month == 3)
        {
            rValue = "III";
        }

        else if (month == 4)
        {
            rValue = "IV";
        }

        else if (month == 5)
        {
            rValue = "V";
        }

        else if (month == 6)
        {
            rValue = "VI";
        }

        else if (month == 7)
        {
            rValue = "VII";
        }

        else if (month == 8)
        {
            rValue = "VIII";
        }

        else if (month == 9)
        {
            rValue = "IX";
        }

        else if (month == 10)
        {
            rValue = "X";
        }

        else if (month == 11)
        {
            rValue = "XI";
        }

        else if (month == 12)
        {
            rValue = "XII";
        }

        return rValue;
    }

    public static int toInt(ENUM_Month month)
    {
        int rValue = 0;

        if (month == EnumMonth.ENUM_Month.JANUARY)
            rValue = 1;
        else if (month == EnumMonth.ENUM_Month.FEBRUARY)
            rValue = 2;
        else if (month == EnumMonth.ENUM_Month.MARCH)
            rValue = 3;
        else if (month == EnumMonth.ENUM_Month.APRIL)
            rValue = 4;
        else if (month == EnumMonth.ENUM_Month.MAY)
            rValue = 5;
        else if (month == EnumMonth.ENUM_Month.JUNE)
            rValue = 6;
        else if (month == EnumMonth.ENUM_Month.JULY)
            rValue = 7;
        else if (month == EnumMonth.ENUM_Month.AUGUST)
            rValue = 8;
        else if (month == EnumMonth.ENUM_Month.SEPTEMBER)
            rValue = 9;
        else if (month == EnumMonth.ENUM_Month.OCTOBER)
            rValue = 10;
        else if (month == EnumMonth.ENUM_Month.NOVEMBER)
            rValue = 11;
        else if (month == EnumMonth.ENUM_Month.DECEMBER)
            rValue = 12;

        return rValue;
    }

}
