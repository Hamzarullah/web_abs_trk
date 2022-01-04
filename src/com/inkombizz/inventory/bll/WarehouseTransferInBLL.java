/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.inventory.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.inventory.dao.WarehouseTransferInDAO;
import com.inkombizz.inventory.model.WarehouseTransferIn;
import com.inkombizz.inventory.model.WarehouseTransferInItemDetail;
import com.inkombizz.inventory.model.WarehouseTransferInItemDetailTemp;
import com.inkombizz.inventory.model.WarehouseTransferInTemp;
import java.util.Date;
import java.util.List;

/**
 *
 * @author egie
 */
public class WarehouseTransferInBLL {
    
    public static final String MODULECODE = "003_IVT_WAREHOUSE_TRANSFER_IN";
    
    private WarehouseTransferInDAO warehouseTransferInDAO;
    
    public WarehouseTransferInBLL (HBMSession hbmSession) {
        this.warehouseTransferInDAO = new WarehouseTransferInDAO(hbmSession);
    }
    
    public ListPaging<WarehouseTransferInTemp> findData(Paging paging,Date firstDate, Date lastDate,String code,String warehouseCode,String warehouseName,String refNo,String remark) throws Exception{
        try{

            paging.setRecords(warehouseTransferInDAO.countData(firstDate,lastDate,code,warehouseCode,warehouseName,refNo,remark));
            paging.setTotal((int)Math.ceil((double)paging.getRecords()/(double)paging.getRows()));
            
            List<WarehouseTransferInTemp> listWarehouseTransferInTemp = warehouseTransferInDAO.findData(firstDate,lastDate,code,warehouseCode,warehouseName,
                    refNo,remark,paging.getFromRow(), paging.getToRow());
            
            ListPaging<WarehouseTransferInTemp> listPaging = new ListPaging<WarehouseTransferInTemp>();
            listPaging.setList(listWarehouseTransferInTemp);
            listPaging.setPaging(paging);
            
            return listPaging;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return null;
        }
    }

    public List<WarehouseTransferInItemDetailTemp> findDataDetailDestination(String headerCode) throws Exception{
       try{
            List<WarehouseTransferInItemDetailTemp> listWarehouseTransferInItemDetailSourceTemp = warehouseTransferInDAO.findItemDetailDestinationData(headerCode);
                        
            return listWarehouseTransferInItemDetailSourceTemp;
        }catch(Exception e){
            throw e;
        }
    }
    
    public void save(WarehouseTransferIn warehouseTransferIn,
            List<WarehouseTransferInItemDetail> listWarehouseTransferInItemDetail) throws Exception {
        try {
            warehouseTransferInDAO.save(warehouseTransferIn,listWarehouseTransferInItemDetail,MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            warehouseTransferInDAO.delete(code,MODULECODE);
        } catch (Exception e){
            throw e;
        }
    }
}
