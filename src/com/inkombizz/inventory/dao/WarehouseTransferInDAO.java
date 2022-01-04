/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.inventory.dao;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.InventoryCommon;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumCOGSType;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.common.enumeration.EnumTransactionType;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.dao.common.AutoNumber;
import com.inkombizz.inventory.model.IvtActualStock;
import com.inkombizz.inventory.model.WarehouseTransferIn;
import com.inkombizz.inventory.model.WarehouseTransferInItemDetail;
import com.inkombizz.inventory.model.WarehouseTransferInItemDetailTemp;
import com.inkombizz.inventory.model.WarehouseTransferInTemp;
//import com.inkombizz.master.dao.UnitOfMeasureConversionDAO;
import com.inkombizz.master.model.ItemBrand;
import com.inkombizz.system.dao.TransactionLogDAO;
import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.transform.Transformers;

/**
 *
 * @author egie
 */
public class WarehouseTransferInDAO {
    
    private HBMSession hbmSession;
    private InventoryInOutDAO inventoryInOutDAO;
//    private UnitOfMeasureConversionDAO unitOfMeasureConversionDAO;
    
    public WarehouseTransferInDAO(HBMSession session) {
        this.hbmSession = session;
        this.inventoryInOutDAO = new InventoryInOutDAO(hbmSession);
//        this.unitOfMeasureConversionDAO = new UnitOfMeasureConversionDAO(session);
    }

