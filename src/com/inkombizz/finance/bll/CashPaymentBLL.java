/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.finance.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.dao.CashPaymentDAO;
import com.inkombizz.finance.model.CashPayment;
import com.inkombizz.finance.model.CashPaymentDetail;
import com.inkombizz.finance.model.CashPaymentDetailTemp;
import com.inkombizz.finance.model.CashPaymentField;
import com.inkombizz.finance.model.CashPaymentPaymentRequestTemp;
import com.inkombizz.finance.model.CashPaymentTemp;
import java.util.Date;
import java.util.List;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

public class CashPaymentBLL {
    
    public static final String MODULECODE = "004_FIN_CASH_PAYMENT";
    public static final String MODULECODE_ACC_SPV = "004_FIN_CASH_PAYMENT_ACC_SPV";
    
    private CashPaymentDAO cashPaymentDAO;
    
    public CashPaymentBLL(HBMSession hbmSession){
        this.cashPaymentDAO = new CashPaymentDAO(hbmSession);
    }
    
    
    public ListPaging<CashPaymentTemp> findData(Paging paging, CashPaymentTemp cashPaymentTemp) throws Exception {
        try {
                     
            paging.setRecords(cashPaymentDAO.countData(cashPaymentTemp));
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<CashPaymentTemp> listCashPaymentTemp = cashPaymentDAO.findData(cashPaymentTemp, paging.getFromRow(), paging.getToRow());
            
            ListPaging<CashPaymentTemp> listPaging = new ListPaging<CashPaymentTemp>();
            
            listPaging.setList(listCashPaymentTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
//    public ListPaging<CashPaymentTemp> findData(Paging paging, String code,String cashPaymentPaymentTo,String status,Date firstDate, Date lastDate) throws Exception {
//        try {
//                     
//            paging.setRecords(cashPaymentDAO.countData(code,cashPaymentPaymentTo,status,firstDate, lastDate));
//            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
//            
//            List<CashPaymentTemp> listCashPaymentTemp = cashPaymentDAO.findData(code,cashPaymentPaymentTo,status,firstDate, lastDate, paging.getFromRow(), paging.getToRow());
//            
//            ListPaging<CashPaymentTemp> listPaging = new ListPaging<CashPaymentTemp>();
//            
//            listPaging.setList(listCashPaymentTemp);
//            listPaging.setPaging(paging);
//            
//            return listPaging;  
//        }
//        catch(Exception ex) {
//            throw ex;
//        }
//    }
    
    public List<CashPaymentPaymentRequestTemp> findDataCashPaymentRequest(String headerCode) throws Exception {
        try {
                     
            List<CashPaymentPaymentRequestTemp> listCashPaymentRequestTemp = cashPaymentDAO.findDataCashPaymentRequest(headerCode);
            
            return listCashPaymentRequestTemp;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<CashPaymentDetailTemp> findDataCashPaymentDetail(String headerCode) throws Exception {
        try {
            
            List<CashPaymentDetailTemp> listCashPaymentDetailTemp = cashPaymentDAO.findDataCashPaymentDetail(headerCode);
            
            return listCashPaymentDetailTemp;  
        }
        catch(Exception ex) {
            ex.printStackTrace();
            throw ex;
        }
    }
    
    //check code dah ada di DB?
    public boolean isExist(String headerCode) throws Exception{
        try{            
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(CashPayment.class)
                            .add(Restrictions.eq(CashPaymentField.CODE, headerCode));
             
            if(cashPaymentDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
    
    public void save(CashPayment cashPayment, List<CashPaymentDetail> listCashPaymentDetail,Double forexAmount) throws Exception {
        try {
            cashPaymentDAO.save(cashPayment, listCashPaymentDetail, forexAmount, MODULECODE);
        }
        catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }
    
    public void update(CashPayment cashPayment, List<CashPaymentDetail> listCashPaymentDetail, Double forexAmount) throws Exception {
        try {
            cashPaymentDAO.update(cashPayment, listCashPaymentDetail, forexAmount, MODULECODE);
        }
        catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }
    
    public void updateAccSpv(CashPayment cashPayment, List<CashPaymentDetail> listCashPaymentDetail, Double forexAmount) throws Exception {
        try {
            cashPaymentDAO.updateAccSpv(cashPayment, listCashPaymentDetail, forexAmount, MODULECODE);
        }
        catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }
    
    public void delete(String headerCode) throws Exception{
        cashPaymentDAO.delete(headerCode, MODULECODE);
    }

    public ListPaging<CashPaymentTemp> findData(Paging paging, String cashCode, String cashPaymentTo, Date cashFirstDate, Date cashLastDate) {
       try {
                     
            paging.setRecords(cashPaymentDAO.countDataAccSpv(cashCode,cashPaymentTo,cashFirstDate,cashLastDate));
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<CashPaymentTemp> listCashPaymentTemp = cashPaymentDAO.findDataAccSpv(cashCode,cashPaymentTo,cashFirstDate,cashLastDate, paging.getFromRow(), paging.getToRow());
            
            ListPaging<CashPaymentTemp> listPaging = new ListPaging<CashPaymentTemp>();
            
            listPaging.setList(listCashPaymentTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
}
