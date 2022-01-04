/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.dao;

import com.inkombizz.action.BaseSession;
import com.inkombizz.inventory.model.BaseModelCogs;
import com.inkombizz.inventory.model.IvtCogsIdr;
import com.inkombizz.master.model.Branch;
import com.inkombizz.master.model.ItemMaterial;
import com.inkombizz.master.model.Warehouse;
import java.io.Serializable;
import java.util.Date;
import org.hibernate.HibernateException;

/**
 *
 * @author jason
 * @param <T>
 */
public abstract class AbstractGenericDaoCogs<T extends Serializable> {
   
    private HBMSession hbmSession;
    
    public void saveCogs(T entity, IvtCogsIdr ivtCogsIdr, HBMSession hbmSession) {
        try {
            this.hbmSession = hbmSession;
            this.hbmSession.hSession.beginTransaction();
            
            String args[] = ivtCogsIdr.getCOGSNo().split("_");
            
            ((BaseModelCogs) entity).setCode(args[1]);
            ((BaseModelCogs) entity).setHeaderCode(args[0]);
            Branch b = new Branch();   
                b.setCode(ivtCogsIdr.getBranchCode());
            ((BaseModelCogs) entity).setBranch(b);
            Warehouse w = new Warehouse();
                w.setCode(ivtCogsIdr.getWarehouseCode());
            ((BaseModelCogs) entity).setWarehouse(w);
            ItemMaterial itemMaterial = new ItemMaterial();
                itemMaterial.setCode(ivtCogsIdr.getItemMaterialCode());
            ((BaseModelCogs) entity).setItemMaterial(itemMaterial);
//            ((BaseModelCogs) entity).setItemDate(ivtCogsIdr.getUsedStockDate());
//            ((BaseModelCogs) entity).setQuantity(ivtCogsIdr.getItemQuantity());
//            ((BaseModelCogs) entity).setCogsIdr(ivtCogsIdr.getUsedStockCOGS());
            ((BaseModelCogs) entity).setCreatedBy(BaseSession.loadProgramSession().getUserName());
            ((BaseModelCogs) entity).setCreatedDate(new Date());
            this.hbmSession.hSession.save(entity);
        } catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
        }        
    }
    
}
