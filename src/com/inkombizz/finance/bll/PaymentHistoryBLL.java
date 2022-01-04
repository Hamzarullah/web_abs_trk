/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.finance.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.dao.PaymentHistoryDAO;
import com.inkombizz.finance.model.PaymentHistoryDetailTemp;
import com.inkombizz.finance.model.PaymentHistoryTemp;
import java.util.Date;
import java.util.List;

public class PaymentHistoryBLL {
    
    public static final String MODULECODE_PAYMENT = "004_FIN_PAYMENT_HISTORY";
    
    private PaymentHistoryDAO payableHistoryDAO;
    
    public PaymentHistoryBLL(HBMSession hbmSession){
        this.payableHistoryDAO = new PaymentHistoryDAO(hbmSession);
    }
    
    public ListPaging<PaymentHistoryTemp> findData(Paging paging,Date firstDate, Date lastDate, PaymentHistoryTemp paymentHistoryTemp) throws Exception{
        try{

            paging.setRecords(payableHistoryDAO.countByData(firstDate, lastDate, paymentHistoryTemp));
            paging.setTotal((int)Math.ceil((double)paging.getRecords()/(double)paging.getRows()));
            
            List<PaymentHistoryTemp> listPayableHistoryTemp = payableHistoryDAO.findData(firstDate, lastDate, paymentHistoryTemp, paging.getFromRow(), paging.getToRow());
            
            ListPaging<PaymentHistoryTemp> listPaging = new ListPaging<PaymentHistoryTemp>();
            listPaging.setList(listPayableHistoryTemp);
            listPaging.setPaging(paging);
            
            return listPaging;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return null;
        }
    }
    
    public List<PaymentHistoryDetailTemp> getDataPaymentHistoryDetail(String documentType, String documentNo) throws Exception{
        try{
            
            List<PaymentHistoryDetailTemp> listPaymentHistoryDetailTemp = payableHistoryDAO.findPaymentHistoryDetail(documentType, documentNo);
            
            return listPaymentHistoryDetailTemp;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return null;
        }
    }
}
