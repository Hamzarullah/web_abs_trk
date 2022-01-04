
package com.inkombizz.inventory.dao;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.CommonFunction;
import com.inkombizz.common.InventoryCommon;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumCOGSType;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.common.enumeration.EnumTransactionAction.ENUM_TransactionAction;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.dao.common.AutoNumber;
import com.inkombizz.inventory.model.InventoryActualStockField;
import com.inkombizz.inventory.model.IvtActualStock;
import com.inkombizz.inventory.model.PickingListSalesOrder;
import com.inkombizz.inventory.model.PickingListSalesOrderBonusItemQuantityDetailTemp;
import com.inkombizz.inventory.model.PickingListSalesOrderTemp;
import com.inkombizz.inventory.model.PickingListSalesOrderTradeItemDetail;
import com.inkombizz.inventory.model.PickingListSalesOrderTradeItemDetailTemp;
import com.inkombizz.inventory.model.PickingListSalesOrderTradeItemQuantityDetail;
import com.inkombizz.inventory.model.PickingListSalesOrderTradeItemQuantityDetailTemp;
import com.inkombizz.master.model.ItemCurrentStockTemp;
import com.inkombizz.system.dao.TransactionLogDAO;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.Date;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.transform.Transformers;


public class PickingListSalesOrderDAO {
    
    private HBMSession hbmSession;
    private CommonFunction commonFunction=new CommonFunction();
    
