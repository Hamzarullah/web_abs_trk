

package com.inkombizz.utils;

import java.util.logging.Level;
import java.util.logging.Logger;

public class JavaTerbilang {
    
    int number = 0;
    boolean includeCurrency = false;

    public JavaTerbilang(int numberr, boolean includeCurrencyy)
    {
        number = numberr;
        includeCurrency = includeCurrencyy;
    }

    public String get()
    {
    String nilai = "";
    if(includeCurrency)
    {
    nilai = JavaTerbilang.convert(number) + " Rupiah";
    }
    else
    {
    nilai = JavaTerbilang.convert(number);
    }

    return nilai;
    }

    static public String convert(int numberr)
    {
        if( (numberr < 0) || (numberr > 999999999) )
        {
            try {
                throw new Exception("Number is out of range");
            } catch (Exception ex) {
                Logger.getLogger(JavaTerbilang.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        int Gn = (int) Math.floor( numberr / 1000000 ); // Millions (giga)
        numberr -= Gn * 1000000;
        int Kn = (int) Math.floor(numberr / 1000); // Thousands (kilo)
        numberr -= Kn * 1000;
        Integer Hn = (int) Math.floor(numberr / 100); // Hundreds (hecto)
        numberr -= Hn * 100;
        int Dn = (int) Math.floor(numberr / 10); // Tens (deca)
        int n = numberr % 10; // Ones

        StringBuilder res = new StringBuilder();

        if(Gn != 0)
        {
            res.append(JavaTerbilang.convert(Gn) + " Juta ");
        }

        if(Kn != 0)
        {
            res.append((res.toString().isEmpty() ? "" : "") + JavaTerbilang.convert(Kn) + " Ribu " );
        }

        if(Hn != 0)
        {
            res.append((res.toString().isEmpty() ? "" : "") + JavaTerbilang.convert(Hn) + " Ratus" );
        }

        String[] ones = {"", "Satu", "Dua", "Tiga", "Empat", "Lima", "Enam", "Tujuh", "Delapan", "Sembilan",
        "Sepuluh", "Sebelas", "Dua Belas", "Tiga Belas", "Empat Belas", "Lima Belas", "Enam Belas",
        "Tujuh Belas", "Delapan Belas", "Sembilan Belas"};
        String[] tens = {"", "Sepuluh", "Dua Puluh", "Tiga Puluh", "Empat Puluh", "Lima Puluh", "Enam Puluh",
        "Tujuh Puluh", "Delapan Puluh", "Sembilan Puluh"};
        String[] thousands = {"", "Seribu", "Dua Ribu", "Tiga Ribu", "Empat Ribu", "Lima Ribu", "Enam Ribu",
        "Tujuh Ribu", "Delapan Ribu", "Sembilan Ribu"};

        if(Dn != 0 || n != 0)
        {
            if(!res.toString().isEmpty())
            {
                res.append(" ");
            }

            if(Dn < 2)
            {
                res.append(ones[Dn * 10 + n]);
            }
            else
            {
                res.append(tens[Dn]);
                if(n != 0)
                {
                    res.append(" " + ones[n]);
                }
            }
        }

        if(res.toString().isEmpty())
        {
            res.append("nol");
        }

        replace("Satu Ratus", "Seratus", res);
        replace("Satu Ribu", "Seribu", res);

        return res.toString();
    }

    public static void replace( String target, String replacement, StringBuilder builder )
    {
        int indexOfTarget = -1;
        while( ( indexOfTarget = builder.indexOf( target ) ) >= 0 )
        {
            builder.replace( indexOfTarget, indexOfTarget + target.length() , replacement );
        }
    }

    public static void main(String[] args)
    {
        JavaTerbilang rupiahNumberWord = new JavaTerbilang(1780000, true);
        System.out.println( rupiahNumberWord.get() );
    }
}
