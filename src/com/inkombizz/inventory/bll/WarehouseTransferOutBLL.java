/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.inventory.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.inventory.dao.WarehouseTransferOutDAO;
import com.inkombizz.inventory.model.WarehouseTransferOut;
import com.inkombizz.inventory.model.WarehouseTransferOutItemDetail;
import com.inkombizz.inventory.model.WarehouseTransferOutItemDetailTemp;
import com.inkombizz.inventory.model.WarehouseTransferOutTemp;
import java.util.Date;
import java.util.List;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author egie
 */
public class WarehouseTransferOutBLL {
    
    public static final String MODULECODE = "003_IVT_WAREHOUSE_TRANSFER_OUT";
    
    private WarehouseTransferOutDAO warehouseTransferOutDAO;
    
    public WarehouseTransferOutBLL (HBMSession hbmSession) {
        this.warehouseTransferOutDAO = new WarehouseTransferOutDAO(hbmSession);
    }
    
    public ListPaging<WarehouseTransferOutTemp> findData(Paging paging,Date firstDate, Date lastDate,String code,String warehouseCode,String warehouseName,String refNo,String remark) throws Exception{
        try{

            paging.setRecords(warehouseTransferOutDAO.countData(firstDate,lastDate,code,warehouseCode,warehouseName,refNo,remark));
            paging.setTotal((int)Math.ceil((double)paging.getRecords()/(double)paging.getRows()));
            
            List<WarehouseTransferOutTemp> listWarehouseTransferOutTemp = warehouseTransferOutDAO.findData(firstDate,lastDate,code,warehouseCode,warehouseName,
                    refNo,remark,paging.getFromRow(), paging.getToRow());
            
            ListPaging<WarehouseTransferOutTemp> listPaging = new ListPaging<WarehouseTransferOutTemp>();
            listPaging.setList(listWarehouseTransferOutTemp);
            listPaging.setPaging(paging);
            
            return listPaging;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return null;
        }
    }
    
    public List<WarehouseTransferOutItemDetailTemp> findDataDetailSource(String headerCode) throws Exception{
       try{
            List<WarehouseTransferOutItemDetailTemp> listWarehouseTransferOutItemDetailCogsTemp = warehouseTransferOutDAO.findItemDetailSourceData(headerCode);
                        
            return listWarehouseTransferOutItemDetailCogsTemp;
        }catch(Exception e){
            throw e;
        }
    }
    
    public void save(WarehouseTransferOut warehouseTransferOut,
            List<WarehouseTransferOutItemDetail> listWarehouseTransferOutItemDetail) throws Exception {
        try {
            warehouseTransferOutDAO.save(warehouseTransferOut,listWarehouseTransferOutItemDetail,MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(WarehouseTransferOut warehouseTransferOut,
            List<WarehouseTransferOutItemDetail> listWarehouseTransferOutItemDetail) throws Exception {
        try {
            warehouseTransferOutDAO.update(warehouseTransferOut,listWarehouseTransferOutItemDetail,MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public boolean isExist(String headerCode) throws Exception{
        try{            
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(WarehouseTransferOut.class)
                            .add(Restrictions.eq("code", headerCode));
             
            if(warehouseTransferOutDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            warehouseTransferOutDAO.delete(code,MODULECODE);
        } catch (Exception e){
            throw e;
        }
    }
    
    public ListPaging<WarehouseTransferOutTemp> searchCountDatasearchDataWHTO(Paging paging,Date firstDate, Date lastDate,String code,String warehouseCode,String warehouseName,String refNo,String remark) throws Exception{
        try{

            paging.setRecords(warehouseTransferOutDAO.searchCountDataWHTO(firstDate,lastDate,code,warehouseCode,warehouseName,refNo,remark));
            paging.setTotal((int)Math.ceil((double)paging.getRecords()/(double)paging.getRows()));
            
            List<WarehouseTransferOutTemp> listWarehouseMutationPickingListTemp = warehouseTransferOutDAO.searchDataWHTO(firstDate,lastDate,code,warehouseCode,warehouseName,refNo,remark,paging.getFromRow(), paging.getToRow());
            
            ListPaging<WarehouseTransferOutTemp> listPaging = new ListPaging<WarehouseTransferOutTemp>();
            listPaging.setList(listWarehouseMutationPickingListTemp);
            listPaging.setPaging(paging);
            
            return listPaging;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return null;
        }
    }
    
}