    public PickingListSalesOrderDAO(HBMSession session) {
        this.hbmSession = session;
    }
    
    
    public int countData(String userCodeTemp,String code,String salesOrderCode,String customerCode,String customerName,String refNo,String remark,Date firstDate,Date lastDate){
        try{            
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                "CALL usp_picking_list_sales_order_list_count(:prmUserCodeTemp,:prmCode,:prmSalesOrderCode,:prmCustomerCode,:prmCustomerName,:prmRefNo,:prmRemark,:prmFirstDate,:prmLastDate)")
            .setParameter("prmUserCodeTemp",userCodeTemp)
            .setParameter("prmCode", "%"+code+"%")
            .setParameter("prmSalesOrderCode", "%"+salesOrderCode+"%")
            .setParameter("prmCustomerCode", "%"+customerCode+"%")
            .setParameter("prmCustomerName", "%"+customerName+"%")
            .setParameter("prmRefNo", "%"+refNo+"%")
            .setParameter("prmRemark", "%"+remark+"%")
            .setParameter("prmFirstDate", firstDate)
            .setParameter("prmLastDate", lastDate)
            .uniqueResult();

            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
        
    public int countDataConfirmation(String userCodeTemp,String code,String salesOrderCode,String customerCode,String customerName,String refNo,String remark,String confirmationStatus,Date firstDate,Date lastDate){
        try{            
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                "CALL usp_picking_list_sales_order_confirmation_list_count(:prmUserCodeTemp,:prmCode,:prmSalesOrderCode,:prmCustomerCode,:prmCustomerName,:prmRefNo,:prmRemark,:prmConfirmationStatus,:prmFirstDate,:prmLastDate)")
            .setParameter("prmUserCodeTemp",userCodeTemp)
            .setParameter("prmCode", "%"+code+"%")
            .setParameter("prmSalesOrderCode", "%"+salesOrderCode+"%")
            .setParameter("prmCustomerCode", "%"+customerCode+"%")
            .setParameter("prmCustomerName", "%"+customerName+"%")
            .setParameter("prmRefNo", "%"+refNo+"%")
            .setParameter("prmRemark", "%"+remark+"%")
            .setParameter("prmConfirmationStatus", "%"+confirmationStatus+"%")
            .setParameter("prmFirstDate", firstDate)
            .setParameter("prmLastDate", lastDate)
            .uniqueResult();

            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public int countByCriteria(DetachedCriteria dc) {
        try {
            Criteria criteria = dc.getExecutableCriteria(this.hbmSession.hSession);
            criteria.setProjection(Projections.rowCount());
            if (criteria.list().size() == 0)
            	return 0;
            else
            	return ((Integer) criteria.list().get(0)).intValue();
        }
        catch (HibernateException e) {
            throw e;
        }
    }
        
    public PickingListSalesOrder get(String code) {
        try {
               return (PickingListSalesOrder) hbmSession.hSession.get(PickingListSalesOrder.class, code);
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<PickingListSalesOrderTemp> findData(String userCodeTemp,String code,String salesOrderCode,String customerCode,String customerName,String refNo,String remark,Date firstDate,Date lastDate,int from, int to) {
        try {   
            
            List<PickingListSalesOrderTemp> list = (List<PickingListSalesOrderTemp>)hbmSession.hSession.createSQLQuery(
                 "CALL usp_picking_list_sales_order_list(:prmUserCodeTemp,:prmCode,:prmSalesOrderCode,:prmCustomerCode,:prmCustomerName,:prmRefNo,:prmRemark,:prmFirstDate,:prmLastDate,:prmLimitFrom,:prmLimitTo)")
                    
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("branchCode", Hibernate.STRING)
                    .addScalar("transactionDate", Hibernate.TIMESTAMP)
                    .addScalar("salesOrderCode", Hibernate.STRING)
                    .addScalar("salesOrderCustomerCode", Hibernate.STRING)
                    .addScalar("salesOrderCustomerName", Hibernate.STRING)
                    .addScalar("currencyCode", Hibernate.STRING)
                    .addScalar("customerAddressCode", Hibernate.STRING)
                    .addScalar("customerAddressName", Hibernate.STRING)
                    .addScalar("customerAddressAddress", Hibernate.STRING)
                    .addScalar("warehouseCode", Hibernate.STRING)
                    .addScalar("warehouseName", Hibernate.STRING)
                    .addScalar("refNo", Hibernate.STRING)
                    .addScalar("remark", Hibernate.STRING)
                    .addScalar("deliveryNoteCode", Hibernate.STRING)
                
                    .setParameter("prmUserCodeTemp",userCodeTemp)
                    .setParameter("prmCode", "%"+code+"%")
                    .setParameter("prmSalesOrderCode", "%"+salesOrderCode+"%")
                    .setParameter("prmCustomerCode", "%"+customerCode+"%")
                    .setParameter("prmCustomerName", "%"+customerName+"%")
                    .setParameter("prmRefNo", "%"+refNo+"%")
                    .setParameter("prmRemark", "%"+remark+"%")
                    .setParameter("prmFirstDate", firstDate)
                    .setParameter("prmLastDate", lastDate)
                    .setParameter("prmLimitFrom", from)
                    .setParameter("prmLimitTo", to)
                    .setResultTransformer(Transformers.aliasToBean(PickingListSalesOrderTemp.class))
                    .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<PickingListSalesOrderTemp> findDataPickingList(String salesOrderCode ) {
        try {
            List<PickingListSalesOrderTemp> list = (List<PickingListSalesOrderTemp>)hbmSession.hSession.createSQLQuery(""
                    + "SELECT  " 
                    + "ivt_picking_list_so.Code AS pickingListCode, " 
                    + "ivt_picking_list_so.WarehouseCode AS warehouseCode, " 
                    + "ivt_picking_list_so.Transactiondate AS transactionDate " 
                    + "FROM ivt_picking_list_so " 
                    + "WHERE "
                    + "ivt_picking_list_so.SalesOrderCode = '"+salesOrderCode+"' " 
                    + "AND "
                    + "ivt_picking_list_so.ConfirmationStatus = 'APPROVED' " 
                    + "AND "
                    + "ivt_picking_list_so.Code NOT IN ("
                    + "SELECT "
                    + "ivt_delivery_note_so_jn_picking_list_so.PickingListSOCode AS salesOrderCode "
                    + "FROM "
                    + "ivt_delivery_note_so_jn_picking_list_so "
                    + ")")
                    .addScalar("pickingListCode", Hibernate.STRING)
                    .addScalar("warehouseCode", Hibernate.STRING)
                    .addScalar("transactionDate", Hibernate.DATE)
             //       .setParameter("prmSalesOrderCode", "+salesOrderCode+")
                    .setResultTransformer(Transformers.aliasToBean(PickingListSalesOrderTemp.class))
                    .list(); 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }    
    
    public List<PickingListSalesOrderTemp> findDataConfirmation(String userCodeTemp,String code,String salesOrderCode,String customerCode,String customerName,String refNo,String remark,String confirmationStatus,Date firstDate,Date lastDate,int from, int to) {
        try {   
            
            List<PickingListSalesOrderTemp> list = (List<PickingListSalesOrderTemp>)hbmSession.hSession.createSQLQuery(""
                    + "CALL usp_picking_list_sales_order_confirmation_list(:prmUserCodeTemp,:prmCode,:prmSalesOrderCode,:prmCustomerCode,:prmCustomerName,:prmRefNo,:prmRemark,:prmConfirmationStatus,:prmFirstDate,:prmLastDate,:prmLimitFrom,:prmLimitTo)")
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("branchCode", Hibernate.STRING)
                    .addScalar("transactionDate", Hibernate.TIMESTAMP)
                    .addScalar("salesOrderCode", Hibernate.STRING)
                    .addScalar("salesOrderCustomerCode", Hibernate.STRING)
                    .addScalar("salesOrderCustomerName", Hibernate.STRING)
                    .addScalar("currencyCode", Hibernate.STRING)
                    .addScalar("customerAddressCode", Hibernate.STRING)
                    .addScalar("customerAddressName", Hibernate.STRING)
                    .addScalar("customerAddressAddress", Hibernate.STRING)
                    .addScalar("warehouseCode", Hibernate.STRING)
                    .addScalar("warehouseName", Hibernate.STRING)
                    .addScalar("refNo", Hibernate.STRING)
                    .addScalar("remark", Hibernate.STRING)
                    .addScalar("deliveryNoteCode", Hibernate.STRING)
                    .addScalar("confirmationStatus", Hibernate.STRING)
                
                    .setParameter("prmUserCodeTemp",userCodeTemp)
                    .setParameter("prmCode", "%"+code+"%")
                    .setParameter("prmSalesOrderCode", "%"+salesOrderCode+"%")
                    .setParameter("prmCustomerCode", "%"+customerCode+"%")
                    .setParameter("prmCustomerName", "%"+customerName+"%")
                    .setParameter("prmRefNo", "%"+refNo+"%")
                    .setParameter("prmRemark", "%"+remark+"%")
                    .setParameter("prmConfirmationStatus", "%"+confirmationStatus+"%")
                    .setParameter("prmFirstDate", firstDate)
                    .setParameter("prmLastDate", lastDate)
                    .setParameter("prmLimitFrom", from)
                    .setParameter("prmLimitTo", to)
                    .setResultTransformer(Transformers.aliasToBean(PickingListSalesOrderTemp.class))
                    .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            e.printStackTrace();
            throw e;
        }
    }
    
    public List<PickingListSalesOrderTradeItemDetailTemp> findDataTradeItemDetail(String headerCode) {
        try {
            List<PickingListSalesOrderTradeItemDetailTemp> list = (List<PickingListSalesOrderTradeItemDetailTemp>)hbmSession.hSession.createSQLQuery(""
                    + "CALL usp_picking_list_sales_order_item_detail_list(:prmHeaderCode); ")
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("headerCode", Hibernate.STRING)
                    .addScalar("itemCode", Hibernate.STRING)
                    .addScalar("itemName", Hibernate.STRING)
                    .addScalar("itemAlias", Hibernate.STRING)
                    .addScalar("quantity", Hibernate.BIG_DECIMAL)
                    .addScalar("itemUnitOfMeasureCode", Hibernate.STRING)
                    .setParameter("prmHeaderCode",headerCode)
                    .setResultTransformer(Transformers.aliasToBean(PickingListSalesOrderTradeItemDetailTemp.class))
                    .list(); 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<PickingListSalesOrderTradeItemQuantityDetailTemp> findDataTradeItemQuantityDetail(String headerCode) {
        try {
            List<PickingListSalesOrderTradeItemQuantityDetailTemp> list = (List<PickingListSalesOrderTradeItemQuantityDetailTemp>)hbmSession.hSession.createSQLQuery(""
                    + "CALL usp_picking_list_sales_order_item_quantity_detail_list(:prmHeaderCode)")
                    .addScalar("detailCode", Hibernate.STRING)
                    .addScalar("itemCode", Hibernate.STRING)
                    .addScalar("itemName", Hibernate.STRING)
                    .addScalar("itemAlias", Hibernate.STRING)
                    .addScalar("itemUnitOfMeasureCode", Hibernate.STRING)
                    .addScalar("quantity", Hibernate.BIG_DECIMAL)
                    .addScalar("rackCode", Hibernate.STRING)
                    .addScalar("rackName", Hibernate.STRING)
                    .setParameter("prmHeaderCode",headerCode)
                    .setResultTransformer(Transformers.aliasToBean(PickingListSalesOrderTradeItemQuantityDetailTemp.class))
                    .list(); 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<PickingListSalesOrderTradeItemQuantityDetailTemp> findDataStockForPickingList(String warehouseCode, String itemCode, int quantity) {
        try {
            List<PickingListSalesOrderTradeItemQuantityDetailTemp> list = (List<PickingListSalesOrderTradeItemQuantityDetailTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "	ivt_picking_list_so_trade_item_quantity_detail.Code, "
                + "	ivt_picking_list_so_trade_item_quantity_detail.HeaderCode, "
                + "	ivt_picking_list_so_trade_item_quantity_detail.ItemCode, "
                + "	mst_item.Name AS ItemName, "
                + "	mst_item.ItemAlias, "
                + "	mst_item.`DefaultUnitOfMeasureCode` AS ItemUnitOfMeasureCode, "
                + "	ivt_picking_list_so_trade_item_quantity_detail.Quantity, "
                + "	ivt_picking_list_so_trade_item_quantity_detail.COGSIDR, "
                + "	ivt_picking_list_so_trade_item_quantity_detail.ItemBrandCode, "
                + "	ivt_picking_list_so_trade_item_quantity_detail.LotNo, "
                + "	ivt_picking_list_so_trade_item_quantity_detail.BatchNo, "
                + "	ivt_picking_list_so_trade_item_quantity_detail.RackCode, "
                + "	mst_rack.name AS RackName, "
                + "	ivt_picking_list_so_trade_item_quantity_detail.ItemDate, "
                + "	ivt_picking_list_so_trade_item_quantity_detail.ExpiredDate, "
                + "	ivt_picking_list_so_trade_item_quantity_detail.InDocumentType, "
                + "	ivt_picking_list_so_trade_item_quantity_detail.InTransactionNo "
                + "FROM ivt_picking_list_so_trade_item_quantity_detail "
                + "INNER JOIN mst_item ON ivt_picking_list_so_trade_item_quantity_detail.ItemCode=mst_item.Code "
                + "INNER JOIN mst_rack ON ivt_picking_list_so_trade_item_quantity_detail.RackCode=mst_rack.code "
                + "INNER JOIN ivt_picking_list_so ON ivt_picking_list_so.Code=ivt_picking_list_so_trade_item_quantity_detail.HeaderCode "
//                + "WHERE ivt_picking_list_so.SalesOrderCode=:prmHeaderCode"
            )
                .addScalar("code", Hibernate.STRING)
                .addScalar("headerCode", Hibernate.STRING)
                .addScalar("itemCode", Hibernate.STRING)
                .addScalar("itemName", Hibernate.STRING)
                .addScalar("itemAlias", Hibernate.STRING)
                .addScalar("itemUnitOfMeasureCode", Hibernate.STRING)
                .addScalar("quantity", Hibernate.BIG_DECIMAL)
                .addScalar("cogsIdr", Hibernate.BIG_DECIMAL)
                .addScalar("itemBrandCode", Hibernate.STRING)
                .addScalar("lotNo", Hibernate.STRING)
                .addScalar("batchNo", Hibernate.STRING)
                .addScalar("rackCode", Hibernate.STRING)
                .addScalar("rackName", Hibernate.STRING)
                .addScalar("itemDate", Hibernate.DATE)
                .addScalar("expiredDate", Hibernate.DATE)
                .addScalar("inDocumentType", Hibernate.STRING)
                .addScalar("InTransactionNo", Hibernate.STRING)
                
//                .setParameter("prmHeaderCode",salesOrderCode)
                .setResultTransformer(Transformers.aliasToBean(PickingListSalesOrderTradeItemQuantityDetailTemp.class))
                .list(); 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    //Create Code
    private String createCode(PickingListSalesOrder packingListSalesOrder){
        try{
            String prefix = packingListSalesOrder.getBranch().getCode()+"/";
            String infiks="PLT-SO/";
                        
            String acronim =prefix + infiks + AutoNumber.formatingDate(packingListSalesOrder.getTransactionDate(), true, true, false);
            
            DetachedCriteria dc = DetachedCriteria.forClass(PickingListSalesOrder.class)
                    .setProjection(Projections.max("code"))
                    .add(Restrictions.like("code", acronim + "%" ));

            Criteria criteria = dc.getExecutableCriteria(hbmSession.hSession);
            List list = criteria.list();

            String oldID = "";
            if(list != null){
                    if (list.size() > 0)
                        if(list.get(0) != null)
                            oldID = list.get(0).toString();
                }
            return AutoNumber.generate(acronim, oldID, AutoNumber.DEFAULT_TRANSACTION_LENGTH_5);
        }
        catch(HibernateException e){
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    //Save Header
    public void save(PickingListSalesOrder packingListSalesOrder,
            List<PickingListSalesOrderTradeItemDetail> listPickingListSalesOrderTradeItemDetail, 
            List<PickingListSalesOrderTradeItemQuantityDetail> listPickingListSalesOrderTradeItemQuantityDetail,
            String moduleCode) throws Exception {
        try {
            hbmSession.hSession.beginTransaction();
            
            packingListSalesOrder.setCode(createCode(packingListSalesOrder));
            packingListSalesOrder.setExchangeRate(new BigDecimal("1")); 
            packingListSalesOrder.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            packingListSalesOrder.setCreatedDate(new Date()); 
            
            saveDetail(packingListSalesOrder,listPickingListSalesOrderTradeItemDetail, listPickingListSalesOrderTradeItemQuantityDetail);
            
            hbmSession.hSession.save(packingListSalesOrder);
            hbmSession.hSession.flush();
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT), 
                                                                    packingListSalesOrder.getCode(), ""));
                                                                                                             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    //Save Detail
    private void saveDetail(PickingListSalesOrder packingListSalesOrder
            ,List<PickingListSalesOrderTradeItemDetail> listPickingListSalesOrderTradeItemDetail, 
            List<PickingListSalesOrderTradeItemQuantityDetail> listPickingListSalesOrderTradeItemQuantityDetail
    ) throws Exception{
        try {
            int i = 1;
            for(PickingListSalesOrderTradeItemDetail pickingListSalesOrderTradeItemDetail : listPickingListSalesOrderTradeItemDetail){
                               
                String detailCode = packingListSalesOrder.getCode()+ "-TRD" + "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                pickingListSalesOrderTradeItemDetail.setCode(detailCode);
                pickingListSalesOrderTradeItemDetail.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                pickingListSalesOrderTradeItemDetail.setCreatedDate(new Date());
                pickingListSalesOrderTradeItemDetail.setHeaderCode(packingListSalesOrder.getCode());
                
                hbmSession.hSession.save(pickingListSalesOrderTradeItemDetail);
                hbmSession.hSession.flush();

                i++;
                
            int k = 1;
            for(PickingListSalesOrderTradeItemQuantityDetail pickingListSalesOrderTradeItemQuantityDetail : listPickingListSalesOrderTradeItemQuantityDetail){
                if(pickingListSalesOrderTradeItemDetail.getItem().getCode().equals(pickingListSalesOrderTradeItemQuantityDetail.getItem().getCode())){

                    pickingListSalesOrderTradeItemQuantityDetail.setHeaderCode(packingListSalesOrder.getCode());
                    pickingListSalesOrderTradeItemQuantityDetail.setSalesOrderTradeItemDetailCode(pickingListSalesOrderTradeItemDetail.getCode());
                    String detailQuantityCode = pickingListSalesOrderTradeItemDetail.getCode() + "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(k),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    pickingListSalesOrderTradeItemQuantityDetail.setCode(detailQuantityCode);
                    pickingListSalesOrderTradeItemQuantityDetail.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    pickingListSalesOrderTradeItemQuantityDetail.setCreatedDate(new Date());

                    hbmSession.hSession.save(pickingListSalesOrderTradeItemQuantityDetail);
                    hbmSession.hSession.flush();
                    
                    k++;
                }                    
              }
            }
        } catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            e.printStackTrace();
            throw e;
        }
    }
    
    public List<PickingListSalesOrderTradeItemQuantityDetailTemp> findDataTradeItemQuantityDetailByReturnPickingList(String salesOrderCode) {
        try {
            List<PickingListSalesOrderTradeItemQuantityDetailTemp> list = (List<PickingListSalesOrderTradeItemQuantityDetailTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "	ivt_picking_list_so_trade_item_quantity_detail.Code, "
                + "	ivt_picking_list_so_trade_item_quantity_detail.HeaderCode, "
                + "	ivt_picking_list_so_trade_item_quantity_detail.ItemCode, "
                + "	mst_item.Name AS ItemName, "
                + "	ivt_picking_list_so_trade_item_quantity_detail.ItemAlias, "
                + "	mst_item.`UnitOfMeasureCode` AS ItemUnitOfMeasureCode, "
                + "	ivt_picking_list_so_trade_item_quantity_detail.Quantity, "
                + "	ivt_picking_list_so_trade_item_quantity_detail.COGSIDR, "
                + "	ivt_picking_list_so_trade_item_quantity_detail.RackCode, "
                + "	mst_rack.name AS RackName "
                + "FROM ivt_picking_list_so_trade_item_quantity_detail "
                + "INNER JOIN mst_item ON ivt_picking_list_so_trade_item_quantity_detail.ItemCode=mst_item.Code "
                + "INNER JOIN mst_rack ON ivt_picking_list_so_trade_item_quantity_detail.RackCode=mst_rack.code "
                + "INNER JOIN ivt_picking_list_so ON ivt_picking_list_so.Code=ivt_picking_list_so_trade_item_quantity_detail.HeaderCode "
                + "WHERE ivt_picking_list_so.SalesOrderCode=:prmHeaderCode")
                .addScalar("code", Hibernate.STRING)
                .addScalar("headerCode", Hibernate.STRING)
                .addScalar("itemCode", Hibernate.STRING)
                .addScalar("itemName", Hibernate.STRING)
                .addScalar("itemAlias", Hibernate.STRING)
                .addScalar("itemUnitOfMeasureCode", Hibernate.STRING)
                .addScalar("quantity", Hibernate.BIG_DECIMAL)
                .addScalar("cogsIdr", Hibernate.BIG_DECIMAL)
                .addScalar("rackCode", Hibernate.STRING)
                .addScalar("rackName", Hibernate.STRING)
                .setParameter("prmHeaderCode",salesOrderCode)
                .setResultTransformer(Transformers.aliasToBean(PickingListSalesOrderTradeItemQuantityDetailTemp.class))
                .list(); 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<PickingListSalesOrderBonusItemQuantityDetailTemp> findDataTradeItemBonusQuantityDetailByReturnPickingList(String salesOrderCode) {
        try {
            
            List<PickingListSalesOrderBonusItemQuantityDetailTemp> list = (List<PickingListSalesOrderBonusItemQuantityDetailTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "     ivt_picking_list_so_bonus_item_quantity_detail.Code, "
                + "	ivt_picking_list_so_bonus_item_quantity_detail.HeaderCode, "
                + "	ivt_picking_list_so_bonus_item_quantity_detail.ItemCode, "
                + "	mst_item.Name AS ItemName, "
                + "	mst_item.`UnitOfMeasureCode` AS ItemUnitOfMeasureCode, "
                + "	ivt_picking_list_so_bonus_item_quantity_detail.Quantity, "
                + "	ivt_picking_list_so_bonus_item_quantity_detail.COGSIDR, "
                + "	ivt_picking_list_so_bonus_item_quantity_detail.RackCode, "
                + "	mst_rack.name AS RackName "
                + "FROM ivt_picking_list_so_bonus_item_quantity_detail "
                + "INNER JOIN mst_item ON ivt_picking_list_so_bonus_item_quantity_detail.ItemCode=mst_item.Code "
                + "INNER JOIN mst_rack ON ivt_picking_list_so_bonus_item_quantity_detail.RackCode=mst_rack.code "
                + "INNER JOIN ivt_picking_list_so ON ivt_picking_list_so.Code=ivt_picking_list_so_bonus_item_quantity_detail.HeaderCode "
                + "WHERE ivt_picking_list_so.SalesOrderCode=:prmHeaderCode")
                .addScalar("code", Hibernate.STRING)
                .addScalar("headerCode", Hibernate.STRING)
                .addScalar("itemCode", Hibernate.STRING)
                .addScalar("itemName", Hibernate.STRING)
                .addScalar("itemUnitOfMeasureCode", Hibernate.STRING)
                .addScalar("quantity", Hibernate.BIG_DECIMAL)
                .addScalar("cogsIdr", Hibernate.BIG_DECIMAL)
                .addScalar("rackCode", Hibernate.STRING)
                .addScalar("rackName", Hibernate.STRING)
                .setParameter("prmHeaderCode",salesOrderCode)
                .setResultTransformer(Transformers.aliasToBean(PickingListSalesOrderBonusItemQuantityDetailTemp.class))
                .list(); 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void confirmation(PickingListSalesOrder pickingListSalesOrder,
            List<PickingListSalesOrderTradeItemDetail> listPickingListSalesOrderTradeItemDetail,
            List<PickingListSalesOrderTradeItemQuantityDetail> listPickingListSalesOrderTradeItemQuantityDetail, String moduleCode) throws Exception {
        try {
            
            hbmSession.hSession.beginTransaction();
            //get detail
            List<PickingListSalesOrderTradeItemDetailTemp> listItem = findDataTradeItemDetail(pickingListSalesOrder.getCode());

            //update quantity detail
            for(PickingListSalesOrderTradeItemDetailTemp detail : listItem){
                int stock = 0;
                for(PickingListSalesOrderTradeItemQuantityDetail qty : listPickingListSalesOrderTradeItemQuantityDetail){
                    if( detail.getCode().equalsIgnoreCase(qty.getSalesOrderTradeItemDetailCode()) && 
                        detail.getItemCode().equalsIgnoreCase(qty.getItem().getCode())){
                        stock += qty.getQuantity().intValue();
                    }
                }
                //update detail
                hbmSession.hSession.createSQLQuery("UPDATE ivt_picking_list_so_trade_item_detail SET "
                        + "ivt_picking_list_so_trade_item_detail.quantity = :prmQuantity "
                        + "WHERE ivt_picking_list_so_trade_item_detail.Code = :prmCode ")
                        .setParameter("prmQuantity", stock)
                        .setParameter("prmCode", detail.getCode())
                        .executeUpdate();
                hbmSession.hSession.flush();
            }
            //delete item quantity detail
            hbmSession.hSession.createSQLQuery("DELETE FROM ivt_picking_list_so_trade_item_quantity_detail "
                    + " WHERE ivt_picking_list_so_trade_item_quantity_detail.HeaderCode = :prmHeaderCode")      
                    .setParameter("prmHeaderCode", pickingListSalesOrder.getCode())
                    .executeUpdate();
            hbmSession.hSession.flush();
            //insert item quantity detail new
            int k = 1;
            for(PickingListSalesOrderTradeItemQuantityDetail pickingListSalesOrderTradeItemQuantityDetail : listPickingListSalesOrderTradeItemQuantityDetail){
                pickingListSalesOrderTradeItemQuantityDetail.setHeaderCode(pickingListSalesOrder.getCode());
                String detailQuantityCode = pickingListSalesOrderTradeItemQuantityDetail.getSalesOrderTradeItemDetailCode() + "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(k),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                pickingListSalesOrderTradeItemQuantityDetail.setCode(detailQuantityCode);
                pickingListSalesOrderTradeItemQuantityDetail.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                pickingListSalesOrderTradeItemQuantityDetail.setCreatedDate(new Date());
                
                hbmSession.hSession.save(pickingListSalesOrderTradeItemQuantityDetail);
                hbmSession.hSession.flush();
                
//                System.out.println("kokonataka2" + pickingListSalesOrderTradeItemQuantityDetail.getQuantity().doubleValue());
//                System.out.println("kokonataka3" + pickingListSalesOrder.getWarehouse().getCode());
//                System.out.println("kokonataka4" + pickingListSalesOrderTradeItemQuantityDetail.getItem().getCode());
//                System.out.println("kokonataka5" + pickingListSalesOrder.getWarehouse().getDockInCode());
              
                hbmSession.hSession.createQuery("UPDATE " + InventoryActualStockField.BEAN_NAME + "  "
                + "SET " + InventoryActualStockField.ACTUALSTOCK + "= " + InventoryActualStockField.ACTUALSTOCK + " - :prmUsedStockQuantity  "
                + "WHERE warehouse.code = :prmWarehouseCode "
                + "AND item.code = :prmItemCode "
                + "AND rack.code = :prmRackCode ")
                .setParameter("prmUsedStockQuantity", pickingListSalesOrderTradeItemQuantityDetail.getQuantity().doubleValue())
                .setParameter("prmWarehouseCode", pickingListSalesOrder.getWarehouse().getCode())
                .setParameter("prmItemCode", pickingListSalesOrderTradeItemQuantityDetail.getItem().getCode())
                .setParameter("prmRackCode", pickingListSalesOrder.getWarehouse().getDockInCode())
                .executeUpdate();
                hbmSession.hSession.flush();
                
                String rackCode = pickingListSalesOrder.getWarehouse().getDockDlnCode();
                String itemCode = pickingListSalesOrderTradeItemQuantityDetail.getItem().getCode()+"-";
                String warehouseCode = pickingListSalesOrder.getWarehouse().getCode()+"/";
                String acronimo = warehouseCode + itemCode + rackCode;
           
                String branchCode;
                branchCode = pickingListSalesOrder.getBranch().getCode();
                if(pickingListSalesOrderTradeItemQuantityDetail.getItem().getInventoryType().equals("INVENTORY")){
                    InventoryInOutDAO inventoryInOutDAO = new InventoryInOutDAO(hbmSession);
                    IvtActualStock newRec = new IvtActualStock();
                    int actualStock_SortNo =0;
                                        
                    newRec = InventoryCommon.newInstance(
                            pickingListSalesOrder.getWarehouse().getCode(),
                            branchCode,
                            pickingListSalesOrderTradeItemQuantityDetail.getItem().getCode(),
                            pickingListSalesOrderTradeItemQuantityDetail.getQuantity(),
                            pickingListSalesOrderTradeItemQuantityDetail.getItem().getCogsIDR(),
                            pickingListSalesOrder.getWarehouse().getDockDlnCode());
                    
//                    inventoryInOutDAO.ActualStockPickingIncrease_AVG(newRec, false, true,
//                            pickingListSalesOrder.getCode()+"-",EnumCOGSType.ENUM_COGSType.IIN,actualStock_SortNo);
                }
                
//                hbmSession.hSession.createSQLQuery(
//                "insert into mst_item_jn_current_stock(Code,WarehouseCode,ItemCode,RackCode,ActualStock) "
//                + "values('"+acronimo+"','"+pickingListSalesOrder.getWarehouse().getCode()+"', "
//                + "'"+pickingListSalesOrderTradeItemQuantityDetail.getItem().getCode()+"','"+rackCode+"','"+pickingListSalesOrderTradeItemQuantityDetail.getQuantity().doubleValue()+"')")
//                .executeUpdate();
//                 hbmSession.hSession.flush();
                k++;
            }
            
            // update status di header
            hbmSession.hSession.createSQLQuery("UPDATE ivt_picking_list_so SET "
                    + "ivt_picking_list_so.ConfirmationBy = :prmConfirmationBy, "
                    + "ivt_picking_list_so.ConfirmationDate = :prmConfirmationDate, "
                    + "ivt_picking_list_so.ConfirmationStatus = 'APPROVED' "
                    + "WHERE ivt_picking_list_so.Code = :prmCode ")
                    .setParameter("prmConfirmationBy", BaseSession.loadProgramSession().getUserName())
                    .setParameter("prmConfirmationDate", new Date())
                    .setParameter("prmCode", pickingListSalesOrder.getCode())
                    .executeUpdate();
            hbmSession.hSession.flush();

            //insert transaction log
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                    pickingListSalesOrder.getCode(), "PLT - Sales Order Confirmation"));
            
            hbmSession.hTransaction.commit();
            hbmSession.hSession.clear();
            hbmSession.hSession.close();
                      
        }
        catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    //Delete
    public void delete(String code, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            // ambil isi header, detail item, detail bonus => complete
            PickingListSalesOrder pickingListSalesOrder = (PickingListSalesOrder)hbmSession.hSession.get(PickingListSalesOrder.class, code);
            List<PickingListSalesOrderTradeItemQuantityDetailTemp> listItem = findDataTradeItemQuantityDetail(code);
            
//             balikan booked stock item
            for (PickingListSalesOrderTradeItemQuantityDetailTemp detailItem : listItem) {
                
                BigDecimal totalQuantity = detailItem.getQuantity().multiply(detailItem.getConversion());
                
                /* UPDATE BOOKED STOCK */
                hbmSession.hSession.createQuery("UPDATE " + InventoryActualStockField.BEAN_NAME + "  "
                + "SET " + InventoryActualStockField.ACTUALSTOCK + "= " + InventoryActualStockField.ACTUALSTOCK + "+ :prmUsedStockQuantity  "
                        + "WHERE warehouse.code = :prmWarehouseCode "
                        + "AND item.code = :prmItemCode "
                        + "AND rack.code = :prmRackCode ")
                        .setParameter("prmUsedStockQuantity", totalQuantity.doubleValue())
                        .setParameter("prmWarehouseCode", pickingListSalesOrder.getWarehouse().getCode())
                        .setParameter("prmItemCode", detailItem.getItemCode())
                        .setParameter("prmRackCode", detailItem.getRackCode())
                        .executeUpdate();
                hbmSession.hSession.flush();
            }
            
            //Delete Detail Item Quantity
            hbmSession.hSession.createSQLQuery("DELETE FROM ivt_picking_list_so_trade_item_quantity_detail "
                    + " WHERE ivt_picking_list_so_trade_item_quantity_detail.HeaderCode = :prmHeaderCode")      
                    .setParameter("prmHeaderCode", code)
                    .executeUpdate();
            hbmSession.hSession.flush();
            
            //Delete Detail Item
            hbmSession.hSession.createSQLQuery("DELETE FROM ivt_picking_list_so_trade_item_detail "
                    + " WHERE ivt_picking_list_so_trade_item_detail.HeaderCode = :prmHeaderCode")      
                    .setParameter("prmHeaderCode", code)
                    .executeUpdate();
            hbmSession.hSession.flush();
            
            //Delete Header
            hbmSession.hSession.createSQLQuery("DELETE FROM ivt_picking_list_so "
                    + " WHERE ivt_picking_list_so.Code = :prmHeaderCode")      
                    .setParameter("prmHeaderCode", code)
                    .executeUpdate();
            hbmSession.hSession.flush();
                    
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.DELETE), 
                                                                    code, ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    //Delete Picking List Check
    public String pickingListSOConfirmed(String code){
        try{
            String temp = (String) hbmSession.hSession.createSQLQuery(""
                    + "SELECT ivt_picking_list_so.ConfirmationStatus "
                    + "FROM ivt_picking_list_so "
                    + "WHERE ivt_picking_list_so.Code = :prmCode ")
                    .setParameter("prmCode", code)
                    .uniqueResult().toString();
            
            return temp;
        }catch(HibernateException e){
            return "ERROR";
        }catch(Exception e){
            return "ERROR";   
        }
    }
    //Update Picking List Check
    public int pickingListSOUsedInDLN(String code){
        try{
            BigInteger temp = (BigInteger) hbmSession.hSession.createSQLQuery(""
                    + "SELECT COUNT(ivt_delivery_note_so_jn_picking_list_so.Code) "
                    + "FROM ivt_delivery_note_so_jn_picking_list_so "
                    + "WHERE ivt_delivery_note_so_jn_picking_list_so.PickingListSOCode = :prmCode ")
                    .setParameter("prmCode", code)
                    .uniqueResult();
            
            return temp.intValue();
        }catch(HibernateException e){
            return 0;
        }catch(Exception e){
            return 0;   
        }
    }
    
    public int countItemStock(String warehouseCode, String itemCode){
        try{            
            String[] itemSplit = itemCode.split(",");
            String stringTemp = "";
            for(int i = 0; i < itemSplit.length; i++){
                if(i == 0){
                    stringTemp += "'" + itemSplit[i] + "'";
                }else{
                    stringTemp += ",'" + itemSplit[i] + "'";
                }
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
               "SELECT "
                + "COUNT(*) "
            + "FROM "
                + "mst_item_jn_current_stock "
            + "WHERE "
                + "mst_item_jn_current_stock.warehouseCode = :prmWarehouseCode "
            + "AND "
                + "mst_item_jn_current_stock.itemCode IN (:prmItemCode)")
            .setParameter("prmWarehouseCode", warehouseCode)
            .setParameter("prmItemCode", stringTemp)
            .uniqueResult();

            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<ItemCurrentStockTemp> findItemStock(String warehouseCode, String itemCode, int from, int to) {
        try {   
            
            String[] itemSplit = itemCode.split(",");
            String stringTemp = "";
            for(int i = 0; i < itemSplit.length; i++){
                if(i == 0){
                    stringTemp += "'" + itemSplit[i] + "'";
                }else{
                    stringTemp += ",'" + itemSplit[i] + "'";
                }
            }
            
            List<ItemCurrentStockTemp> list = (List<ItemCurrentStockTemp>)hbmSession.hSession.createSQLQuery(
                        "SELECT "
                            + "mst_item_jn_current_stock.ItemCode, "
                            + "mst_item.name AS itemName, "
                            + "'' AS itemAlias, "
                            + "mst_item.UnitOfMeasureCode AS itemUnitOfMeasureCode, "
                            + "mst_item_jn_current_stock.actualStock AS actualStock, "
                            + "mst_item_jn_current_stock.rackCode, "
                            + "mst_rack.name AS rackName "
                        + "FROM "
                            + "mst_item_jn_current_stock "
                        + "INNER JOIN "
                            + "mst_item ON mst_item_jn_current_stock.itemCode = mst_item.code "
                        + "INNER JOIN "
                            + "mst_rack ON mst_item_jn_current_stock.rackCode = mst_rack.code "
                        + "WHERE "
                            + "mst_item_jn_current_stock.warehouseCode = '"+warehouseCode+"' "
                        + "AND "
                            + "mst_item_jn_current_stock.itemCode IN ("+stringTemp+")")
                    
                    .addScalar("itemCode", Hibernate.STRING)
                    .addScalar("itemName", Hibernate.STRING)
                    .addScalar("itemAlias", Hibernate.STRING)
                    .addScalar("itemUnitOfMeasureCode", Hibernate.STRING)
                    .addScalar("actualStock", Hibernate.BIG_DECIMAL)
                    .addScalar("rackCode", Hibernate.STRING)
                    .addScalar("rackName", Hibernate.STRING)
                
//                    .setParameter("prmWarehouseCode", warehouseCode)
//                    .setParameter("prmItemCode", stringTemp)
//                    .setFirstResult(from)
//                    .setMaxResults(to)
                    .setResultTransformer(Transformers.aliasToBean(ItemCurrentStockTemp.class))
                    .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            e.printStackTrace();
            throw e;
        }
    }
    
    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public CommonFunction getCommonFunction() {
        return commonFunction;
    }

    public void setCommonFunction(CommonFunction commonFunction) {
        this.commonFunction = commonFunction;
    }
    
}
