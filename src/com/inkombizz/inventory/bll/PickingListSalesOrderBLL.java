
package com.inkombizz.inventory.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.inventory.dao.PickingListSalesOrderDAO;
import com.inkombizz.inventory.model.PickingListSalesOrder;
import com.inkombizz.inventory.model.PickingListSalesOrderBonusItemQuantityDetailTemp;
import com.inkombizz.inventory.model.PickingListSalesOrderField;
import com.inkombizz.inventory.model.PickingListSalesOrderTemp;
import com.inkombizz.inventory.model.PickingListSalesOrderTradeItemDetail;
import com.inkombizz.inventory.model.PickingListSalesOrderTradeItemDetailTemp;
import com.inkombizz.inventory.model.PickingListSalesOrderTradeItemQuantityDetail;
import com.inkombizz.inventory.model.PickingListSalesOrderTradeItemQuantityDetailTemp;
import com.inkombizz.master.model.ItemCurrentStockTemp;
import java.util.Date;
import java.util.List;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.hibernate.transform.Transformers;


public class PickingListSalesOrderBLL {
    
    public static final String MODULECODE = "003_IVT_PICKING_LIST_SALES_ORDER";
    public static final String MODULECODE_CONFIRMATION = "003_IVT_PICKING_LIST_SALES_ORDER_CONFIRMATION";
//    public static final String MODULECODE_CONFIRMATION_SUPERVISOR = "003_IVT_PICKING_LIST_SALES_ORDER_CONFIRMATION_SUPERVISOR";
    
    private PickingListSalesOrderDAO pickingListSalesOrderDAO;
    
    public PickingListSalesOrderBLL(HBMSession hbmSession){
        this.pickingListSalesOrderDAO = new PickingListSalesOrderDAO(hbmSession);
    }
    
    public ListPaging<PickingListSalesOrderTemp> findData(Paging paging,String userCodeTemp,String code,String salesOrderCode,String customerCode,String customerName,String refNo,String remark,Date firstDate,Date lastDate) throws Exception{
        try{

            paging.setRecords(pickingListSalesOrderDAO.countData(userCodeTemp,code,salesOrderCode,customerCode,customerName,refNo,remark,firstDate,lastDate));
            
            paging.setTotal((int)Math.ceil((double)paging.getRecords()/(double)paging.getRows()));
            
            List<PickingListSalesOrderTemp> listPickingListSalesOrderTemp = pickingListSalesOrderDAO.findData(userCodeTemp,code,salesOrderCode,customerCode,customerName,refNo,remark,firstDate,lastDate,paging.getFromRow(), paging.getToRow());
            
            ListPaging<PickingListSalesOrderTemp> listPaging = new ListPaging<PickingListSalesOrderTemp>();
            
            listPaging.setList(listPickingListSalesOrderTemp);
            listPaging.setPaging(paging);
            
            return listPaging;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return null;
        }
    }
    
    public List<PickingListSalesOrderTradeItemDetailTemp> findDataTradeItemDetail(String headerCode) throws Exception{
       try{
            
            List<PickingListSalesOrderTradeItemDetailTemp> listPickingListSalesOrderTradeItemDetailTemp = pickingListSalesOrderDAO.findDataTradeItemDetail(headerCode);
            
            return listPickingListSalesOrderTradeItemDetailTemp;
        }catch(Exception e){
            throw e;
        }
    }
    
    public List<PickingListSalesOrderTradeItemQuantityDetailTemp> findDataTradeItemQuantityDetail(String headerCode) throws Exception{
       try{
            
            List<PickingListSalesOrderTradeItemQuantityDetailTemp> listPickingListSalesOrderTradeItemQuantityDetailTemp = pickingListSalesOrderDAO.findDataTradeItemQuantityDetail(headerCode);
            
            return listPickingListSalesOrderTradeItemQuantityDetailTemp;
        }catch(Exception e){
            throw e;
        }
    }
    
