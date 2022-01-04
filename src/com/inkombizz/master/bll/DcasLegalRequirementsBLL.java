
package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.DcasLegalRequirementsDAO;
import com.inkombizz.master.model.DcasLegalRequirements;
import com.inkombizz.master.model.DcasLegalRequirementsField;
import com.inkombizz.master.model.DcasLegalRequirementsTemp;


public class DcasLegalRequirementsBLL {
    
    public final String MODULECODE = "006_MST_DCAS_LEGAL_REQUIREMENTS";
    
    private DcasLegalRequirementsDAO dcasLegalRequirementsDAO;
    
    public DcasLegalRequirementsBLL(HBMSession hbmSession){
        this.dcasLegalRequirementsDAO=new DcasLegalRequirementsDAO(hbmSession);
    }
    
    public ListPaging<DcasLegalRequirementsTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(DcasLegalRequirements.class);           
    
            paging.setRecords(dcasLegalRequirementsDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<DcasLegalRequirementsTemp> listDcasLegalRequirementsTemp = dcasLegalRequirementsDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<DcasLegalRequirementsTemp> listPaging = new ListPaging<DcasLegalRequirementsTemp>();
            
            listPaging.setList(listDcasLegalRequirementsTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
        
    public DcasLegalRequirementsTemp findData(String code) throws Exception {
        try {
            return (DcasLegalRequirementsTemp) dcasLegalRequirementsDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public DcasLegalRequirementsTemp findData(String code,boolean active) throws Exception {
        try {
            return (DcasLegalRequirementsTemp) dcasLegalRequirementsDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(DcasLegalRequirements dcasLegalRequirements) throws Exception {
        try {
            dcasLegalRequirementsDAO.save(dcasLegalRequirements, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(DcasLegalRequirements dcasLegalRequirements) throws Exception {
        try {
            dcasLegalRequirementsDAO.update(dcasLegalRequirements, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            dcasLegalRequirementsDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(DcasLegalRequirements.class)
                            .add(Restrictions.eq(DcasLegalRequirementsField.CODE, code));
             
            if(dcasLegalRequirementsDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}
