/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.inventory.dao;

import com.inkombizz.common.InventoryCommon;
import com.inkombizz.common.enumeration.EnumCOGSType;
import com.inkombizz.dao.AbstractGenericDaoCogs;
import com.inkombizz.dao.HBMSession;
//import com.inkombizz.inventory.model.DeliveryNoteSalesContractCogs;
//import com.inkombizz.inventory.model.DeliveryNoteSalesOrderCogs;
import com.inkombizz.inventory.model.InventoryActualStock;
import com.inkombizz.inventory.model.InventoryActualStockField;
import com.inkombizz.inventory.model.InventoryActualStockTemp;
import com.inkombizz.inventory.model.IvtActualStock;
import com.inkombizz.inventory.model.IvtCogsIdr;
//import com.inkombizz.inventory.model.PickingListSalesContractCogsIn;
//import com.inkombizz.inventory.model.PickingListSalesContractCogsOut;
//import com.inkombizz.inventory.model.PickingListSalesOrderCogsIn;
//import com.inkombizz.inventory.model.PickingListSalesOrderCogsOut;
//import com.inkombizz.inventory.model.WarehouseTransferOutCogsIn;
//import com.inkombizz.inventory.model.WarehouseTransferOutCogsOut;
import com.inkombizz.master.model.ItemMaterial;
import com.inkombizz.master.model.ItemMaterialField;
import com.inkombizz.master.model.Rack;
import com.inkombizz.master.model.Warehouse;
//import com.inkombizz.sales.model.ReturnByDeliveryNoteSalesContractCogs;
//import com.inkombizz.sales.model.ReturnByDeliveryNoteSalesOrderCogs;
//import com.inkombizz.sales.model.ReturnByPickingListSalesContractCogsIn;
//import com.inkombizz.sales.model.ReturnByPickingListSalesContractCogsOut;
//import com.inkombizz.sales.model.ReturnByPickingListSalesOrderCogsIn;
//import com.inkombizz.sales.model.ReturnByPickingListSalesOrderCogsOut;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.math.MathContext;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import org.hibernate.transform.Transformers;

public class InventoryInOutDAO extends AbstractGenericDaoCogs {

    private HBMSession hbmSession;
    public InventoryInOutDAO(HBMSession session) {
        this.hbmSession = session;
    }
    
