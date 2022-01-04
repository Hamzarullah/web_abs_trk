package com.inkombizz.inventory.dao;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.InventoryCommon;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumCOGSType;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.common.enumeration.EnumTransactionType;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.dao.common.AutoNumber;
import com.inkombizz.inventory.model.AdjustmentIn;
import com.inkombizz.inventory.model.AdjustmentInItemDetail;
import com.inkombizz.inventory.model.AdjustmentInItemDetailField;
import com.inkombizz.inventory.model.AdjustmentInItemDetailTemp;
import com.inkombizz.inventory.model.AdjustmentInSerialNoDetail;
import com.inkombizz.inventory.model.AdjustmentInTemp;
import com.inkombizz.inventory.model.ItemMaterialStockLocation;
import com.inkombizz.inventory.model.IvtActualStock;
import com.inkombizz.master.model.Item;
import com.inkombizz.master.model.ItemMaterial;
import com.inkombizz.system.dao.TransactionLogDAO;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.transform.Transformers;

public class AdjustmentInDAO {

    private HBMSession hbmSession;

    public AdjustmentInDAO(HBMSession session) {
        this.hbmSession = session;
    }

    public int countData(String code,String warehouseCode,String warehouseName,String refNo,Date firstDate, Date lastDate) {
        try {
            
//            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
//                
//            String dateFirst = DATE_FORMAT.format(firstDate);
//            String dateLast = DATE_FORMAT.format(lastDate);
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                "SELECT COUNT(*) " +
            "FROM ivt_adjustment_in " +
            "INNER JOIN mst_branch ON ivt_adjustment_in.BranchCode=mst_branch.Code " +
            "LEFT JOIN mst_currency ON ivt_adjustment_in.Currencycode=mst_currency.Code " +
            "INNER JOIN mst_warehouse ON ivt_adjustment_in.Warehousecode=mst_warehouse.Code " +
            "WHERE ivt_adjustment_in.Code LIKE :prmCode " +
            "AND ivt_adjustment_in.Warehousecode LIKE :prmWarehouseCode " +
            "AND mst_warehouse.Name LIKE :prmWarehouseName " +
            "AND ivt_adjustment_in.RefNo LIKE :prmRefNo " +
            "AND DATE(ivt_adjustment_in.Transactiondate) BETWEEN DATE(:prmFirstDate) AND DATE(:prmLastDate)")
            .setParameter("prmCode", "%"+code+"%")
            .setParameter("prmWarehouseCode", "%"+warehouseCode+"%")
            .setParameter("prmWarehouseName", "%"+warehouseName+"%")
            .setParameter("prmRefNo", "%"+refNo+"%")
            .setParameter("prmFirstDate", firstDate)
            .setParameter("prmLastDate", lastDate)
            .uniqueResult();
            return temp.intValue();

        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    public List<AdjustmentInTemp> findData(String code,String warehouseCode,String warehouseName,String refNo,Date firstDate, Date lastDate, int from, int to) {
        try {
            
            List<AdjustmentInTemp> list = (List<AdjustmentInTemp>)hbmSession.hSession.createSQLQuery(
            "SELECT " +
            "	ivt_adjustment_in.Code, " +
            "	ivt_adjustment_in.BranchCode, " +
            "	mst_branch.Name AS BranchName, " +
            "	ivt_adjustment_in.Transactiondate, " +
            "	ivt_adjustment_in.Currencycode, " +
            "	IFNULL(mst_currency.Name,'') AS CurrencyName, " +
            "	ivt_adjustment_in.Exchangerate, " +
            "	ivt_adjustment_in.Warehousecode, " +
            "	mst_warehouse.Name AS WarehouseName, " +
            "	ivt_adjustment_in.GrandTotalAmount, " +
            "	ivt_adjustment_in.ApprovalStatus, " +
            "	ivt_adjustment_in.ApprovalDate, " +
            "	ivt_adjustment_in.ApprovalBy, " +
            "	ivt_adjustment_in.RefNo, " +
            "	ivt_adjustment_in.Remark " +
            "FROM ivt_adjustment_in " +
            "INNER JOIN mst_branch ON ivt_adjustment_in.BranchCode=mst_branch.Code " +
            "LEFT JOIN mst_currency ON ivt_adjustment_in.Currencycode=mst_currency.Code " +
            "INNER JOIN mst_warehouse ON ivt_adjustment_in.Warehousecode=mst_warehouse.Code " +
            "WHERE ivt_adjustment_in.Code LIKE :prmCode " +
            "AND ivt_adjustment_in.Warehousecode LIKE :prmWarehouseCode " +
            "AND mst_warehouse.Name LIKE :prmWarehouseName " +
            "AND ivt_adjustment_in.RefNo LIKE :prmRefNo " +
            "AND DATE(ivt_adjustment_in.Transactiondate) BETWEEN DATE(:prmFirstDate) AND DATE(:prmLastDate) " +
            "ORDER BY ivt_adjustment_in.TransactionDate DESC,ivt_adjustment_in.Code ASC")                     
            .addScalar("code", Hibernate.STRING)
            .addScalar("branchCode", Hibernate.STRING)
            .addScalar("currencyCode", Hibernate.STRING)
            .addScalar("warehouseCode", Hibernate.STRING)
            .addScalar("warehouseName", Hibernate.STRING)
            .addScalar("transactionDate", Hibernate.TIMESTAMP)                                 
            .addScalar("exchangeRate", Hibernate.BIG_DECIMAL)    
            .addScalar("grandTotalAmount", Hibernate.BIG_DECIMAL)    
            .addScalar("approvalStatus", Hibernate.STRING)    
            .addScalar("refNo", Hibernate.STRING)
            .addScalar("remark", Hibernate.STRING)
            .setParameter("prmCode", "%"+code+"%")
            .setParameter("prmWarehouseCode", "%"+warehouseCode+"%")
            .setParameter("prmWarehouseName", "%"+warehouseName+"%")
            .setParameter("prmRefNo", "%"+refNo+"%")
            .setParameter("prmFirstDate", firstDate)
            .setParameter("prmLastDate", lastDate)
            .setFirstResult(from)
            .setMaxResults(to)
            .setResultTransformer(Transformers.aliasToBean(AdjustmentInTemp.class))
            .list(); 

            return list;
        } catch (HibernateException e) {
            throw e;
        }
    }

     public List<AdjustmentInItemDetail> findDataItemDetail(String headerCode) {
        try {
            List<AdjustmentInItemDetail> list = (List<AdjustmentInItemDetail>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "ivt_adjustment_in_item_detail.Code, "
                + "ivt_adjustment_in_item_detail.ItemMaterialCode, "
                + "mst_item_material.Name AS ItemMaterialName, "
                + "mst_item_material.UnitOfMeasureCode AS ItemMaterialUnitOfMeasureCode, "
                + "CASE "  
		+ " WHEN mst_item_material.SerialNoStatus = 1 THEN 'YES' "
		+ " WHEN mst_item_material.SerialNoStatus = 0 THEN 'NO' "
		+ " END AS ItemMaterialSerialNoStatus, "
                + "ivt_adjustment_in_item_detail.Price, "
                + "ivt_adjustment_in_item_detail.TotalAmount, "
                + "ivt_adjustment_in_item_detail.Quantity, "
                + "ivt_adjustment_in_item_detail.ReasonCode, "
                + "IFNULL(mst_reason.Name,'') AS ReasonName, "
                + "ivt_adjustment_in_item_detail.RackCode, "
                + "IFNULL(mst_rack.Name,'') AS RackName, "
                + "ivt_adjustment_in_item_detail.Remark "
                + "FROM ivt_adjustment_in_item_detail "
                + "INNER JOIN mst_item_material ON ivt_adjustment_in_item_detail.ItemMaterialCode=mst_item_material.Code "
                + "LEFT JOIN mst_reason ON ivt_adjustment_in_item_detail.ReasonCode=mst_reason.Code "
                + "LEFT JOIN mst_rack ON ivt_adjustment_in_item_detail.RackCode=mst_rack.Code "
                + "INNER JOIN mst_unit_of_measure ON mst_item_material.UnitOfMeasureCode=mst_unit_of_measure.Code "
                + "WHERE ivt_adjustment_in_item_detail.HeaderCode='"+headerCode+"' "
                + "ORDER BY ivt_adjustment_in_item_detail.Code ASC")

                .addScalar("code", Hibernate.STRING)
                .addScalar("itemMaterialCode",  Hibernate.STRING)
                .addScalar("itemMaterialName",  Hibernate.STRING)
                .addScalar("itemMaterialUnitOfMeasureCode", Hibernate.STRING)
                .addScalar("ItemMaterialSerialNoStatus", Hibernate.STRING)
                .addScalar("reasonCode",  Hibernate.STRING)
                .addScalar("reasonName",  Hibernate.STRING)
                .addScalar("rackCode",  Hibernate.STRING)
                .addScalar("rackName",  Hibernate.STRING)
                .addScalar("price", Hibernate.BIG_DECIMAL)
                .addScalar("totalAmount", Hibernate.BIG_DECIMAL)
                .addScalar("quantity", Hibernate.BIG_DECIMAL)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(AdjustmentInItemDetail.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<AdjustmentInSerialNoDetail> findDataSerialNoDetail(String headerCode) {
        try {
            List<AdjustmentInSerialNoDetail> list = (List<AdjustmentInSerialNoDetail>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "ivt_adjustment_in_serial_no_detail.ItemMaterialCode, "
                + "mst_item_material.Name AS ItemMaterialName, "
                + "CASE "  
		+ " WHEN mst_item_material.SerialNoStatus = 1 THEN 'YES' "
		+ " WHEN mst_item_material.SerialNoStatus = 0 THEN 'NO' "
		+ " END AS ItemMaterialSerialNoStatus, "
                + "mst_item_material.UnitOfMeasureCode AS ItemMaterialUnitOfMeasureCode, "
                + "ivt_adjustment_in_serial_no_detail.SerialNo, "
                + "ivt_adjustment_in_serial_no_detail.Capacity, "
                + "ivt_adjustment_in_serial_no_detail.RackCode, "
                + "mst_rack.Name AS RackName, "
                + "ivt_adjustment_in_serial_no_detail.Remark "
                + "FROM ivt_adjustment_in_serial_no_detail "
                + "INNER JOIN mst_item_material ON ivt_adjustment_in_serial_no_detail.ItemMaterialCode=mst_item_material.Code "
                + "INNER JOIN mst_unit_of_measure ON mst_item_material.UnitOfMeasureCode=mst_unit_of_measure.Code "
                + "INNER JOIN mst_rack ON mst_rack.Code=ivt_adjustment_in_serial_no_detail.RackCode "
                + "WHERE ivt_adjustment_in_serial_no_detail.HeaderCode='"+headerCode+"' "
                + "ORDER BY ivt_adjustment_in_serial_no_detail.HeaderCode ASC")

                .addScalar("itemMaterialCode", Hibernate.STRING)
                .addScalar("itemMaterialName",Hibernate.STRING)
                .addScalar("itemMaterialSerialNoStatus",Hibernate.STRING)
                .addScalar("itemMaterialUnitOfMeasureCode",Hibernate.STRING)
                .addScalar("serialNo",Hibernate.STRING)
                .addScalar("remark",Hibernate.STRING)
                .addScalar("capacity",Hibernate.BIG_DECIMAL)
                .addScalar("rackCode", Hibernate.STRING)
                .addScalar("rackName",Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(AdjustmentInSerialNoDetail.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
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

    private String createCode(AdjustmentIn adjustmentIn) {
        try {
            String tempKode = "ADJ-IN";
            String acronim = adjustmentIn.getBranch().getCode() + "/" +tempKode +"/"+AutoNumber.formatingDate(adjustmentIn.getTransactionDate(), true, true, false);
            
            DetachedCriteria dc = DetachedCriteria.forClass(AdjustmentIn.class)
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

    public int countDataApproval(String code,String warehouseCode,String warehouseName,String refNo,String remark,String approvalStatus, Date firstDate, Date lastDate) {
        try {
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
            "SELECT COUNT(*) " +
            "FROM ivt_adjustment_in " +
            "INNER JOIN mst_branch ON ivt_adjustment_in.BranchCode=mst_branch.Code " +
            "LEFT JOIN mst_currency ON ivt_adjustment_in.Currencycode=mst_currency.Code " +
            "INNER JOIN mst_warehouse ON ivt_adjustment_in.Warehousecode=mst_warehouse.Code " +
            "WHERE ivt_adjustment_in.Code LIKE :prmCode " +
            "AND ivt_adjustment_in.Warehousecode LIKE :prmWarehouseCode " +
            "AND mst_warehouse.Name LIKE :prmWarehouseName " +
            "AND ivt_adjustment_in.RefNo LIKE :prmRefNo " +
            "AND ivt_adjustment_in.Remark LIKE :prmRemark " +
            "AND ivt_adjustment_in.ApprovalStatus LIKE :prmApprovalStatus " +
            "AND DATE(ivt_adjustment_in.Transactiondate) BETWEEN DATE(:prmFirstDate) AND DATE(:prmLastDate)")
            .setParameter("prmCode", "%"+code+"%")
            .setParameter("prmWarehouseCode", "%"+warehouseCode+"%")
            .setParameter("prmWarehouseName", "%"+warehouseName+"%")
            .setParameter("prmRefNo", "%"+refNo+"%")
            .setParameter("prmRemark", "%"+remark+"%")
            .setParameter("prmApprovalStatus", "%"+approvalStatus+"%")
            .setParameter("prmFirstDate", firstDate)
            .setParameter("prmLastDate", lastDate)
            .uniqueResult();
            return temp.intValue();

        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    public List<AdjustmentInTemp> findDataApproval(String code,String warehouseCode,String warehouseName,String refNo,String remark,String approvalStatus, Date firstDate, Date lastDate, int from, int to) {
        try {
            
            List<AdjustmentInTemp> list = (List<AdjustmentInTemp>)hbmSession.hSession.createSQLQuery(
            "SELECT " +
            "	ivt_adjustment_in.Code, " +
            "	ivt_adjustment_in.BranchCode, " +
            "	mst_branch.Name AS BranchName, " +
            "	ivt_adjustment_in.Transactiondate, " +
            "	ivt_adjustment_in.Currencycode, " +
            "	IFNULL(mst_currency.Name,'') AS CurrencyName, " +
            "	ivt_adjustment_in.Exchangerate, " +
            "	ivt_adjustment_in.Warehousecode, " +
            "	mst_warehouse.Name AS WarehouseName, " +
            "	ivt_adjustment_in.GrandTotalAmount, " +
            "	ivt_adjustment_in.ApprovalStatus, " +
            "	ivt_adjustment_in.ApprovalDate, " +
            "	ivt_adjustment_in.ApprovalBy, " +
            "	ivt_adjustment_in.RefNo, " +
            "	ivt_adjustment_in.Remark " +
            "FROM ivt_adjustment_in " +
            "INNER JOIN mst_branch ON ivt_adjustment_in.BranchCode=mst_branch.Code " +
            "LEFT JOIN mst_currency ON ivt_adjustment_in.Currencycode=mst_currency.Code " +
            "INNER JOIN mst_warehouse ON ivt_adjustment_in.Warehousecode=mst_warehouse.Code " +
            "WHERE ivt_adjustment_in.Code LIKE :prmCode " +
            "AND ivt_adjustment_in.Warehousecode LIKE :prmWarehouseCode " +
            "AND mst_warehouse.Name LIKE :prmWarehouseName " +
            "AND ivt_adjustment_in.RefNo LIKE :prmRefNo " +
            "AND ivt_adjustment_in.Remark LIKE :prmRemark " +
            "AND ivt_adjustment_in.ApprovalStatus LIKE :prmApprovalStatus " +
            "AND DATE(ivt_adjustment_in.Transactiondate) BETWEEN DATE(:prmFirstDate) AND DATE(:prmLastDate) " +
            "ORDER BY ivt_adjustment_in.TransactionDate DESC,ivt_adjustment_in.Code ASC")                       
            .addScalar("code", Hibernate.STRING)
            .addScalar("branchCode", Hibernate.STRING)
            .addScalar("currencyCode", Hibernate.STRING)
            .addScalar("warehouseCode", Hibernate.STRING)
            .addScalar("warehouseName", Hibernate.STRING)
            .addScalar("transactionDate", Hibernate.TIMESTAMP)                                 
            .addScalar("exchangeRate", Hibernate.BIG_DECIMAL)    
            .addScalar("grandTotalAmount", Hibernate.BIG_DECIMAL)
            .addScalar("approvalDate", Hibernate.TIMESTAMP)
            .addScalar("approvalStatus", Hibernate.STRING)    
            .addScalar("approvalBy", Hibernate.STRING)    
            .addScalar("refNo", Hibernate.STRING)
            .addScalar("remark", Hibernate.STRING)
            .setParameter("prmCode", "%"+code+"%")
            .setParameter("prmWarehouseCode", "%"+warehouseCode+"%")
            .setParameter("prmWarehouseName", "%"+warehouseName+"%")
            .setParameter("prmRefNo", "%"+refNo+"%")
            .setParameter("prmRemark", "%"+remark+"%")
            .setParameter("prmApprovalStatus", "%"+approvalStatus+"%")
            .setParameter("prmFirstDate", firstDate)
            .setParameter("prmLastDate", lastDate)
            .setFirstResult(from)
            .setMaxResults(to)
            .setResultTransformer(Transformers.aliasToBean(AdjustmentInTemp.class))
            .list(); 
                 
                return list;
        } catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<AdjustmentInSerialNoDetail> findBulkDataSerialNoDetail(List<AdjustmentInItemDetail> listAdjustmentInItemDetail) {
        try {
            
            ArrayList<String> arrItemDetailCode=new ArrayList<String>();
            for(AdjustmentInItemDetail adjustmentInItemDetail:listAdjustmentInItemDetail){
                arrItemDetailCode.add(adjustmentInItemDetail.getCode());
            }
            
            String strItemDetailCode=Arrays.toString(arrItemDetailCode.toArray());
            strItemDetailCode = strItemDetailCode.replaceAll(" ","");
            strItemDetailCode = strItemDetailCode.replaceAll("[\\[\\]]", "");
            strItemDetailCode = strItemDetailCode.replaceAll(",", "','");
            
            List<AdjustmentInSerialNoDetail> list = (List<AdjustmentInSerialNoDetail>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "ivt_adjustment_in_serial_no_detail.Code, "
                + "ivt_adjustment_in_serial_no_detail.HeaderCode, "
                + "ivt_adjustment_in_serial_no_detail.ItemMaterialCode, "
                + "mst_item_material.Name AS ItemMaterialName, "
                + "CASE "  
		+ " WHEN mst_item_material.SerialNoStatus = 1 THEN 'YES' "
		+ " WHEN mst_item_material.SerialNoStatus = 0 THEN 'NO' "
		+ " END AS ItemMaterialSerialNoStatus, "
                + "mst_item_material.UnitOfMeasureCode AS ItemMaterialUnitOfMeasureCode, "
                + "ivt_adjustment_in_serial_no_detail.SerialNo, "
                + "ivt_adjustment_in_serial_no_detail.Capacity, "
                + "ivt_adjustment_in_serial_no_detail.RackCode, "
                + "mst_rack.Name AS RackName, "
                + "ivt_adjustment_in_serial_no_detail.Remark "
                + "FROM ivt_adjustment_in_serial_no_detail "
                + "INNER JOIN mst_item_material ON ivt_adjustment_in_serial_no_detail.ItemMaterialCode=mst_item_material.Code "
                + "INNER JOIN mst_unit_of_measure ON mst_item_material.UnitOfMeasureCode=mst_unit_of_measure.Code "
                + "INNER JOIN mst_rack ON mst_rack.Code=ivt_adjustment_in_serial_no_detail.RackCode "
                + "WHERE ivt_adjustment_in_serial_no_detail.HeaderCode IN('"+strItemDetailCode+"') "
                + "ORDER BY ivt_adjustment_in_serial_no_detail.HeaderCode ASC")

                .addScalar("code", Hibernate.STRING)
                .addScalar("headerCode", Hibernate.STRING)
                .addScalar("itemMaterialCode", Hibernate.STRING)
                .addScalar("itemMaterialName",Hibernate.STRING)
                .addScalar("itemMaterialSerialNoStatus",Hibernate.STRING)
                .addScalar("itemMaterialUnitOfMeasureCode",Hibernate.STRING)
                .addScalar("serialNo",Hibernate.STRING)
                .addScalar("remark",Hibernate.STRING)
                .addScalar("capacity",Hibernate.BIG_DECIMAL)
                .addScalar("rackCode", Hibernate.STRING)
                .addScalar("rackName",Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(AdjustmentInSerialNoDetail.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public void save(AdjustmentIn adjustmentIn, List<AdjustmentInItemDetail> listAdjustmentInDetail,List<AdjustmentInSerialNoDetail> listAdjustmentInSerialNoDetail,String MODULECODE) throws Exception {
        try {
            
            String headerCode=createCode(adjustmentIn);
            
            hbmSession.hSession.beginTransaction();
            
            adjustmentIn.setCode(headerCode);
            adjustmentIn.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            adjustmentIn.setCreatedDate(new Date());
            adjustmentIn.setApprovalStatus("PENDING");
                        
            int i=1;
            for(AdjustmentInItemDetail adjustmentInItemDetail:listAdjustmentInDetail){
                String detailCode = adjustmentIn.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                adjustmentInItemDetail.setCode(detailCode);
                adjustmentInItemDetail.setHeaderCode(headerCode);
                adjustmentInItemDetail.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                adjustmentInItemDetail.setCreatedDate(new Date());
                
                String checkDetailItem=adjustmentInItemDetail.getItemMaterial().getCode()+adjustmentInItemDetail.getReason().getCode()+adjustmentInItemDetail.getRemark()+adjustmentInItemDetail.getQuantity();

                i++;
                
                int j = 1;
                for(AdjustmentInSerialNoDetail adjustmentInSerialNoDetail : listAdjustmentInSerialNoDetail){
                    if(checkDetailItem.equalsIgnoreCase(adjustmentInSerialNoDetail.getCode())){
                        String serialDetailCode = adjustmentInItemDetail.getCode() + "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(j),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                        adjustmentInSerialNoDetail.setCode(serialDetailCode);
                        adjustmentInSerialNoDetail.setHeaderCode(adjustmentInItemDetail.getCode());
                        adjustmentInSerialNoDetail.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                        adjustmentInSerialNoDetail.setCreatedDate(new Date());
                        
                        hbmSession.hSession.save(adjustmentInSerialNoDetail);
                        j++;
                    
                    }
                }
                
                hbmSession.hSession.save(adjustmentInItemDetail);
            }   
            
            hbmSession.hSession.save(adjustmentIn);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(MODULECODE, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT), 
                                                                    adjustmentIn.getCode(), ""));
            hbmSession.hTransaction.commit();
                      
        }
        catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(AdjustmentIn adjustmentIn, List<AdjustmentInItemDetail> listAdjustmentInItemDetail,List<AdjustmentInSerialNoDetail> listAdjustmentInSerialNoDetail, String moduleCode) throws Exception {
        try {
            hbmSession.hSession.beginTransaction();

            if(!updateDetail(adjustmentIn, listAdjustmentInItemDetail,listAdjustmentInSerialNoDetail)){
                hbmSession.hTransaction.rollback();
            }
            
            adjustmentIn.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            adjustmentIn.setUpdatedDate(new Date());
            hbmSession.hSession.update(adjustmentIn);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
                                                                    adjustmentIn.getCode(), ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
        }
    }
    
    private boolean updateDetail(AdjustmentIn adjustmentIn, List<AdjustmentInItemDetail> listAdjustmentInItemDetail,List<AdjustmentInSerialNoDetail> listAdjustmentInSerialNoDetail) throws Exception{
        try {
            
           
            List<AdjustmentInItemDetail> oldItemDetail = findDataItemDetail(adjustmentIn.getCode());  
            
            for(AdjustmentInItemDetail itemDetail : oldItemDetail){                
                hbmSession.hSession.createQuery("DELETE FROM AdjustmentInSerialNoDetail " 
                                 +" WHERE headerCode = :prmHeaderCode")
                    .setParameter("prmHeaderCode", itemDetail.getCode())
                    .executeUpdate();
            
                hbmSession.hSession.flush();
            }
    
            hbmSession.hSession.createQuery("DELETE FROM AdjustmentInItemDetail " 
                                 +" WHERE headerCode = :prmHeaderCode")
                    .setParameter("prmHeaderCode", adjustmentIn.getCode())
                    .executeUpdate();
            
            hbmSession.hSession.flush();
            
            int i = 1;
            for(AdjustmentInItemDetail adjustmentInItemDetail : listAdjustmentInItemDetail){
                
                adjustmentInItemDetail.setHeaderCode(adjustmentIn.getCode());
                String detailCode = adjustmentIn.getCode() + "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                adjustmentInItemDetail.setCode(detailCode);
                adjustmentInItemDetail.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                adjustmentInItemDetail.setCreatedDate(new Date());
                adjustmentInItemDetail.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
                adjustmentInItemDetail.setUpdatedDate(new Date());
                                
                i++;
                
                String checkDetailItem=adjustmentInItemDetail.getItemMaterial().getCode()+adjustmentInItemDetail.getReason().getCode()+adjustmentInItemDetail.getRemark()+adjustmentInItemDetail.getQuantity();

                int j = 1;
                for(AdjustmentInSerialNoDetail adjustmentInSerialNoDetail : listAdjustmentInSerialNoDetail){
                    if(checkDetailItem.equalsIgnoreCase(adjustmentInSerialNoDetail.getCode())){
                        String serialDetailCode = adjustmentInItemDetail.getCode() + "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(j),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                        adjustmentInSerialNoDetail.setCode(serialDetailCode);
                        adjustmentInSerialNoDetail.setHeaderCode(adjustmentInItemDetail.getCode());
                        adjustmentInSerialNoDetail.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                        adjustmentInSerialNoDetail.setCreatedDate(new Date());
                        adjustmentInSerialNoDetail.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
                        adjustmentInSerialNoDetail.setUpdatedDate(new Date());
                        
                        hbmSession.hSession.save(adjustmentInSerialNoDetail);
                        j++;
                    
                    }
                }
                
                hbmSession.hSession.save(adjustmentInItemDetail);
            }

            return Boolean.TRUE;
            
        } catch (HibernateException e) {
            e.printStackTrace();
            return Boolean.FALSE;
        }
    }
    
    public void approval(AdjustmentIn adjustmentIn, List<AdjustmentInItemDetail> listAdjustmentInItemDetail,List<AdjustmentInSerialNoDetail> listAdjustmentInSerialNoDetail,String MODULECODE) throws Exception {
        try {
                        
            hbmSession.hSession.beginTransaction();
                        
            if(adjustmentIn.getApprovalStatus().equalsIgnoreCase("APPROVED")){
                adjustmentIn.setApprovalBy(BaseSession.loadProgramSession().getUserName());
                adjustmentIn.setApprovalDate(new Date());
            }else{
                SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss",Locale.ENGLISH);
                Date defaultDateTime = sdf.parse("1900-01-01 00:00:00");
                adjustmentIn.setApprovalBy(null);
                adjustmentIn.setApprovalDate(defaultDateTime);
            }
            
            List<AdjustmentInItemDetail> oldItemDetail = findDataItemDetail(adjustmentIn.getCode());  
            
            for(AdjustmentInItemDetail itemDetail : oldItemDetail){                
                hbmSession.hSession.createQuery("DELETE FROM AdjustmentInSerialNoDetail " 
                                 +" WHERE headerCode = :prmHeaderCode")
                    .setParameter("prmHeaderCode", itemDetail.getCode())
                    .executeUpdate();
            
                hbmSession.hSession.flush();
            }
    
            hbmSession.hSession.createQuery("DELETE FROM AdjustmentInItemDetail " 
                                 +" WHERE headerCode = :prmHeaderCode")
                    .setParameter("prmHeaderCode", adjustmentIn.getCode())
                    .executeUpdate();
            
            hbmSession.hSession.flush();
            
            int i=1;
            for(AdjustmentInItemDetail adjustmentInItemDetail:listAdjustmentInItemDetail){
                String detailCode = adjustmentIn.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                adjustmentInItemDetail.setCode(detailCode);
                adjustmentInItemDetail.setHeaderCode(adjustmentIn.getCode());
                adjustmentInItemDetail.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                adjustmentInItemDetail.setCreatedDate(new Date());
                adjustmentInItemDetail.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
                adjustmentInItemDetail.setUpdatedDate(new Date());
                        
                hbmSession.hSession.save(adjustmentInItemDetail);	
                String branchCode;
                branchCode = adjustmentIn.getBranch().getCode();
                if(adjustmentInItemDetail.getItemMaterial().getInventoryType().equals("INVENTORY")){
                    InventoryInOutDAO inventoryInOutDAO=new InventoryInOutDAO(hbmSession);
                    IvtActualStock newRec = new IvtActualStock(); 
                    int actualStock_SortNo =0;
                    newRec = InventoryCommon.newInstance(
                            adjustmentIn.getWarehouse().getCode(),
                            branchCode,
                            adjustmentInItemDetail.getItemMaterial().getCode(),
                            adjustmentInItemDetail.getQuantity(),
                            adjustmentInItemDetail.getPrice(),
                            adjustmentInItemDetail.getRack().getCode()
                            );
                    
                    inventoryInOutDAO.ActualStockIncrease_AVG(newRec,false,true,adjustmentIn.getCode()+"-"+detailCode, EnumCOGSType.ENUM_COGSType.IIN,actualStock_SortNo);
                }
                
                i++;
            }
            
            ItemMaterialStockLocationDAO itemMaterialStockLocationDAO=new ItemMaterialStockLocationDAO(hbmSession);
            int j = 1;
            for(AdjustmentInSerialNoDetail adjustmentInSerialNoDetail : listAdjustmentInSerialNoDetail){
                    adjustmentInSerialNoDetail.setCode(adjustmentInSerialNoDetail.getCode());
                    adjustmentInSerialNoDetail.setHeaderCode(adjustmentInSerialNoDetail.getHeaderCode());
                    adjustmentInSerialNoDetail.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    adjustmentInSerialNoDetail.setCreatedDate(new Date());
                    adjustmentInSerialNoDetail.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
                    adjustmentInSerialNoDetail.setUpdatedDate(new Date());

                    String code=adjustmentIn.getCode()+"-"+ adjustmentInSerialNoDetail.getItemMaterial().getCode()+"-"+ org.apache.commons.lang.StringUtils.leftPad(Integer.toString(j),AutoNumber.DEFAULT_TRANSACTION_LENGTH_5, "0");

                    ItemMaterialStockLocation itemMaterialStockLocation=new ItemMaterialStockLocation();
                    itemMaterialStockLocation.setCode(code);
                    itemMaterialStockLocation.setWarehouse(adjustmentIn.getWarehouse());
                    itemMaterialStockLocation.setRack(adjustmentInSerialNoDetail.getRack());
                    itemMaterialStockLocation.setCapacity(adjustmentInSerialNoDetail.getCapacity());
                    itemMaterialStockLocation.setTransactionDate(adjustmentIn.getApprovalDate());
                    itemMaterialStockLocation.setTransactionCode(adjustmentIn.getCode());
                    itemMaterialStockLocation.setTransactionType(EnumTransactionType.ENUM_TransactionType.ADJIN.toString());
                    itemMaterialStockLocation.setItemMaterial(adjustmentInSerialNoDetail.getItemMaterial());

                    if(!itemMaterialStockLocationDAO.save(itemMaterialStockLocation, "003_IVT_ITEM_STOCK_LOCATION")){
                        hbmSession.hTransaction.rollback();
                    }
                    
                    adjustmentInSerialNoDetail.setSerialNo(itemMaterialStockLocation.getSerialNo());
                    adjustmentInSerialNoDetail.setSerialNoDetailCode(code);
                    
                    hbmSession.hSession.save(adjustmentInSerialNoDetail);
                    j++;
            }
            
            
            hbmSession.hSession.update(adjustmentIn);
            
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(MODULECODE, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
                                                                    adjustmentIn.getCode(), "Adjustment In Approval"));
            hbmSession.hTransaction.commit();
                      
        }
        catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    
    public void delete(String code, String MODULECODE) throws Exception {
        try {
            hbmSession.hSession.beginTransaction();
            
            List<AdjustmentInItemDetail> oldItemDetail = findDataItemDetail(code);  
            
            for(AdjustmentInItemDetail itemDetail : oldItemDetail){                
                hbmSession.hSession.createQuery("DELETE FROM AdjustmentInSerialNoDetail " 
                                 +" WHERE headerCode = :prmHeaderCode")
                    .setParameter("prmHeaderCode", itemDetail.getCode())
                    .executeUpdate();
            
                hbmSession.hSession.flush();
            }
    
            hbmSession.hSession.createQuery("DELETE FROM AdjustmentInItemDetail " 
                                 +" WHERE headerCode = :prmHeaderCode")
                    .setParameter("prmHeaderCode", code)
                    .executeUpdate();
            
            hbmSession.hSession.flush();
            
            hbmSession.hSession.createQuery("DELETE FROM AdjustmentIn " 
                                 +" WHERE code  = :prmCode")
                    .setParameter("prmCode", code)
                    .executeUpdate();
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(MODULECODE, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.DELETE), 
                                                                    code, ""));
            
            hbmSession.hTransaction.commit();
            
        }catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
 
    public Boolean isApproved(String code) throws Exception{
        try {
            String approvalStatus = (String)hbmSession.hSession.createSQLQuery(
                "SELECT "
                + "CASE "
                + "WHEN ivt_adjustment_in.ApprovalStatus='APPROVED' THEN "
                + " 'APPROVED' "
                + "WHEN ivt_adjustment_in.ApprovalStatus='REJECTED' THEN "
                + " 'REJECTED' "
                + "ELSE 'PENDING' END AS ApprovalStatus "
                + "FROM ivt_adjustment_in "
                + "WHERE ivt_adjustment_in.Code='"+code+"'"
            ).uniqueResult();
            
            if(approvalStatus.equals("APPROVED") || approvalStatus.equals("REJECTED")){
                return Boolean.TRUE;
            }
            
            return Boolean.FALSE;
        } catch (HibernateException e) {
            e.printStackTrace();
            return Boolean.FALSE;
        }
    }
}
