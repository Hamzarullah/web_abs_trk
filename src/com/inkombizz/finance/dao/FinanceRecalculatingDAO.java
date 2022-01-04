/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.finance.dao;

/**
 *
 * @author Rayis
 */

import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.system.dao.TransactionLogDAO;
import org.hibernate.HibernateException;


public class FinanceRecalculatingDAO {
    
    private HBMSession hbmSession;
    
    public FinanceRecalculatingDAO(HBMSession session) {
        this.hbmSession = session;
    }
    
    public void financeRecalculatingProses(String moduleCode) throws Exception {
        try {
                    
            /*  EMPTY    */    
            String empty_paid_amount = "CALL usp_Finance_Recalculating_Empty_DocumentPaidAmount()";
            hbmSession.hSession.createSQLQuery(empty_paid_amount)
                    .executeUpdate();
            hbmSession.hSession.flush();
            
            /*  NEW SUMMARY AMOUNT    */    
            String new_summary_amount = "CALL usp_Finance_Recalculating_New_SummaryAmount()";
            hbmSession.hSession.createSQLQuery(new_summary_amount)
                    .executeUpdate();
            hbmSession.hSession.flush();
            
            /*  NEW UPDATE AMOUNT    */    
            String new_update_amount = "CALL usp_Finance_Recalculating_New_Update_DocumentAmount()";
            hbmSession.hSession.createSQLQuery(new_update_amount)
                    .executeUpdate();
            hbmSession.hSession.flush();
          
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT), 
                                                                    "FinanceRecalculating", ""));
//             commitAndClear();
             hbmSession.hTransaction.commit();
             hbmSession.hSession.clear();
             hbmSession.hSession.close();
        }
        catch (HibernateException e) {
            e.printStackTrace();           
            hbmSession.hTransaction.rollback(); 
            throw new Exception("FINACE RECALCULATING FAILED!");
//            throw e;
        }
    }
}