    public int getMaxSortNo_ActualStock() {
        try {
            int rValue = 0;
            DetachedCriteria dc = DetachedCriteria.forClass(InventoryActualStock.class)
                    .setProjection(Projections.max("sortNo"));
            
            Criteria criteria = dc.getExecutableCriteria(hbmSession.hSession);
            List list = criteria.list();
            
            if (list != null) {
                if (list.size() > 0) {
                    if (list.get(0) != null) {
                        rValue = Integer.parseInt(list.get(0).toString());
                    }
                }
            }

            return rValue + 1;
        } catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    // Mencari Total Stock Per ItemMaterial
//    private BigDecimal getActualStockTotal(String itemMaterialCode) {
//        try {
//            BigDecimal rValue = 0;
//            Query qry = hbmSession.hSession.createQuery(
//                "SELECT SUM(" + InventoryActualStockField.ACTUALSTOCK + ") "
//                + "FROM " + InventoryActualStockField.BEAN_NAME + "  "
//                + "WHERE "
//                + InventoryActualStockField.ITEMMATERIALCODE + "= :prmItemMaterialCode "
//                + "GROUP BY " + InventoryActualStockField.ITEMMATERIALCODE
//            )
//                .setParameter("prmItemMaterialCode", itemMaterialCode);
//
//            List list = qry.list();
//
//            if (list != null) {
//                if (list.size() > 0) {
//                    if (list.get(0) != null) {
//                        rValue = Double.parseDouble(list.get(0).toString());
//                    }
//                }
//            }
//
//            return rValue;
//        } catch (HibernateException e) {
//            hbmSession.hTransaction.rollback();
//            throw e;
//        }
//    }
    
//    private BigDecimal getActualStockTotal(String branchCode, String warehouseCode, String itemMaterialCode) {
//        try {
//            BigDecimal rValue = 0;
//            Query qry = hbmSession.hSession.createQuery("SELECT SUM(" + InventoryActualStockField.ACTUALSTOCK + " - " + InventoryActualStockField.USEDSTOCK + ") "
//                    + "FROM " + InventoryActualStockField.BEAN_NAME + "  "
//                    + "WHERE "
//                    + //                                                                InventoryActualStockField.BRANCHCODE + "= :prmBranchCode " + 
//                    //                                                                "AND " + 
//                    InventoryActualStockField.WAREHOUSECODE + "= :prmWarehouseCode "
//                    + "AND " + InventoryActualStockField.ITEMMATERIALCODE + "= :prmItemMaterialCode"
//            )
//                    //                        .setParameter("prmBranchCode", branchCode)
//                    .setParameter("prmWarehouseCode", warehouseCode)
//                    .setParameter("prmItemMaterialCode", itemMaterialCode);
//
//            List list = qry.list();
//
//            if (list != null) {
//                if (list.size() > 0) {
//                    if (list.get(0) != null) {
//                        rValue = Double.parseDouble(list.get(0).toString());
//                    }
//                }
//            }
//
//            return rValue;
//        } catch (HibernateException e) {
//            hbmSession.hTransaction.rollback();
//            throw e;
//        }
//    }
    
    
    private List<InventoryActualStock> getActualStock(String warehouseCode,String itemMaterialCode, String rackCode) {
        try {
            
            String qry = "SELECT wes "
                    + "FROM " + InventoryActualStockField.BEAN_NAME + " as wes "
                    + "JOIN wes.warehouse as warehouse "
                    + "JOIN wes.itemMaterial as itemMaterial "
                    + "JOIN wes.rack as rack "
                    + "WHERE "
                    + InventoryActualStockField.ITEMMATERIALCODE + "= '"+itemMaterialCode+"' "
                    + "AND " + InventoryActualStockField.RACKCODE + "= '"+rackCode+"' "
                    + "AND " + InventoryActualStockField.WAREHOUSECODE + "= '"+warehouseCode+"' ";
            
            List<InventoryActualStock> listInvActualStock = hbmSession.hSession.createQuery(qry)
//                    .setParameter("prmItemMaterialCode", itemMaterialCode)
//                    .setParameter("prmRackCode", rackCode)
//                    .setParameter("prmWarehouseCode", warehouseCode)
                    .list();

            return listInvActualStock;
        } catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
//    private List<InventoryActualStock> getActualStockPicking(String warehouseCode,String itemMaterialCode, String rackCode) {
//        try {
//            
//            String qry = "SELECT wes "
//                    + "FROM " + InventoryActualStockField.BEAN_NAME + " as wes "
//                    + "JOIN wes.warehouse as warehouse "
//                    + "JOIN wes.item as item "
//                    + "JOIN wes.rack as rack "
//                    + "WHERE "
//                    + InventoryActualStockField.ITEMMATERIALCODE + "= '"+itemMaterialCode+"' "
//                    + "AND " + InventoryActualStockField.RACKCODE + "= '"+rackCode+"' "
//                    + "AND " + InventoryActualStockField.WAREHOUSECODE + "= '"+warehouseCode+"' ";
////                    + "AND " + InventoryActualStockField.ACTUALSTOCK + " > 0" ;
//           
//            List<InventoryActualStock> listInvActualStock = hbmSession.hSession.createQuery(qry)
//                    .list();
//
//            return listInvActualStock;
//        } catch (HibernateException e) {
//            e.printStackTrace();
//            hbmSession.hTransaction.rollback();
//            throw e;
//        }
//    }
    
    private void insertActualStock(InventoryActualStock ivtActualStock) {
        try {
            hbmSession.hSession.save(ivtActualStock);
            hbmSession.hSession.flush();
        } catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    private void updateActualStock(String code, BigDecimal quantity) {
        try {
            hbmSession.hSession.createQuery("UPDATE " + InventoryActualStockField.BEAN_NAME + " "
                    + "SET " + InventoryActualStockField.ACTUALSTOCK + "= " + InventoryActualStockField.ACTUALSTOCK + "+  '"+quantity+"' "
                    + "WHERE " + InventoryActualStockField.CODE + " = '"+code+"' ")
                  //  .setParameter("prmCode", code)
                  //  .setParameter("prmQuantity", quantity)
                    .executeUpdate();
            
            hbmSession.hSession.flush();
        } catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void increase_decrease_ActualStock(String warehouse,String item,String rack, BigDecimal quantity,boolean isIncrease) {
        try {
            String query="";
            if(isIncrease){
                query="SET " + InventoryActualStockField.ACTUALSTOCK + "= " + InventoryActualStockField.ACTUALSTOCK + "+ :prmUsedQuantity  ";
            }else{
                query="SET " + InventoryActualStockField.ACTUALSTOCK + "= " + InventoryActualStockField.ACTUALSTOCK + "- :prmUsedQuantity  ";
            }
            
            
            hbmSession.hSession.createQuery(
                    "UPDATE " + InventoryActualStockField.BEAN_NAME + "  "
                    + query
                    + "WHERE warehouse.code = :prmWarehouseCode "
                    + "AND itemMaterial.code = :prmItemMaterialCode "
                    + "AND rack.code = :prmRackCode ")
                .setParameter("prmUsedQuantity", quantity)
                .setParameter("prmWarehouseCode", warehouse)
                .setParameter("prmItemMaterialCode", item)
                .setParameter("prmRackCode", rack)
                .executeUpdate();
            
            hbmSession.hSession.flush();
        } catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    private void usedActualStock(String code, BigDecimal usedStockQuantity) {
        try {
            hbmSession.hSession.createQuery("UPDATE " + InventoryActualStockField.BEAN_NAME + "  "
                    + "SET " + InventoryActualStockField.ACTUALSTOCK + "= "+usedStockQuantity+"  "
                    + "WHERE " + InventoryActualStockField.CODE + " = '"+code+"'  "
                    + "AND " + InventoryActualStockField.ACTUALSTOCK + " >= 0")
                   // .setParameter("prmUsedStockQuantity", usedStockQuantity)
                  //  .setParameter("prmCode", code)
                    .executeUpdate();
            hbmSession.hSession.flush();
        } catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }

    
//    private BigDecimal getQuantityMinusStock(String branchCode, String warehouseCode, String itemMaterialCode) {
//        try {
//            BigDecimal rValue = 0;
//            Query qry = hbmSession.hSession.createQuery("SELECT " + InventoryMinusStockField.MINUSQUANTITY + " "
//                    + "FROM " + InventoryMinusStockField.BEAN_NAME + "  "
//                    + "WHERE "
//                    + //                                                                InventoryMinusStockField.BRANCHCODE + "= :prmBranchCode " + 
//                    //                                                                "AND " + 
//                    InventoryMinusStockField.WAREHOUSECODE + "= :prmWarehouseCode "
//                    + "AND " + InventoryMinusStockField.ITEMMATERIALCODE + "= :prmItemMaterialCode"
//            )
//                    //                        .setParameter("prmBranchCode", branchCode)
//                    .setParameter("prmWarehouseCode", warehouseCode)
//                    .setParameter("prmItemMaterialCode", itemMaterialCode);
//
//            List list = qry.list();
//
//            if (list != null) {
//                if (list.size() > 0) {
//                    if (list.get(0) != null) {
//                        rValue = Double.parseDouble(list.get(0).toString());
//                    }
//                }
//            }
//
//            return rValue;
//        } catch (HibernateException e) {
//            hbmSession.hTransaction.rollback();
//            throw e;
//        }
//    }
    
//    private InventoryMinusStock getMinusStock(String branchCode, String warehouseCode, String itemMaterialCode) {
//        try {
//            DetachedCriteria criteria = DetachedCriteria.forClass(InventoryMinusStock.class)
//                    //                                        .add(Restrictions.eq(InventoryMinusStockField.BRANCHCODE, branchCode))
//                    .add(Restrictions.eq(InventoryMinusStockField.WAREHOUSECODE, warehouseCode))
//                    .add(Restrictions.eq(InventoryMinusStockField.ITEMMATERIALCODE, itemMaterialCode));
//
//            List<InventoryMinusStock> listInventoryMinusStock = criteria.getExecutableCriteria(hbmSession.hSession)
//                    .list();
//
//            hbmSession.hSession.flush();
//            hbmSession.hSession.clear();
//
//            if (listInventoryMinusStock != null) {
//                if (listInventoryMinusStock.size() > 0) {
//                    if (listInventoryMinusStock.get(0) != null) {
//                        return listInventoryMinusStock.get(0);
//                    }
//                }
//            }
//
//            return null;
//        } catch (HibernateException e) {
//            hbmSession.hTransaction.rollback();
//            throw e;
//        }
//    }
//
//    private boolean isUpdateMinusStock(String branchCode, String warehouseCode, String itemMaterialCode) {
//        try {
//            BigDecimal rValue = 0;
//            Query qry = hbmSession.hSession.createQuery("SELECT COUNT(*)  "
//                    + "FROM " + InventoryMinusStockField.BEAN_NAME + "  "
//                    + "WHERE "
//                    + //                                                                InventoryMinusStockField.BRANCHCODE + "= :prmBranchCode " + 
//                    //                                                                "AND " + 
//                    InventoryMinusStockField.WAREHOUSECODE + "= :prmWarehouseCode "
//                    + "AND " + InventoryMinusStockField.ITEMMATERIALCODE + "= :prmItemMaterialCode"
//            )
//                    //                        .setParameter("prmBranchCode", branchCode)
//                    .setParameter("prmWarehouseCode", warehouseCode)
//                    .setParameter("prmItemMaterialCode", itemMaterialCode);
//
//            List list = qry.list();
//
//            if (list != null) {
//                if (list.size() > 0) {
//                    if (list.get(0) != null) {
//                        rValue = Integer.parseInt(list.get(0).toString());
//                    }
//                }
//            }
//
//            if (rValue > 0) {
//                return true;
//            } else {
//                return false;
//            }
//        } catch (HibernateException e) {
//            hbmSession.hTransaction.rollback();
//            throw e;
//        }
//    }
//
//    private void insertMinusStock(InventoryMinusStock ivtMinusStock) {
//        try {
//            //InventoryStockMinus ivtStockMinus = InventoryCommon.newInstance(ivtActualStock.getBranchCode(), ivtActualStock.getWarehouse(), ivtActualStock.getItemMaterial(), quantity);
//            hbmSession.hSession.save(ivtMinusStock);
//            hbmSession.hSession.flush();
//        } catch (HibernateException e) {
//            hbmSession.hTransaction.rollback();
//            throw e;
//        }
//    }
//
//    private void updateMinusStock(String code, BigDecimal quantity) {
//        try {
//            hbmSession.hSession.createQuery("UPDATE " + InventoryMinusStockField.BEAN_NAME + " "
//                    + "SET " + InventoryMinusStockField.MINUSQUANTITY + "= " + InventoryMinusStockField.MINUSQUANTITY + "+ :prmQuantity "
//                    + "WHERE " + InventoryMinusStockField.CODE + " = :prmCode")
//                    .setParameter("prmCode", code)
//                    .setParameter("prmQuantity", quantity)
//                    .executeUpdate();
//
//            hbmSession.hSession.flush();
//        } catch (HibernateException e) {
//            hbmSession.hTransaction.rollback();
//            throw e;
//        }
//    }
    
    private BigDecimal getCogsItemMaterial(BigDecimal quantity, BigDecimal cogsIdr, String itemMaterialCode) {
        try {
            BigDecimal rValue = new BigDecimal("0.00");
//            Query qry = hbmSession.hSession.createQuery(
//                    "SELECT (SUM(IFNULL(" + InventoryActualStockField.ACTUALSTOCK + ",0) * " + ItemMaterialField.COGSIDR + ") + (" + quantity + "*"+cogsIdr+"))/"
//                         + "(SUM(IFNULL(" + InventoryActualStockField.ACTUALSTOCK + ",0))+"+quantity+") AS CogsIdr "
//                + "FROM " + ItemMaterialField.BEAN_NAME + " "
//                + "LEFT JOIN " + InventoryActualStockField.ACTUALSTOCK
//                + "WHERE " 
//                + ItemMaterialField.BEAN_NAME + "= :prmItemMaterialCode"
//            )
            List<IvtActualStock> lstIvtActualStock =(List<IvtActualStock>) hbmSession.hSession.createSQLQuery(
                "SELECT ((SUM(IFNULL(mst_item_material_jn_current_stock.ActualStock,0) * mst_item_material.COGSIDR) + (" + quantity + "*"+cogsIdr+"))/"
                + "(SUM(IFNULL(mst_item_material_jn_current_stock.ActualStock,0))+"+quantity+")) AS COGSIDR "
                + "FROM mst_item_material "
                + "LEFT JOIN mst_item_material_jn_current_stock ON mst_item_material_jn_current_stock.ItemMaterialCode=mst_item_material.Code "
                + "WHERE mst_item_material.Code= '"+itemMaterialCode+"' "
            )
                    .addScalar("COGSIDR", Hibernate.BIG_DECIMAL)
                    .setResultTransformer(Transformers.aliasToBean(IvtActualStock.class))
                    .list();
            

//            List list = qry.list();
//
//            if (list != null) {
//                if (list.size() > 0) {
//                    if (list.get(0) != null) {
//                        rValue = Double.parseDouble(list.get(0).toString());
//                    }
//                }
//            }
            
            rValue = lstIvtActualStock.get(0).getCOGSIDR();
            return rValue;
            
           
        } catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    private void updateCogsItemMaterialStock(String code, BigDecimal cogsIdr) {
        try {
            
            hbmSession.hSession.createQuery("UPDATE " + ItemMaterialField.BEAN_NAME + " "
                    + "SET " + ItemMaterialField.COGSIDR + "= "+cogsIdr+" "
                    + "WHERE " + ItemMaterialField.CODE + " = '"+code+"' ")
                   // .setParameter("prmCode", code)
                   // .setParameter("prmCogsIdr", cogsIdr)
                    .executeUpdate();
            
            hbmSession.hSession.flush();
        } catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }

//    private void deleteMinusStock(String code) {
//        try {
//            hbmSession.hSession.createQuery("DELETE FROM " + InventoryMinusStockField.BEAN_NAME
//                    + " WHERE " + InventoryMinusStockField.CODE + " = :prmCode")
//                    .setParameter("prmCode", code)
//                    .executeUpdate();
//
//            hbmSession.hSession.flush();
//        } catch (HibernateException e) {
//            hbmSession.hTransaction.rollback();
//            throw e;
//        }
//    }
    
    public void ActualStockIncrease_AVG(IvtActualStock increaseRec, boolean isCogsIn, boolean isUpdateItemMaterialCogs, String COGSNo,
            EnumCOGSType.ENUM_COGSType COGSType, int actualStock_SortNo) throws Exception {
        
        BigDecimal itemQuantity;
        BigDecimal cogsIdr=new BigDecimal(BigInteger.ZERO);
        try {
    
                Warehouse warehouse = new Warehouse();
                warehouse.setCode(increaseRec.getWarehouseCode());
                ItemMaterial item = new ItemMaterial();
                itemQuantity = increaseRec.getActualStock();
                item.setCode(increaseRec.getItemMaterialCode());
                Rack rack =new Rack();
                rack.setCode(increaseRec.getRackCode());
                
                if(isUpdateItemMaterialCogs){
                    cogsIdr=getCogsItemMaterial(itemQuantity,increaseRec.getCOGSIDR(),increaseRec.getItemMaterialCode());  
                    
                   updateCogsItemMaterialStock(increaseRec.getItemMaterialCode(),cogsIdr);
                }
                
                if(isCogsIn){
                    ItemMaterial itemCogsIn=(ItemMaterial) hbmSession.hSession.get(ItemMaterial.class,increaseRec.getItemMaterialCode());
                    insertCOGS(COGSType,"IN",InventoryCommon.newInstance(
                            COGSNo,
                            increaseRec.getBranchCode(),
                            increaseRec.getWarehouseCode(),
                            increaseRec.getItemMaterialCode(),
                            increaseRec.getRackCode(),new Date(), increaseRec.getActualStock(),itemCogsIn.getCogsIDR()));
                }

                //Check Stock dengan Parameter warehouse,item,rack sudah ada?
                List<InventoryActualStock> listInvActualStock =
                getActualStock(increaseRec.getWarehouseCode(),increaseRec.getItemMaterialCode(),increaseRec.getRackCode());
                
                if(listInvActualStock.isEmpty()){
                    insertActualStock(InventoryCommon.newInstance(warehouse, item, itemQuantity , rack, increaseRec.getHeatNo()));
                }else{
                    updateActualStock(listInvActualStock.get(0).getCode(), itemQuantity);
                }
                
         //   }
        }catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
        
    }
    
//    public void ActualStockPickingIncrease_AVG(IvtActualStock newRec, boolean isIncreaseDecrease, boolean isUpdateItemMaterialCogs, String COGSNo,
//            EnumCOGSType.ENUM_COGSType COGSType, int actualStock_SortNo) throws Exception {
//        
//        BigDecimal itemQuantity;
//        BigDecimal cogsIdr=0;
//        try {
//    
//                Warehouse warehouse = new Warehouse();
//                warehouse.setCode(newRec.getWarehouseCode());
//                ItemMaterial item = new ItemMaterial();
//                itemQuantity = newRec.getActualStock();
//                item.setCode(newRec.getItemMaterialCode());
//                Rack rack =new Rack();
//                rack.setCode(newRec.getRackCode());
//                
//                if(isUpdateItemMaterialCogs){
//                    cogsIdr=
//                   getCogsItemMaterial(
//                     new BigDecimal(itemQuantity),
//                     new BigDecimal(newRec.getCOGSIDR()),
//                     newRec.getItemMaterialCode());  
//                    
//                   updateCogsItemMaterialStock(newRec.getItemMaterialCode(),
//                     new BigDecimal(cogsIdr));
//                }
//                             
//                //Check Stock dengan Parameter warehouse,item,rack sudah ada?
//                List<InventoryActualStock> listInvActualStockPicking =
//                getActualStockPicking(newRec.getWarehouseCode(),newRec.getItemMaterialCode(),newRec.getRackCode());
//                    
//                if(listInvActualStockPicking.isEmpty()){
//                    insertActualStock(InventoryCommon.newInstance(warehouse, item, itemQuantity , rack));
//                }else{
//                    updateActualStock(listInvActualStockPicking.get(0).getCode(), itemQuantity);
//                }
//         //   }
//        }catch (HibernateException e) {
//            e.printStackTrace();
//            hbmSession.hTransaction.rollback();
//            throw e;
//        }
//        
//    }
    
    public void ActualStockDecrease_AVG(IvtActualStock decreaseRec,boolean isIncreaseDecrease,boolean isDelete, String COGSNo,
            EnumCOGSType.ENUM_COGSType COGSType, int actualStock_SortNo
            ) throws Exception {
        try {
              
            List<InventoryActualStock> listInvActualStock = getActualStock(decreaseRec.getWarehouseCode(),decreaseRec.getItemMaterialCode(),decreaseRec.getRackCode());
            
            BigDecimal actualStockQuantity = new BigDecimal("0.00");
            BigDecimal itemQuantity= decreaseRec.getActualStock();
            String usedStockCode = "";
            DecimalFormat df = new DecimalFormat("#,##0.00");
            if (listInvActualStock.size() > 0) {
                for (InventoryActualStock invActualStock : listInvActualStock) {
                    actualStockQuantity = invActualStock.getActualStock();// - invActualStock.getUsedStock();
//                  
                    usedStockCode = invActualStock.getCode();
//
                    if (actualStockQuantity.compareTo(BigDecimal.ZERO) > -1) {
//                        actualStockQuantity -= itemQuantity;
                        actualStockQuantity=actualStockQuantity.subtract(itemQuantity);
                        
                        if(actualStockQuantity.compareTo(BigDecimal.ZERO) < 0){
                            hbmSession.hTransaction.rollback();
                            throw new Exception("stock quantity is not enough!<br/>"
                                    + "<div>"
                                    + "<table>"
                                    + "<tr><td size='10px'>Warehouse</td><td>:</td><td>"+invActualStock.getWarehouse().getCode()+"</td></tr>"
                                    + "<tr><td>Rack</td><td>:</td><td>"+invActualStock.getRack().getCode()+"</td></tr>"
                                    + "<tr><td>Item Material</td><td>:</td><td>"+invActualStock.getItemMaterial().getCode()+"</td></tr>"
                                    + "<tr><td>Stock</td><td>:</td><td>"+df.format(invActualStock.getActualStock())+"</td></tr>"
                                    + "</table></div>");
                        }
                        
                        
                        usedActualStock(usedStockCode, actualStockQuantity);
                        
                        // INSERT COGS 
                        if(!isDelete){
                            ItemMaterial item=(ItemMaterial) hbmSession.hSession.get(ItemMaterial.class,decreaseRec.getItemMaterialCode());
                            insertCOGS(COGSType,"OUT",InventoryCommon.newInstance(COGSNo,decreaseRec.getBranchCode(),
                                    decreaseRec.getWarehouseCode(),
                                    decreaseRec.getItemMaterialCode(),
                                    decreaseRec.getRackCode(),new Date(), decreaseRec.getActualStock(),item.getCogsIDR()));
                        }
                        
                        
                        if (isIncreaseDecrease) {
                            IvtActualStock newIvtActualStock = InventoryCommon.newInstance(decreaseRec.getWarehouseCode(),decreaseRec.getBranchCode(),
                            decreaseRec.getItemMaterialCode() ,decreaseRec.getNewQuantity(),decreaseRec.getOldQuantity(),decreaseRec.getRackCode());
                            ActualStockIncrease_AVG(newIvtActualStock,true,true, COGSNo, COGSType, actualStock_SortNo);
                            
                        }
//
                    } // END OF IF >> (actualStockQuantity > 0)

//                    if (itemQuantity <= 0) {
//                        break;
//                    }
                } // END OF FOR >> (InventoryActualStock invActualStock : listInvActualStock)
//
            } // END OF IF  >> (listInvActualStock.size() > 0)
            else{
                hbmSession.hTransaction.rollback();
                throw new Exception("stock quantity is not enough!");
            }

        } catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }

    }
    
    public void insertCOGS(EnumCOGSType.ENUM_COGSType cogsType,String StatINOUT ,IvtCogsIdr ivtCogsIdr){
        
        try{
            
            if(cogsType != EnumCOGSType.ENUM_COGSType.NONE){
                
                switch (cogsType){
//                    case IOT:
//                            super.saveCogs(new InventoryOutCogs(), ivtCogsIdr, hbmSession);
//                        break;
//                    case DLNSO:
//                            super.saveCogs(new DeliveryNoteSalesOrderCogs(), ivtCogsIdr, hbmSession);
//                        break;
//                    case DLNSC:
//                            super.saveCogs(new DeliveryNoteSalesContractCogs(), ivtCogsIdr, hbmSession);
//                        break;
////                    case PRT:
////                            super.saveCogs(new PurchaseReturnItemMaterialCogs(), ivtCogsIdr, hbmSession);
////                        break;
////                    case SRT:
////                            super.saveCogs(new SalesReturnItemMaterialCogs(), ivtCogsIdr, hbmSession);
////                        break;
//                    case WHT:
//                            if(StatINOUT != null){
//                                if(StatINOUT.equalsIgnoreCase("IN")){
//                                    super.saveCogs(new WarehouseTransferOutCogsIn(), ivtCogsIdr, hbmSession);
//                                }else{
//                                    super.saveCogs(new WarehouseTransferOutCogsOut(), ivtCogsIdr, hbmSession);
//                                }
//                            }
//                        break;      
//                    case PLTSO:
//                         if(StatINOUT != null){
//                            if(StatINOUT.equalsIgnoreCase("IN")){
//                                super.saveCogs(new PickingListSalesOrderCogsIn(), ivtCogsIdr, hbmSession);
//                            }else{
//                                super.saveCogs(new PickingListSalesOrderCogsOut(), ivtCogsIdr, hbmSession);
//                            }
//                         }
//                        break;
//                    case PLTSC:
//                         if(StatINOUT != null){
//                            if(StatINOUT.equalsIgnoreCase("IN")){
//                                super.saveCogs(new PickingListSalesContractCogsIn(), ivtCogsIdr, hbmSession);
//                            }else{
//                                super.saveCogs(new PickingListSalesContractCogsOut(), ivtCogsIdr, hbmSession);
//                            }
//                         }
//                        break;
//                    case RPLTSO:
//                         if(StatINOUT != null){
//                            if(StatINOUT.equalsIgnoreCase("IN")){
//                                super.saveCogs(new ReturnByPickingListSalesOrderCogsIn(), ivtCogsIdr, hbmSession);
//                                super.saveCogs(new ReturnByPickingListSalesOrderCogsOut(), ivtCogsIdr, hbmSession);
//                            }else{
//                                super.saveCogs(new ReturnByPickingListSalesOrderCogsOut(), ivtCogsIdr, hbmSession);
//                            }
//                         }
//                        break;
//                    case RPLTSC:
//                         if(StatINOUT != null){
//                            if(StatINOUT.equalsIgnoreCase("IN")){
//                                super.saveCogs(new ReturnByPickingListSalesContractCogsIn(), ivtCogsIdr, hbmSession);
//                                super.saveCogs(new ReturnByPickingListSalesContractCogsOut(), ivtCogsIdr, hbmSession);
//                            }else{
//                                super.saveCogs(new ReturnByPickingListSalesContractCogsOut(), ivtCogsIdr, hbmSession);
//                            }
//                         }
//                        break;
//                    case RDLNSO:
//                         if(StatINOUT != null){
//                            if(StatINOUT.equalsIgnoreCase("IN")){
//                                super.saveCogs(new ReturnByDeliveryNoteSalesOrderCogs(), ivtCogsIdr, hbmSession);
//                            }
//                         }
//                        break;
//                    case RDLNSC:
//                         if(StatINOUT != null){
//                            if(StatINOUT.equalsIgnoreCase("IN")){
//                                super.saveCogs(new ReturnByDeliveryNoteSalesContractCogs(), ivtCogsIdr, hbmSession);
//                            }
//                         }
//                        break;
//                    default :
//                        break;
                }
                
                hbmSession.hSession.flush();
                hbmSession.hSession.clear();
            }
        }
        catch(HibernateException e){
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    
    private BigDecimal getActualCurrentStockTotalAssemblyRealization(String warehouseCode, String itemMaterialCode, String transactionCode) {
        try {
            BigDecimal rValue = new BigDecimal('0');
            Query qry = hbmSession.hSession.createSQLQuery(
                    "SELECT SUM(qwerty.actualStock) " +
                    "FROM " + 
                    "(SELECT ( mst_item_material_jn_current_stock.ActualStock) AS actualStock " +
                    "FROM mst_item_material_jn_current_stock   " +
                    "WHERE  " +
                    "  mst_item_material_jn_current_stock.WarehouseCode = :prmWarehouseCode  " +
                    "  AND mst_item_material_jn_current_stock.ItemMaterialCode = :prmItemMaterialCode  " +
                    "UNION ALL " +
                    "SELECT ivt_assembly_realization_cogs.Quantity AS actualStock " +
                    "FROM ivt_assembly_realization_cogs " +
                    "WHERE  " +
                    "    ivt_assembly_realization_cogs.HeaderCode = :prmHeaderCode " +
                    "    AND ivt_assembly_realization_cogs.ItemMaterialCode = :prmItemMaterialCode " +
                    ")AS qwerty "
            )
            .setParameter("prmWarehouseCode", warehouseCode)
            .setParameter("prmItemMaterialCode", itemMaterialCode)
            .setParameter("prmHeaderCode", transactionCode);

            List list = qry.list();

            if (list != null) {
                if (list.size() > 0) {
                    if (list.get(0) != null) {
                        rValue = new BigDecimal(list.get(0).toString());
                    }
                }
            }

            return rValue;
        } catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    /*MODULE DOCK STOCK*/
    public int countData(String code, String name, String warehouseCode, String warehouseName, String rackCode){
        try{
            String[] arrOfStrItemMaterial = name.split("%"); 
            String tempItemMaterialQry="";
            for (String a : arrOfStrItemMaterial){
                String tempQryItemMaterialName=" AND mst_item_material.name LIKE '%"+a+"%' ";
                tempItemMaterialQry+=tempQryItemMaterialName;
            }        
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                 "SELECT "
                + "COUNT(*) "
                + "FROM mst_item_material_jn_current_stock "
                + "INNER JOIN mst_item_material ON mst_item_material_jn_current_stock.itemMaterialCode = mst_item_material.code  "
                + "WHERE mst_item_material_jn_current_stock.ItemMaterialCode LIKE '%"+code+"%' "
                + tempItemMaterialQry 
                + "AND mst_item_material_jn_current_stock.WarehouseCode LIKE '%"+warehouseCode+"%' "
                + "AND mst_item_material_jn_current_stock.RackCode LIKE '%"+rackCode+"%' "
               
            ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    /*MODULE DOCK STOCK*/
    public List<IvtActualStock> findData(String code, String name, String warehouseCode, String warehouseName,String rackCode,int from, int row){
        try{
            String[] arrOfStrItemMaterial = name.split("%"); 
            String tempItemMaterialQry="";
            for (String a : arrOfStrItemMaterial){
                String tempQryItemMaterialName=" AND mst_item_material.name LIKE '%"+a+"%' ";
                tempItemMaterialQry+=tempQryItemMaterialName;
            }
            String qry = "SELECT  "
            + "mst_item_material_jn_current_stock.ItemMaterialCode, "
            + "mst_item_material.Name AS ItemMaterialName, "
            + "mst_item_material.UnitOfMeasureCode AS unitOfMeasureCode, "
            + "mst_item_material_jn_current_stock.ActualStock, "
            + "mst_item_material_jn_current_stock.RackCode, "
            + "mst_item_material_jn_current_stock.WarehouseCode, "
            + "mst_warehouse.Name AS warehouseName, "
            + "mst_rack.name AS RackName "
            + "FROM mst_item_material_jn_current_stock  "
            + "INNER JOIN mst_rack ON mst_item_material_jn_current_stock.RackCode = mst_rack.code  "
            + "INNER JOIN mst_item_material ON mst_item_material_jn_current_stock.itemMaterialCode = mst_item_material.code  "
            + "INNER JOIN mst_unit_of_measure ON mst_item_material.UnitOfMeasureCode = mst_unit_of_measure.code  "
            + "INNER JOIN mst_warehouse ON mst_item_material_jn_current_stock.warehouseCode = mst_warehouse.code "
            + "WHERE mst_item_material_jn_current_stock.ItemMaterialCode LIKE '%"+code+"%' "
            + tempItemMaterialQry
            + "AND mst_item_material_jn_current_stock.WarehouseCode LIKE '%"+warehouseCode+"%' "
            + "AND mst_warehouse.Name LIKE '%"+warehouseName+"%' "
            + "AND mst_item_material_jn_current_stock.RackCode LIKE '%"+rackCode+"%'  ";
            
            Query q = hbmSession.hSession.createSQLQuery(qry)
                    .addScalar("itemMaterialCode", Hibernate.STRING)
                    .addScalar("itemMaterialName", Hibernate.STRING)
                    .addScalar("unitOfMeasureCode", Hibernate.STRING)
                    .addScalar("actualStock",Hibernate.BIG_DECIMAL)
                    .addScalar("rackCode",Hibernate.STRING)
                    .addScalar("rackName",Hibernate.STRING)
                    .addScalar("warehouseCode",Hibernate.STRING)
                    .addScalar("warehouseName",Hibernate.STRING)
                    .setResultTransformer(Transformers.aliasToBean(IvtActualStock.class));
            List<IvtActualStock> list =  q.list();
            System.out.println("dapetin dock stock"+ list.get(0).getItemAlias());
            return list;
        }catch(Exception e){
            e.printStackTrace();
            return null;
        }
    }
    
    public List<IvtActualStock> getActualCurrentStock(List<InventoryActualStockTemp> lstInventoryActualStockTemp){
        try{
            String strArrItemMaterialCode="";
            String strArrwarhouseCode="";
            String strReackCode="";
            
            
            int x=0;
            for(InventoryActualStockTemp inventoryActualStock : lstInventoryActualStockTemp){
                if(x==0){
                    strArrItemMaterialCode="'"+inventoryActualStock.getItemMaterialCode()+"'";
                    strArrwarhouseCode="'"+inventoryActualStock.getWarehouseCode()+"'";
                    strReackCode="'"+inventoryActualStock.getRackCode()+"'";
                }else{
                    strArrItemMaterialCode+=",'"+inventoryActualStock.getItemMaterialCode()+"'";
                    strArrwarhouseCode="'"+inventoryActualStock.getWarehouseCode()+"'";
                    strReackCode="'"+inventoryActualStock.getRackCode()+"'";
                }
                x++;
            }
            
            
            
            String qry = "SELECT  "
            + "mst_item_material_jn_current_stock.ItemMaterialCode, "
            + "mst_item_material.Name AS ItemMaterialName, "
            + "sal_sales_order_detail.`ItemAlias` AS ItemAlias, "
//            + "mst_item_material.InventoryType AS inventoryType, "
            + "mst_item_material.UnitOfMeasureCode AS unitOfMeasureCode, "
            + "mst_item_material_jn_current_stock.ActualStock, "
//            + "mst_item_material_jn_current_stock.UsedStock, "
//            + "mst_item_material_jn_current_stock.bookedStock, "
            + "0 AS quantity, "
//            + "mst_item_material_jn_current_stock.COGSIDR, "
//            + "mst_item_material_jn_current_stock.ItemMaterialBrandCode, "
//            + "mst_item_material_brand.Name AS itemBrandName, "
//            + "mst_item_material_jn_current_stock.LotNo, "
//            + "mst_item_material_jn_current_stock.BatchNo, "
//            + "mst_item_material_jn_current_stock.ItemMaterialDate, "
//            + "mst_item_material_jn_current_stock.InDocumentType, "
//            + "mst_item_material_jn_current_stock.InTransactionNo, "
//            + "mst_item_material_jn_current_stock.ProductionDate, "
//            + "mst_item_material_jn_current_stock.ExpiredDate, "
            + "mst_item_material_jn_current_stock.RackCode, "
            + "mst_rack.name AS RackName "
            + "FROM mst_item_material_jn_current_stock  "
            + "INNER JOIN mst_rack ON mst_item_material_jn_current_stock.RackCode = mst_rack.code  "
            + "INNER JOIN  sal_sales_order_detail  ON mst_item_material_jn_current_stock.itemMaterialCode = sal_sales_order_detail.itemMaterialCode   "
//            + "LEFT JOIN mst_item_material_brand ON mst_item_material_jn_current_stock.itemBrandCode = mst_item_material_brand.code  "
            + "INNER JOIN mst_item_material ON mst_item_material_jn_current_stock.itemMaterialCode = mst_item_material.code  "
            + "INNER JOIN mst_unit_of_measure ON mst_item_material.UnitOfMeasureCode = mst_unit_of_measure.code  "
            + "INNER JOIN mst_warehouse ON mst_item_material_jn_current_stock.warehouseCode = mst_warehouse.code            "
            + "WHERE mst_item_material_jn_current_stock.ItemMaterialCode IN("+strArrItemMaterialCode+") "
//            + "AND mst_item_material_jn_current_stock.BranchCode=:prmBranchCode "
            + "AND mst_item_material_jn_current_stock.WarehouseCode= "+strArrwarhouseCode+" "
            + "AND mst_item_material_jn_current_stock.`RackCode`="+strReackCode+""
//            + "AND mst_item_material_jn_current_stock.ActualStock > (mst_item_material_jn_current_stock.UsedStock+mst_item_material_jn_current_stock.BookedStock) "
            + "GROUP BY mst_item_material_jn_current_stock.ItemMaterialCode, mst_item_material_jn_current_stock.RackCode";
            
            Query q = hbmSession.hSession.createSQLQuery(qry)
                    .addScalar("itemMaterialCode", Hibernate.STRING)
                    .addScalar("itemMaterialName", Hibernate.STRING)
                    .addScalar("itemAlias", Hibernate.STRING)
//                    .addScalar("inventoryType", Hibernate.STRING)
                    .addScalar("unitOfMeasureCode", Hibernate.STRING)
                    .addScalar("actualStock",Hibernate.BIG_DECIMAL)
//                    .addScalar("usedStock",Hibernate.DOUBLE)
//                    .addScalar("bookedStock",Hibernate.DOUBLE)
                    .addScalar("quantity",Hibernate.BIG_DECIMAL)
//                    .addScalar("lotNo",Hibernate.STRING)
//                    .addScalar("batchNo",Hibernate.STRING)
//                    .addScalar("inTransactionNo",Hibernate.STRING)
//                    .addScalar("inDocumentType",Hibernate.STRING)
//                    .addScalar("productionDate",Hibernate.DATE)
//                    .addScalar("itemDate",Hibernate.DATE)
//                    .addScalar("itemBrandCode",Hibernate.STRING)
//                    .addScalar("itemBrandName",Hibernate.STRING)
//                    .addScalar("expiredDate",Hibernate.DATE)
//                    .addScalar("COGSIDR",Hibernate.DOUBLE)
                    .addScalar("rackCode",Hibernate.STRING)
                    .addScalar("rackName",Hibernate.STRING)
//                    .setParameter("prmBranchCode", lstInventoryActualStock.get(0).getBranchCode())
 //                   .setParameter("prmWarehouseCode", lstInventoryActualStockTemp.get(0).getWarehouseCode())
                    .setResultTransformer(Transformers.aliasToBean(IvtActualStock.class));
            List<IvtActualStock> list =  q.list();
            return list;
        }catch(Exception e){
            e.printStackTrace();
            return null;
        }
    }
    
    public List<IvtActualStock> getActualCurrentStockSC(List<InventoryActualStockTemp> lstInventoryActualStockTemp){
        try{
            String strArrItemMaterialCode="";
            String strArrwarhouseCode="";
            String strReackCode="";
            
            
            int x=0;
            for(InventoryActualStockTemp inventoryActualStock : lstInventoryActualStockTemp){
                if(x==0){
                    strArrItemMaterialCode="'"+inventoryActualStock.getItemMaterialCode()+"'";
                    strArrwarhouseCode="'"+inventoryActualStock.getWarehouseCode()+"'";
                    strReackCode="'"+inventoryActualStock.getRackCode()+"'";
                }else{
                    strArrItemMaterialCode+=",'"+inventoryActualStock.getItemMaterialCode()+"'";
                    strArrwarhouseCode="'"+inventoryActualStock.getWarehouseCode()+"'";
                    strReackCode="'"+inventoryActualStock.getRackCode()+"'";
                }
                x++;
            }
            
            
            
            String qry = "SELECT  "
            + "mst_item_material_jn_current_stock.ItemMaterialCode, "
            + "mst_item_material.Name AS ItemMaterialName, "
            + "sal_sales_contract_detail.`ItemAlias` AS ItemAlias, "
//            + "mst_item_material.InventoryType AS inventoryType, "
            + "mst_item_material.UnitOfMeasureCode AS unitOfMeasureCode, "
            + "mst_item_material_jn_current_stock.ActualStock, "
//            + "mst_item_material_jn_current_stock.UsedStock, "
//            + "mst_item_material_jn_current_stock.bookedStock, "
            + "0 AS quantity, "
//            + "mst_item_material_jn_current_stock.COGSIDR, "
//            + "mst_item_material_jn_current_stock.ItemMaterialBrandCode, "
//            + "mst_item_material_brand.Name AS itemBrandName, "
//            + "mst_item_material_jn_current_stock.LotNo, "
//            + "mst_item_material_jn_current_stock.BatchNo, "
//            + "mst_item_material_jn_current_stock.ItemMaterialDate, "
//            + "mst_item_material_jn_current_stock.InDocumentType, "
//            + "mst_item_material_jn_current_stock.InTransactionNo, "
//            + "mst_item_material_jn_current_stock.ProductionDate, "
//            + "mst_item_material_jn_current_stock.ExpiredDate, "
            + "mst_item_material_jn_current_stock.RackCode, "
            + "mst_rack.name AS RackName "
            + "FROM mst_item_material_jn_current_stock  "
            + "INNER JOIN mst_rack ON mst_item_material_jn_current_stock.RackCode = mst_rack.code  "
            + "INNER JOIN  sal_sales_contract_detail  ON mst_item_material_jn_current_stock.itemMaterialCode = sal_sales_contract_detail.itemMaterialCode   "
//            + "LEFT JOIN mst_item_material_brand ON mst_item_material_jn_current_stock.itemBrandCode = mst_item_material_brand.code  "
            + "INNER JOIN mst_item_material ON mst_item_material_jn_current_stock.itemMaterialCode = mst_item_material.code  "
            + "INNER JOIN mst_unit_of_measure ON mst_item_material.UnitOfMeasureCode = mst_unit_of_measure.code  "
            + "INNER JOIN mst_warehouse ON mst_item_material_jn_current_stock.warehouseCode = mst_warehouse.code            "
            + "WHERE mst_item_material_jn_current_stock.ItemMaterialCode IN("+strArrItemMaterialCode+") "
//            + "AND mst_item_material_jn_current_stock.BranchCode=:prmBranchCode "
            + "AND mst_item_material_jn_current_stock.WarehouseCode= "+strArrwarhouseCode+" "
            + "AND mst_item_material_jn_current_stock.`RackCode`="+strReackCode+""
//            + "AND mst_item_material_jn_current_stock.ActualStock > (mst_item_material_jn_current_stock.UsedStock+mst_item_material_jn_current_stock.BookedStock) "
            + "GROUP BY mst_item_material_jn_current_stock.ItemMaterialCode, mst_item_material_jn_current_stock.RackCode";
            
            Query q = hbmSession.hSession.createSQLQuery(qry)
                    .addScalar("itemMaterialCode", Hibernate.STRING)
                    .addScalar("itemName", Hibernate.STRING)
                    .addScalar("itemAlias", Hibernate.STRING)
//                    .addScalar("inventoryType", Hibernate.STRING)
                    .addScalar("unitOfMeasureCode", Hibernate.STRING)
                    .addScalar("actualStock",Hibernate.BIG_DECIMAL)
//                    .addScalar("usedStock",Hibernate.DOUBLE)
//                    .addScalar("bookedStock",Hibernate.DOUBLE)
                    .addScalar("quantity",Hibernate.BIG_DECIMAL)
//                    .addScalar("lotNo",Hibernate.STRING)
//                    .addScalar("batchNo",Hibernate.STRING)
//                    .addScalar("inTransactionNo",Hibernate.STRING)
//                    .addScalar("inDocumentType",Hibernate.STRING)
//                    .addScalar("productionDate",Hibernate.DATE)
//                    .addScalar("itemDate",Hibernate.DATE)
//                    .addScalar("itemBrandCode",Hibernate.STRING)
//                    .addScalar("itemBrandName",Hibernate.STRING)
//                    .addScalar("expiredDate",Hibernate.DATE)
//                    .addScalar("COGSIDR",Hibernate.DOUBLE)
                    .addScalar("rackCode",Hibernate.STRING)
                    .addScalar("rackName",Hibernate.STRING)
//                    .setParameter("prmBranchCode", lstInventoryActualStock.get(0).getBranchCode())
 //                   .setParameter("prmWarehouseCode", lstInventoryActualStockTemp.get(0).getWarehouseCode())
                    .setResultTransformer(Transformers.aliasToBean(IvtActualStock.class));
            List<IvtActualStock> list =  q.list();
            return list;
        }catch(Exception e){
            e.printStackTrace();
            return null;
        }
    }
    
    
    
//    public List<IvtActualStock> findDataByAssemblyRealization(List<InventoryActualStock> lstInventoryActualStock) throws Exception {
//        try { 
//            
//            BigDecimal itemQuantityTotal;
//            
//            for(InventoryActualStock inventoryActualStock:lstInventoryActualStock){
//                
//            //    BigDecimal conversion = unitOfMeasureConversionDAO.getConversionByItemMaterialCode(inventoryActualStock.getItemMaterial().getCode());
//                
//                itemQuantityTotal = getActualCurrentStockTotalAssemblyRealization(inventoryActualStock.getWarehouse().getCode(), 
//                        inventoryActualStock.getItemMaterial().getCode(),inventoryActualStock.getTransactionCode());
//            //    itemQuantityTotal = itemQuantityTotal/conversion.BigDecimalValue();
//                itemQuantityTotal = itemQuantityTotal;
//                
//                if (itemQuantityTotal < inventoryActualStock.getActualStock()) {
//                    hbmSession.hTransaction.rollback();
//                    throw new Exception("Quantity ItemMaterial "+inventoryActualStock.getItemMaterial().getName()+"is not enough");
//                }
//            }
//                               
//            List<IvtActualStock> listInvActualStock = getActualCurrentStockAssemblyRealization(lstInventoryActualStock);
//
//            List<IvtActualStock> listInvActualStockReturn = new ArrayList<IvtActualStock>();
//            BigDecimal actualStockQuantity = 0;
//            BigDecimal usedStockQuantity = 0;
//            BigDecimal bookedStock = 0;
//            
//            if (listInvActualStock.size() > 0) {
//                for(InventoryActualStock inventoryActualStock:lstInventoryActualStock){
//                    
//                //    BigDecimal conversion = unitOfMeasureConversionDAO.getConversionByItemMaterialCode(inventoryActualStock.getItemMaterial().getCode());
//                    
//                    bookedStock=inventoryActualStock.getActualStock();
//                    for (IvtActualStock invActualStock : listInvActualStock) {
//                        if(invActualStock.getItemMaterialCode().equals(inventoryActualStock.getItemMaterial().getCode())){
//                            actualStockQuantity=invActualStock.getQuantity();
//                            
//                                if (actualStockQuantity > 0) {
//                                    if (( bookedStock- actualStockQuantity) > 0) {
//                                        usedStockQuantity = actualStockQuantity;
//                                    } else {
//                                        usedStockQuantity = bookedStock;
//                                    }
//                                    
//                                    bookedStock -= usedStockQuantity;
//                                    
//                                    invActualStock.setQuantity(usedStockQuantity);
//                                    
//                                    listInvActualStockReturn.add(invActualStock);
//                                }
//                                
//                                if (bookedStock < 1) {
//                                    break;
//                                }
//                        }
//                    }
//                 }
//                 
//            }
//            
//            return listInvActualStockReturn;
//        }
//        catch (HibernateException e) {
//            throw e;
//        }
//    }
    
//    public List<IvtActualStock> getActualCurrentStockAssemblyRealization(List<InventoryActualStock> lstInventoryActualStock){
//        try{
//            String strArrItemMaterialCode="";
//            int x=0;
//            for(InventoryActualStock inventoryActualStock:lstInventoryActualStock){
//                if(x==0){
//                    strArrItemMaterialCode="'"+inventoryActualStock.getItemMaterial().getCode()+"'";
//                }else{
//                    strArrItemMaterialCode+=",'"+inventoryActualStock.getItemMaterial().getCode()+"'";
//                }
//                x++;
//            }
//            
//            String qry = "SELECT qwerty.* FROM " +
//                        "(SELECT   " +
//                        "             mst_item_material_jn_current_stock.ItemMaterialCode,  " +
//                        "             mst_item_material.Name AS ItemMaterialName,  " +
//                        "             mst_item_material.InventoryType AS inventoryType,  " +
//                        "             mst_item_material.UnitOfMeasureCode AS unitOfMeasureCode,  " +
//                        "             mst_item_material_jn_current_stock.ActualStock,  " +
//                        "             mst_item_material_jn_current_stock.ActualStock AS quantity,  " +
//                        "             mst_item_material_jn_current_stock.RackCode,  " +
//                        "             mst_rack.name AS RackName " +
//                        "FROM mst_item_material_jn_current_stock   " +
//                        "INNER JOIN mst_rack ON mst_item_material_jn_current_stock.RackCode = mst_rack.code   " +
//                        "INNER JOIN mst_item_material ON mst_item_material_jn_current_stock.itemMaterialCode = mst_item_material.code   " +
//                        "INNER JOIN mst_unit_of_measure ON mst_item_material.UnitOfMeasureCode = mst_unit_of_measure.code " +
//                        "INNER JOIN mst_warehouse ON mst_item_material_jn_current_stock.warehouseCode = mst_warehouse.code " +
//                        "WHERE mst_item_material_jn_current_stock.ItemMaterialCode IN("+strArrItemMaterialCode+")  " +
//                        "AND mst_item_material_jn_current_stock.WarehouseCode= :prmWarehouseCode " +
//                        "AND mst_item_material_jn_current_stock.ActualStock > 0  " +
//                        " " +
//                        "UNION ALL " +
//                        " " +
//                        "SELECT    " +
//                        "	    ivt_assembly_realization_cogs.ItemMaterialCode,    " +
//                        "	    mst_item_material.Name AS ItemMaterialName,   " +
//                        "	    mst_item_material.InventoryType AS inventoryType,   " +
//                        "	    mst_item_material.UnitOfMeasureCode AS unitOfMeasureCode,     " +
//                        "	    0 AS ActualStock,   " +
//                        "	    ivt_assembly_realization_cogs.Quantity AS quantity,    " +
//                        "	    ivt_assembly_realization_cogs.RackCode,    " +
//                        "	    mst_rack.Name AS rackName   " +
//                        "FROM ivt_assembly_realization_cogs " +
//                        "INNER JOIN mst_item_material ON ivt_assembly_realization_cogs.ItemMaterialCode=mst_item_material.Code    " +
//                        "INNER JOIN mst_rack ON mst_rack.Code=ivt_assembly_realization_cogs.RackCode    " +
//                        "WHERE ivt_assembly_realization_cogs.headerCode = :prmHeaderCode   " +
//                        "AND ivt_assembly_realization_cogs.ItemMaterialCode IN("+strArrItemMaterialCode+") " +
//                        ")AS qwerty " +
//                        "ORDER BY qwerty.ItemMaterialCode";
//            
//            Query q = hbmSession.hSession.createSQLQuery(qry)
//                    .addScalar("itemMaterialCode", Hibernate.STRING)
//                    .addScalar("itemName", Hibernate.STRING)
//                    .addScalar("inventoryType", Hibernate.STRING)
//                    .addScalar("unitOfMeasureCode", Hibernate.STRING)
//                    .addScalar("actualStock",Hibernate.DOUBLE)
//                    .addScalar("quantity",Hibernate.DOUBLE)
//                    .addScalar("rackCode",Hibernate.STRING)
//                    .addScalar("rackName",Hibernate.STRING)
//                    .setParameter("prmWarehouseCode", lstInventoryActualStock.get(0).getWarehouse().getCode())
//                    .setParameter("prmHeaderCode", lstInventoryActualStock.get(0).getTransactionCode())
//                    .setResultTransformer(Transformers.aliasToBean(IvtActualStock.class));
//            List<IvtActualStock> list =  q.list();
//            
//            return list;
//        }catch(Exception e){
//            e.printStackTrace();
//            return null;
//        }
//    }
    
    public List<IvtActualStock> findDataByPickingListSOItemMaterial(List<InventoryActualStockTemp> lstInventoryActualStockTemp) throws Exception {
        try { 
            
            BigDecimal itemQuantityTotal;
            
//            for(InventoryActualStock inventoryActualStock:lstInventoryActualStock){
//                itemQuantityTotal = getActualCurrentStockTotal(inventoryActualStock.getBranchCode(), inventoryActualStock.getWarehouse().getCode(), inventoryActualStock.getItemMaterial().getCode());
//                if (itemQuantityTotal < inventoryActualStock.getBookedStock()) {
//                    hbmSession.hTransaction.rollback();
//                    throw new Exception("Quantity ItemMaterial "+inventoryActualStock.getItemMaterial().getCode()+"is not enough");
//                }
//            }
                               
            List<IvtActualStock> listInvActualStock = getActualCurrentStock(lstInventoryActualStockTemp);
            
            BigDecimal actualStockQuantity =new BigDecimal(BigInteger.ZERO);
            BigDecimal usedStockQuantity = new BigDecimal(BigInteger.ZERO);
            BigDecimal bookedStock = new BigDecimal(BigInteger.ZERO);
            
            if (listInvActualStock.size() > 0) {
                for(InventoryActualStockTemp inventoryActualStock : lstInventoryActualStockTemp){
//                    bookedStock=0;//inventoryActualStock.getBookedStock();
                    bookedStock=new BigDecimal(BigInteger.ZERO);
                    for (IvtActualStock invActualStock : listInvActualStock) {
                        if(invActualStock.getItemMaterialCode().equals(inventoryActualStock.getItemMaterialCode())){
                            actualStockQuantity = invActualStock.getActualStock();
                                
                                if (actualStockQuantity.compareTo(BigDecimal.ZERO) > 0) {
                                    if ((bookedStock.subtract(actualStockQuantity)).compareTo(BigDecimal.ZERO) > 0) {
                                        usedStockQuantity = actualStockQuantity;
                                    } else {
                                        usedStockQuantity = bookedStock;
                                    }
                                    
                                    invActualStock.setQuantity(usedStockQuantity);
                                    
                                    bookedStock.subtract(usedStockQuantity);
                                }
                                
                                if (bookedStock.compareTo(BigDecimal.ZERO) <= 0) {
                                    break;
                                }
//                                if (actualStockQuantity > 0) {
//                                    if (( bookedStock- actualStockQuantity) > 0) {
//                                        usedStockQuantity = actualStockQuantity;
//                                    } else {
//                                        usedStockQuantity = bookedStock;
//                                    }
//                                    
//                                    invActualStock.setQuantity(usedStockQuantity);
//                                    
//                                    bookedStock -= usedStockQuantity;
//                                }
//                                
//                                if (bookedStock <= 0) {
//                                    break;
//                                }
                        }
                    }
                 }
                 
            }

            return listInvActualStock;
        }
        catch (HibernateException e) {
            e.printStackTrace();
            throw e;
        }
    }
    
    public List<IvtActualStock> findDataByPickingListSCItemMaterial(List<InventoryActualStockTemp> lstInventoryActualStockTemp) throws Exception {
        try { 
            
            BigDecimal itemQuantityTotal;
            
//            for(InventoryActualStock inventoryActualStock:lstInventoryActualStock){
//                itemQuantityTotal = getActualCurrentStockTotal(inventoryActualStock.getBranchCode(), inventoryActualStock.getWarehouse().getCode(), inventoryActualStock.getItemMaterial().getCode());
//                if (itemQuantityTotal < inventoryActualStock.getBookedStock()) {
//                    hbmSession.hTransaction.rollback();
//                    throw new Exception("Quantity ItemMaterial "+inventoryActualStock.getItemMaterial().getCode()+"is not enough");
//                }
//            }
                               
            List<IvtActualStock> listInvActualStock = getActualCurrentStockSC(lstInventoryActualStockTemp);
            
            BigDecimal actualStockQuantity =new BigDecimal(BigInteger.ZERO);
            BigDecimal usedStockQuantity = new BigDecimal(BigInteger.ZERO);
            BigDecimal bookedStock = new BigDecimal(BigInteger.ZERO);
            
            if (listInvActualStock.size() > 0) {
                for(InventoryActualStockTemp inventoryActualStock : lstInventoryActualStockTemp){
//                    bookedStock=0;//inventoryActualStock.getBookedStock();
                    bookedStock=new BigDecimal(BigInteger.ZERO);
                    for (IvtActualStock invActualStock : listInvActualStock) {
                        if(invActualStock.getItemMaterialCode().equals(inventoryActualStock.getItemMaterialCode())){
                            actualStockQuantity = invActualStock.getActualStock();
                                
                                if (actualStockQuantity.compareTo(BigDecimal.ZERO) > 0) {
                                    if ((bookedStock.subtract(actualStockQuantity)).compareTo(BigDecimal.ZERO) > 0) {
                                        usedStockQuantity = actualStockQuantity;
                                    } else {
                                        usedStockQuantity = bookedStock;
                                    }
                                    
                                    invActualStock.setQuantity(usedStockQuantity);
                                    
                                    bookedStock.subtract(usedStockQuantity);
                                }
                                
                                if (bookedStock.compareTo(BigDecimal.ZERO) <= 0) {
                                    break;
                                }
//                                if (actualStockQuantity > 0) {
//                                    if (( bookedStock- actualStockQuantity) > 0) {
//                                        usedStockQuantity = actualStockQuantity;
//                                    } else {
//                                        usedStockQuantity = bookedStock;
//                                    }
//                                    
//                                    invActualStock.setQuantity(usedStockQuantity);
//                                    
//                                    bookedStock -= usedStockQuantity;
//                                }
//                                
//                                if (bookedStock <= 0) {
//                                    break;
//                                }
                        }
                    }
                 }
                 
            }

            return listInvActualStock;
        }
        catch (HibernateException e) {
            e.printStackTrace();
            throw e;
        }
    }
    
    public List<IvtActualStock> getActualCurrentStockAssemblyRealization(List<InventoryActualStock> lstInventoryActualStock){
        try{
            String strArrItemMaterialCode="";
            int x=0;
            for(InventoryActualStock inventoryActualStock:lstInventoryActualStock){
                if(x==0){
                    strArrItemMaterialCode="'"+inventoryActualStock.getItemMaterial().getCode()+"'";
                }else{
                    strArrItemMaterialCode+=",'"+inventoryActualStock.getItemMaterial().getCode()+"'";
                }
                x++;
            }
            
            String qry = "SELECT qwerty.* FROM " +
                        "(SELECT   " +
                        "             mst_item_material_jn_current_stock.ItemMaterialCode,  " +
                        "             mst_item_material.Name AS ItemMaterialName,  " +
                        "             mst_item_material.InventoryType AS inventoryType,  " +
                        "             mst_item_material.UnitOfMeasureCode AS unitOfMeasureCode,  " +
                        "             mst_item_material_jn_current_stock.ActualStock,  " +
                        "             mst_item_material_jn_current_stock.ActualStock AS quantity,  " +
                        "             mst_item_material_jn_current_stock.RackCode,  " +
                        "             mst_rack.name AS RackName " +
                        "FROM mst_item_material_jn_current_stock   " +
                        "INNER JOIN mst_rack ON mst_item_material_jn_current_stock.RackCode = mst_rack.code   " +
                        "INNER JOIN mst_item_material ON mst_item_material_jn_current_stock.itemMaterialCode = mst_item_material.code   " +
                        "INNER JOIN mst_unit_of_measure ON mst_item_material.UnitOfMeasureCode = mst_unit_of_measure.code " +
                        "INNER JOIN mst_warehouse ON mst_item_material_jn_current_stock.warehouseCode = mst_warehouse.code " +
                        "WHERE mst_item_material_jn_current_stock.ItemMaterialCode IN("+strArrItemMaterialCode+")  " +
                        "AND mst_item_material_jn_current_stock.WarehouseCode= :prmWarehouseCode " +
                        "AND mst_item_material_jn_current_stock.ActualStock > 0  " +
                        " " +
                        "UNION ALL " +
                        " " +
                        "SELECT    " +
                        "	    ivt_assembly_realization_cogs.ItemMaterialCode,    " +
                        "	    mst_item_material.Name AS ItemMaterialName,   " +
                        "	    mst_item_material.InventoryType AS inventoryType,   " +
                        "	    mst_item_material.UnitOfMeasureCode AS unitOfMeasureCode,     " +
                        "	    0 AS ActualStock,   " +
                        "	    ivt_assembly_realization_cogs.Quantity AS quantity,    " +
                        "	    ivt_assembly_realization_cogs.RackCode,    " +
                        "	    mst_rack.Name AS rackName   " +
                        "FROM ivt_assembly_realization_cogs " +
                        "INNER JOIN mst_item_material ON ivt_assembly_realization_cogs.ItemMaterialCode=mst_item_material.Code    " +
                        "INNER JOIN mst_rack ON mst_rack.Code=ivt_assembly_realization_cogs.RackCode    " +
                        "WHERE ivt_assembly_realization_cogs.headerCode = :prmHeaderCode   " +
                        "AND ivt_assembly_realization_cogs.ItemMaterialCode IN("+strArrItemMaterialCode+") " +
                        ")AS qwerty " +
                        "ORDER BY qwerty.ItemMaterialCode";
            
            Query q = hbmSession.hSession.createSQLQuery(qry)
                    .addScalar("itemMaterialCode", Hibernate.STRING)
                    .addScalar("itemName", Hibernate.STRING)
                    .addScalar("inventoryType", Hibernate.STRING)
                    .addScalar("unitOfMeasureCode", Hibernate.STRING)
                    .addScalar("actualStock",Hibernate.BIG_DECIMAL)
                    .addScalar("quantity",Hibernate.BIG_DECIMAL)
                    .addScalar("rackCode",Hibernate.STRING)
                    .addScalar("rackName",Hibernate.STRING)
                    .setParameter("prmWarehouseCode", lstInventoryActualStock.get(0).getWarehouse().getCode())
                    .setParameter("prmHeaderCode", lstInventoryActualStock.get(0).getTransactionCode())
                    .setResultTransformer(Transformers.aliasToBean(IvtActualStock.class));
            List<IvtActualStock> list =  q.list();
            
            return list;
        }catch(Exception e){
            e.printStackTrace();
            return null;
        }
    }
    
    public List<IvtActualStock> findDataByAssemblyRealization(List<InventoryActualStock> lstInventoryActualStock) throws Exception {
        try { 
            
            BigDecimal itemQuantityTotal;
            
            for(InventoryActualStock inventoryActualStock:lstInventoryActualStock){
                
            //    BigDecimal conversion = unitOfMeasureConversionDAO.getConversionByItemMaterialCode(inventoryActualStock.getItemMaterial().getCode());
                
                itemQuantityTotal = getActualCurrentStockTotalAssemblyRealization(inventoryActualStock.getWarehouse().getCode(), 
                inventoryActualStock.getItemMaterial().getCode(),inventoryActualStock.getTransactionCode());
            //    itemQuantityTotal = itemQuantityTotal/conversion.BigDecimalValue();
                itemQuantityTotal = itemQuantityTotal;
                
                if (itemQuantityTotal.compareTo(inventoryActualStock.getActualStock()) == -1) {
                    hbmSession.hTransaction.rollback();
                    throw new Exception("<b><br/>Quantity ItemMaterial is not enough <br/>ItemMaterial Code : "+inventoryActualStock.getItemMaterial().getCode()+"<br/>&nbsp&nbsp&nbsp ItemMaterial Name :"+inventoryActualStock.getItemMaterial().getName()+"<br/>&nbsp&nbsp&nbsp Current Stock : "+itemQuantityTotal+"<br/>&nbsp&nbsp Request Qty : "+ inventoryActualStock.getActualStock()+"</b>");
                }
            }
                               
            List<IvtActualStock> listInvActualStock = getActualCurrentStockAssemblyRealization(lstInventoryActualStock);

            List<IvtActualStock> listInvActualStockReturn = new ArrayList<IvtActualStock>();
            BigDecimal actualStockQuantity = new BigDecimal('0');
            BigDecimal usedStockQuantity = new BigDecimal('0');
            BigDecimal bookedStock = new BigDecimal('0');
            int nol, need, stock;
            BigDecimal result;
            
            if (listInvActualStock.size() > 0) {
                for(InventoryActualStock inventoryActualStock:lstInventoryActualStock){
                    
                //    BigDecimal conversion = unitOfMeasureConversionDAO.getConversionByItemMaterialCode(inventoryActualStock.getItemMaterial().getCode());
                    
                    bookedStock=inventoryActualStock.getActualStock();
                    for (IvtActualStock invActualStock : listInvActualStock) {
                        if(invActualStock.getItemMaterialCode().equals(inventoryActualStock.getItemMaterial().getCode())){
                            actualStockQuantity=invActualStock.getQuantity();
                            nol = actualStockQuantity.compareTo(BigDecimal.ZERO);
                            stock = bookedStock.compareTo(BigDecimal.ZERO);
                            result =bookedStock.subtract(actualStockQuantity);
                            need = result.compareTo(BigDecimal.ZERO);
                            
                                if (nol == 1) {
                                    if (need == 1) {
                                        usedStockQuantity = actualStockQuantity;
                                    } else {
                                        usedStockQuantity = bookedStock;
                                    }
                                    
                                    bookedStock = bookedStock.subtract(usedStockQuantity);
                                    
                                    invActualStock.setQuantity(usedStockQuantity);
                                    
                                    
                                    listInvActualStockReturn.add(invActualStock);
                                }
                                
                                if (stock == -1) {
                                    break;
                                }
                        }
                    }
                 }
                 
            }
            
            return listInvActualStockReturn;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

}
