
package com.inkombizz.finance.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import java.util.Date;
import java.util.List;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.finance.dao.CashReceivedDAO;
import com.inkombizz.finance.model.CashReceived;
import com.inkombizz.finance.model.CashReceivedDetail;
import com.inkombizz.finance.model.CashReceivedDetailTemp;
import com.inkombizz.finance.model.CashReceivedDeposit;
import com.inkombizz.finance.model.CashReceivedDepositTemp;
import com.inkombizz.finance.model.CashReceivedField;
import com.inkombizz.finance.model.CashReceivedTemp;
import java.math.BigDecimal;

public class CashReceivedBLL {
    
    public static final String MODULECODE = "004_FIN_CASH_RECEIVED";
    public static final String MODULECODE_ACC_SPV = "004_FIN_CASH_RECEIVED_ACC_SPV";
    public static final String MODULECODE_DOWNPAYMENT_UPDATE = "004_FIN_CASH_RECEIVED_DEPOSIT_UPDATE";
    
    private CashReceivedDAO cashReceivedDAO;
    
    public CashReceivedBLL(HBMSession hbmSession){
        this.cashReceivedDAO = new CashReceivedDAO(hbmSession);
    }
    
    public ListPaging<CashReceivedTemp> findData(Paging paging,String userCodeTemp,String code, String receiveFrom,String cashAccountCode,String cashAccountName,BigDecimal firstTotalTransactionAmount,BigDecimal lastTotalTransactionAmount,String remark, Date firstDate, Date lastDate) throws Exception {
        try {
                     
            paging.setRecords(cashReceivedDAO.countData(userCodeTemp,code, receiveFrom,cashAccountCode,cashAccountName,firstTotalTransactionAmount,lastTotalTransactionAmount,remark, firstDate, lastDate));
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<CashReceivedTemp> listCashReceivedTemp = cashReceivedDAO.findData(userCodeTemp,code, receiveFrom,cashAccountCode,cashAccountName,firstTotalTransactionAmount,lastTotalTransactionAmount,remark,paging.getFromRow(), paging.getToRow(), firstDate, lastDate);
            
            ListPaging<CashReceivedTemp> listPaging = new ListPaging<CashReceivedTemp>();
            
            listPaging.setList(listCashReceivedTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    public ListPaging<CashReceivedTemp> findDataAccSpv(Paging paging,String userCodeTemp,String code, String receiveFrom,String cashAccountCode,String cashAccountName,BigDecimal firstTotalTransactionAmount,BigDecimal lastTotalTransactionAmount,String remark, Date firstDate, Date lastDate,String status) throws Exception {
        try {
                     
            paging.setRecords(cashReceivedDAO.countDataAccSpv(userCodeTemp,code, receiveFrom,cashAccountCode,cashAccountName,firstTotalTransactionAmount,lastTotalTransactionAmount,remark, firstDate, lastDate,status));
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<CashReceivedTemp> listCashReceivedTemp = cashReceivedDAO.findDataAccSpv(userCodeTemp,code, receiveFrom,cashAccountCode,cashAccountName,firstTotalTransactionAmount,lastTotalTransactionAmount,remark,paging.getFromRow(), paging.getToRow(), firstDate, lastDate,status);
            
            ListPaging<CashReceivedTemp> listPaging = new ListPaging<CashReceivedTemp>();
            
            listPaging.setList(listCashReceivedTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    public ListPaging<CashReceivedDepositTemp> findDataDeposit(Paging paging,String code,Date firstDate, Date lastDate) throws Exception {
        try {
                     
            paging.setRecords(cashReceivedDAO.countDataDeposit(code,firstDate, lastDate));
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<CashReceivedDepositTemp> listCashReceivedDepositTemp = cashReceivedDAO.findDataDeposit(code,firstDate, lastDate,paging.getFromRow(), paging.getToRow());
            
            ListPaging<CashReceivedDepositTemp> listPaging = new ListPaging<CashReceivedDepositTemp>();
            
            listPaging.setList(listCashReceivedDepositTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<CashReceivedDetailTemp> findDataDetail(String headerCode) throws Exception {
        try {

            List<CashReceivedDetailTemp> listCashReceivedDetailTemp = cashReceivedDAO.findDataDetail(headerCode);

            return listCashReceivedDetailTemp;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
        
    public boolean isExist(String headerCode) throws Exception{
        try{            
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(CashReceived.class)
                            .add(Restrictions.eq(CashReceivedField.CODE, headerCode));
             
            if(cashReceivedDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
    
    public void save(CashReceived cashReceived, List<CashReceivedDetail> listCashReceivedDetail, Double forexAmount) throws Exception {
        try {
            cashReceivedDAO.save(cashReceived, listCashReceivedDetail, forexAmount, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(CashReceived cashReceived, List<CashReceivedDetail> listDetail, Double forexAmount) throws Exception{
        cashReceivedDAO.update(cashReceived, listDetail, forexAmount, MODULECODE);
    }
    
    public void delete(String headerCode) throws Exception{
        cashReceivedDAO.delete(headerCode, MODULECODE);
    }
    
    public void updateDeposit(CashReceivedDeposit cashReceivedDeposit) throws Exception {
        try {
            cashReceivedDAO.updateDeposit(cashReceivedDeposit, MODULECODE_DOWNPAYMENT_UPDATE);
        }
        catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    public CashReceivedDAO getCashReceivedDAO() {
        return cashReceivedDAO;
    }

    public void setCashReceivedDAO(CashReceivedDAO cashReceivedDAO) {
        this.cashReceivedDAO = cashReceivedDAO;
    }
    
}
