
package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.DcasHydroTestDAO;
import com.inkombizz.master.model.DcasHydroTest;
import com.inkombizz.master.model.DcasHydroTestField;
import com.inkombizz.master.model.DcasHydroTestTemp;


public class DcasHydroTestBLL {
    
    public final String MODULECODE = "006_MST_DCAS_HYDRO_TEST";
    
    private DcasHydroTestDAO dcasHydroTestDAO;
    
    public DcasHydroTestBLL(HBMSession hbmSession){
        this.dcasHydroTestDAO=new DcasHydroTestDAO(hbmSession);
    }
    
    public ListPaging<DcasHydroTestTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(DcasHydroTest.class);           
    
            paging.setRecords(dcasHydroTestDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<DcasHydroTestTemp> listDcasHydroTestTemp = dcasHydroTestDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<DcasHydroTestTemp> listPaging = new ListPaging<DcasHydroTestTemp>();
            
            listPaging.setList(listDcasHydroTestTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
        
    public DcasHydroTestTemp findData(String code) throws Exception {
        try {
            return (DcasHydroTestTemp) dcasHydroTestDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public DcasHydroTestTemp findData(String code,boolean active) throws Exception {
        try {
            return (DcasHydroTestTemp) dcasHydroTestDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(DcasHydroTest dcasHydroTest) throws Exception {
        try {
            dcasHydroTestDAO.save(dcasHydroTest, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(DcasHydroTest dcasHydroTest) throws Exception {
        try {
            dcasHydroTestDAO.update(dcasHydroTest, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            dcasHydroTestDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(DcasHydroTest.class)
                            .add(Restrictions.eq(DcasHydroTestField.CODE, code));
             
            if(dcasHydroTestDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}
