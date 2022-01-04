package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.CashAccountDAO;
import com.inkombizz.master.model.CashAccount;
import com.inkombizz.master.model.CashAccountField;
import com.inkombizz.master.model.CashAccountTemp;

public class CashAccountBLL {
    
    public final String MODULECODE = "006_MST_CASH_ACCOUNT";
    
    private CashAccountDAO cashAccountDAO;
    
    public CashAccountBLL(HBMSession hbmSession){
        this.cashAccountDAO=new CashAccountDAO(hbmSession);
    }
    
    public ListPaging<CashAccountTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(CashAccount.class);           
    
            paging.setRecords(cashAccountDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<CashAccountTemp> listCashAccountTemp = cashAccountDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<CashAccountTemp> listPaging = new ListPaging<CashAccountTemp>();
            
            listPaging.setList(listCashAccountTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
        
    
    public CashAccountTemp findData(String code) throws Exception {
        try {
            return (CashAccountTemp) cashAccountDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public CashAccountTemp findData(String code,boolean active) throws Exception {
        try {
            return (CashAccountTemp) cashAccountDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(CashAccount cashAccount) throws Exception {
        try {
            cashAccountDAO.save(cashAccount, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(CashAccount cashAccount) throws Exception {
        try {
            cashAccountDAO.update(cashAccount, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            cashAccountDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(CashAccount.class)
                            .add(Restrictions.eq(CashAccountField.CODE, code));
             
            if(cashAccountDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}

