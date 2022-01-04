
package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.ReasonDAO;
import com.inkombizz.master.model.Reason;
import com.inkombizz.master.model.ReasonField;
import com.inkombizz.master.model.ReasonModuleDetail;
import com.inkombizz.master.model.ReasonModuleDetailTemp;
import com.inkombizz.master.model.ReasonTemp;


public class ReasonBLL {
    
    public final String MODULECODE = "006_MST_REASON";
    
    private ReasonDAO reasonDAO;
    
    public ReasonBLL(HBMSession hbmSession){
        this.reasonDAO=new ReasonDAO(hbmSession);
    }
    public List<ReasonModuleDetailTemp> findDataReasonModuleCoaTempUpdate(String headerCode) throws Exception {
        try {

            List<ReasonModuleDetailTemp> listWarehouseItemCategoryTemp = reasonDAO.findDataReasonModuleCoaTempUpdate(headerCode);

            return listWarehouseItemCategoryTemp;
        } catch (Exception e) {
            throw e;
        }
    }
    public ListPaging<ReasonTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(Reason.class);           
    
            paging.setRecords(reasonDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ReasonTemp> listReasonTemp = reasonDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<ReasonTemp> listPaging = new ListPaging<ReasonTemp>();
            
            listPaging.setList(listReasonTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
        
    public ReasonTemp findData(String code) throws Exception {
        try {
            return (ReasonTemp) reasonDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
     public int countDetail(String headerCode) throws Exception {
        try {
            int count = reasonDAO.countDetail(headerCode);
            
            return count;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
     public List<ReasonModuleDetailTemp> findDataReasonModuleCoaTempNew() throws Exception {
        try {

            List<ReasonModuleDetailTemp> listWarehouseItemCategoryTemp = reasonDAO.findDataReasonModuleCoaTempNew();

            return listWarehouseItemCategoryTemp;
        } catch (Exception e) {
            throw e;
        }
    }
    public List<ReasonModuleDetailTemp> findDataReasonModuleCoaTemp(String headerCode) throws Exception {
        try {

            List<ReasonModuleDetailTemp> listWarehouseItemCategoryTemp = reasonDAO.findDataReasonModuleCoaTemp(headerCode);

            return listWarehouseItemCategoryTemp;
        } catch (Exception e) {
            throw e;
        }
    }
    
    public ReasonTemp findData(String code,boolean active) throws Exception {
        try {
            return (ReasonTemp) reasonDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    public void save(Reason reason,List<ReasonModuleDetail> listReasonModuleCoa) throws Exception {
        try {
            reasonDAO.save(reason,listReasonModuleCoa, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(Reason reason,List<ReasonModuleDetail> listReasonModuleCoa) throws Exception {
        try {
            reasonDAO.update(reason,listReasonModuleCoa, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    public void delete(String code) throws Exception {
        try {
            reasonDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(Reason.class)
                            .add(Restrictions.eq(ReasonField.CODE, code));
             
            if(reasonDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }

    public ReasonDAO getReasonDAO() {
        return reasonDAO;
    }

    public void setReasonDAO(ReasonDAO reasonDAO) {
        this.reasonDAO = reasonDAO;
    }
    
}
