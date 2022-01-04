
package com.inkombizz.master.bll;

import java.util.List;

import org.hibernate.criterion.CriteriaSpecification;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.master.dao.ProductTypeDAO;
import com.inkombizz.master.model.ProductType;
import com.inkombizz.master.model.ProductTypeField;
import com.inkombizz.master.model.ProductTypeTemp;


public class ProductTypeBLL {
    
    public final String MODULECODE = "006_MST_PRODUCT_TYPE";
    
    private ProductTypeDAO productTypeDAO;
    
    public ProductTypeBLL(HBMSession hbmSession){
        this.productTypeDAO=new ProductTypeDAO(hbmSession);
    }
    
    public ListPaging<ProductTypeTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(ProductType.class);           
    
            paging.setRecords(productTypeDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(CriteriaSpecification.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ProductTypeTemp> listProductTypeTemp = productTypeDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<ProductTypeTemp> listPaging = new ListPaging<ProductTypeTemp>();
            
            listPaging.setList(listProductTypeTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
        
    public ProductTypeTemp findData(String code) throws Exception {
        try {
            return productTypeDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public ProductTypeTemp findData(String code,boolean active) throws Exception {
        try {
            return productTypeDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(ProductType productType) throws Exception {
        try {
            productTypeDAO.save(productType, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(ProductType productType) throws Exception {
        try {
            productTypeDAO.update(productType, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            productTypeDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(ProductType.class)
                            .add(Restrictions.eq(ProductTypeField.CODE, code));
             
            if(productTypeDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }

    public ProductTypeDAO getProductTypeDAO() {
        return productTypeDAO;
    }

    public void setProductTypeDAO(ProductTypeDAO productTypeDAO) {
        this.productTypeDAO = productTypeDAO;
    }
    
}
