
package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumTriState;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.ProvinceDAO;
import com.inkombizz.master.model.Province;
import com.inkombizz.master.model.ProvinceField;
import com.inkombizz.master.model.ProvinceTemp;


public class ProvinceBLL {
    
    public final String MODULECODE = "006_MST_PROVINCE";
    
    private ProvinceDAO provinceDAO;
    
    public ProvinceBLL(HBMSession hbmSession){
        this.provinceDAO=new ProvinceDAO(hbmSession);
    }
    
    public ListPaging<ProvinceTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(Province.class);           
    
            paging.setRecords(provinceDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ProvinceTemp> listProvinceTemp = provinceDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<ProvinceTemp> listPaging = new ListPaging<ProvinceTemp>();
            
            listPaging.setList(listProvinceTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
        
    public ProvinceTemp findData(String code) throws Exception {
        try {
            return (ProvinceTemp) provinceDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public ProvinceTemp findData(String code,boolean active) throws Exception {
        try {
            return (ProvinceTemp) provinceDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(Province province) throws Exception {
        try {
            provinceDAO.save(province, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(Province province) throws Exception {
        try {
            provinceDAO.update(province, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            provinceDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(Province.class)
                            .add(Restrictions.eq(ProvinceField.CODE, code));
             
            if(provinceDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }

    public ListPaging<Province> search(Paging paging, String code, String name, EnumTriState.Enum_TriState searchProvinceActiveStatus) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    public Province get(String code) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    public ListPaging<Province> get(Paging paging) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
}
