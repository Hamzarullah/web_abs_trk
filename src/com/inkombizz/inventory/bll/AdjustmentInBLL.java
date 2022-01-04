
package com.inkombizz.inventory.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.inventory.model.AdjustmentIn;
import com.inkombizz.inventory.dao.AdjustmentInDAO;
import com.inkombizz.inventory.model.AdjustmentInItemDetail;
import com.inkombizz.inventory.model.AdjustmentInItemDetailTemp;
import com.inkombizz.inventory.model.AdjustmentInField;
import com.inkombizz.inventory.model.AdjustmentInSerialNoDetail;
import com.inkombizz.inventory.model.AdjustmentInTemp;
import java.util.Date;
import java.util.List;
import org.hibernate.HibernateException;


public class AdjustmentInBLL {
    
    public static final String MODULECODE = "003_IVT_ADJUSTMENT_IN";
    public static final String MODULECODE_APPROVAL = "003_IVT_ADJUSTMENT_IN_APPROVAL";
    
    private AdjustmentInDAO adjustmentInDAO;
    
    public AdjustmentInBLL (HBMSession hbmSession) {
        this.adjustmentInDAO = new AdjustmentInDAO(hbmSession);
    }
    
    public ListPaging<AdjustmentInTemp> findData(Paging paging,String code,String warehouseCode,String warehouseName,String refNo,Date firstDate, Date lastDate) throws Exception{
        try{

            paging.setRecords(adjustmentInDAO.countData(code,warehouseCode,warehouseName,refNo,firstDate,lastDate));
            paging.setTotal((int)Math.ceil((double)paging.getRecords()/(double)paging.getRows()));
            
            List<AdjustmentInTemp> listAdjustmentInTemp = adjustmentInDAO.findData(code,warehouseCode,warehouseName,refNo,firstDate,lastDate,paging.getFromRow(), paging.getToRow());
            
            ListPaging<AdjustmentInTemp> listPaging = new ListPaging<AdjustmentInTemp>();
            listPaging.setList(listAdjustmentInTemp);
            listPaging.setPaging(paging);
            
            return listPaging;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return null;
        }
    }
    
    public List<AdjustmentInItemDetail> findDataItemDetail(String headerCode) throws Exception{
       try{
            
            List<AdjustmentInItemDetail> listAdjustmentInItemDetailTemp = adjustmentInDAO.findDataItemDetail(headerCode);
                        
            return listAdjustmentInItemDetailTemp;
        }catch(Exception e){
            throw e;
        }
    }
    
    public List<AdjustmentInSerialNoDetail> findDataSerialNoDetail(String headerCode) throws Exception{
       try{
            
            List<AdjustmentInSerialNoDetail> listAdjustmentInSerialNoDetail = adjustmentInDAO.findDataSerialNoDetail(headerCode);
                        
            return listAdjustmentInSerialNoDetail;
        }catch(Exception e){
            throw e;
        }
    }
    
    public List<AdjustmentInSerialNoDetail> findBulkDataSerialNoDetail(List<AdjustmentInItemDetail> listAdjustmentInItemDetail) throws Exception{
       try{
            
            List<AdjustmentInSerialNoDetail> listAdjustmentInSerialNoDetail = adjustmentInDAO.findBulkDataSerialNoDetail(listAdjustmentInItemDetail);
                        
            return listAdjustmentInSerialNoDetail;
        }catch(Exception e){
            throw e;
        }
    }
    
    public void save(AdjustmentIn adjustmentIn, List<AdjustmentInItemDetail> listAdjustmentInItemDetail, List<AdjustmentInSerialNoDetail> listAdjustmentInSerialNoDetail) throws Exception {
        try {
            adjustmentInDAO.save(adjustmentIn, listAdjustmentInItemDetail,listAdjustmentInSerialNoDetail, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(AdjustmentIn adjustmentIn, List<AdjustmentInItemDetail> listAdjustmentInItemDetail, List<AdjustmentInSerialNoDetail> listAdjustmentInSerialNoDetail) throws Exception{
        adjustmentInDAO.update(adjustmentIn, listAdjustmentInItemDetail,listAdjustmentInSerialNoDetail, MODULECODE);
    }
    
    public void approval(AdjustmentIn adjustmentInApproval, List<AdjustmentInItemDetail> listAdjustmentInItemDetail, List<AdjustmentInSerialNoDetail> listAdjustmentInSerialNoDetail) throws Exception {
        try {
            adjustmentInDAO.approval(adjustmentInApproval, listAdjustmentInItemDetail,listAdjustmentInSerialNoDetail,MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception{
        try{
            adjustmentInDAO.delete(code, MODULECODE);
        }catch(Exception e){
            throw e;
        }
    }
    
//    public AdjustmentInTemp findDataHeader(String code) throws Exception{
//        try{
//            return adjustmentInDAO.findDataHeader(code);
//        }
//        catch(Exception ex){
//            throw ex;
//        }
//    }
    
    public boolean isExist(String headerCode) throws Exception{
        try{            
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(AdjustmentIn.class)
                            .add(Restrictions.eq(AdjustmentInField.CODE, headerCode));
             
            if(adjustmentInDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }   
   public ListPaging<AdjustmentInTemp> findDataApproval(Paging paging,String code,String warehouseCode,String warehouseName,String refNo,String remark,String approvalStatus,Date firstDate,Date lastDate) throws Exception{
        try{

            paging.setRecords(adjustmentInDAO.countDataApproval(code,warehouseCode,warehouseName,refNo,remark,approvalStatus,firstDate,lastDate));
            paging.setTotal((int)Math.ceil((double)paging.getRecords()/(double)paging.getRows()));
            
            List<AdjustmentInTemp> listAdjustmentInTemp = adjustmentInDAO.findDataApproval(code,warehouseCode,warehouseName,refNo,remark,approvalStatus,firstDate,lastDate,paging.getFromRow(), paging.getToRow());
            
            ListPaging<AdjustmentInTemp> listPaging = new ListPaging<AdjustmentInTemp>();
            listPaging.setList(listAdjustmentInTemp);
            listPaging.setPaging(paging);
            
            return listPaging;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return null;
        }
    }
   
    public Boolean isApproved(String code) throws Exception{
        try {
            return adjustmentInDAO.isApproved(code);
        } catch (HibernateException e) {
            e.printStackTrace();
            return Boolean.FALSE;
        }
    }
}
