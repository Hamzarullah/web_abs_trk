
package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.DcasMarkingDAO;
import com.inkombizz.master.model.DcasMarking;
import com.inkombizz.master.model.DcasMarkingField;
import com.inkombizz.master.model.DcasMarkingTemp;


public class DcasMarkingBLL {
    
    public final String MODULECODE = "006_MST_DCAS_MARKING";
    
    private DcasMarkingDAO dcasMarkingDAO;
    
    public DcasMarkingBLL(HBMSession hbmSession){
        this.dcasMarkingDAO=new DcasMarkingDAO(hbmSession);
    }
    
    public ListPaging<DcasMarkingTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(DcasMarking.class);           
    
            paging.setRecords(dcasMarkingDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<DcasMarkingTemp> listDcasMarkingTemp = dcasMarkingDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<DcasMarkingTemp> listPaging = new ListPaging<DcasMarkingTemp>();
            
            listPaging.setList(listDcasMarkingTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
        
    public DcasMarkingTemp findData(String code) throws Exception {
        try {
            return (DcasMarkingTemp) dcasMarkingDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public DcasMarkingTemp findData(String code,boolean active) throws Exception {
        try {
            return (DcasMarkingTemp) dcasMarkingDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(DcasMarking dcasMarking) throws Exception {
        try {
            dcasMarkingDAO.save(dcasMarking, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(DcasMarking dcasMarking) throws Exception {
        try {
            dcasMarkingDAO.update(dcasMarking, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            dcasMarkingDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(DcasMarking.class)
                            .add(Restrictions.eq(DcasMarkingField.CODE, code));
             
            if(dcasMarkingDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}
