
package com.inkombizz.master.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import java.util.List;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.BankAccountDAO;
import com.inkombizz.master.model.BankAccount;
import com.inkombizz.master.model.BankAccountField;
import com.inkombizz.master.model.BankAccountTemp;


public class BankAccountBLL {
    
    public static final String MODULECODE = "006_MST_BANK_ACCOUNT";
    
    private BankAccountDAO bankAccountDAO;
    
    public BankAccountBLL (HBMSession hbmSession) {
        this.bankAccountDAO = new BankAccountDAO(hbmSession);
    }
    
    
    public ListPaging<BankAccountTemp> findData(Paging paging, String code, String name,String bbmVoucherNo, String ChartOfAccountCode, String ChartOfAccountName,String active) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(BankAccount.class);           
            paging.setRecords(bankAccountDAO.countData(code,name,active));
            criteria = paging.addOrderCriteria(criteria);          
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<BankAccountTemp> listBankAccountTemp = bankAccountDAO.findData(code,name,bbmVoucherNo,ChartOfAccountCode,ChartOfAccountName,active,paging.getFromRow(), paging.getToRow());
            
            ListPaging<BankAccountTemp> listPaging = new ListPaging<BankAccountTemp>();
            
            listPaging.setList(listBankAccountTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public BankAccountTemp findData(String code) throws Exception {
        try {
            return (BankAccountTemp) bankAccountDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public BankAccountTemp findData(String code,boolean active) throws Exception {
        try {
            return (BankAccountTemp) bankAccountDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public BankAccountTemp findData2(String code,String active) throws Exception {
        try {
            return (BankAccountTemp) bankAccountDAO.findData2(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(BankAccount bankAccount) throws Exception {
        try {
            bankAccountDAO.save(bankAccount, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(BankAccount bankAccount) throws Exception {
        try {
            bankAccountDAO.update(bankAccount, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            bankAccountDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
    
    
    public boolean isExist(String code) throws Exception{
        try{            
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(BankAccount.class)
                            .add(Restrictions.eq(BankAccountField.CODE, code));
             
            if(bankAccountDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
    
    public BankAccountTemp min() throws Exception {
        try {
            return bankAccountDAO.min();
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public BankAccountTemp max() throws Exception {
        try {
            return bankAccountDAO.max();
        }
        catch (Exception e) {
            throw e;
        }
    }
 
}
