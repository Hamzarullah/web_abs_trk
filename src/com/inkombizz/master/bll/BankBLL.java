
package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.BankDAO;
import com.inkombizz.master.model.Bank;
import com.inkombizz.master.model.BankField;
import com.inkombizz.master.model.BankTemp;


public class BankBLL {
    
    public final String MODULECODE = "006_MST_BANK";
    
    private BankDAO bankDAO;
    
    public BankBLL(HBMSession hbmSession){
        this.bankDAO=new BankDAO(hbmSession);
    }
    
    public ListPaging<BankTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(Bank.class);           
    
            paging.setRecords(bankDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<BankTemp> listBankTemp = bankDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<BankTemp> listPaging = new ListPaging<BankTemp>();
            
            listPaging.setList(listBankTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
        
    public BankTemp findData(String code) throws Exception {
        try {
            return (BankTemp) bankDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public BankTemp findData(String code,boolean active) throws Exception {
        try {
            return (BankTemp) bankDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(Bank bank) throws Exception {
        try {
            bankDAO.save(bank, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(Bank bank) throws Exception {
        try {
            bankDAO.update(bank, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            bankDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(Bank.class)
                            .add(Restrictions.eq(BankField.CODE, code));
             
            if(bankDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}
