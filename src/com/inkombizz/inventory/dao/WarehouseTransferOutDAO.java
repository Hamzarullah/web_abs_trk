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
import com.inkombizz.inventory.model.WarehouseTransferOut;
import com.inkombizz.inventory.model.WarehouseTransferOutItemDetail;
import com.inkombizz.inventory.model.WarehouseTransferOutItemDetailTemp;
import com.inkombizz.inventory.model.WarehouseTransferOutTemp;
//import com.inkombizz.master.dao.UnitOfMeasureConversionDAO;
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


public class WarehouseTransferOutDAO {
    
    private HBMSession hbmSession;
    
    public WarehouseTransferOutDAO(HBMSession session) {
        this.hbmSession = session;
    }

    public int countData(Date firstDate, Date lastDate,String code,String warehouseCode,String warehouseName,String refNo,String remark) {
        try {

            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");

            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);

            BigInteger temp = (BigInteger) hbmSession.hSession.createSQLQuery(
                    "SELECT  "
                    + "COUNT(*) "
                    + "FROM ivt_warehouse_transfer_out "
                    + "INNER JOIN mst_branch ON ivt_warehouse_transfer_out.BranchCode=mst_branch.Code "
                    + "INNER JOIN mst_warehouse sourceWarehouse ON sourceWarehouse.Code=ivt_warehouse_transfer_out.SourceWarehouseCode "
                    + "INNER JOIN mst_warehouse destinationWarehouse ON destinationWarehouse.Code=ivt_warehouse_transfer_out.DestinationWarehouseCode "
                    + "WHERE ivt_warehouse_transfer_out.code LIKE '%" + code + "%' "
                    + "AND DATE(ivt_warehouse_transfer_out.TransactionDate) BETWEEN '" + dateFirst + "' AND '" + dateLast + "'"
            ).uniqueResult();

            return temp.intValue();

        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    public List<WarehouseTransferOutTemp> findData(Date firstDate, Date lastDate,String code,String warehouseCode,String warehouseName,String refNo,String remark, int from, int to) {
        try {

            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");

            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);

            List<WarehouseTransferOutTemp> list = (List<WarehouseTransferOutTemp>) hbmSession.hSession.createSQLQuery(
                    "SELECT "
                    + "ivt_warehouse_transfer_out.Code, "
                    + "ivt_warehouse_transfer_out.BranchCode, "
                    + "mst_branch.Name AS branchName, "
                    + "ivt_warehouse_transfer_out.TransactionDate, "
                    + "ivt_warehouse_transfer_out.TransactionDate, "
                    + "ivt_warehouse_transfer_out.SourceWarehouseCode, "
                    + "sourceWarehouse.Name AS SourceWarehouseName, "
                    + "ivt_warehouse_transfer_out.DestinationWarehouseCode, "
                    + "destinationWarehouse.Name AS DestinationWarehouseName, "
                    + "ivt_warehouse_transfer_out.Refno, "
                    + "ivt_warehouse_transfer_out.Remark "
                    + "FROM ivt_warehouse_transfer_out "
                    + "INNER JOIN mst_branch ON ivt_warehouse_transfer_out.BranchCode=mst_branch.Code "
                    + "INNER JOIN mst_warehouse sourceWarehouse ON sourceWarehouse.Code=ivt_warehouse_transfer_out.SourceWarehouseCode "
                    + "INNER JOIN mst_warehouse destinationWarehouse ON destinationWarehouse.Code=ivt_warehouse_transfer_out.DestinationWarehouseCode "
                    + "WHERE ivt_warehouse_transfer_out.code LIKE '%" + code + "%' "
                    + "AND DATE(ivt_warehouse_transfer_out.TransactionDate) BETWEEN '" + dateFirst + "' AND '" + dateLast + "' "
                    + "ORDER BY ivt_warehouse_transfer_out.TransactionDate DESC "
                    + "LIMIT " + from + "," + to + "")
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("branchCode", Hibernate.STRING)
                    .addScalar("branchName", Hibernate.STRING)
                    .addScalar("transactionDate", Hibernate.TIMESTAMP)
                    .addScalar("sourceWarehouseCode", Hibernate.STRING)
                    .addScalar("sourceWarehouseName", Hibernate.STRING)
                    .addScalar("destinationWarehouseCode", Hibernate.STRING)
                    .addScalar("destinationWarehouseName", Hibernate.STRING)
                    .addScalar("refNo", Hibernate.STRING)
                    .addScalar("remark", Hibernate.STRING)
                    .setResultTransformer(Transformers.aliasToBean(WarehouseTransferOutTemp.class))
                    .list();

            return list;
        } catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<WarehouseTransferOutItemDetailTemp> findItemDetailSourceData(String code) {
        try {

            List<WarehouseTransferOutItemDetailTemp> list = (List<WarehouseTransferOutItemDetailTemp>) hbmSession.hSession.createSQLQuery(
                    "SELECT "
                    + "ivt_warehouse_transfer_out_item_detail.Code, "
                    + "ivt_warehouse_transfer_out_item_detail.ItemCode AS ItemMaterialCode, "
                    + "mst_item_material.Name AS ItemMaterialName, "
                    + "mst_item_material.UnitOfMeasureCode AS ItemMaterialUnitOfMeasureCode, "
                    + "mst_item_material.InventoryType AS ItemMaterialInventoryType, "
                    + "ivt_warehouse_transfer_out_item_detail.ReasonCode, "
                    + "mst_reason.Name AS reasonName, "
                    + "ivt_warehouse_transfer_out_item_detail.Quantity, "
                    + "ivt_warehouse_transfer_out_item_detail.COGSIDR AS cogsIdr, "
                    + "ivt_warehouse_transfer_out_item_detail.TotalAmount, "
                    + "ivt_warehouse_transfer_out_item_detail.RackCode AS rackCode, "
                    + "mst_rack.Name AS rackName, "
                    + "dest.Code AS destinationRackCode, "
                    + "dest.Name AS destinationRackName, "
                    + "mst_item_jn_current_stock.`ActualStock`, "
                    + "ivt_warehouse_transfer_out_item_detail.Remark "
                    + "FROM ivt_warehouse_transfer_out_item_detail "
                    + "INNER JOIN mst_item_material ON ivt_warehouse_transfer_out_item_detail.ItemCode=mst_item_material.Code "
                    + "INNER JOIN mst_reason ON mst_reason.Code=ivt_warehouse_transfer_out_item_detail.ReasonCode "    
                    + "LEFT JOIN mst_item_jn_current_stock ON mst_item_jn_current_stock.`ItemCode`=ivt_warehouse_transfer_out_item_detail.`ItemCode` "
                    + "LEFT JOIN ivt_warehouse_transfer_out ON ivt_warehouse_transfer_out.`SourceWarehouseCode`=mst_item_jn_current_stock.`WarehouseCode` "
                    + "INNER JOIN mst_rack ON mst_rack.Code=ivt_warehouse_transfer_out_item_detail.RackCode "
                    + "INNER JOIN mst_rack dest ON ivt_warehouse_transfer_out.DestinationWarehouseCode=dest.`WarehouseCode` "
                    + "WHERE ivt_warehouse_transfer_out_item_detail.headerCode = '"+ code + "' group by ivt_warehouse_transfer_out_item_detail.`ItemCode` ")
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("itemMaterialCode", Hibernate.STRING)
                    .addScalar("itemMaterialName", Hibernate.STRING)
                    .addScalar("itemMaterialUnitOfMeasureCode",Hibernate.STRING)
                    .addScalar("itemMaterialInventoryType",Hibernate.STRING)
                    .addScalar("reasonCode", Hibernate.STRING)
                    .addScalar("reasonName", Hibernate.STRING)
                    .addScalar("quantity", Hibernate.BIG_DECIMAL)
                    .addScalar("cogsIdr",Hibernate.BIG_DECIMAL)
                    .addScalar("totalAmount",Hibernate.BIG_DECIMAL)
                    .addScalar("actualStock",Hibernate.BIG_DECIMAL)
                    .addScalar("rackCode", Hibernate.STRING)
                    .addScalar("rackName", Hibernate.STRING)
                    .addScalar("destinationRackCode", Hibernate.STRING)
                    .addScalar("destinationRackName", Hibernate.STRING)
                    .addScalar("remark", Hibernate.STRING)
                    .setResultTransformer(Transformers.aliasToBean(WarehouseTransferOutItemDetailTemp.class))
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

    private String createCode(WarehouseTransferOut warehouseTransferOut) {
        try {
            
            String tempKode =warehouseTransferOut.getBranch().getCode()+ "/" + EnumTransactionType.ENUM_TransactionType.WHTO.toString();
            String acronim = tempKode + "/"+ AutoNumber.formatingDate(warehouseTransferOut.getTransactionDate(), true, true, false);

            DetachedCriteria dc = DetachedCriteria.forClass(WarehouseTransferOut.class)
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

    public void save(WarehouseTransferOut warehouseTransferOut, 
            List<WarehouseTransferOutItemDetail> listWarehouseTransferOutItemDetail,
            String MODULECODE) throws Exception {
        try {

            String headerCode = createCode(warehouseTransferOut);

            hbmSession.hSession.beginTransaction();

            warehouseTransferOut.setCode(headerCode);
            warehouseTransferOut.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            warehouseTransferOut.setCreatedDate(new Date());
            
            hbmSession.hSession.save(warehouseTransferOut);
            InventoryInOutDAO inventoryInOutDAO=new InventoryInOutDAO(hbmSession);
            int nSource = 1;
            for (WarehouseTransferOutItemDetail warehouseTransferOutItemDetail : listWarehouseTransferOutItemDetail) {
                String detailCode = warehouseTransferOut.getCode() + "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(nSource), AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                warehouseTransferOutItemDetail.setCode(detailCode);
                warehouseTransferOutItemDetail.setHeaderCode(headerCode);
                warehouseTransferOutItemDetail.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                warehouseTransferOutItemDetail.setCreatedDate(new Date());
                warehouseTransferOutItemDetail.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
                warehouseTransferOutItemDetail.setUpdatedDate(new Date());
                
                hbmSession.hSession.save(warehouseTransferOutItemDetail);
                String branchCode;
                branchCode = warehouseTransferOut.getBranch().getCode();
                IvtActualStock newRec = new IvtActualStock();
                if(warehouseTransferOutItemDetail.getItemMaterial().getInventoryType().equals("INVENTORY")){
//                    newRec = InventoryCommon.newInstance(
//                            warehouseTransferOut.getSourceWarehouse().getCode(),
//                            branchCode, 
//                            warehouseTransferOutItemDetail.getItemMaterial().getCode(),
//                            warehouseTransferOutItemDetail.getQuantity(),
//                            warehouseTransferOutItemDetail.getRack().getCode());
//                    inventoryInOutDAO.ActualStockDecrease_AVG(newRec,false,warehouseTransferOut.getCode()+"-"+detailCode, EnumCOGSType.ENUM_COGSType.IIN,nSource);
                }
                nSource++;
            }
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(MODULECODE,
                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT),
                    warehouseTransferOut.getCode(), ""));
            hbmSession.hTransaction.commit();

        } catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }

    public void update(WarehouseTransferOut warehouseTransferOut,
            List<WarehouseTransferOutItemDetail> listWarehouseTransferOutItemDetail,
            String moduleCode) throws Exception {
        try {
            hbmSession.hSession.beginTransaction();

            warehouseTransferOut.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            warehouseTransferOut.setUpdatedDate(new Date());

            hbmSession.hSession.update(warehouseTransferOut);

            if (!updateDetail(warehouseTransferOut,listWarehouseTransferOutItemDetail)) {
                hbmSession.hTransaction.rollback();
            }
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode,
                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE),
                    warehouseTransferOut.getCode(), ""));

            hbmSession.hTransaction.commit();
        } catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
        }
    }

    private Boolean updateDetail(WarehouseTransferOut warehouseTransferOut,
            List<WarehouseTransferOutItemDetail> listWarehouseTransferOutItemDetail) throws Exception {
        try {
            
            List<WarehouseTransferOutItemDetailTemp> listSource = (List<WarehouseTransferOutItemDetailTemp>) findItemDetailSourceData(warehouseTransferOut.getCode());
            
            hbmSession.hSession.createSQLQuery("DELETE FROM ivt_warehouse_transfer_out_item_detail "
                    + " WHERE HeaderCode = :prmHeaderCode")
                    .setParameter("prmHeaderCode", warehouseTransferOut.getCode())
                    .executeUpdate();

            hbmSession.hSession.flush();
                        
            int nSource = 1;
            for (WarehouseTransferOutItemDetail warehouseTransferOutItemDetail : listWarehouseTransferOutItemDetail) {
                String detailCode = warehouseTransferOut.getCode() + "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(nSource), AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                warehouseTransferOutItemDetail.setCode(detailCode);
                warehouseTransferOutItemDetail.setHeaderCode(warehouseTransferOut.getCode());
                warehouseTransferOutItemDetail.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                warehouseTransferOutItemDetail.setCreatedDate(new Date());
                warehouseTransferOutItemDetail.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
                warehouseTransferOutItemDetail.setUpdatedDate(new Date());

                hbmSession.hSession.save(warehouseTransferOutItemDetail);
                 String branchCode;
                 branchCode = BaseSession.loadProgramSession().getBranchCode();
                for (WarehouseTransferOutItemDetailTemp oldWarehouseTransferOutItemDetail : listSource) {                    
                    if(warehouseTransferOutItemDetail.getItemMaterial().getCode().equals(oldWarehouseTransferOutItemDetail.getItemMaterialCode())
                            & warehouseTransferOutItemDetail.getRack().getCode().equals(oldWarehouseTransferOutItemDetail.getRackCode())
                            & warehouseTransferOutItemDetail.getItemMaterial().getInventoryType().equals("INVENTORY")){
                        InventoryInOutDAO inventoryInOutDAO=new InventoryInOutDAO(hbmSession);
                        IvtActualStock newRec = new IvtActualStock();
                        newRec = InventoryCommon.newInstance(
                                warehouseTransferOut.getSourceWarehouse().getCode(),
                                branchCode, warehouseTransferOutItemDetail.getItemMaterial().getCode(),
                                warehouseTransferOutItemDetail.getQuantity(),oldWarehouseTransferOutItemDetail.getQuantity(),warehouseTransferOutItemDetail.getRack().getCode());
//                        inventoryInOutDAO.ActualStockDecrease_AVG(newRec,true,warehouseTransferOut.getCode()+"-"+detailCode, EnumCOGSType.ENUM_COGSType.IIN,nSource);
                    }
                }
                
                hbmSession.hSession.flush();
                
                nSource++;
            }
            
            return Boolean.TRUE;

        } catch (HibernateException e) {
            e.printStackTrace();
            return Boolean.FALSE;
        }
    }
    
    public void delete(String code, String MODULECODE) throws Exception {
        try {
            hbmSession.hSession.beginTransaction();
            
            WarehouseTransferOut warehouseTransferOut = (WarehouseTransferOut) hbmSession.hSession.get(WarehouseTransferOut.class, code);
            
            List<WarehouseTransferOutItemDetailTemp> listSource = (List<WarehouseTransferOutItemDetailTemp>) findItemDetailSourceData(code);
            
            hbmSession.hSession.createQuery("DELETE FROM WarehouseTransferOutItemDetail "
                    + " WHERE headerCode = :prmHeaderCode")
                    .setParameter("prmHeaderCode", code)
                    .executeUpdate();

            hbmSession.hSession.flush();
           

            hbmSession.hSession.createQuery("DELETE FROM WarehouseTransferOut "
                    + " WHERE code  = :prmCode")
                    .setParameter("prmCode", code)
                    .executeUpdate();
            
            hbmSession.hSession.flush();
            String branchCode;
            branchCode = BaseSession.loadProgramSession().getBranchCode();
            int nSource = 1;
            for (WarehouseTransferOutItemDetailTemp warehouseTransferOutItemDetail : listSource) {
                if(warehouseTransferOutItemDetail.getItemMaterialInventoryType().equals("INVENTORY")){
                    InventoryInOutDAO inventoryInOutDAO=new InventoryInOutDAO(hbmSession);
                    IvtActualStock newRec = new IvtActualStock();
                        String detailCode = warehouseTransferOut.getCode() + "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(nSource), AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
            
//                    newRec = InventoryCommon.newInstance(
//                            warehouseTransferOut.getSourceWarehouse().getCode(),
//                            branchCode,
//                            warehouseTransferOutItemDetail.getItemMaterialCode(),
//                            warehouseTransferOutItemDetail.getQuantity(),
//                            warehouseTransferOutItemDetail.getRackCode()
//                    );
//                    
//                    inventoryInOutDAO.ActualStockIncrease_AVG(newRec,false,false,warehouseTransferOut.getCode()+"-"+detailCode, EnumCOGSType.ENUM_COGSType.IIN,nSource);
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
    
    public int searchCountDataWHTO(Date firstDate, Date lastDate,String code,String warehouseCode,String warehouseName,String refNo,String remark) {
        try {

            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");

            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);

            BigInteger temp = (BigInteger) hbmSession.hSession.createSQLQuery(
                    "SELECT  "
                    + "COUNT(*) "
                    + "FROM ivt_warehouse_transfer_out "
                    + "LEFT JOIN ivt_warehouse_transfer_in ON ivt_warehouse_transfer_in.WarehouseTransferOutCode=ivt_warehouse_transfer_out.Code "
                    + "INNER JOIN mst_branch ON ivt_warehouse_transfer_out.BranchCode=mst_branch.Code "
                    + "INNER JOIN mst_warehouse sourceWarehouse ON sourceWarehouse.Code=ivt_warehouse_transfer_out.SourceWarehouseCode "
                    + "INNER JOIN mst_warehouse destinationWarehouse ON destinationWarehouse.Code=ivt_warehouse_transfer_out.DestinationWarehouseCode "
                    + "WHERE ivt_warehouse_transfer_out.code LIKE '%" + code + "%' "
                    + "AND DATE(ivt_warehouse_transfer_out.TransactionDate) BETWEEN '" + dateFirst + "' AND '" + dateLast + "' "
                    + "AND ivt_warehouse_transfer_in.Code IS NULL "
            ).uniqueResult();

            return temp.intValue();

        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<WarehouseTransferOutTemp> searchDataWHTO(Date firstDate, Date lastDate,String code,String warehouseCode,String warehouseName,String refNo,String remark, int from, int to) {
        try {

            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");

            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);

            List<WarehouseTransferOutTemp> list = (List<WarehouseTransferOutTemp>) hbmSession.hSession.createSQLQuery(
                    "SELECT "
                    + "ivt_warehouse_transfer_out.Code, "
                    + "ivt_warehouse_transfer_out.BranchCode, "
                    + "mst_branch.Name AS branchName, "
                    + "ivt_warehouse_transfer_out.TransactionDate, "
                    + "ivt_warehouse_transfer_out.SourceWarehouseCode, "
                    + "sourceWarehouse.Name AS sourceWarehouseName, "
                    + "ivt_warehouse_transfer_out.DestinationWarehouseCode, "
                    + "destinationWarehouse.Name AS DestinationWarehouseName, "
                    + "ivt_warehouse_transfer_out.Refno, "
                    + "ivt_warehouse_transfer_out.Remark "
                    + "FROM ivt_warehouse_transfer_out "
                    + "LEFT JOIN ivt_warehouse_transfer_in ON ivt_warehouse_transfer_in.WarehouseTransferOutCode=ivt_warehouse_transfer_out.Code "
                    + "INNER JOIN mst_branch ON ivt_warehouse_transfer_out.BranchCode=mst_branch.Code "
                    + "INNER JOIN mst_warehouse sourceWarehouse ON sourceWarehouse.Code=ivt_warehouse_transfer_out.SourceWarehouseCode "
                    + "INNER JOIN mst_warehouse destinationWarehouse ON destinationWarehouse.Code=ivt_warehouse_transfer_out.DestinationWarehouseCode "
                    + "WHERE ivt_warehouse_transfer_out.code LIKE '%" + code + "%' "
                    + "AND DATE(ivt_warehouse_transfer_out.TransactionDate) BETWEEN '" + dateFirst + "' AND '" + dateLast + "' "
                    + "AND ivt_warehouse_transfer_in.Code IS NULL "
                    + "ORDER BY ivt_warehouse_transfer_out.TransactionDate DESC "
                    + "LIMIT " + from + "," + to + "")
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("branchCode", Hibernate.STRING)
                    .addScalar("branchName", Hibernate.STRING)
                    .addScalar("transactionDate", Hibernate.TIMESTAMP)
                    .addScalar("sourceWarehouseCode", Hibernate.STRING)
                    .addScalar("sourceWarehouseName", Hibernate.STRING)
                    .addScalar("destinationWarehouseCode", Hibernate.STRING)
                    .addScalar("destinationWarehouseName", Hibernate.STRING)
                    .addScalar("refNo", Hibernate.STRING)
                    .addScalar("remark", Hibernate.STRING)
                    .setResultTransformer(Transformers.aliasToBean(WarehouseTransferOutTemp.class))
                    .list();

            return list;
        } catch (HibernateException e) {
            throw e;
        }
    }
}
