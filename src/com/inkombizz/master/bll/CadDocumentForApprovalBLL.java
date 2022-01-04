
package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.CadDocumentForApprovalDAO;
import com.inkombizz.master.model.CadDocumentForApproval;
import com.inkombizz.master.model.CadDocumentForApprovalField;
import com.inkombizz.master.model.CadDocumentForApprovalTemp;


public class CadDocumentForApprovalBLL {
    
    public final String MODULECODE = "006_MST_CAD_DOCUMENT_FOR_APPROVAL";
    
    private CadDocumentForApprovalDAO cadDocumentForApprovalDAO;
    
    public CadDocumentForApprovalBLL(HBMSession hbmSession){
        this.cadDocumentForApprovalDAO=new CadDocumentForApprovalDAO(hbmSession);
    }
    
    public ListPaging<CadDocumentForApprovalTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(CadDocumentForApproval.class);           
    
            paging.setRecords(cadDocumentForApprovalDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<CadDocumentForApprovalTemp> listCadDocumentForApprovalTemp = cadDocumentForApprovalDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<CadDocumentForApprovalTemp> listPaging = new ListPaging<CadDocumentForApprovalTemp>();
            
            listPaging.setList(listCadDocumentForApprovalTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
        
    public CadDocumentForApprovalTemp findData(String code) throws Exception {
        try {
            return (CadDocumentForApprovalTemp) cadDocumentForApprovalDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public CadDocumentForApprovalTemp findData(String code,boolean active) throws Exception {
        try {
            return (CadDocumentForApprovalTemp) cadDocumentForApprovalDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(CadDocumentForApproval cadDocumentForApproval) throws Exception {
        try {
            cadDocumentForApprovalDAO.save(cadDocumentForApproval, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(CadDocumentForApproval cadDocumentForApproval) throws Exception {
        try {
            cadDocumentForApprovalDAO.update(cadDocumentForApproval, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            cadDocumentForApprovalDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(CadDocumentForApproval.class)
                            .add(Restrictions.eq(CadDocumentForApprovalField.CODE, code));
             
            if(cadDocumentForApprovalDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}
