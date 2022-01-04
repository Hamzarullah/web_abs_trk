package com.inkombizz.common;


public class ExcelColumnName {
        
    // Function to convert given number into an excel column
    public static String getColumnName(int n)
    {
        // initalize output String as empty
        StringBuilder res = new StringBuilder();

        while (n > 0)
        {
                // find index of next letter and concatenate the letter
                // to the solution

                // Here index 0 corresponds to 'A' and 25 corresponds to 'Z'
                int index = (n - 1) % 26;
                res.append((char)(index + 'A'));
                n = (n - 1) / 26;
        }

        return res.reverse().toString();
    }
    
}