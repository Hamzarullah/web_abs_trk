/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.inventory.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.inventory.dao.ItemMaterialStockLocationDAO;
import com.inkombizz.inventory.model.ItemMaterialStockLocation;
import java.util.List;

public class ItemMaterialStockLocationBLL {
    
    public static final String MODULECODE = "003_IVT_ITEM_STOCK_LOCATION";    
    
    private ItemMaterialStockLocationDAO itemMaterialStockLocationDAO;
    
    public ItemMaterialStockLocationBLL (HBMSession hbmSession) {
        this.itemMaterialStockLocationDAO = new ItemMaterialStockLocationDAO(hbmSession);
    }
    
    public ListPaging<ItemMaterialStockLocation> findData(Paging paging,ItemMaterialStockLocation itemMaterialStockLocation) throws Exception{
        try{

            paging.setRecords(itemMaterialStockLocationDAO.countData(itemMaterialStockLocation));
            paging.setTotal((int)Math.ceil((double)paging.getRecords()/(double)paging.getRows()));
            
            List<ItemMaterialStockLocation> listItemMaterialStockLocation = itemMaterialStockLocationDAO.findData(itemMaterialStockLocation,paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemMaterialStockLocation> listPaging = new ListPaging<ItemMaterialStockLocation>();
            listPaging.setList(listItemMaterialStockLocation);
            listPaging.setPaging(paging);
            
            return listPaging;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return null;
        }
    }
    
    public ListPaging<ItemMaterialStockLocation> findSearchData(Paging paging,ItemMaterialStockLocation itemMaterialStockLocation) throws Exception{
        try{

            paging.setRecords(itemMaterialStockLocationDAO.countSearchData(itemMaterialStockLocation));
            paging.setTotal((int)Math.ceil((double)paging.getRecords()/(double)paging.getRows()));
            
            List<ItemMaterialStockLocation> listItemMaterialStockLocation = itemMaterialStockLocationDAO.findSearchData(itemMaterialStockLocation,paging.getFromRow(), paging.getToRow());
            
            ListPaging<ItemMaterialStockLocation> listPaging = new ListPaging<ItemMaterialStockLocation>();
            listPaging.setList(listItemMaterialStockLocation);
            listPaging.setPaging(paging);
            
            return listPaging;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return null;
        }
    }
    
}
