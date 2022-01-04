
package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.DcasNdeDAO;
import com.inkombizz.master.model.DcasNde;
import com.inkombizz.master.model.DcasNdeField;
import com.inkombizz.master.model.DcasNdeTemp;


public class DcasNdeBLL {
    
    public final String MODULECODE = "006_MST_DCAS_NDE";
    
    private DcasNdeDAO dcasNdeDAO;
    
    public DcasNdeBLL(HBMSession hbmSession){
        this.dcasNdeDAO=new DcasNdeDAO(hbmSession);
    }
    
    public ListPaging<DcasNdeTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(DcasNde.class);           
    
            paging.setRecords(dcasNdeDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<DcasNdeTemp> listDcasNdeTemp = dcasNdeDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<DcasNdeTemp> listPaging = new ListPaging<DcasNdeTemp>();
            
            listPaging.setList(listDcasNdeTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
        
    public DcasNdeTemp findData(String code) throws Exception {
        try {
            return (DcasNdeTemp) dcasNdeDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public DcasNdeTemp findData(String code,boolean active) throws Exception {
        try {
            return (DcasNdeTemp) dcasNdeDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(DcasNde dcasNde) throws Exception {
        try {
            dcasNdeDAO.save(dcasNde, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(DcasNde dcasNde) throws Exception {
        try {
            dcasNdeDAO.update(dcasNde, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            dcasNdeDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(DcasNde.class)
                            .add(Restrictions.eq(DcasNdeField.CODE, code));
             
            if(dcasNdeDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}