    public int countData(Date firstDate, Date lastDate,String code,String warehouseCode,String warehouseName,String refNo,String remark) {
        try {
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");

            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);

            BigInteger temp = (BigInteger) hbmSession.hSession.createSQLQuery(
                    "SELECT  "
                    + "COUNT(*) "
                    + "FROM ivt_warehouse_transfer_in "
                    + "INNER JOIN ivt_warehouse_transfer_out ON ivt_warehouse_transfer_in.WarehouseTransferOutCode=ivt_warehouse_transfer_out.Code "
                    + "INNER JOIN mst_branch ON ivt_warehouse_transfer_out.BranchCode=mst_branch.Code "
                    + "INNER JOIN mst_warehouse sourceWarehouse ON sourceWarehouse.Code=ivt_warehouse_transfer_out.SourceWarehouseCode "
                    + "INNER JOIN mst_warehouse destinationWarehouse ON destinationWarehouse.Code=ivt_warehouse_transfer_in.DestinationWarehouseCode "
                    + "WHERE ivt_warehouse_transfer_in.code LIKE '%" + code + "%' "
                    + "AND DATE(ivt_warehouse_transfer_in.TransactionDate) BETWEEN '" + dateFirst + "' AND '" + dateLast + "'"
            ).uniqueResult();

            return temp.intValue();

        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    public List<WarehouseTransferInTemp> findData(Date firstDate, Date lastDate,String code,String warehouseCode,String warehouseName,String refNo,String remark, int from, int to) {
        try {
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");

            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);

            List<WarehouseTransferInTemp> list = (List<WarehouseTransferInTemp>) hbmSession.hSession.createSQLQuery(
                    "SELECT "
                    + "ivt_warehouse_transfer_in.Code, "
                    + "ivt_warehouse_transfer_out.Code AS warehouseTransferOutCode, "
                    + "ivt_warehouse_transfer_out.BranchCode, "
                    + "mst_branch.Name AS branchName, "
                    + "ivt_warehouse_transfer_in.TransactionDate, "
                    + "ivt_warehouse_transfer_in.TransactionDate, "
                    + "sourceWarehouse.Code AS sourceWarehouseCode, "
                    + "sourceWarehouse.Name AS sourceWarehouseName, "        
                    + "destinationWarehouse.Code AS destinationWarehouseCode, "
                    + "destinationWarehouse.Name AS destinationWarehouseName, "
                    + "ivt_warehouse_transfer_in.Refno, "
                    + "ivt_warehouse_transfer_in.Remark "
                    + "FROM ivt_warehouse_transfer_in "
                    + "INNER JOIN ivt_warehouse_transfer_out ON ivt_warehouse_transfer_in.WarehouseTransferOutCode=ivt_warehouse_transfer_out.Code "
                    + "INNER JOIN mst_branch ON ivt_warehouse_transfer_out.BranchCode=mst_branch.Code "
                    + "INNER JOIN mst_warehouse sourceWarehouse ON sourceWarehouse.Code=ivt_warehouse_transfer_out.SourceWarehouseCode "
                    + "INNER JOIN mst_warehouse destinationWarehouse ON destinationWarehouse.Code=ivt_warehouse_transfer_in.DestinationWarehouseCode "
                    + "WHERE ivt_warehouse_transfer_in.code LIKE '%" + code + "%' "
                    + "AND DATE(ivt_warehouse_transfer_in.TransactionDate) BETWEEN '" + dateFirst + "' AND '" + dateLast + "' "
                    + "ORDER BY ivt_warehouse_transfer_in.TransactionDate DESC "
                    + "LIMIT " + from + "," + to + "")
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("warehouseTransferOutCode", Hibernate.STRING)
                    .addScalar("branchCode", Hibernate.STRING)
                    .addScalar("branchName", Hibernate.STRING)
                    .addScalar("transactionDate", Hibernate.TIMESTAMP)
                    .addScalar("sourceWarehouseCode", Hibernate.STRING)
                    .addScalar("sourceWarehouseName", Hibernate.STRING)
                    .addScalar("destinationWarehouseCode", Hibernate.STRING)
                    .addScalar("destinationWarehouseName", Hibernate.STRING)
                    .addScalar("refNo", Hibernate.STRING)
                    .addScalar("remark", Hibernate.STRING)
                    .setResultTransformer(Transformers.aliasToBean(WarehouseTransferInTemp.class))
                    .list();

            return list;
        } catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<WarehouseTransferInItemDetailTemp> findItemDetailDestinationData(String code) {
        try {

            List<WarehouseTransferInItemDetailTemp> list = (List<WarehouseTransferInItemDetailTemp>) hbmSession.hSession.createSQLQuery(
                    "SELECT "
                    + "ivt_warehouse_transfer_in_item_detail.Code, "
                    + "ivt_warehouse_transfer_in_item_detail.ItemCode AS itemMaterialCode, "
                    + "mst_item_material.Name AS itemMaterialName, "
                    + "mst_item_material.UnitOfMeasureCode AS ItemMaterialUnitOfMeasureCode, "
                    + "mst_item_material.InventoryType AS ItemMaterialInventoryType, "
                    + "ivt_warehouse_transfer_in_item_detail.Quantity, "
                    + "ivt_warehouse_transfer_in_item_detail.COGSIDR, "
                    + "ivt_warehouse_transfer_in_item_detail.TotalAmount, "
                    + "ivt_warehouse_transfer_in_item_detail.RackCode, "
                    + "mst_rack.Name AS rackName, "
                    + "ivt_warehouse_transfer_in_item_detail.Remark "
                    + "FROM ivt_warehouse_transfer_in_item_detail "
                    + "INNER JOIN mst_item_material ON ivt_warehouse_transfer_in_item_detail.ItemCode=mst_item_material.Code "
                    + "INNER JOIN mst_rack ON mst_rack.Code=ivt_warehouse_transfer_in_item_detail.RackCode "
                    + "WHERE ivt_warehouse_transfer_in_item_detail.headerCode = '"+ code + "' ")
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("itemMaterialCode", Hibernate.STRING)
                    .addScalar("itemMaterialName", Hibernate.STRING)
                    .addScalar("itemMaterialUnitOfMeasureCode",Hibernate.STRING)
                    .addScalar("itemMaterialInventoryType",Hibernate.STRING)
                    .addScalar("quantity", Hibernate.BIG_DECIMAL)
                    .addScalar("cogsIdr",Hibernate.BIG_DECIMAL)
                    .addScalar("totalAmount",Hibernate.BIG_DECIMAL)
                    .addScalar("rackCode", Hibernate.STRING)
                    .addScalar("rackName", Hibernate.STRING)
                    .addScalar("remark", Hibernate.STRING)
                    .setResultTransformer(Transformers.aliasToBean(WarehouseTransferInItemDetailTemp.class))
                    .list();

            return list;
        } catch (HibernateException e) {
            throw e;
        }
    }
  
    public int countByCriteria(DetachedCriteria dc) {
        try {
            Criteria criteria = dc.getExecutableCriteria(this.hbmSession.hSession);
            criteria.setProjection(Projections.rowCount());
            if (criteria.list().size() == 0) {
                return 0;
            } else {
                return ((Integer) criteria.list().get(0)).intValue();
            }
        } catch (HibernateException e) {
            throw e;
        }
    }

    public void save(WarehouseTransferIn warehouseTransferIn, 
            List<WarehouseTransferInItemDetail> listWarehouseTransferInItemDetail,
            String MODULECODE) throws Exception {
        try {

            String headerCode = createCode(warehouseTransferIn);
            hbmSession.hSession.beginTransaction();
            warehouseTransferIn.setCode(headerCode);
            warehouseTransferIn.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            warehouseTransferIn.setCreatedDate(new Date());
            
            hbmSession.hSession.save(warehouseTransferIn);

            int nDestination = 1;
            for (WarehouseTransferInItemDetail warehouseTransferInItemDetail : listWarehouseTransferInItemDetail) {
                
                String detailCode = warehouseTransferIn.getCode() + "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(nDestination), AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                warehouseTransferInItemDetail.setCode(detailCode);
                warehouseTransferInItemDetail.setHeaderCode(warehouseTransferIn.getCode());
                warehouseTransferInItemDetail.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                warehouseTransferInItemDetail.setCreatedDate(new Date());
                warehouseTransferInItemDetail.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
                warehouseTransferInItemDetail.setUpdatedDate(new Date());
                                
                hbmSession.hSession.save(warehouseTransferInItemDetail);
                String branchCode;
                branchCode = warehouseTransferIn.getWarehouseTransferOut().getBranch().getCode();
                if(warehouseTransferInItemDetail.getItemMaterial().getInventoryType().equals("INVENTORY")){
                    InventoryInOutDAO inventoryInOutDAO=new InventoryInOutDAO(hbmSession);
                    IvtActualStock newRec = new IvtActualStock();   
                    int actualStock_SortNo =0;
//                    newRec = InventoryCommon.newInstance(
//                    warehouseTransferIn.getDestinationWarehouse().getCode(),
//                    branchCode,
//                    warehouseTransferInItemDetail.getItemMaterial().getCode(),
//                    warehouseTransferInItemDetail.getQuantity(),
//                    warehouseTransferInItemDetail.getRack().getCode(),
//                    );
//                    
//                    inventoryInOutDAO.ActualStockIncrease_AVG(newRec,false,false,warehouseTransferIn.getCode()+"-"+detailCode, EnumCOGSType.ENUM_COGSType.IIN,actualStock_SortNo);
                }
                
                nDestination++;
            }
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(MODULECODE,
                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT),
                    warehouseTransferIn.getCode(), ""));
            hbmSession.hTransaction.commit();

        } catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void delete(String code, String MODULECODE) throws Exception {
        try {
            hbmSession.hSession.beginTransaction();
            
            WarehouseTransferIn warehouseTransferIn = (WarehouseTransferIn) hbmSession.hSession.get(WarehouseTransferIn.class, code);
            
            List<WarehouseTransferInItemDetailTemp> listSource = (List<WarehouseTransferInItemDetailTemp>) findItemDetailDestinationData(code);
            
            hbmSession.hSession.createQuery("DELETE FROM WarehouseTransferInItemDetail "
                    + " WHERE headerCode = :prmHeaderCode")
                    .setParameter("prmHeaderCode", code)
                    .executeUpdate();

            hbmSession.hSession.flush();
           

            hbmSession.hSession.createQuery("DELETE FROM WarehouseTransferIn "
                    + " WHERE code  = :prmCode")
                    .setParameter("prmCode", code)
                    .executeUpdate();
            
            hbmSession.hSession.flush();
            

            String branchCode;
            branchCode = BaseSession.loadProgramSession().getBranchCode();
            int i = 1;
            for (WarehouseTransferInItemDetailTemp warehouseTransferInItemDetail : listSource) {
                if(warehouseTransferInItemDetail.getItemMaterialInventoryType().equals("INVENTORY")){
                    InventoryInOutDAO inventoryInOutDAO=new InventoryInOutDAO(hbmSession);
                     String detailCode = warehouseTransferInItemDetail.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                
                    IvtActualStock newRec = new IvtActualStock();
                     int actualStock_SortNo =0;
//                    newRec = InventoryCommon.newInstance(
//                            warehouseTransferIn.getDestinationWarehouse().getCode(), 
//                            branchCode,
//                            warehouseTransferInItemDetail.getItemMaterialCode(),
//                            warehouseTransferInItemDetail.getQuantity(),
//                            warehouseTransferInItemDetail.getRackCode()
//                    );
                    
//                    inventoryInOutDAO.ActualStockDecrease_AVG(newRec,false,warehouseTransferInItemDetail.getCode()+"-"+detailCode, EnumCOGSType.ENUM_COGSType.IIN,actualStock_SortNo);
                }
            }
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(MODULECODE,
                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.DELETE),
                    code, ""));

            hbmSession.hTransaction.commit();

        } catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    private String createCode(WarehouseTransferIn warehouseTransferIn) {
        try {
            
            String tempKode =warehouseTransferIn.getWarehouseTransferOut().getBranch().getCode()+ "/" + EnumTransactionType.ENUM_TransactionType.WHTI.toString();
            String acronim = tempKode + "/"+ AutoNumber.formatingDate(warehouseTransferIn.getTransactionDate(), true, true, false);

            DetachedCriteria dc = DetachedCriteria.forClass(WarehouseTransferIn.class)
                    .setProjection(Projections.max("code"))
                    .add(Restrictions.like("code", acronim + "%"));

            Criteria criteria = dc.getExecutableCriteria(hbmSession.hSession);
            List list = criteria.list();

            String oldID = "";
            if (list != null) {
                if (list.size() > 0) {
                    if (list.get(0) != null) {
                        oldID = list.get(0).toString();
                    }
                }
            }
            return AutoNumber.generate(acronim, oldID, AutoNumber.DEFAULT_TRANSACTION_LENGTH_4);
        } catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }

}
