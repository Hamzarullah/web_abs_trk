
package com.inkombizz.inventory.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.inventory.dao.AdjustmentOutDAO;
import com.inkombizz.inventory.model.AdjustmentOutField;
import com.inkombizz.inventory.model.AdjustmentOutItemDetail;
import com.inkombizz.inventory.model.AdjustmentOutSerialNoDetail;
import com.inkombizz.inventory.model.AdjustmentOut;
import java.util.Date;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

public class AdjustmentOutBLL {
    
    public static final String MODULECODE = "003_IVT_ADJUSTMENT_OUT";
    public static final String MODULECODE_APPROVAL = "003_IVT_ADJUSTMENT_OUT_APPROVAL";
    
    private AdjustmentOutDAO adjustmentOutDAO;
    
    public AdjustmentOutBLL (HBMSession hbmSession) {
        this.adjustmentOutDAO = new AdjustmentOutDAO(hbmSession);
    }
    
    public ListPaging<AdjustmentOut> findData(Paging paging,AdjustmentOut adjustmentOut) throws Exception{
        try{

            paging.setRecords(adjustmentOutDAO.countData(adjustmentOut));
            paging.setTotal((int)Math.ceil((double)paging.getRecords()/(double)paging.getRows()));
            
            List<AdjustmentOut> listAdjustmentOut = adjustmentOutDAO.findData(adjustmentOut,paging.getFromRow(), paging.getToRow());
            
            ListPaging<AdjustmentOut> listPaging = new ListPaging<AdjustmentOut>();
            listPaging.setList(listAdjustmentOut);
            listPaging.setPaging(paging);
            
            return listPaging;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return null;
        }
    }
    
    public ListPaging<AdjustmentOut> findDataApproval(Paging paging,AdjustmentOut adjustmentOut) throws Exception{
        try{

            paging.setRecords(adjustmentOutDAO.countDataApproval(adjustmentOut));
            paging.setTotal((int)Math.ceil((double)paging.getRecords()/(double)paging.getRows()));
            
            List<AdjustmentOut> listAdjustmentOut = adjustmentOutDAO.findDataApproval(adjustmentOut,paging.getFromRow(), paging.getToRow());
            
            ListPaging<AdjustmentOut> listPaging = new ListPaging<AdjustmentOut>();
            listPaging.setList(listAdjustmentOut);
            listPaging.setPaging(paging);
            
            return listPaging;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return null;
        }
    }
    
    public List<AdjustmentOutItemDetail> findDataItemDetail(String headerCode) throws Exception{
       try{
            
            List<AdjustmentOutItemDetail> listAdjustmentOutItemDetail = adjustmentOutDAO.findDataItemDetail(headerCode);
                        
            return listAdjustmentOutItemDetail;
        }catch(Exception e){
            throw e;
        }
    }
    
    public List<AdjustmentOutSerialNoDetail> findDataSerialNoDetail(String detailCode) throws Exception{
       try{
            
            List<AdjustmentOutSerialNoDetail> listAdjustmentOutSerialNoDetail = adjustmentOutDAO.findDataSerialNoDetail(detailCode);
                        
            return listAdjustmentOutSerialNoDetail;
        }catch(Exception e){
            throw e;
        }
    }
    
    public List<AdjustmentOutSerialNoDetail> findBulkDataSerialNoDetail(List<AdjustmentOutItemDetail> listAdjustmentOutItemDetail) throws Exception{
       try{
            
            List<AdjustmentOutSerialNoDetail> listAdjustmentOutSerialNoDetail = adjustmentOutDAO.findBulkDataSerialNoDetail(listAdjustmentOutItemDetail);
                        
            return listAdjustmentOutSerialNoDetail;
        }catch(Exception e){
            throw e;
        }
    }
    
    public List<AdjustmentOutSerialNoDetail> findDataSerialNoDetailByApproval(String code) throws Exception{
       try{
            
            List<AdjustmentOutSerialNoDetail> listWarehouseMutationItemDetailTemp = adjustmentOutDAO.findDataSerialNoDetailByApproval(code);
                        
            return listWarehouseMutationItemDetailTemp;
        }catch(Exception e){
            throw e;
        }
    }
    
    public AdjustmentOut findDataHeader(String code) throws Exception{
        try{
            return adjustmentOutDAO.findDataHeader(code);
        }
        catch(Exception ex){
            throw ex;
        }
    }
    
    public void save(AdjustmentOut inventoryOut, List<AdjustmentOutItemDetail> listAdjustmentOutItemDetail,List<AdjustmentOutSerialNoDetail> listAdjustmentOutSerialNoDetail) throws Exception {
        try {
            adjustmentOutDAO.save(inventoryOut, listAdjustmentOutItemDetail,listAdjustmentOutSerialNoDetail,MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(AdjustmentOut inventoryOut, List<AdjustmentOutItemDetail> listAdjustmentOutItemDetail,List<AdjustmentOutSerialNoDetail> listAdjustmentOutSerialNoDetail) throws Exception{
        adjustmentOutDAO.update(inventoryOut, listAdjustmentOutItemDetail,listAdjustmentOutSerialNoDetail, MODULECODE);
    }
    
    public boolean isExist(String headerCode) throws Exception{
        try{            
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(AdjustmentOut.class)
                            .add(Restrictions.eq(AdjustmentOutField.CODE, headerCode));
             
            if(adjustmentOutDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }   
   
    
    public ListPaging<AdjustmentOut> findDataApproval(Paging paging,String code,String approvalStatus,Date firstDate,Date lastDate) throws Exception{
        try{

            paging.setRecords(adjustmentOutDAO.countDataApproval(code,approvalStatus,firstDate,lastDate));
            paging.setTotal((int)Math.ceil((double)paging.getRecords()/(double)paging.getRows()));
            
            List<AdjustmentOut> listAdjustmentOut = adjustmentOutDAO.findDataApproval(code,approvalStatus,firstDate,lastDate,paging.getFromRow(), paging.getToRow());
            
            ListPaging<AdjustmentOut> listPaging = new ListPaging<AdjustmentOut>();
            listPaging.setList(listAdjustmentOut);
            listPaging.setPaging(paging);
            
            return listPaging;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return null;
        }
    }
    
    public void approval(AdjustmentOut adjustmentOut, List<AdjustmentOutItemDetail> listAdjustmentOutItemDetail,List<AdjustmentOutSerialNoDetail> listAdjustmentOutSerialNoDetail) throws Exception {
        try {
            adjustmentOutDAO.approval(adjustmentOut, listAdjustmentOutItemDetail,listAdjustmentOutSerialNoDetail,MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            adjustmentOutDAO.delete(code,MODULECODE);
        } catch (Exception e){
            throw e;
        }
    }
    
    public Boolean isApproved(String code) throws Exception{
        try {
            return adjustmentOutDAO.isApproved(code);
        } catch (HibernateException e) {
            e.printStackTrace();
            return Boolean.FALSE;
        }
    }

    public AdjustmentOutDAO getInventoryOutDAO() {
        return adjustmentOutDAO;
    }

    public void setInventoryOutDAO(AdjustmentOutDAO adjustmentOutDAO) {
        this.adjustmentOutDAO = adjustmentOutDAO;
    }

    public AdjustmentOutDAO getAdjustmentOutDAO() {
        return adjustmentOutDAO;
    }

    public void setAdjustmentOutDAO(AdjustmentOutDAO adjustmentOutDAO) {
        this.adjustmentOutDAO = adjustmentOutDAO;
    }

    
}
