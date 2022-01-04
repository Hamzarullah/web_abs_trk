
package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.DcasTestingDAO;
import com.inkombizz.master.model.DcasTesting;
import com.inkombizz.master.model.DcasTestingField;
import com.inkombizz.master.model.DcasTestingTemp;


public class DcasTestingBLL {
    
    public final String MODULECODE = "006_MST_DCAS_TESTING";
    
    private DcasTestingDAO dcasTestingDAO;
    
    public DcasTestingBLL(HBMSession hbmSession){
        this.dcasTestingDAO=new DcasTestingDAO(hbmSession);
    }
    
    public ListPaging<DcasTestingTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(DcasTesting.class);           
    
            paging.setRecords(dcasTestingDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<DcasTestingTemp> listDcasTestingTemp = dcasTestingDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<DcasTestingTemp> listPaging = new ListPaging<DcasTestingTemp>();
            
            listPaging.setList(listDcasTestingTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
        
    public DcasTestingTemp findData(String code) throws Exception {
        try {
            return (DcasTestingTemp) dcasTestingDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public DcasTestingTemp findData(String code,boolean active) throws Exception {
        try {
            return (DcasTestingTemp) dcasTestingDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(DcasTesting dcasTesting) throws Exception {
        try {
            dcasTestingDAO.save(dcasTesting, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(DcasTesting dcasTesting) throws Exception {
        try {
            dcasTestingDAO.update(dcasTesting, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            dcasTestingDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(DcasTesting.class)
                            .add(Restrictions.eq(DcasTestingField.CODE, code));
             
            if(dcasTestingDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}
