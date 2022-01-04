package com.inkombizz.master.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.master.dao.BillOfMaterialTemplateDAO;
import com.inkombizz.master.model.BillOfMaterialTemplate;
import com.inkombizz.master.model.BillOfMaterialTemplateDetail;
import com.inkombizz.master.model.BillOfMaterialTemplateField;
import com.inkombizz.master.model.BillOfMaterialTemplateTemp;
import static com.inkombizz.ppic.bll.ProductionPlanningOrderBLL.MODULECODE;
import com.inkombizz.ppic.model.ProductionPlanningOrder;
import com.inkombizz.ppic.model.ProductionPlanningOrderField;
import com.inkombizz.ppic.model.ProductionPlanningOrderItemDetail;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;


public class BillOfMaterialTemplateBLL {
    
    public static final String MODULECODE="006_MST_BILL_OF_MATERIAL_TEMPLATE";
    
    private BillOfMaterialTemplateDAO billOfMaterialTemplateDAO;
    
    public BillOfMaterialTemplateBLL(HBMSession hbmSession){
        this.billOfMaterialTemplateDAO=new BillOfMaterialTemplateDAO(hbmSession);
    }
    
    public ListPaging<BillOfMaterialTemplate> findData(Paging paging,BillOfMaterialTemplate billOfMaterialTemplate) throws Exception{
        try{
            DetachedCriteria criteria=DetachedCriteria.forClass(BillOfMaterialTemplate.class);
            
            paging.setRecords(billOfMaterialTemplateDAO.countData(billOfMaterialTemplate));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria=paging.addOrderCriteria(criteria);
            
            paging.setTotal((int)Math.ceil((double)paging.getRecords()/(double)paging.getRows()));
            
            List<BillOfMaterialTemplate> listBillOfMaterialTemplate=billOfMaterialTemplateDAO.findData(billOfMaterialTemplate,paging.getFromRow(), paging.getToRow());
            
            ListPaging<BillOfMaterialTemplate> listPaging=new ListPaging<BillOfMaterialTemplate>();
            
            listPaging.setList(listBillOfMaterialTemplate);
            listPaging.setPaging(paging);
            
            return listPaging;
        }
        catch(Exception ex){
            throw ex;
        }
    }
    
    public boolean isExist(String code) throws Exception{
        try{            
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(BillOfMaterialTemplate.class)
                            .add(Restrictions.eq(BillOfMaterialTemplateField.CODE, code));
             
            if(billOfMaterialTemplateDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
    
    public BillOfMaterialTemplateTemp findData(String code) throws Exception {
        try {
            return (BillOfMaterialTemplateTemp) billOfMaterialTemplateDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public List<BillOfMaterialTemplateDetail> findDataDetail(String headerCode) throws Exception {
        try {
            
            List<BillOfMaterialTemplateDetail> listBillOfMaterialTemplateDetail = billOfMaterialTemplateDAO.findDataDetail(headerCode);
            
            return listBillOfMaterialTemplateDetail;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<BillOfMaterialTemplateDetail> findDataDetailTemplate(String headerCode) throws Exception {
        try {
            
            List<BillOfMaterialTemplateDetail> listBillOfMaterialTemplateDetail = billOfMaterialTemplateDAO.findDataDetailTemplate(headerCode);
            
            return listBillOfMaterialTemplateDetail;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public void update(BillOfMaterialTemplate billOfMaterialTemplate, List<BillOfMaterialTemplateDetail> listBillOfMaterialTemplateDetail) throws Exception{
        billOfMaterialTemplateDAO.update(billOfMaterialTemplate, listBillOfMaterialTemplateDetail, MODULECODE);
    }
    
    public void save(BillOfMaterialTemplate billOfMaterialTemplate, List<BillOfMaterialTemplateDetail> listBillOfMaterialTemplateDetail) throws Exception {
        try {
            billOfMaterialTemplateDAO.save(billOfMaterialTemplate, listBillOfMaterialTemplateDetail,MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public BillOfMaterialTemplate get(String code) throws Exception {
        try {
            return (BillOfMaterialTemplate) billOfMaterialTemplateDAO.get(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception{
        try{
            billOfMaterialTemplateDAO.delete(code, MODULECODE);
        }catch(Exception e){
            throw e;
        }
    } 
    
    
}

