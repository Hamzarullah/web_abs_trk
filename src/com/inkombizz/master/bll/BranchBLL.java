
package com.inkombizz.master.bll;


import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;

import com.inkombizz.master.dao.BranchDAO;
import com.inkombizz.master.model.BranchTemp;
import com.inkombizz.master.model.Branch;
import com.inkombizz.master.model.BranchField;
import org.hibernate.criterion.Restrictions;


public class BranchBLL {
    
    public static final String MODULECODE="006_MST_BRANCH";
    
    private BranchDAO branchDAO;
    
    public BranchBLL(HBMSession hbmSession){
        this.branchDAO=new BranchDAO(hbmSession);
    }
    
    public ListPaging<BranchTemp> findData(Paging paging,String code, String name,String active) throws Exception{
        try{
            DetachedCriteria criteria=DetachedCriteria.forClass(Branch.class);
            
            paging.setRecords(branchDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria=paging.addOrderCriteria(criteria);
            
            paging.setTotal((int)Math.ceil((double)paging.getRecords()/(double)paging.getRows()));
            
            List<BranchTemp> listBranchTemp=branchDAO.findData(code,name,active,paging.getFromRow(), paging.getToRow());
            
            ListPaging<BranchTemp> listPaging=new ListPaging<BranchTemp>();
            
            listPaging.setList(listBranchTemp);
            listPaging.setPaging(paging);
            
            return listPaging;
        }
        catch(Exception ex){
            throw ex;
        }
    }
    
    public BranchTemp findData(String code) throws Exception {
        try {
            return (BranchTemp) branchDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public BranchTemp findData(String code,boolean active) throws Exception {
        try {
            return (BranchTemp) branchDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(Branch branch) throws Exception {
        try {
            branchDAO.save(branch, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(Branch branch) throws Exception {
        try {
            branchDAO.update(branch, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            branchDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
    
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(Branch.class)
                            .add(Restrictions.eq(BranchField.CODE, code));
             
            if(branchDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
    public BranchTemp getMin() throws Exception {
        try {
            return branchDAO.getMin();
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public BranchTemp getMax() throws Exception {
        try {
            return branchDAO.getMax();
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public ListPaging<BranchTemp> polulateSearchDataWithArray(String code, String name, String concat, Paging paging) throws Exception {
        try {
                     
            paging.setRecords(branchDAO.countSearchDataWithArray(code, name, concat));
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<BranchTemp> listBranchTemp = branchDAO.findSearchDataWithArray(code,name, concat, paging.getFromRow(),paging.getToRow());
            
            ListPaging<BranchTemp> listPaging = new ListPaging<BranchTemp>();
            
            listPaging.setList(listBranchTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<BranchTemp> findAllBranchForDeposit() throws Exception {
        try {
           
            List<BranchTemp> listBranchCustomerDepositTypeTemp = branchDAO.findAllBranchForDeposit();
            
            return listBranchCustomerDepositTypeTemp;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
}