    public ListPaging<ItemCurrentStockTemp> ItemStock(Paging paging, String warehouseCode, String itemCode) throws Exception{
        try{

            paging.setRecords(pickingListSalesOrderDAO.countItemStock(warehouseCode, itemCode));
            
            paging.setTotal((int)Math.ceil((double)paging.getRecords()/(double)paging.getRows()));
            
            List<ItemCurrentStockTemp> listItemCurrentStockTemp = pickingListSalesOrderDAO.findItemStock(warehouseCode, itemCode, paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemCurrentStockTemp> listPaging = new ListPaging<ItemCurrentStockTemp>();
            
            listPaging.setList(listItemCurrentStockTemp);
            listPaging.setPaging(paging);
            
            return listPaging;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return null;
        }
    }
    
       public List<PickingListSalesOrderTradeItemQuantityDetailTemp> findDataTradeItemDetailByReturnPickingList(String salesOrderCode) throws Exception{
       try{
            
            List<PickingListSalesOrderTradeItemQuantityDetailTemp> listPickingListSalesOrderTradeItemDetailTemp = pickingListSalesOrderDAO.findDataTradeItemQuantityDetailByReturnPickingList(salesOrderCode);
            
            return listPickingListSalesOrderTradeItemDetailTemp;
        }catch(Exception e){
            throw e;
        }
    }
    
    public ListPaging<PickingListSalesOrderTemp> findDataConfirmation(Paging paging,String userCodeTemp,String code,String salesOrderCode,String customerCode,String customerName,String refNo,String remark,String confirmationStatus,Date firstDate,Date lastDate) throws Exception{
        try{

            paging.setRecords(pickingListSalesOrderDAO.countDataConfirmation(userCodeTemp,code,salesOrderCode,customerCode,customerName,refNo,remark,confirmationStatus,firstDate,lastDate));
            
            paging.setTotal((int)Math.ceil((double)paging.getRecords()/(double)paging.getRows()));
            
            List<PickingListSalesOrderTemp> listPickingListSalesOrderTemp = pickingListSalesOrderDAO.findDataConfirmation(userCodeTemp,code,salesOrderCode,customerCode,customerName,refNo,remark,confirmationStatus,firstDate,lastDate,paging.getFromRow(), paging.getToRow());
            
            ListPaging<PickingListSalesOrderTemp> listPaging = new ListPaging<PickingListSalesOrderTemp>();
            
            listPaging.setList(listPickingListSalesOrderTemp);
            listPaging.setPaging(paging);
            
            return listPaging;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return null;
        }
    }
    
    public List<PickingListSalesOrderBonusItemQuantityDetailTemp> findDataBonusItemDetailByReturnPickingList(String salesOrderCode) throws Exception{
       try{
            
            List<PickingListSalesOrderBonusItemQuantityDetailTemp> listPickingListSalesOrderBonusItemDetailTemp = pickingListSalesOrderDAO.findDataTradeItemBonusQuantityDetailByReturnPickingList(salesOrderCode);
            
            return listPickingListSalesOrderBonusItemDetailTemp;
        }catch(Exception e){
            throw e;
        }
    }
        
    public PickingListSalesOrder get(String code) throws Exception {
        try {
            return (PickingListSalesOrder) pickingListSalesOrderDAO.get(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public List<PickingListSalesOrderTradeItemQuantityDetailTemp> findDataPickingListItemQuantityDetail(String warehouseCode, String itemCode, int quantity) throws Exception{
       try{
            
            List<PickingListSalesOrderTradeItemQuantityDetailTemp> listPickingListSalesOrderTradeItemDetailTemp = pickingListSalesOrderDAO.findDataStockForPickingList(warehouseCode,itemCode,quantity);
            
            return listPickingListSalesOrderTradeItemDetailTemp;
        }catch(Exception e){
            throw e;
        }
    }
    
//    public List<PickingListSalesOrderTradeItemQuantityDetailTemp> findDataTradeItemDetailByReturnPickingList(String salesOrderCode) throws Exception{
//       try{
//            
//            List<PickingListSalesOrderTradeItemQuantityDetailTemp> listPickingListSalesOrderTradeItemDetailTemp = pickingListSalesOrderDAO.findDataTradeItemQuantityDetailByReturnPickingList(salesOrderCode);
//            
//            return listPickingListSalesOrderTradeItemDetailTemp;
//        }catch(Exception e){
//            throw e;
//        }
//    }
    
//    public List<PickingListSalesOrderBonusItemQuantityDetailTemp> findDataBonusItemQuantityDetail(String headerCode) throws Exception{
//       try{
//            
//            List<PickingListSalesOrderBonusItemQuantityDetailTemp> listPickingListSalesOrderBonusItemQuantityDetailTemp = pickingListSalesOrderDAO.findDataBonusItemQuantityDetail(headerCode);
//            
//            return listPickingListSalesOrderBonusItemQuantityDetailTemp;
//        }catch(Exception e){
//            throw e;
//        }
//    }
    
//    public List<PickingListSalesOrderTradeItemDetailTemp> findDataTradeItemDetailConfirmation(String pickingListCode) throws Exception{
//       try{
//            
//            List<PickingListSalesOrderTradeItemDetailTemp> listPickingListSalesOrderTradeItemDetailTemp = pickingListSalesOrderDAO.findDataTradeItemDetailConfirmation(pickingListCode);
//            
//            return listPickingListSalesOrderTradeItemDetailTemp;
//        }catch(Exception e){
//            throw e;
//        }
//    }
    
//    public List<PickingListSalesOrderBonusItemDetailTemp> findDataBonusItemDetailConfirmation(String pickingListCode) throws Exception{
//       try{
//            
//            List<PickingListSalesOrderBonusItemDetailTemp> listPickingListSalesOrderBonusItemDetailTemp = pickingListSalesOrderDAO.findDataBonusItemDetailConfirmation(pickingListCode);
//            
//            return listPickingListSalesOrderBonusItemDetailTemp;
//        }catch(Exception e){
//            throw e;
//        }
//    }
    
//    public List<PickingListSalesOrderTradeItemDetailTemp> findDataPickingListSalesOrderDetailConfirmationDistinctCustomerAddress(String pickingListCode) throws Exception{
//       try{
//            
//            List<PickingListSalesOrderTradeItemDetailTemp> listPickingListSalesOrderTradeItemDetailTemp = pickingListSalesOrderDAO.findDataPickingListSalesOrderDetailConfirmationDistinctCustomerAddress(pickingListCode);
//            
//            return listPickingListSalesOrderTradeItemDetailTemp;
//        }catch(Exception e){
//            throw e;
//        }
//    }
    
    public void save(PickingListSalesOrder pickingListSalesOrder
            ,List<PickingListSalesOrderTradeItemDetail> listPickingListSalesOrderTradeItemDetail, 
//            List<PickingListSalesOrderBonusItemDetail> listPickingListSalesOrderBonusItemDetail,
            List<PickingListSalesOrderTradeItemQuantityDetail> listPickingListSalesOrderTradeItemQuantityDetail
//            List<PickingListSalesOrderBonusItemQuantityDetail> listPickingListSalesOrderBonusItemQuantityDetail
    ) throws Exception{
        try{
            pickingListSalesOrderDAO.save(pickingListSalesOrder, listPickingListSalesOrderTradeItemDetail, listPickingListSalesOrderTradeItemQuantityDetail,
                    MODULECODE);
        }
        catch(Exception ex){
            ex.printStackTrace();
            throw ex;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            pickingListSalesOrderDAO.delete(code,MODULECODE);
        } catch (Exception e){
            throw e;
        }
    }
    
    public void confirmation(PickingListSalesOrder pickingListSalesOrder,
            List<PickingListSalesOrderTradeItemDetail> listPickingListSalesOrderTradeItemDetail, 
            List<PickingListSalesOrderTradeItemQuantityDetail> listPickingListSalesOrderTradeItemQuantityDetail) throws Exception {
        try {
            pickingListSalesOrderDAO.confirmation(pickingListSalesOrder,listPickingListSalesOrderTradeItemDetail, listPickingListSalesOrderTradeItemQuantityDetail, MODULECODE_CONFIRMATION);
        }
        catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }
    
    public List<PickingListSalesOrderTemp> findDataPickingList(String salesOrderCode ) throws Exception{
       try{
            
            List<PickingListSalesOrderTemp> listPickingListSalesOrderTemp = pickingListSalesOrderDAO.findDataPickingList(salesOrderCode);
            
            return listPickingListSalesOrderTemp;
        }catch(Exception e){
            throw e;
        }
    }  
     
    public boolean isExist(String headerCode) throws Exception{
        try{            
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(PickingListSalesOrder.class)
                            .add(Restrictions.eq(PickingListSalesOrderField.CODE, headerCode));
             
            if(pickingListSalesOrderDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }

    public String pickingListSOConfirmed(String code){
        try{
            return pickingListSalesOrderDAO.pickingListSOConfirmed(code);
        }catch(Exception e){
             return "ERROR";
        }
    }
    
    public int pickingListSOUsedInDLN(String code){
        try{
            return pickingListSalesOrderDAO.pickingListSOUsedInDLN(code);
        }catch(Exception e){
             return 0;
        }
    }
}
