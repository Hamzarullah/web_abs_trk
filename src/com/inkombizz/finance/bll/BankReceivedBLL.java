
package com.inkombizz.finance.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import static com.inkombizz.finance.bll.BankReceivedBLL.MODULECODE;
import java.util.Date;
import java.util.List;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.finance.dao.BankReceivedDAO;
import com.inkombizz.finance.model.BankReceived;
import com.inkombizz.finance.model.BankReceivedDetail;
import com.inkombizz.finance.model.BankReceivedDetailTemp;
import com.inkombizz.finance.model.BankReceivedDeposit;
import com.inkombizz.finance.model.BankReceivedDepositTemp;
import com.inkombizz.finance.model.BankReceivedField;
import com.inkombizz.finance.model.BankReceivedTemp;
import java.math.BigDecimal;

public class BankReceivedBLL {
    
    public static final String MODULECODE = "004_FIN_BANK_RECEIVED";
    public static final String MODULECODE_ACC_SPV = "004_FIN_BANK_RECEIVED_ACC_SPV";
    public static final String MODULECODE_DOWNPAYMENT_UPDATE = "004_FIN_BANK_RECEIVED_DEPOSIT_UPDATE";
    
    private BankReceivedDAO bankReceivedDAO;
    
    public BankReceivedBLL(HBMSession hbmSession){
        this.bankReceivedDAO = new BankReceivedDAO(hbmSession);
    }
    
    
    public ListPaging<BankReceivedTemp> findData(Paging paging,String userCodeTemp,String code,String receivedFrom,String bankAccountCode,String bankAccountName,BigDecimal firstTotalTransactionAmount,BigDecimal lastTotalTransactionAmount,String remark,Date firstDate, Date lastDate) throws Exception {
        try {
                     
            paging.setRecords(bankReceivedDAO.countData(userCodeTemp,code, receivedFrom,bankAccountCode,bankAccountName,firstTotalTransactionAmount,lastTotalTransactionAmount,remark,firstDate, lastDate));
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<BankReceivedTemp> listBankReceivedTemp = bankReceivedDAO.findData(userCodeTemp,code,receivedFrom,bankAccountCode,bankAccountName,firstTotalTransactionAmount,lastTotalTransactionAmount,remark,firstDate, lastDate,paging.getFromRow(), paging.getToRow());
            
            ListPaging<BankReceivedTemp> listPaging = new ListPaging<BankReceivedTemp>();
            
            listPaging.setList(listBankReceivedTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public ListPaging<BankReceivedDepositTemp> findDataDeposit(Paging paging,String code,Date firstDate, Date lastDate) throws Exception {
        try {
                     
            paging.setRecords(bankReceivedDAO.countDataDeposit(code,firstDate, lastDate));
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<BankReceivedDepositTemp> listBankReceivedDepositTemp = bankReceivedDAO.findDataDeposit(code,firstDate, lastDate,paging.getFromRow(), paging.getToRow());
            
            ListPaging<BankReceivedDepositTemp> listPaging = new ListPaging<BankReceivedDepositTemp>();
            
            listPaging.setList(listBankReceivedDepositTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<BankReceivedDetailTemp> findDataDetail(String headerCode) throws Exception {
        try {
            
            List<BankReceivedDetailTemp> listBankReceivedDetailTemp = bankReceivedDAO.findDataDetail(headerCode);
            
            return listBankReceivedDetailTemp;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
        
    //check code dah ada di DB?
    public boolean isExist(String headerCode) throws Exception{
        try{            
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(BankReceived.class)
                            .add(Restrictions.eq(BankReceivedField.CODE, headerCode));
             
            if(bankReceivedDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
    
    public void save(BankReceived bankReceived, List<BankReceivedDetail> listBankReceivedDetail, Double forexAmount) throws Exception {
        try {
            bankReceivedDAO.save(bankReceived, listBankReceivedDetail, forexAmount, MODULECODE);
        }
        catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }
    
    public void update(BankReceived bankReceived, List<BankReceivedDetail> listBankReceivedDetail, Double forexAmount) throws Exception {
        try {
            bankReceivedDAO.update(bankReceived, listBankReceivedDetail, forexAmount, MODULECODE);
        }
        catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }
    
    public void delete(String headerCode) throws Exception{
        bankReceivedDAO.delete(headerCode, MODULECODE);
    }
    
    public void updateDeposit(BankReceivedDeposit bankReceivedDeposit) throws Exception {
        try {
            bankReceivedDAO.updateDeposit(bankReceivedDeposit, MODULECODE_DOWNPAYMENT_UPDATE);
        }
        catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    public BankReceivedDAO getBankReceivedDAO() {
        return bankReceivedDAO;
    }

    public void setBankReceivedDAO(BankReceivedDAO bankReceivedDAO) {
        this.bankReceivedDAO = bankReceivedDAO;
    }
    
}
