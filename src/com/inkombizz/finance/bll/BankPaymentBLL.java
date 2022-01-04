/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.finance.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.dao.BankPaymentDAO;
import com.inkombizz.finance.model.BankPayment;
import com.inkombizz.finance.model.BankPaymentDetail;
import com.inkombizz.finance.model.BankPaymentDetailTemp;
import com.inkombizz.finance.model.BankPaymentField;
import com.inkombizz.finance.model.BankPaymentPaymentRequestTemp;
import com.inkombizz.finance.model.BankPaymentTemp;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

public class BankPaymentBLL {
    
    public static final String MODULECODE = "004_FIN_BANK_PAYMENT";
    public static final String MODULECODE_ACC_SPV = "004_FIN_BANK_PAYMENT_ACC_SPV";
    
    private BankPaymentDAO bankPaymentDAO;
    
    public BankPaymentBLL(HBMSession hbmSession){
        this.bankPaymentDAO = new BankPaymentDAO(hbmSession);
    }
    
    
    public ListPaging<BankPaymentTemp> findData(Paging paging, BankPaymentTemp bankPaymentTemp) throws Exception {
        try {
                     
            paging.setRecords(bankPaymentDAO.countData(bankPaymentTemp));
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<BankPaymentTemp> listBankPaymentTemp = bankPaymentDAO.findData(bankPaymentTemp, paging.getFromRow(), paging.getToRow());
            
            ListPaging<BankPaymentTemp> listPaging = new ListPaging<BankPaymentTemp>();
            
            listPaging.setList(listBankPaymentTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
//    public ListPaging<BankPaymentTemp> findData(Paging paging, String code,String bankPaymentPaymentTo,String status,Date firstDate, Date lastDate) throws Exception {
//        try {
//                     
//            paging.setRecords(bankPaymentDAO.countData(code,bankPaymentPaymentTo,status,firstDate, lastDate));
//            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
//            
//            List<BankPaymentTemp> listBankPaymentTemp = bankPaymentDAO.findData(code,bankPaymentPaymentTo,status,firstDate, lastDate, paging.getFromRow(), paging.getToRow());
//            
//            ListPaging<BankPaymentTemp> listPaging = new ListPaging<BankPaymentTemp>();
//            
//            listPaging.setList(listBankPaymentTemp);
//            listPaging.setPaging(paging);
//            
//            return listPaging;  
//        }
//        catch(Exception ex) {
//            throw ex;
//        }
//    }
    
    public List<BankPaymentPaymentRequestTemp> findDataBankPaymentRequest(String headerCode) throws Exception {
        try {
                     
            List<BankPaymentPaymentRequestTemp> listBankPaymentRequestTemp = bankPaymentDAO.findDataBankPaymentRequest(headerCode);
            
            return listBankPaymentRequestTemp;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<BankPaymentDetailTemp> findDataBankPaymentDetail(String headerCode) throws Exception {
        try {
            
            List<BankPaymentDetailTemp> listBankPaymentDetailTemp = bankPaymentDAO.findDataBankPaymentDetail(headerCode);
            
            return listBankPaymentDetailTemp;  
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
            
            DetachedCriteria criteria = DetachedCriteria.forClass(BankPayment.class)
                            .add(Restrictions.eq(BankPaymentField.CODE, headerCode));
             
            if(bankPaymentDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
    
    public void save(BankPayment bankPayment, List<BankPaymentDetail> listBankPaymentDetail,Double forexAmount) throws Exception {
        try {
            bankPaymentDAO.save(bankPayment, listBankPaymentDetail, forexAmount, MODULECODE);
        }
        catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }
    
    public void update(BankPayment bankPayment, List<BankPaymentDetail> listBankPaymentDetail, Double forexAmount) throws Exception {
        try {
            bankPaymentDAO.update(bankPayment, listBankPaymentDetail, forexAmount, MODULECODE);
        }
        catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }
    
    public void updateAccSpv(BankPayment bankPayment, List<BankPaymentDetail> listBankPaymentDetail, Double forexAmount) throws Exception {
        try {
            bankPaymentDAO.updateAccSpv(bankPayment, listBankPaymentDetail, forexAmount, MODULECODE);
        }
        catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }
    
    public void delete(String headerCode) throws Exception{
        bankPaymentDAO.delete(headerCode, MODULECODE);
    }

    public ListPaging<BankPaymentTemp> findDataAccSpv(Paging paging, String bankCode, String bankPaymentTo, String bankAccStatus, Date bankFirstDate, Date bankLastDate) {
        try {
                     
            paging.setRecords(bankPaymentDAO.countDataAccSpv(bankCode,bankPaymentTo,bankAccStatus,bankFirstDate,bankLastDate));
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<BankPaymentTemp> listBankPaymentTemp = bankPaymentDAO.findDataAccSpv(bankCode,bankPaymentTo,bankAccStatus,bankFirstDate,bankLastDate, paging.getFromRow(), paging.getToRow());
            
            ListPaging<BankPaymentTemp> listPaging = new ListPaging<BankPaymentTemp>();
            
            listPaging.setList(listBankPaymentTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }

    public BankPaymentDAO getBankPaymentDAO() {
        return bankPaymentDAO;
    }

    public void setBankPaymentDAO(BankPaymentDAO bankPaymentDAO) {
        this.bankPaymentDAO = bankPaymentDAO;
    }
    
    
}
