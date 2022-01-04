/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.finance.bll;

/**
 *
 * @author Rayis
 */

import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.dao.FinanceRecalculatingDAO;


public class FinanceRecalculatingBLL {
    
    public static final String MODULECODE = "004_FIN_FINANCE_RECALCULATING";
    
    private FinanceRecalculatingDAO financeRecalculatingDAO;
    
    public FinanceRecalculatingBLL(HBMSession hbmSession){
        this.financeRecalculatingDAO = new FinanceRecalculatingDAO(hbmSession);
    }
    
    public void financeRecalculatingProses() throws Exception{
        try{
            financeRecalculatingDAO.financeRecalculatingProses(MODULECODE);
        }
        catch(Exception ex){
            ex.printStackTrace();
            throw ex;
        }
    }
}
