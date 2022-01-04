
package com.inkombizz.sales.dao;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.CommonConst;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumActivity;
import com.inkombizz.common.enumeration.EnumClosingStatus;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.common.enumeration.EnumTransactionType;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.dao.common.AutoNumber;
import com.inkombizz.sales.model.CustomerPurchaseOrder;
import com.inkombizz.sales.model.CustomerPurchaseOrderAdditionalFee;
import com.inkombizz.sales.model.CustomerPurchaseOrderAdditionalFeeField;
import com.inkombizz.sales.model.CustomerPurchaseOrderItemDeliveryDate;
import com.inkombizz.sales.model.CustomerPurchaseOrderItemDeliveryDateField;
import com.inkombizz.sales.model.CustomerPurchaseOrderItemDetail;
import com.inkombizz.sales.model.CustomerPurchaseOrderItemDetailField;
import com.inkombizz.sales.model.CustomerPurchaseOrderPaymentTerm;
import com.inkombizz.sales.model.CustomerPurchaseOrderPaymentTermField;
import com.inkombizz.sales.model.CustomerPurchaseOrderSalesQuotation;
import com.inkombizz.sales.model.CustomerPurchaseOrderSalesQuotationField;
import com.inkombizz.sales.model.CustomerBlanketOrder;
import com.inkombizz.sales.model.CustomerBlanketOrderAdditionalFee;
import com.inkombizz.sales.model.CustomerBlanketOrderAdditionalFeeField;
import com.inkombizz.sales.model.CustomerBlanketOrderItemDeliveryDate;
import com.inkombizz.sales.model.CustomerBlanketOrderItemDeliveryDateField;
import com.inkombizz.sales.model.CustomerBlanketOrderItemDetail;
import com.inkombizz.sales.model.CustomerBlanketOrderItemDetailField;
import com.inkombizz.sales.model.CustomerBlanketOrderPaymentTerm;
import com.inkombizz.sales.model.CustomerBlanketOrderPaymentTermField;
import com.inkombizz.sales.model.CustomerBlanketOrderSalesQuotation;
import com.inkombizz.sales.model.CustomerBlanketOrderSalesQuotationField;
import com.inkombizz.system.dao.TransactionLogDAO;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.transform.Transformers;


public class CustomerPurchaseOrderToBlanketOrderDAO {
    private HBMSession hbmSession;
    
    public CustomerPurchaseOrderToBlanketOrderDAO(HBMSession session) {
        this.hbmSession = session;
    }
    
    public int countData(CustomerPurchaseOrder customerPurchaseOrder, String validStatus) {
        try {
            
            String closingStatus=customerPurchaseOrder.getClosingStatus().equalsIgnoreCase(EnumClosingStatus.toString(EnumClosingStatus.ENUM_ClosingStatus.ALL)) ? "%%" : "%"+customerPurchaseOrder.getClosingStatus() +"%";
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                "CALL usp_customer_purchase_order_list_blanket_order(:prmFlag,:prmCode,:prmCustomerCode,:prmCustomerName,"
                        + ":prmSalesPersonCode,:prmSalesPersonName,:prmRefNo,:prmRemark,:prmClosingStatus,:prmValidStatus,:prmFirstDate,:prmLastDate,0,0)")
                .setParameter("prmFlag", "COUNT")
                .setParameter("prmCode", "%"+customerPurchaseOrder.getCode()+"%")
                .setParameter("prmCustomerCode","%"+customerPurchaseOrder.getCustomerCode() +"%")
                .setParameter("prmCustomerName","%"+customerPurchaseOrder.getCustomerName()+"%")
                .setParameter("prmSalesPersonCode", "%"+customerPurchaseOrder.getSalesPersonCode()+"%")
                .setParameter("prmSalesPersonName", "%"+customerPurchaseOrder.getSalesPersonName()+"%")
                .setParameter("prmRefNo", "%"+customerPurchaseOrder.getRefNo()+"%")
                .setParameter("prmRemark", "%"+customerPurchaseOrder.getRemark()+"%")
                .setParameter("prmClosingStatus", closingStatus)    
                .setParameter("prmValidStatus", validStatus)    
                .setParameter("prmFirstDate", customerPurchaseOrder.getTransactionFirstDate())
                .setParameter("prmLastDate", customerPurchaseOrder.getTransactionLastDate())
                .uniqueResult();
            return temp.intValue();

        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<CustomerPurchaseOrder> findData(CustomerPurchaseOrder customerPurchaseOrder, String validStatus,int from, int to) {
        try {
            String closingStatus=customerPurchaseOrder.getClosingStatus().equalsIgnoreCase(EnumClosingStatus.toString(EnumClosingStatus.ENUM_ClosingStatus.ALL)) ? "%%" : "%"+customerPurchaseOrder.getClosingStatus() +"%";
            List<CustomerPurchaseOrder> list = (List<CustomerPurchaseOrder>)hbmSession.hSession.createSQLQuery(
                    "CALL usp_customer_purchase_order_list_blanket_order(:prmFlag,:prmCode,:prmCustomerCode,:prmCustomerName,"
                        + ":prmSalesPersonCode,:prmSalesPersonName,:prmRefNo,:prmRemark,:prmClosingStatus,:prmValidStatus,:prmFirstDate,:prmLastDate,:prmLimitFrom,:prmLimitTo)")                       
                .addScalar("code", Hibernate.STRING)
                .addScalar("custPONo", Hibernate.STRING)
                .addScalar("revision", Hibernate.STRING)
                .addScalar("refCUSTPOCode", Hibernate.STRING) 
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("customerPurchaseOrderNo", Hibernate.STRING)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("branchName", Hibernate.STRING)
                .addScalar("customerCode", Hibernate.STRING)
                .addScalar("customerName", Hibernate.STRING)
                .addScalar("currencyCode", Hibernate.STRING)
                .addScalar("currencyName", Hibernate.STRING)
                .addScalar("endUserCode", Hibernate.STRING)
                .addScalar("endUserName", Hibernate.STRING)                                 
                .addScalar("partialShipmentStatus", Hibernate.STRING) 
                .addScalar("orderStatus", Hibernate.STRING) 
                .addScalar("retentionPercent", Hibernate.BIG_DECIMAL)    
                .addScalar("currencyCode", Hibernate.STRING)    
                .addScalar("currencyName", Hibernate.STRING)    
                .addScalar("salesPersonCode", Hibernate.STRING)    
                .addScalar("salesPersonName", Hibernate.STRING)    
                .addScalar("projectCode", Hibernate.STRING)     
                .addScalar("projectName", Hibernate.STRING)     
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("closingStatus", Hibernate.STRING)
                .addScalar("totalTransactionAmount", Hibernate.BIG_DECIMAL)
                .addScalar("discountPercent", Hibernate.BIG_DECIMAL)
                .addScalar("discountAmount", Hibernate.BIG_DECIMAL)
                .addScalar("totalAdditionalFeeAmount", Hibernate.BIG_DECIMAL)
                .addScalar("taxBaseAmount", Hibernate.BIG_DECIMAL)
                .addScalar("vatPercent", Hibernate.BIG_DECIMAL)
                .addScalar("vatAmount", Hibernate.BIG_DECIMAL)
                .addScalar("grandTotalAmount", Hibernate.BIG_DECIMAL)
                .setParameter("prmFlag", "LISTS")
                .setParameter("prmCode", "%"+customerPurchaseOrder.getCode()+"%")
                .setParameter("prmCustomerCode","%"+customerPurchaseOrder.getCustomerCode() +"%")
                .setParameter("prmCustomerName","%"+customerPurchaseOrder.getCustomerName()+"%")
                .setParameter("prmSalesPersonCode", "%"+customerPurchaseOrder.getSalesPersonCode()+"%")
                .setParameter("prmSalesPersonName", "%"+customerPurchaseOrder.getSalesPersonName()+"%")
                .setParameter("prmRefNo", "%"+customerPurchaseOrder.getRefNo()+"%")
                .setParameter("prmRemark", "%"+customerPurchaseOrder.getRemark()+"%")
                .setParameter("prmClosingStatus", closingStatus)    
                .setParameter("prmValidStatus", validStatus)    
                .setParameter("prmFirstDate", customerPurchaseOrder.getTransactionFirstDate())
                .setParameter("prmLastDate", customerPurchaseOrder.getTransactionLastDate())
                .setParameter("prmLimitFrom", from)
                .setParameter("prmLimitTo", to)
                .setResultTransformer(Transformers.aliasToBean(CustomerPurchaseOrder.class))
                .list(); 
                 
                return list;
        } catch (HibernateException e) {
            throw e;
        }
    }
//    
    public List<CustomerPurchaseOrderSalesQuotation> findDataSalesQuotation(String headerCode) {
        try {
            
            List<CustomerPurchaseOrderSalesQuotation> list = (List<CustomerPurchaseOrderSalesQuotation>)hbmSession.hSession.createSQLQuery(
                "SELECT " 
                + "sal_customer_purchase_order_jn_sales_quotation.SalesQuotationCode AS SalesQuotationCode, "
                + "sal_sales_quotation.TransactionDate AS SalesQuotationTransactionDate, "
                + "mst_customer.Code AS salesQuotationCustomerCode, "
                + "mst_customer.Name AS salesQuotationCustomerName, "
                + "sal_sales_quotation.EndUserCode AS salesQuotationEndUserCode, "
                + "endUser.Name AS salesQuotationEndUserName, "
                + "sal_sales_quotation.subject AS salesQuotationSubject, "
                + "sal_sales_quotation.RFQCode AS salesQuotationRfqCode, "
                + "sal_sales_quotation.ProjectCode AS salesQuotationProject, "
                + "sal_sales_quotation.Attn AS salesQuotationAttn, "
                + "sal_sales_quotation.RefNo AS salesQuotationRefNo, "
                + "sal_sales_quotation.Remark AS salesQuotationRemark "
                    + "FROM sal_customer_purchase_order_jn_sales_quotation "
                + "INNER JOIN "
                    + "sal_sales_quotation ON sal_sales_quotation.Code = sal_customer_purchase_order_jn_sales_quotation.SalesQuotationCode "
                + "INNER JOIN "
                    + "mst_customer ON mst_customer.Code = sal_sales_quotation.CustomerCode "
                + "INNER JOIN "
                    + "mst_customer endUser ON sal_sales_quotation.EndUserCode = endUser.Code "
                + "WHERE sal_customer_purchase_order_jn_sales_quotation.HeaderCode=:prmHeaderCode"
            )
                        
                .addScalar("salesQuotationCode", Hibernate.STRING)
                .addScalar("SalesQuotationTransactionDate", Hibernate.TIMESTAMP)
                .addScalar("salesQuotationCustomerCode", Hibernate.STRING)
                .addScalar("salesQuotationCustomerName", Hibernate.STRING)
                .addScalar("salesQuotationRfqCode", Hibernate.STRING)
                .addScalar("salesQuotationProject", Hibernate.STRING)
                .addScalar("salesQuotationAttn", Hibernate.STRING)
                .addScalar("salesQuotationRefNo", Hibernate.STRING)
                .addScalar("salesQuotationRemark", Hibernate.STRING)
                .addScalar("salesQuotationRemark", Hibernate.STRING)
                .addScalar("salesQuotationEndUserCode", Hibernate.STRING)
                .addScalar("salesQuotationEndUserName", Hibernate.STRING)
                .addScalar("salesQuotationSubject", Hibernate.STRING)
                .setParameter("prmHeaderCode", headerCode)
                .setResultTransformer(Transformers.aliasToBean(CustomerPurchaseOrderSalesQuotation.class))
                .list(); 
                 
            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<CustomerPurchaseOrderItemDetail> findDataItemDetail(String headerCode) {
        try {
            
            List<CustomerPurchaseOrderItemDetail> list = (List<CustomerPurchaseOrderItemDetail>)hbmSession.hSession.createSQLQuery(
                "SELECT "
                + " sal_customer_purchase_order_item_detail.SalesQuotationCode, "
                + " sal_customer_purchase_order_item_detail.CustomerPurchaseOrderSortNo AS customerPurchaseOrderSortNo, "
                
                + " sal_customer_purchase_order_item_detail.ItemFinishGoodsCode AS itemFinishGoodsCode, "
                + " mst_item_finish_goods.Remark AS itemFinishGoodsRemark, "
                + " sal_customer_purchase_order_item_detail.Code AS salesQuotationDetailCode, "
                + " sal_customer_purchase_order_item_detail.ItemAlias AS itemAlias, "
                
                + " sal_sales_quotation_detail.ValveTypeCode, "
                + " mst_valve_type.Name AS ValveTypeName, "
                + " sal_sales_quotation_detail.ValveTag, "
                + "sal_sales_quotation_detail.dataSheet, "
                + "sal_sales_quotation_detail.description, "
                
                + "sal_sales_quotation_detail.bodyConstruction, "
                + "sal_sales_quotation_detail.typeDesign, "
                + "sal_sales_quotation_detail.seatDesign, "
                + "sal_sales_quotation_detail.Size, "
                + "sal_sales_quotation_detail.Rating, "
                + "sal_sales_quotation_detail.Bore, "
                
                + "sal_sales_quotation_detail.EndCon, "
                + "sal_sales_quotation_detail.Body, "
                + "sal_sales_quotation_detail.Ball, "
                + "sal_sales_quotation_detail.Seat, "
                + "sal_sales_quotation_detail.SeatInsert, "
                + "sal_sales_quotation_detail.Stem, "
                        
                + "sal_sales_quotation_detail.Seal, "
                + "sal_sales_quotation_detail.Bolting, "
                + "sal_sales_quotation_detail.Disc, "
                + "sal_sales_quotation_detail.Plates, "
                + "sal_sales_quotation_detail.Shaft, "
                + "sal_sales_quotation_detail.Spring, "
                        
                + "sal_sales_quotation_detail.ArmPin, "
                + "sal_sales_quotation_detail.Backseat, "
                + "sal_sales_quotation_detail.Arm, "
                + "sal_sales_quotation_detail.HingePin, "
                + "sal_sales_quotation_detail.StopPin, "
                + "sal_sales_quotation_detail.Oper AS operator, "
                
                + " sal_sales_quotation_detail.Note, "
                + " sal_sales_quotation_detail.Quantity, "
                + " sal_sales_quotation_detail.UnitPrice, "
                + " sal_sales_quotation_detail.TotalAmount, "
                
                //FinishGoodQuotation
                + " IFNULL(mst_item_finish_goods.ItemBodyConstructionCode,'') AS itemBodyConstructionCode, "
                + " IFNULL(mst_item_body_construction.Name,'') AS itemBodyConstructionName, "
                + " IFNULL(mst_item_finish_goods.ItemTypeDesignCode,'') AS itemTypeDesignCode, "
                + " IFNULL(mst_item_type_design.Name,'') AS itemTypeDesignName, "
                + " IFNULL(mst_item_finish_goods.ItemSeatDesignCode,'') AS itemSeatDesignCode, "
                + " IFNULL(mst_item_seat_design.Name,'') AS itemSeatDesignName, "
                + " IFNULL(mst_item_finish_goods.ItemSizeCode,'') AS itemSizeCode, "
                + " IFNULL(mst_item_size.Name,'') AS itemSizeName, "
                + " IFNULL(mst_item_finish_goods.ItemRatingCode,'') AS itemRatingCode, "
                + " IFNULL(mst_item_rating.Name,'') AS itemRatingName, "
                + " IFNULL(mst_item_finish_goods.ItemBoreCode,'') AS itemBoreCode, "
                + " IFNULL(mst_item_bore.Name,'') AS itemBoreName, "
                
                + " IFNULL(mst_item_finish_goods.ItemEndConCode,'') AS itemEndConCode, "
                + " IFNULL(mst_item_end_con.Name,'') AS itemEndConName, "
                + " IFNULL(mst_item_finish_goods.ItemBodyCode,'') AS itemBodyCode, "
                + " IFNULL(mst_item_body.Name,'') AS itemBodyName, "
                + " IFNULL(mst_item_finish_goods.ItemBallCode,'') AS itemBallCode, "
                + " IFNULL(mst_item_ball.Name,'') AS itemBallName, "
                + " IFNULL(mst_item_finish_goods.ItemSeatCode,'') AS itemSeatCode, "
                + " IFNULL(mst_item_seat.Name,'') AS itemSeatName, "
                + " IFNULL(mst_item_finish_goods.ItemSeatInsertCode,'') AS itemSeatInsertCode, "
                + " IFNULL(mst_item_seat_insert.Name,'') AS itemSeatInsertName, "
                + " IFNULL(mst_item_finish_goods.ItemStemCode,'') AS itemStemCode, "
                + " IFNULL(mst_item_stem.Name,'') AS itemStemName, "
                
                + " IFNULL(mst_item_finish_goods.ItemSealCode,'') AS itemSealCode, "
                + " IFNULL(mst_item_seal.Name,'') AS itemSealName, "
                + " IFNULL(mst_item_finish_goods.ItemBoltCode,'') AS itemBoltCode, "
                + " IFNULL(mst_item_bolt.Name,'') AS itemBoltName, "
                + " IFNULL(mst_item_finish_goods.ItemDiscCode,'') AS itemDiscCode, "
                + " IFNULL(mst_item_disc.Name,'') AS itemDiscName, "
                + " IFNULL(mst_item_finish_goods.ItemPlatesCode,'') AS itemPlatesCode, "
                + " IFNULL(mst_item_plates.Name,'') AS itemPlatesName, "
                + " IFNULL(mst_item_finish_goods.ItemShaftCode,'') AS itemShaftCode, "
                + " IFNULL(mst_item_shaft.Name,'') AS itemShaftName, "
                + " IFNULL(mst_item_finish_goods.ItemSpringCode,'') AS itemSpringCode, "
                + " IFNULL(mst_item_spring.Name,'') ItemSpringName, "
                
                + " IFNULL(mst_item_finish_goods.ItemArmPinCode,'') AS itemArmPinCode, "
                + " IFNULL(mst_item_arm.Name,'') AS itemArmPinName, "

                + " IFNULL(mst_item_finish_goods.ItemBackSeatCode,'') AS itemBackSeatCode, "
                + " IFNULL(mst_item_backseat.Name,'') AS itemBackSeatName, "

                + " IFNULL(mst_item_finish_goods.ItemArmCode,'') AS itemArmCode, "
                + " IFNULL(mst_item_arm.Name,'') AS itemArmName, "

                + " IFNULL(mst_item_finish_goods.ItemHingePinCode,'') AS itemHingePinCode, "
                + " IFNULL(mst_item_hinge_pin.Name,'') AS itemHingePinName, "

                + " IFNULL(mst_item_finish_goods.ItemStopPinCode,'') AS itemStopPinCode, "
                + " IFNULL(mst_item_stop_pin.Name,'') AS itemStopPinName, "

                + " IFNULL(mst_item_finish_goods.ItemOperatorCode,'') AS itemOperatorCode, "
                + " IFNULL(mst_item_operator.Name,'') AS itemOperatorName "
                
                + " FROM "
                + " sal_customer_purchase_order_item_detail "
                + " INNER JOIN `mst_item_finish_goods` ON mst_item_finish_goods.`code` = sal_customer_purchase_order_item_detail.`ItemFinishGoodsCode` "
                + " INNER JOIN sal_sales_quotation_detail ON sal_sales_quotation_detail.Code = sal_customer_purchase_order_item_detail.SalesQuotationDetailCode "
                + " INNER JOIN mst_valve_type ON mst_valve_type.Code = sal_sales_quotation_detail.ValveTypeCode "
                //join Finish Goods
                + " LEFT JOIN mst_item_body_construction ON mst_item_body_construction.Code = mst_item_finish_goods.ItemBodyConstructionCode "
                + " LEFT JOIN mst_item_type_design ON mst_item_type_design.Code = mst_item_finish_goods.ItemTypeDesignCode "
                + " LEFT JOIN mst_item_seat_design ON mst_item_seat_design.Code = mst_item_finish_goods.ItemSeatDesignCode "
                + " LEFT JOIN mst_item_size ON mst_item_size.Code = mst_item_finish_goods.ItemSizeCode "
                + " LEFT JOIN mst_item_rating ON mst_item_rating.Code = mst_item_finish_goods.ItemRatingCode "
                + " LEFT JOIN mst_item_bore ON mst_item_bore.Code = mst_item_finish_goods.ItemBoreCode "
                    
                + " LEFT JOIN mst_item_end_con ON mst_item_end_con.Code = mst_item_finish_goods.ItemEndConCode "
                + " LEFT JOIN mst_item_body ON mst_item_body.Code = mst_item_finish_goods.ItemBodyCode "
                + " LEFT JOIN mst_item_ball ON mst_item_ball.Code = mst_item_finish_goods.ItemBallCode "
                + " LEFT JOIN mst_item_seat ON mst_item_seat.Code = mst_item_finish_goods.ItemSeatCode "
                + " LEFT JOIN mst_item_seat_insert ON mst_item_seat_insert.Code = mst_item_finish_goods.ItemSeatInsertCode "
                + " LEFT JOIN mst_item_stem ON mst_item_stem.Code = mst_item_finish_goods.ItemStemCode "
                        
                + " LEFT JOIN mst_item_seal ON mst_item_seal.Code = mst_item_finish_goods.ItemSealCode "
                + " LEFT JOIN mst_item_bolt ON mst_item_bolt.Code = mst_item_finish_goods.ItemBoltCode "
                + " LEFT JOIN mst_item_disc ON mst_item_disc.Code = mst_item_finish_goods.ItemDiscCode "
                + " LEFT JOIN mst_item_plates ON mst_item_plates.Code = mst_item_finish_goods.ItemPlatesCode "
                + " LEFT JOIN mst_item_shaft ON mst_item_shaft.Code = mst_item_finish_goods.ItemShaftCode "
                + " LEFT JOIN mst_item_spring ON mst_item_spring.Code = mst_item_finish_goods.ItemSpringCode "
                        
                + " LEFT JOIN mst_item_arm_pin ON mst_item_arm_pin.Code = mst_item_finish_goods.ItemArmPinCode "
                + " LEFT JOIN mst_item_backseat ON mst_item_backseat.Code = mst_item_finish_goods.ItemBackSeatCode "
                + " LEFT JOIN mst_item_arm ON mst_item_arm.Code = mst_item_finish_goods.ItemArmCode "
                + " LEFT JOIN mst_item_hinge_pin ON mst_item_hinge_pin.Code = mst_item_finish_goods.ItemHingePinCode "
                + " LEFT JOIN mst_item_stop_pin ON mst_item_stop_pin.Code = mst_item_finish_goods.ItemStopPinCode "
                + " LEFT JOIN mst_item_operator ON mst_item_operator.Code = mst_item_finish_goods.ItemOperatorCode "
                
                + " WHERE sal_customer_purchase_order_item_detail.HeaderCode =:prmHeaderCode "
            )

                .addScalar("salesQuotationCode", Hibernate.STRING)
                .addScalar("customerPurchaseOrderSortNo", Hibernate.BIG_DECIMAL)
                .addScalar("itemFinishGoodsCode", Hibernate.STRING)
                .addScalar("itemFinishGoodsRemark", Hibernate.STRING)
                .addScalar("salesQuotationDetailCode", Hibernate.STRING)
                .addScalar("valveTypeCode", Hibernate.STRING)
                .addScalar("valveTypeName", Hibernate.STRING)
                .addScalar("valveTag", Hibernate.STRING)
                .addScalar("dataSheet", Hibernate.STRING)
                .addScalar("description", Hibernate.STRING)
                .addScalar("itemAlias", Hibernate.STRING)
                    
                .addScalar("bodyConstruction", Hibernate.STRING)
                .addScalar("typeDesign", Hibernate.STRING)
                .addScalar("seatDesign", Hibernate.STRING)
                .addScalar("size", Hibernate.STRING)
                .addScalar("rating", Hibernate.STRING)
                .addScalar("bore", Hibernate.STRING)
                    
                .addScalar("endCon", Hibernate.STRING)
                .addScalar("body", Hibernate.STRING)
                .addScalar("ball", Hibernate.STRING)
                .addScalar("seat", Hibernate.STRING)
                .addScalar("seatInsert", Hibernate.STRING)
                .addScalar("stem", Hibernate.STRING)
                    
                .addScalar("seal", Hibernate.STRING)
                .addScalar("bolting", Hibernate.STRING)
                .addScalar("disc", Hibernate.STRING)
                .addScalar("plates", Hibernate.STRING)
                .addScalar("shaft", Hibernate.STRING)
                .addScalar("spring", Hibernate.STRING)
                    
                .addScalar("armPin", Hibernate.STRING)
                .addScalar("backSeat", Hibernate.STRING)
                .addScalar("arm", Hibernate.STRING)
                .addScalar("hingePin", Hibernate.STRING)
                .addScalar("StopPin", Hibernate.STRING)
                .addScalar("operator", Hibernate.STRING)
                    
                .addScalar("note", Hibernate.STRING)
                .addScalar("quantity", Hibernate.BIG_DECIMAL)
                .addScalar("unitPrice", Hibernate.BIG_DECIMAL)
                .addScalar("totalAmount", Hibernate.BIG_DECIMAL)
                    
                //finish goods
                .addScalar("itemBodyConstructionCode", Hibernate.STRING)
                .addScalar("itemBodyConstructionName", Hibernate.STRING)
                .addScalar("itemTypeDesignCode", Hibernate.STRING)
                .addScalar("itemTypeDesignName", Hibernate.STRING)
                .addScalar("itemSeatDesignCode", Hibernate.STRING)
                .addScalar("itemSeatDesignName", Hibernate.STRING)
                .addScalar("itemSizeCode", Hibernate.STRING)
                .addScalar("itemSizeName", Hibernate.STRING)
                .addScalar("itemRatingCode", Hibernate.STRING)
                .addScalar("itemRatingName", Hibernate.STRING)
                .addScalar("itemBoreCode", Hibernate.STRING)
                .addScalar("itemBoreName", Hibernate.STRING)
                    
                .addScalar("itemEndConCode", Hibernate.STRING)
                .addScalar("itemEndConName", Hibernate.STRING)
                .addScalar("itemBodyCode", Hibernate.STRING)
                .addScalar("itemBodyName", Hibernate.STRING)
                .addScalar("itemBallCode", Hibernate.STRING)
                .addScalar("itemBallName", Hibernate.STRING)
                .addScalar("itemSeatCode", Hibernate.STRING)
                .addScalar("itemSeatName", Hibernate.STRING)
                .addScalar("itemSeatInsertCode", Hibernate.STRING)
                .addScalar("itemSeatInsertName", Hibernate.STRING)
                .addScalar("itemStemCode", Hibernate.STRING)
                .addScalar("itemStemName", Hibernate.STRING)
                    
                .addScalar("itemSealCode", Hibernate.STRING)
                .addScalar("itemSealName", Hibernate.STRING)
                .addScalar("itemBoltCode", Hibernate.STRING)
                .addScalar("itemBoltName", Hibernate.STRING)
                .addScalar("itemDiscCode", Hibernate.STRING)
                .addScalar("itemDiscName", Hibernate.STRING)
                .addScalar("itemPlatesCode", Hibernate.STRING)
                .addScalar("itemPlatesName", Hibernate.STRING)
                .addScalar("itemShaftCode", Hibernate.STRING)
                .addScalar("itemShaftName", Hibernate.STRING)
                .addScalar("itemSpringCode", Hibernate.STRING)
                .addScalar("itemSpringName", Hibernate.STRING)
                    
                .addScalar("itemArmPinCode", Hibernate.STRING)
                .addScalar("itemArmPinName", Hibernate.STRING)
                .addScalar("itemBackSeatCode", Hibernate.STRING)
                .addScalar("itemBackSeatName", Hibernate.STRING)
                .addScalar("itemArmCode", Hibernate.STRING)
                .addScalar("itemArmName", Hibernate.STRING)
                .addScalar("itemHingePinCode", Hibernate.STRING)
                .addScalar("itemHingePinName", Hibernate.STRING)
                .addScalar("itemStopPinCode", Hibernate.STRING)
                .addScalar("itemStopPinName", Hibernate.STRING)
                .addScalar("itemOperatorCode", Hibernate.STRING)
                .addScalar("itemOperatorName", Hibernate.STRING)
                    
                .setParameter("prmHeaderCode", headerCode)
                .setResultTransformer(Transformers.aliasToBean(CustomerPurchaseOrderItemDetail.class))
                .list(); 

            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<CustomerPurchaseOrderItemDetail> findDataItemDetailArray(ArrayList arrSalesQuotationCode) {
        try {
            
            String strSalesQuotationNo=Arrays.toString(arrSalesQuotationCode.toArray());
            strSalesQuotationNo = strSalesQuotationNo.replaceAll("[\\[\\]]", "");
            strSalesQuotationNo = strSalesQuotationNo.replaceAll(",", "','");
            List<CustomerPurchaseOrderItemDetail> list = (List<CustomerPurchaseOrderItemDetail>)hbmSession.hSession.createSQLQuery(
                "SELECT "
                + " sal_customer_purchase_order_item_detail.SalesQuotationCode, "
                + " sal_customer_purchase_order_item_detail.CustomerPurchaseOrderSortNo AS customerPurchaseOrderSortNo, "
                
                + " sal_customer_purchase_order_item_detail.ItemFinishGoodsCode AS itemFinishGoodsCode, "
                + " mst_item_finish_goods.Remark AS itemFinishGoodsRemark, "
                + " sal_customer_purchase_order_item_detail.Code, "
                + " sal_customer_purchase_order_item_detail.salesQuotationDetailCode, "
                + " sal_customer_purchase_order_item_detail.ItemAlias AS itemAlias, "
                + " sal_customer_purchase_order_item_detail.ValveTag, "
                + "sal_customer_purchase_order_item_detail.dataSheet, "
                + "sal_customer_purchase_order_item_detail.description, "        
                + " sal_sales_quotation.RefNo, "
                
                + " sal_sales_quotation_detail.ValveTypeCode, "
                + " mst_valve_type.Name AS ValveTypeName, "
                
                + "sal_sales_quotation_detail.bodyConstruction, "
                + "sal_sales_quotation_detail.typeDesign, "
                + "sal_sales_quotation_detail.seatDesign, "
                + "sal_sales_quotation_detail.Size, "
                + "sal_sales_quotation_detail.Rating, "
                + "sal_sales_quotation_detail.Bore, "
                
                + "sal_sales_quotation_detail.EndCon, "
                + "sal_sales_quotation_detail.Body, "
                + "sal_sales_quotation_detail.Ball, "
                + "sal_sales_quotation_detail.Seat, "
                + "sal_sales_quotation_detail.SeatInsert, "
                + "sal_sales_quotation_detail.Stem, "
                        
                + "sal_sales_quotation_detail.Seal, "
                + "sal_sales_quotation_detail.Bolting, "
                + "sal_sales_quotation_detail.Disc, "
                + "sal_sales_quotation_detail.Plates, "
                + "sal_sales_quotation_detail.Shaft, "
                + "sal_sales_quotation_detail.Spring, "
                        
                + "sal_sales_quotation_detail.ArmPin, "
                + "sal_sales_quotation_detail.Backseat, "
                + "sal_sales_quotation_detail.Arm, "
                + "sal_sales_quotation_detail.HingePin, "
                + "sal_sales_quotation_detail.StopPin, "
                + "sal_sales_quotation_detail.Oper AS operator, "
                
                + " sal_sales_quotation_detail.Note, "
                + " sal_sales_quotation_detail.Quantity, "
                + " sal_sales_quotation_detail.UnitPrice, "
                + " sal_sales_quotation_detail.TotalAmount, "
                
                //FinishGoodQuotation
                + " IFNULL(mst_item_finish_goods.ItemBodyConstructionCode,'') AS itemBodyConstructionCode, "
                + " IFNULL(mst_item_body_construction.Name,'') AS itemBodyConstructionName, "
                + " IFNULL(mst_item_finish_goods.ItemTypeDesignCode,'') AS itemTypeDesignCode, "
                + " IFNULL(mst_item_type_design.Name,'') AS itemTypeDesignName, "
                + " IFNULL(mst_item_finish_goods.ItemSeatDesignCode,'') AS itemSeatDesignCode, "
                + " IFNULL(mst_item_seat_design.Name,'') AS itemSeatDesignName, "
                + " IFNULL(mst_item_finish_goods.ItemSizeCode,'') AS itemSizeCode, "
                + " IFNULL(mst_item_size.Name,'') AS itemSizeName, "
                + " IFNULL(mst_item_finish_goods.ItemRatingCode,'') AS itemRatingCode, "
                + " IFNULL(mst_item_rating.Name,'') AS itemRatingName, "
                + " IFNULL(mst_item_finish_goods.ItemBoreCode,'') AS itemBoreCode, "
                + " IFNULL(mst_item_bore.Name,'') AS itemBoreName, "
                
                + " IFNULL(mst_item_finish_goods.ItemEndConCode,'') AS itemEndConCode, "
                + " IFNULL(mst_item_end_con.Name,'') AS itemEndConName, "
                + " IFNULL(mst_item_finish_goods.ItemBodyCode,'') AS itemBodyCode, "
                + " IFNULL(mst_item_body.Name,'') AS itemBodyName, "
                + " IFNULL(mst_item_finish_goods.ItemBallCode,'') AS itemBallCode, "
                + " IFNULL(mst_item_ball.Name,'') AS itemBallName, "
                + " IFNULL(mst_item_finish_goods.ItemSeatCode,'') AS itemSeatCode, "
                + " IFNULL(mst_item_seat.Name,'') AS itemSeatName, "
                + " IFNULL(mst_item_finish_goods.ItemSeatInsertCode,'') AS itemSeatInsertCode, "
                + " IFNULL(mst_item_seat_insert.Name,'') AS itemSeatInsertName, "
                + " IFNULL(mst_item_finish_goods.ItemStemCode,'') AS itemStemCode, "
                + " IFNULL(mst_item_stem.Name,'') AS itemStemName, "
                
                + " IFNULL(mst_item_finish_goods.ItemSealCode,'') AS itemSealCode, "
                + " IFNULL(mst_item_seal.Name,'') AS itemSealName, "
                + " IFNULL(mst_item_finish_goods.ItemBoltCode,'') AS itemBoltCode, "
                + " IFNULL(mst_item_bolt.Name,'') AS itemBoltName, "
                + " IFNULL(mst_item_finish_goods.ItemDiscCode,'') AS itemDiscCode, "
                + " IFNULL(mst_item_disc.Name,'') AS itemDiscName, "
                + " IFNULL(mst_item_finish_goods.ItemPlatesCode,'') AS itemPlatesCode, "
                + " IFNULL(mst_item_plates.Name,'') AS itemPlatesName, "
                + " IFNULL(mst_item_finish_goods.ItemShaftCode,'') AS itemShaftCode, "
                + " IFNULL(mst_item_shaft.Name,'') AS itemShaftName, "
                + " IFNULL(mst_item_finish_goods.ItemSpringCode,'') AS itemSpringCode, "
                + " IFNULL(mst_item_spring.Name,'') ItemSpringName, "
                
                + " IFNULL(mst_item_finish_goods.ItemArmPinCode,'') AS itemArmPinCode, "
                + " IFNULL(mst_item_arm.Name,'') AS itemArmPinName, "

                + " IFNULL(mst_item_finish_goods.ItemBackSeatCode,'') AS itemBackSeatCode, "
                + " IFNULL(mst_item_backseat.Name,'') AS itemBackSeatName, "

                + " IFNULL(mst_item_finish_goods.ItemArmCode,'') AS itemArmCode, "
                + " IFNULL(mst_item_arm.Name,'') AS itemArmName, "

                + " IFNULL(mst_item_finish_goods.ItemHingePinCode,'') AS itemHingePinCode, "
                + " IFNULL(mst_item_hinge_pin.Name,'') AS itemHingePinName, "

                + " IFNULL(mst_item_finish_goods.ItemStopPinCode,'') AS itemStopPinCode, "
                + " IFNULL(mst_item_stop_pin.Name,'') AS itemStopPinName, "

                + " IFNULL(mst_item_finish_goods.ItemOperatorCode,'') AS itemOperatorCode, "
                + " IFNULL(mst_item_operator.Name,'') AS itemOperatorName "
                
                + " FROM "
                + " sal_customer_purchase_order_item_detail "
                + " INNER JOIN `mst_item_finish_goods` ON mst_item_finish_goods.`code` = sal_customer_purchase_order_item_detail.`ItemFinishGoodsCode` "
                + " INNER JOIN sal_sales_quotation_detail ON sal_sales_quotation_detail.Code = sal_customer_purchase_order_item_detail.SalesQuotationDetailCode "
                + " INNER JOIN sal_sales_quotation ON sal_sales_quotation.Code = sal_sales_quotation_detail.HeaderCode "        
                + " INNER JOIN mst_valve_type ON mst_valve_type.Code = sal_sales_quotation_detail.ValveTypeCode "
                //join Finish Goods
                + " LEFT JOIN mst_item_body_construction ON mst_item_body_construction.Code = mst_item_finish_goods.ItemBodyConstructionCode "
                + " LEFT JOIN mst_item_type_design ON mst_item_type_design.Code = mst_item_finish_goods.ItemTypeDesignCode "
                + " LEFT JOIN mst_item_seat_design ON mst_item_seat_design.Code = mst_item_finish_goods.ItemSeatDesignCode "
                + " LEFT JOIN mst_item_size ON mst_item_size.Code = mst_item_finish_goods.ItemSizeCode "
                + " LEFT JOIN mst_item_rating ON mst_item_rating.Code = mst_item_finish_goods.ItemRatingCode "
                + " LEFT JOIN mst_item_bore ON mst_item_bore.Code = mst_item_finish_goods.ItemBoreCode "
                    
                + " LEFT JOIN mst_item_end_con ON mst_item_end_con.Code = mst_item_finish_goods.ItemEndConCode "
                + " LEFT JOIN mst_item_body ON mst_item_body.Code = mst_item_finish_goods.ItemBodyCode "
                + " LEFT JOIN mst_item_ball ON mst_item_ball.Code = mst_item_finish_goods.ItemBallCode "
                + " LEFT JOIN mst_item_seat ON mst_item_seat.Code = mst_item_finish_goods.ItemSeatCode "
                + " LEFT JOIN mst_item_seat_insert ON mst_item_seat_insert.Code = mst_item_finish_goods.ItemSeatInsertCode "
                + " LEFT JOIN mst_item_stem ON mst_item_stem.Code = mst_item_finish_goods.ItemStemCode "
                        
                + " LEFT JOIN mst_item_seal ON mst_item_seal.Code = mst_item_finish_goods.ItemSealCode "
                + " LEFT JOIN mst_item_bolt ON mst_item_bolt.Code = mst_item_finish_goods.ItemBoltCode "
                + " LEFT JOIN mst_item_disc ON mst_item_disc.Code = mst_item_finish_goods.ItemDiscCode "
                + " LEFT JOIN mst_item_plates ON mst_item_plates.Code = mst_item_finish_goods.ItemPlatesCode "
                + " LEFT JOIN mst_item_shaft ON mst_item_shaft.Code = mst_item_finish_goods.ItemShaftCode "
                + " LEFT JOIN mst_item_spring ON mst_item_spring.Code = mst_item_finish_goods.ItemSpringCode "
                        
                + " LEFT JOIN mst_item_arm_pin ON mst_item_arm_pin.Code = mst_item_finish_goods.ItemArmPinCode "
                + " LEFT JOIN mst_item_backseat ON mst_item_backseat.Code = mst_item_finish_goods.ItemBackSeatCode "
                + " LEFT JOIN mst_item_arm ON mst_item_arm.Code = mst_item_finish_goods.ItemArmCode "
                + " LEFT JOIN mst_item_hinge_pin ON mst_item_hinge_pin.Code = mst_item_finish_goods.ItemHingePinCode "
                + " LEFT JOIN mst_item_stop_pin ON mst_item_stop_pin.Code = mst_item_finish_goods.ItemStopPinCode "
                + " LEFT JOIN mst_item_operator ON mst_item_operator.Code = mst_item_finish_goods.ItemOperatorCode "
                
                + " WHERE sal_customer_purchase_order_item_detail.SalesQuotationCode IN ('"+strSalesQuotationNo+"')"
            )

                .addScalar("code", Hibernate.STRING)
                .addScalar("salesQuotationCode", Hibernate.STRING)
                .addScalar("customerPurchaseOrderSortNo", Hibernate.BIG_DECIMAL)
                .addScalar("itemFinishGoodsCode", Hibernate.STRING)
                .addScalar("itemFinishGoodsRemark", Hibernate.STRING)
                .addScalar("salesQuotationDetailCode", Hibernate.STRING)
                .addScalar("valveTypeCode", Hibernate.STRING)
                .addScalar("valveTypeName", Hibernate.STRING)
                .addScalar("valveTag", Hibernate.STRING)
                .addScalar("dataSheet", Hibernate.STRING)
                .addScalar("description", Hibernate.STRING)
                .addScalar("itemAlias", Hibernate.STRING)
                .addScalar("refNo", Hibernate.STRING)
                    
                .addScalar("bodyConstruction", Hibernate.STRING)
                .addScalar("typeDesign", Hibernate.STRING)
                .addScalar("seatDesign", Hibernate.STRING)
                .addScalar("size", Hibernate.STRING)
                .addScalar("rating", Hibernate.STRING)
                .addScalar("bore", Hibernate.STRING)
                    
                .addScalar("endCon", Hibernate.STRING)
                .addScalar("body", Hibernate.STRING)
                .addScalar("ball", Hibernate.STRING)
                .addScalar("seat", Hibernate.STRING)
                .addScalar("seatInsert", Hibernate.STRING)
                .addScalar("stem", Hibernate.STRING)
                    
                .addScalar("seal", Hibernate.STRING)
                .addScalar("bolting", Hibernate.STRING)
                .addScalar("disc", Hibernate.STRING)
                .addScalar("plates", Hibernate.STRING)
                .addScalar("shaft", Hibernate.STRING)
                .addScalar("spring", Hibernate.STRING)
                    
                .addScalar("armPin", Hibernate.STRING)
                .addScalar("backSeat", Hibernate.STRING)
                .addScalar("arm", Hibernate.STRING)
                .addScalar("hingePin", Hibernate.STRING)
                .addScalar("StopPin", Hibernate.STRING)
                .addScalar("operator", Hibernate.STRING)
                    
                .addScalar("note", Hibernate.STRING)
                .addScalar("quantity", Hibernate.BIG_DECIMAL)
                .addScalar("unitPrice", Hibernate.BIG_DECIMAL)
                .addScalar("totalAmount", Hibernate.BIG_DECIMAL)
                    
                //finish goods
                .addScalar("itemBodyConstructionCode", Hibernate.STRING)
                .addScalar("itemBodyConstructionName", Hibernate.STRING)
                .addScalar("itemTypeDesignCode", Hibernate.STRING)
                .addScalar("itemTypeDesignName", Hibernate.STRING)
                .addScalar("itemSeatDesignCode", Hibernate.STRING)
                .addScalar("itemSeatDesignName", Hibernate.STRING)
                .addScalar("itemSizeCode", Hibernate.STRING)
                .addScalar("itemSizeName", Hibernate.STRING)
                .addScalar("itemRatingCode", Hibernate.STRING)
                .addScalar("itemRatingName", Hibernate.STRING)
                .addScalar("itemBoreCode", Hibernate.STRING)
                .addScalar("itemBoreName", Hibernate.STRING)
                    
                .addScalar("itemEndConCode", Hibernate.STRING)
                .addScalar("itemEndConName", Hibernate.STRING)
                .addScalar("itemBodyCode", Hibernate.STRING)
                .addScalar("itemBodyName", Hibernate.STRING)
                .addScalar("itemBallCode", Hibernate.STRING)
                .addScalar("itemBallName", Hibernate.STRING)
                .addScalar("itemSeatCode", Hibernate.STRING)
                .addScalar("itemSeatName", Hibernate.STRING)
                .addScalar("itemSeatInsertCode", Hibernate.STRING)
                .addScalar("itemSeatInsertName", Hibernate.STRING)
                .addScalar("itemStemCode", Hibernate.STRING)
                .addScalar("itemStemName", Hibernate.STRING)
                    
                .addScalar("itemSealCode", Hibernate.STRING)
                .addScalar("itemSealName", Hibernate.STRING)
                .addScalar("itemBoltCode", Hibernate.STRING)
                .addScalar("itemBoltName", Hibernate.STRING)
                .addScalar("itemDiscCode", Hibernate.STRING)
                .addScalar("itemDiscName", Hibernate.STRING)
                .addScalar("itemPlatesCode", Hibernate.STRING)
                .addScalar("itemPlatesName", Hibernate.STRING)
                .addScalar("itemShaftCode", Hibernate.STRING)
                .addScalar("itemShaftName", Hibernate.STRING)
                .addScalar("itemSpringCode", Hibernate.STRING)
                .addScalar("itemSpringName", Hibernate.STRING)
                    
                .addScalar("itemArmPinCode", Hibernate.STRING)
                .addScalar("itemArmPinName", Hibernate.STRING)
                .addScalar("itemBackSeatCode", Hibernate.STRING)
                .addScalar("itemBackSeatName", Hibernate.STRING)
                .addScalar("itemArmCode", Hibernate.STRING)
                .addScalar("itemArmName", Hibernate.STRING)
                .addScalar("itemHingePinCode", Hibernate.STRING)
                .addScalar("itemHingePinName", Hibernate.STRING)
                .addScalar("itemStopPinCode", Hibernate.STRING)
                .addScalar("itemStopPinName", Hibernate.STRING)
                .addScalar("itemOperatorCode", Hibernate.STRING)
                .addScalar("itemOperatorName", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(CustomerPurchaseOrderItemDetail.class))
                .list(); 

            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<CustomerPurchaseOrderItemDetail> findDataItemDetailArray2(ArrayList arrSalesQuotationCode, String headerCode) {
        try {
            
            String strSalesQuotationNo=Arrays.toString(arrSalesQuotationCode.toArray());
            strSalesQuotationNo = strSalesQuotationNo.replaceAll("[\\[\\]]", "");
            strSalesQuotationNo = strSalesQuotationNo.replaceAll(",", "','");
            List<CustomerPurchaseOrderItemDetail> list = (List<CustomerPurchaseOrderItemDetail>)hbmSession.hSession.createSQLQuery(
                "SELECT "
                + " sal_customer_purchase_order_item_detail.SalesQuotationCode, "
                + " sal_customer_purchase_order_item_detail.CustomerPurchaseOrderSortNo AS customerPurchaseOrderSortNo, "
                
                + " sal_customer_purchase_order_item_detail.ItemFinishGoodsCode AS itemFinishGoodsCode, "
                + " mst_item_finish_goods.Remark AS itemFinishGoodsRemark, "
                + " sal_customer_purchase_order_item_detail.Code, "
                + " sal_customer_purchase_order_item_detail.salesQuotationDetailCode, "
                + " sal_customer_purchase_order_item_detail.ItemAlias AS itemAlias, "
                + " sal_sales_quotation.RefNo, "
                
                + " sal_sales_quotation_detail.ValveTypeCode, "
                + " mst_valve_type.Name AS ValveTypeName, "
                + " sal_sales_quotation_detail.ValveTag, "
                + "sal_sales_quotation_detail.dataSheet, "
                + "sal_sales_quotation_detail.description, "
                
                + "sal_sales_quotation_detail.bodyConstruction, "
                + "sal_sales_quotation_detail.typeDesign, "
                + "sal_sales_quotation_detail.seatDesign, "
                + "sal_sales_quotation_detail.Size, "
                + "sal_sales_quotation_detail.Rating, "
                + "sal_sales_quotation_detail.Bore, "
                
                + "sal_sales_quotation_detail.EndCon, "
                + "sal_sales_quotation_detail.Body, "
                + "sal_sales_quotation_detail.Ball, "
                + "sal_sales_quotation_detail.Seat, "
                + "sal_sales_quotation_detail.SeatInsert, "
                + "sal_sales_quotation_detail.Stem, "
                        
                + "sal_sales_quotation_detail.Seal, "
                + "sal_sales_quotation_detail.Bolting, "
                + "sal_sales_quotation_detail.Disc, "
                + "sal_sales_quotation_detail.Plates, "
                + "sal_sales_quotation_detail.Shaft, "
                + "sal_sales_quotation_detail.Spring, "
                        
                + "sal_sales_quotation_detail.ArmPin, "
                + "sal_sales_quotation_detail.Backseat, "
                + "sal_sales_quotation_detail.Arm, "
                + "sal_sales_quotation_detail.HingePin, "
                + "sal_sales_quotation_detail.StopPin, "
                + "sal_sales_quotation_detail.Oper AS operator, "
                
                + " sal_sales_quotation_detail.Note, "
                + " sal_sales_quotation_detail.Quantity, "
                + " sal_sales_quotation_detail.UnitPrice, "
                + " sal_sales_quotation_detail.TotalAmount, "
                
                //FinishGoodQuotation
                + " IFNULL(mst_item_finish_goods.ItemBodyConstructionCode,'') AS itemBodyConstructionCode, "
                + " IFNULL(mst_item_body_construction.Name,'') AS itemBodyConstructionName, "
                + " IFNULL(mst_item_finish_goods.ItemTypeDesignCode,'') AS itemTypeDesignCode, "
                + " IFNULL(mst_item_type_design.Name,'') AS itemTypeDesignName, "
                + " IFNULL(mst_item_finish_goods.ItemSeatDesignCode,'') AS itemSeatDesignCode, "
                + " IFNULL(mst_item_seat_design.Name,'') AS itemSeatDesignName, "
                + " IFNULL(mst_item_finish_goods.ItemSizeCode,'') AS itemSizeCode, "
                + " IFNULL(mst_item_size.Name,'') AS itemSizeName, "
                + " IFNULL(mst_item_finish_goods.ItemRatingCode,'') AS itemRatingCode, "
                + " IFNULL(mst_item_rating.Name,'') AS itemRatingName, "
                + " IFNULL(mst_item_finish_goods.ItemBoreCode,'') AS itemBoreCode, "
                + " IFNULL(mst_item_bore.Name,'') AS itemBoreName, "
                
                + " IFNULL(mst_item_finish_goods.ItemEndConCode,'') AS itemEndConCode, "
                + " IFNULL(mst_item_end_con.Name,'') AS itemEndConName, "
                + " IFNULL(mst_item_finish_goods.ItemBodyCode,'') AS itemBodyCode, "
                + " IFNULL(mst_item_body.Name,'') AS itemBodyName, "
                + " IFNULL(mst_item_finish_goods.ItemBallCode,'') AS itemBallCode, "
                + " IFNULL(mst_item_ball.Name,'') AS itemBallName, "
                + " IFNULL(mst_item_finish_goods.ItemSeatCode,'') AS itemSeatCode, "
                + " IFNULL(mst_item_seat.Name,'') AS itemSeatName, "
                + " IFNULL(mst_item_finish_goods.ItemSeatInsertCode,'') AS itemSeatInsertCode, "
                + " IFNULL(mst_item_seat_insert.Name,'') AS itemSeatInsertName, "
                + " IFNULL(mst_item_finish_goods.ItemStemCode,'') AS itemStemCode, "
                + " IFNULL(mst_item_stem.Name,'') AS itemStemName, "
                
                + " IFNULL(mst_item_finish_goods.ItemSealCode,'') AS itemSealCode, "
                + " IFNULL(mst_item_seal.Name,'') AS itemSealName, "
                + " IFNULL(mst_item_finish_goods.ItemBoltCode,'') AS itemBoltCode, "
                + " IFNULL(mst_item_bolt.Name,'') AS itemBoltName, "
                + " IFNULL(mst_item_finish_goods.ItemDiscCode,'') AS itemDiscCode, "
                + " IFNULL(mst_item_disc.Name,'') AS itemDiscName, "
                + " IFNULL(mst_item_finish_goods.ItemPlatesCode,'') AS itemPlatesCode, "
                + " IFNULL(mst_item_plates.Name,'') AS itemPlatesName, "
                + " IFNULL(mst_item_finish_goods.ItemShaftCode,'') AS itemShaftCode, "
                + " IFNULL(mst_item_shaft.Name,'') AS itemShaftName, "
                + " IFNULL(mst_item_finish_goods.ItemSpringCode,'') AS itemSpringCode, "
                + " IFNULL(mst_item_spring.Name,'') ItemSpringName, "
                
                + " IFNULL(mst_item_finish_goods.ItemArmPinCode,'') AS itemArmPinCode, "
                + " IFNULL(mst_item_arm.Name,'') AS itemArmPinName, "

                + " IFNULL(mst_item_finish_goods.ItemBackSeatCode,'') AS itemBackSeatCode, "
                + " IFNULL(mst_item_backseat.Name,'') AS itemBackSeatName, "

                + " IFNULL(mst_item_finish_goods.ItemArmCode,'') AS itemArmCode, "
                + " IFNULL(mst_item_arm.Name,'') AS itemArmName, "

                + " IFNULL(mst_item_finish_goods.ItemHingePinCode,'') AS itemHingePinCode, "
                + " IFNULL(mst_item_hinge_pin.Name,'') AS itemHingePinName, "

                + " IFNULL(mst_item_finish_goods.ItemStopPinCode,'') AS itemStopPinCode, "
                + " IFNULL(mst_item_stop_pin.Name,'') AS itemStopPinName, "

                + " IFNULL(mst_item_finish_goods.ItemOperatorCode,'') AS itemOperatorCode, "
                + " IFNULL(mst_item_operator.Name,'') AS itemOperatorName "
                
                + " FROM "
                + " sal_customer_purchase_order_item_detail "
                + " INNER JOIN `mst_item_finish_goods` ON mst_item_finish_goods.`code` = sal_customer_purchase_order_item_detail.`ItemFinishGoodsCode` "
                + " INNER JOIN sal_sales_quotation_detail ON sal_sales_quotation_detail.Code = sal_customer_purchase_order_item_detail.SalesQuotationDetailCode "
                + " INNER JOIN sal_sales_quotation ON sal_sales_quotation.Code = sal_sales_quotation_detail.HeaderCode "
                + " INNER JOIN mst_valve_type ON mst_valve_type.Code = sal_sales_quotation_detail.ValveTypeCode "
                //join Finish Goods
                + " LEFT JOIN mst_item_body_construction ON mst_item_body_construction.Code = mst_item_finish_goods.ItemBodyConstructionCode "
                + " LEFT JOIN mst_item_type_design ON mst_item_type_design.Code = mst_item_finish_goods.ItemTypeDesignCode "
                + " LEFT JOIN mst_item_seat_design ON mst_item_seat_design.Code = mst_item_finish_goods.ItemSeatDesignCode "
                + " LEFT JOIN mst_item_size ON mst_item_size.Code = mst_item_finish_goods.ItemSizeCode "
                + " LEFT JOIN mst_item_rating ON mst_item_rating.Code = mst_item_finish_goods.ItemRatingCode "
                + " LEFT JOIN mst_item_bore ON mst_item_bore.Code = mst_item_finish_goods.ItemBoreCode "
                    
                + " LEFT JOIN mst_item_end_con ON mst_item_end_con.Code = mst_item_finish_goods.ItemEndConCode "
                + " LEFT JOIN mst_item_body ON mst_item_body.Code = mst_item_finish_goods.ItemBodyCode "
                + " LEFT JOIN mst_item_ball ON mst_item_ball.Code = mst_item_finish_goods.ItemBallCode "
                + " LEFT JOIN mst_item_seat ON mst_item_seat.Code = mst_item_finish_goods.ItemSeatCode "
                + " LEFT JOIN mst_item_seat_insert ON mst_item_seat_insert.Code = mst_item_finish_goods.ItemSeatInsertCode "
                + " LEFT JOIN mst_item_stem ON mst_item_stem.Code = mst_item_finish_goods.ItemStemCode "
                        
                + " LEFT JOIN mst_item_seal ON mst_item_seal.Code = mst_item_finish_goods.ItemSealCode "
                + " LEFT JOIN mst_item_bolt ON mst_item_bolt.Code = mst_item_finish_goods.ItemBoltCode "
                + " LEFT JOIN mst_item_disc ON mst_item_disc.Code = mst_item_finish_goods.ItemDiscCode "
                + " LEFT JOIN mst_item_plates ON mst_item_plates.Code = mst_item_finish_goods.ItemPlatesCode "
                + " LEFT JOIN mst_item_shaft ON mst_item_shaft.Code = mst_item_finish_goods.ItemShaftCode "
                + " LEFT JOIN mst_item_spring ON mst_item_spring.Code = mst_item_finish_goods.ItemSpringCode "
                        
                + " LEFT JOIN mst_item_arm_pin ON mst_item_arm_pin.Code = mst_item_finish_goods.ItemArmPinCode "
                + " LEFT JOIN mst_item_backseat ON mst_item_backseat.Code = mst_item_finish_goods.ItemBackSeatCode "
                + " LEFT JOIN mst_item_arm ON mst_item_arm.Code = mst_item_finish_goods.ItemArmCode "
                + " LEFT JOIN mst_item_hinge_pin ON mst_item_hinge_pin.Code = mst_item_finish_goods.ItemHingePinCode "
                + " LEFT JOIN mst_item_stop_pin ON mst_item_stop_pin.Code = mst_item_finish_goods.ItemStopPinCode "
                + " LEFT JOIN mst_item_operator ON mst_item_operator.Code = mst_item_finish_goods.ItemOperatorCode "
                
                + " WHERE sal_customer_purchase_order_item_detail.SalesQuotationCode IN ('"+strSalesQuotationNo+"')"
                + " AND sal_customer_purchase_order_item_detail.HeaderCode =:prmHeaderCode"
            )

                .addScalar("code", Hibernate.STRING)
                .addScalar("salesQuotationCode", Hibernate.STRING)
                .addScalar("customerPurchaseOrderSortNo", Hibernate.BIG_DECIMAL)
                .addScalar("itemFinishGoodsCode", Hibernate.STRING)
                .addScalar("itemFinishGoodsRemark", Hibernate.STRING)
                .addScalar("salesQuotationDetailCode", Hibernate.STRING)
                .addScalar("valveTypeCode", Hibernate.STRING)
                .addScalar("valveTypeName", Hibernate.STRING)
                .addScalar("valveTag", Hibernate.STRING)
                .addScalar("dataSheet", Hibernate.STRING)
                .addScalar("description", Hibernate.STRING)
                .addScalar("itemAlias", Hibernate.STRING)
                .addScalar("refNo", Hibernate.STRING)
                    
                .addScalar("bodyConstruction", Hibernate.STRING)
                .addScalar("typeDesign", Hibernate.STRING)
                .addScalar("seatDesign", Hibernate.STRING)
                .addScalar("size", Hibernate.STRING)
                .addScalar("rating", Hibernate.STRING)
                .addScalar("bore", Hibernate.STRING)
                    
                .addScalar("endCon", Hibernate.STRING)
                .addScalar("body", Hibernate.STRING)
                .addScalar("ball", Hibernate.STRING)
                .addScalar("seat", Hibernate.STRING)
                .addScalar("seatInsert", Hibernate.STRING)
                .addScalar("stem", Hibernate.STRING)
                    
                .addScalar("seal", Hibernate.STRING)
                .addScalar("bolting", Hibernate.STRING)
                .addScalar("disc", Hibernate.STRING)
                .addScalar("plates", Hibernate.STRING)
                .addScalar("shaft", Hibernate.STRING)
                .addScalar("spring", Hibernate.STRING)
                    
                .addScalar("armPin", Hibernate.STRING)
                .addScalar("backSeat", Hibernate.STRING)
                .addScalar("arm", Hibernate.STRING)
                .addScalar("hingePin", Hibernate.STRING)
                .addScalar("StopPin", Hibernate.STRING)
                .addScalar("operator", Hibernate.STRING)
                    
                .addScalar("note", Hibernate.STRING)
                .addScalar("quantity", Hibernate.BIG_DECIMAL)
                .addScalar("unitPrice", Hibernate.BIG_DECIMAL)
                .addScalar("totalAmount", Hibernate.BIG_DECIMAL)
                    
                //finish goods
                .addScalar("itemBodyConstructionCode", Hibernate.STRING)
                .addScalar("itemBodyConstructionName", Hibernate.STRING)
                .addScalar("itemTypeDesignCode", Hibernate.STRING)
                .addScalar("itemTypeDesignName", Hibernate.STRING)
                .addScalar("itemSeatDesignCode", Hibernate.STRING)
                .addScalar("itemSeatDesignName", Hibernate.STRING)
                .addScalar("itemSizeCode", Hibernate.STRING)
                .addScalar("itemSizeName", Hibernate.STRING)
                .addScalar("itemRatingCode", Hibernate.STRING)
                .addScalar("itemRatingName", Hibernate.STRING)
                .addScalar("itemBoreCode", Hibernate.STRING)
                .addScalar("itemBoreName", Hibernate.STRING)
                    
                .addScalar("itemEndConCode", Hibernate.STRING)
                .addScalar("itemEndConName", Hibernate.STRING)
                .addScalar("itemBodyCode", Hibernate.STRING)
                .addScalar("itemBodyName", Hibernate.STRING)
                .addScalar("itemBallCode", Hibernate.STRING)
                .addScalar("itemBallName", Hibernate.STRING)
                .addScalar("itemSeatCode", Hibernate.STRING)
                .addScalar("itemSeatName", Hibernate.STRING)
                .addScalar("itemSeatInsertCode", Hibernate.STRING)
                .addScalar("itemSeatInsertName", Hibernate.STRING)
                .addScalar("itemStemCode", Hibernate.STRING)
                .addScalar("itemStemName", Hibernate.STRING)
                    
                .addScalar("itemSealCode", Hibernate.STRING)
                .addScalar("itemSealName", Hibernate.STRING)
                .addScalar("itemBoltCode", Hibernate.STRING)
                .addScalar("itemBoltName", Hibernate.STRING)
                .addScalar("itemDiscCode", Hibernate.STRING)
                .addScalar("itemDiscName", Hibernate.STRING)
                .addScalar("itemPlatesCode", Hibernate.STRING)
                .addScalar("itemPlatesName", Hibernate.STRING)
                .addScalar("itemShaftCode", Hibernate.STRING)
                .addScalar("itemShaftName", Hibernate.STRING)
                .addScalar("itemSpringCode", Hibernate.STRING)
                .addScalar("itemSpringName", Hibernate.STRING)
                    
                .addScalar("itemArmPinCode", Hibernate.STRING)
                .addScalar("itemArmPinName", Hibernate.STRING)
                .addScalar("itemBackSeatCode", Hibernate.STRING)
                .addScalar("itemBackSeatName", Hibernate.STRING)
                .addScalar("itemArmCode", Hibernate.STRING)
                .addScalar("itemArmName", Hibernate.STRING)
                .addScalar("itemHingePinCode", Hibernate.STRING)
                .addScalar("itemHingePinName", Hibernate.STRING)
                .addScalar("itemStopPinCode", Hibernate.STRING)
                .addScalar("itemStopPinName", Hibernate.STRING)
                .addScalar("itemOperatorCode", Hibernate.STRING)
                .addScalar("itemOperatorName", Hibernate.STRING)
                .setParameter("prmHeaderCode", headerCode)
                .setResultTransformer(Transformers.aliasToBean(CustomerPurchaseOrderItemDetail.class))
                .list(); 

            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<CustomerPurchaseOrderItemDetail> findDataItemDetail(ArrayList arrSalesQuotationNo,CustomerPurchaseOrderItemDetail customerPurchaseOrderItemDetail) {
        try {
            
            String strSalesQuotationNo=Arrays.toString(arrSalesQuotationNo.toArray());
            strSalesQuotationNo = strSalesQuotationNo.replaceAll("[\\[\\]]", "");
            strSalesQuotationNo = strSalesQuotationNo.replaceAll(",", "','");
            
            List<CustomerPurchaseOrderItemDetail> list = (List<CustomerPurchaseOrderItemDetail>)hbmSession.hSession.createSQLQuery(
                "SELECT " +
                "	sal_customer_purchase_order_item_detail.SalesQuotationCode, " +
                "	sal_customer_purchase_order_item_detail.CustomerPurchaseOrderSortNo, " +
                "	sal_customer_purchase_order_item_detail.ItemFinishGoodsCode, " +
                "	mst_item_finish_goods.Name AS itemFinishGoodsName, " +
                "	sal_sales_quotation_detail.code AS salesQuotationDetailCode, " +
                "	sal_sales_quotation_detail.valveTypeCode, " +
                "	mst_valve_type.name AS valveTypeName, " +
                "	sal_sales_quotation_detail.ValveTag, " +
                "	sal_sales_quotation_detail.DataSheet, " +
                "	sal_sales_quotation_detail.bodyConstruction, " +
                "	sal_sales_quotation_detail.Description, " +
                "	sal_sales_quotation_detail.Type, " +
                "	sal_sales_quotation_detail.Size, " +
                "	sal_sales_quotation_detail.Rating, " +
                "	sal_sales_quotation_detail.EndCon, " +
                "	sal_sales_quotation_detail.Body, " +
                "	sal_sales_quotation_detail.Ball, " +
                "	sal_sales_quotation_detail.Seat, " +
                "	sal_sales_quotation_detail.Stem, " +
                "	sal_sales_quotation_detail.seatInsert, " +
                "	sal_sales_quotation_detail.Seal, " +
                "	sal_sales_quotation_detail.Bolting, " +
                "	sal_sales_quotation_detail.SeatDesign, " +
                "	sal_sales_quotation_detail.Oper, " +
                "       sal_sales_quotation_detail.bore, " +
                "       sal_sales_quotation_detail.disc, " +
                "       sal_sales_quotation_detail.plates,"+
                "       sal_sales_quotation_detail.shaft, "+
                "       sal_sales_quotation_detail.spring, "+
                "       sal_sales_quotation_detail.armPin, "+
                "       sal_sales_quotation_detail.backseat, "+
                "	sal_sales_quotation_detail.Note, " +
                "	sal_customer_purchase_order_item_detail.Quantity, " +
                "	sal_sales_quotation_detail.UnitPrice, " +
                "	sal_sales_quotation_detail.TotalAmount " +
                "FROM sal_customer_purchase_order_item_detail " +
                "INNER JOIN `mst_item_finish_goods` ON mst_item_finish_goods.`code`=sal_customer_purchase_order_item_detail.`ItemFinishGoodsCode` " +          
                "INNER JOIN sal_sales_quotation_detail ON " +
                "	sal_customer_purchase_order_item_detail.SalesQuotationCode=sal_sales_quotation_detail.HeaderCode " +
                "INNER JOIN `mst_valve_type` ON mst_valve_type.`code`=sal_sales_quotation_detail.ValveTypeCode " +            
                "WHERE sal_customer_purchase_order_item_detail.SalesQuotationCode IN('"+strSalesQuotationNo+"') " +
                "AND sal_customer_purchase_order_item_detail.SalesQuotationCode LIKE '%"+customerPurchaseOrderItemDetail.getSalesQuotationCode()+"%' " +
                "AND sal_customer_purchase_order_item_detail.ItemFinishGoodsCode LIKE '%"+customerPurchaseOrderItemDetail.getItemFinishGoodsCode() +"%' " +
                "ORDER BY sal_customer_purchase_order_item_detail.CustomerPurchaseOrderSortNo ASC")
                        
                .addScalar("salesQuotationCode", Hibernate.STRING)
                .addScalar("customerPurchaseOrderSortNo", Hibernate.BIG_DECIMAL)
                .addScalar("itemFinishGoodsCode", Hibernate.STRING)
                .addScalar("itemFinishGoodsName", Hibernate.STRING)
                .addScalar("salesQuotationDetailCode", Hibernate.STRING)
                .addScalar("valveTypeCode", Hibernate.STRING)
                .addScalar("valveTypeName", Hibernate.STRING)   
                .addScalar("valveTag", Hibernate.STRING)
                .addScalar("dataSheet", Hibernate.STRING)
                .addScalar("description", Hibernate.STRING)
                .addScalar("type", Hibernate.STRING)
                .addScalar("size", Hibernate.STRING)
                .addScalar("rating", Hibernate.STRING)
                .addScalar("endCon", Hibernate.STRING)
                .addScalar("body", Hibernate.STRING)
                .addScalar("ball", Hibernate.STRING)
                .addScalar("seat", Hibernate.STRING)
                .addScalar("stem", Hibernate.STRING)
                .addScalar("seatInsert", Hibernate.STRING)
                .addScalar("seal", Hibernate.STRING)
                .addScalar("bolting", Hibernate.STRING)
                .addScalar("seatDesign", Hibernate.STRING)
                .addScalar("oper", Hibernate.STRING)
                .addScalar("bodyConstruction", Hibernate.STRING)
                .addScalar("bore", Hibernate.STRING)
                .addScalar("disc", Hibernate.STRING)
                .addScalar("plates", Hibernate.STRING)
                .addScalar("shaft", Hibernate.STRING)
                .addScalar("armPin", Hibernate.STRING)
                .addScalar("spring", Hibernate.STRING)
                .addScalar("backseat", Hibernate.STRING)  
                .addScalar("note", Hibernate.STRING)
                .addScalar("quantity", Hibernate.BIG_DECIMAL)
                .addScalar("unitPrice", Hibernate.BIG_DECIMAL)
                .addScalar("totalAmount", Hibernate.BIG_DECIMAL)
                .setResultTransformer(Transformers.aliasToBean(CustomerPurchaseOrderItemDetail.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<CustomerPurchaseOrderItemDetail> findDataSyncItemDetail(ArrayList arrSalesQuotationNo,CustomerPurchaseOrder customerPurchaseOrder) {
        try {
            
            String strSalesQuotationNo=Arrays.toString(arrSalesQuotationNo.toArray());
            strSalesQuotationNo = strSalesQuotationNo.replaceAll("[\\[\\]]", "");
            strSalesQuotationNo = strSalesQuotationNo.replaceAll(",", "','");
            
            List<CustomerPurchaseOrderItemDetail> list = (List<CustomerPurchaseOrderItemDetail>)hbmSession.hSession.createSQLQuery(
                "SELECT " +
                "	customer_purchase_order_item_detail.SalesQuotationCode, " +
                "	customer_purchase_order_item_detail.CustomerPurchaseOrderSortNo, " +
                "	customer_purchase_order_item_detail.ItemCode, " +
                "	customer_purchase_order_item_detail.ValveTag, " +
                "	customer_purchase_order_item_detail.DataSheet, " +
                "	customer_purchase_order_item_detail.Description, " +
                "	customer_purchase_order_item_detail.Type, " +
                "	customer_purchase_order_item_detail.Size, " +
                "	customer_purchase_order_item_detail.Rating, " +
                "	customer_purchase_order_item_detail.EndCon, " +
                "	customer_purchase_order_item_detail.Body, " +
                "	customer_purchase_order_item_detail.Ball, " +
                "	customer_purchase_order_item_detail.Seat, " +
                "	customer_purchase_order_item_detail.Stem, " +
                "	customer_purchase_order_item_detail.seatInsert, " +
                "	customer_purchase_order_item_detail.Seal, " +
                "	customer_purchase_order_item_detail.Bolting, " +
                "	customer_purchase_order_item_detail.SeatDesign, " +
                "	customer_purchase_order_item_detail.Oper, " +
                "	customer_purchase_order_item_detail.Note, " +
                "	customer_purchase_order_item_detail.Quantity - IFNULL(customer_blanket_order_item_detail.Quantity,0)AS Quantity, " +
                "	customer_purchase_order_item_detail.UnitPrice, " +
                "	ROUND((customer_purchase_order_item_detail.Quantity - IFNULL(customer_blanket_order_item_detail.Quantity,0)) * customer_purchase_order_item_detail.UnitPrice,2)AS TotalAmount " +
                "FROM( " +
                "	SELECT " +
                "		sal_customer_purchase_order_item_detail.SalesQuotationCode, " +
                "		sal_customer_purchase_order_item_detail.CustomerPurchaseOrderSortNo, " +
                "		sal_customer_purchase_order_item_detail.ItemCode, " +
                "		sal_sales_quotation_detail.ValveTag, " +
                "		sal_sales_quotation_detail.DataSheet, " +
                "		sal_sales_quotation_detail.Description, " +
                "		sal_sales_quotation_detail.Type, " +
                "		sal_sales_quotation_detail.Size, " +
                "		sal_sales_quotation_detail.Rating, " +
                "		sal_sales_quotation_detail.EndCon, " +
                "		sal_sales_quotation_detail.Body, " +
                "		sal_sales_quotation_detail.Ball, " +
                "		sal_sales_quotation_detail.Seat, " +
                "		sal_sales_quotation_detail.Stem, " +
                "		sal_sales_quotation_detail.seatInsert, " +
                "		sal_sales_quotation_detail.Seal, " +
                "		sal_sales_quotation_detail.Bolting, " +
                "		sal_sales_quotation_detail.SeatDesign, " +
                "		sal_sales_quotation_detail.Oper, " +
                "		sal_sales_quotation_detail.Note, " +
                "		sal_customer_purchase_order_item_detail.Quantity, " +
                "		sal_sales_quotation_detail.UnitPrice, " +
                "		sal_sales_quotation_detail.TotalAmount  " +
                "	FROM sal_customer_purchase_order_item_detail  " +
                "	INNER JOIN sal_sales_quotation_detail  " +
                "	ON  sal_customer_purchase_order_item_detail.SalesQuotationCode=sal_sales_quotation_detail.HeaderCode   " +
                "		AND sal_customer_purchase_order_item_detail.ItemCode=sal_sales_quotation_detail.Item  " +
                "	WHERE sal_customer_purchase_order_item_detail.SalesQuotationCode IN('"+strSalesQuotationNo+"')  " +
                ")AS customer_purchase_order_item_detail " +
                "LEFT JOIN( " +
                "	SELECT " +
                "		sal_customer_blanket_order_item_detail.SalesQuotationCode, " +
                "		sal_customer_blanket_order_item_detail.ItemCode, " +
                "		SUM(sal_customer_blanket_order_item_detail.Quantity)AS Quantity " +
                "	FROM sal_customer_blanket_order_item_detail " +
                "	INNER JOIN sal_customer_blanket_order ON sal_customer_blanket_order_item_detail.HeaderCode=sal_customer_blanket_order.Code " +
                "	WHERE sal_customer_blanket_order.CustomerPurchaseOrderCode='"+customerPurchaseOrder.getCode()+"' " +
                "	GROUP BY sal_customer_blanket_order_item_detail.SalesQuotationCode,sal_customer_blanket_order_item_detail.ItemCode " +
                ")AS customer_blanket_order_item_detail  " +
                "ON customer_purchase_order_item_detail.SalesQuotationCode=customer_blanket_order_item_detail.SalesQuotationCode " +
                "	AND customer_purchase_order_item_detail.ItemCode=customer_blanket_order_item_detail.ItemCode " +
                "WHERE (customer_purchase_order_item_detail.Quantity-IFNULL(customer_blanket_order_item_detail.Quantity,0))>0")
                        
                .addScalar("salesQuotationCode", Hibernate.STRING)
                .addScalar("customerPurchaseOrderSortNo", Hibernate.BIG_DECIMAL)
                .addScalar("itemCode", Hibernate.STRING)
                .addScalar("valveTag", Hibernate.STRING)
                .addScalar("dataSheet", Hibernate.STRING)
                .addScalar("description", Hibernate.STRING)
                .addScalar("type", Hibernate.STRING)
                .addScalar("size", Hibernate.STRING)
                .addScalar("rating", Hibernate.STRING)
                .addScalar("endCon", Hibernate.STRING)
                .addScalar("body", Hibernate.STRING)
                .addScalar("ball", Hibernate.STRING)
                .addScalar("seat", Hibernate.STRING)
                .addScalar("stem", Hibernate.STRING)
                .addScalar("seatInsert", Hibernate.STRING)
                .addScalar("seal", Hibernate.STRING)
                .addScalar("bolting", Hibernate.STRING)
                .addScalar("seatDesign", Hibernate.STRING)
                .addScalar("oper", Hibernate.STRING)
                .addScalar("note", Hibernate.STRING)
                .addScalar("quantity", Hibernate.BIG_DECIMAL)
                .addScalar("unitPrice", Hibernate.BIG_DECIMAL)
                .addScalar("totalAmount", Hibernate.BIG_DECIMAL)
                .setResultTransformer(Transformers.aliasToBean(CustomerPurchaseOrderItemDetail.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<CustomerPurchaseOrderAdditionalFee> findDataAdditionalFee(String headerCode) {
        try {
            
            List<CustomerPurchaseOrderAdditionalFee> list = (List<CustomerPurchaseOrderAdditionalFee>)hbmSession.hSession.createSQLQuery(
                "SELECT " +
                "	sal_customer_purchase_order_additional_fee.Remark, " +
                "	sal_customer_purchase_order_additional_fee.Quantity, " +
                "	sal_customer_purchase_order_additional_fee.AdditionalFeeCode, " +
                "	mst_additional_fee.Name AS additionalFeeName, " +
                "	mst_additional_fee.SalesChartOfAccountCode AS coaCode, " +
                "	mst_chart_of_account.name AS coaName, " +
                "	sal_customer_purchase_order_additional_fee.UnitCode AS unitOfMeasureCode, " +
                "	sal_customer_purchase_order_additional_fee.Price, " +
                "	sal_customer_purchase_order_additional_fee.Total " +
                "FROM sal_customer_purchase_order_additional_fee " +
                " INNER JOIN  mst_additional_fee ON mst_additional_fee.Code = sal_customer_purchase_order_additional_fee.AdditionalFeeCode " +        
                " INNER JOIN  mst_chart_of_account ON mst_chart_of_account.Code = mst_additional_fee.SalesChartOfAccountCode " +        
                "WHERE sal_customer_purchase_order_additional_fee.HeaderCode=:prmHeaderCode")

                .addScalar("remark", Hibernate.STRING)
                .addScalar("quantity", Hibernate.BIG_DECIMAL)
                .addScalar("additionalFeeCode", Hibernate.STRING)
                .addScalar("additionalFeeName", Hibernate.STRING)
                .addScalar("unitOfMeasureCode", Hibernate.STRING)
                .addScalar("coaCode", Hibernate.STRING)
                .addScalar("coaName", Hibernate.STRING)    
                .addScalar("price", Hibernate.BIG_DECIMAL)
                .addScalar("total", Hibernate.BIG_DECIMAL)
                .setParameter("prmHeaderCode", headerCode)
                .setResultTransformer(Transformers.aliasToBean(CustomerPurchaseOrderAdditionalFee.class))
                .list(); 

            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<CustomerPurchaseOrderPaymentTerm> findDataPaymentTerm(String headerCode) {
        try {
            
            List<CustomerPurchaseOrderPaymentTerm> list = (List<CustomerPurchaseOrderPaymentTerm>)hbmSession.hSession.createSQLQuery(
                "SELECT " +
                "	sal_customer_purchase_order_payment_term.SortNo, " +
                "	sal_customer_purchase_order_payment_term.PaymentTermCode, " +
                " mst_payment_term.Name AS paymentTermName, " +
                "	sal_customer_purchase_order_payment_term.Percentage, " +
                "	sal_customer_purchase_order_payment_term.Remark " +
                "FROM sal_customer_purchase_order_payment_term " +
                "INNER JOIN mst_payment_term ON sal_customer_purchase_order_payment_term.PaymentTermCode=mst_payment_term.Code " +
                "WHERE sal_customer_purchase_order_payment_term.HeaderCode=:prmHeaderCode")

                .addScalar("sortNo", Hibernate.BIG_DECIMAL)
                .addScalar("paymentTermCode", Hibernate.STRING)
                .addScalar("paymentTermName", Hibernate.STRING)
                .addScalar("percentage", Hibernate.BIG_DECIMAL)
                .addScalar("remark", Hibernate.STRING)
                .setParameter("prmHeaderCode", headerCode)
                .setResultTransformer(Transformers.aliasToBean(CustomerPurchaseOrderPaymentTerm.class))
                .list(); 

            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<CustomerPurchaseOrderItemDeliveryDate> findDataItemDeliveryDate(String headerCode) {
        try {
            
            List<CustomerPurchaseOrderItemDeliveryDate> list = (List<CustomerPurchaseOrderItemDeliveryDate>)hbmSession.hSession.createSQLQuery(
                "SELECT " +
                "	sal_customer_purchase_order_item_delivery_date.Code, " +
                "	sal_customer_purchase_order_item_delivery_date.ItemFinishGoodsCode AS itemFinishGoodsCode, " +
                "	mst_item_finish_goods.Remark AS itemFinishGoodsRemark, " +
                "	sal_customer_purchase_order_item_delivery_date.Quantity, " +
                "	sal_customer_purchase_order_item_delivery_date.DeliveryDate, " +
                "	sal_customer_purchase_order_item_delivery_date.SalesQuotationCode AS salesQuotationCode, " +
                "	sal_customer_purchase_order_item_detail.CustomerPurchaseOrderSortNo AS customerPurchaseOrderSortNo, " +
                "	sal_sales_quotation.RefNo " +
                "FROM sal_customer_purchase_order_item_delivery_date " +       
                "INNER JOIN sal_customer_purchase_order_item_detail ON sal_customer_purchase_order_item_delivery_date.Code = sal_customer_purchase_order_item_detail.Code " +       
                "INNER JOIN mst_item_finish_goods ON sal_customer_purchase_order_item_delivery_date.ItemFinishGoodsCode = mst_item_finish_goods.Code " +  
                "INNER JOIN sal_sales_quotation ON sal_sales_quotation.Code = sal_customer_purchase_order_item_delivery_date.SalesQuotationCode " +
                "WHERE sal_customer_purchase_order_item_delivery_date.HeaderCode=:prmHeaderCode "+
                "ORDER BY sal_customer_purchase_order_item_delivery_date.Code")

                .addScalar("itemFinishGoodsCode", Hibernate.STRING)
                .addScalar("itemFinishGoodsRemark", Hibernate.STRING)
                .addScalar("quantity", Hibernate.BIG_DECIMAL)
                .addScalar("customerPurchaseOrderSortNo", Hibernate.BIG_DECIMAL)
                .addScalar("deliveryDate", Hibernate.DATE)
                .addScalar("salesQuotationCode", Hibernate.STRING)
                .addScalar("refNo", Hibernate.STRING)
                .setParameter("prmHeaderCode", headerCode)
                .setResultTransformer(Transformers.aliasToBean(CustomerPurchaseOrderItemDeliveryDate.class))
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
            if (criteria.list().size() == 0)
            	return 0;
            else
            	return ((Integer) criteria.list().get(0)).intValue();
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public CustomerPurchaseOrder get(String code) {
        try {
               return (CustomerPurchaseOrder) hbmSession.hSession.get(CustomerPurchaseOrder.class, code);
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public CustomerPurchaseOrder findDataGet(String code){
        try {
            CustomerPurchaseOrder customerPurchaseOrder = (CustomerPurchaseOrder)hbmSession.hSession.createSQLQuery(
                    "SELECT " +
                    "sal_customer_purchase_order.`Code`, " +
                    "sal_customer_purchase_order.`CUSTPONo`, " +
                    "sal_customer_purchase_order.`Revision`, " +
                    "sal_customer_purchase_order.`RefCUSTPOCode`, " +
                    "sal_customer_purchase_order.`TransactionDate`, " +
                    "sal_customer_purchase_order.`CustomerPurchaseOrderNo`, " +
                    "sal_customer_purchase_order.`CustomerCode`, " +
                    "mst_customer.Name AS CustomerName, " +
                    "sal_customer_purchase_order.`EndUserCode`, " +
                    "EndUser.`Name` AS EndUserName, " +
                    "sal_customer_purchase_order.`PartialShipmentStatus`, " +
                    "sal_customer_purchase_order.`RetentionPercent`, " +
                    "sal_customer_purchase_order.`CurrencyCode`, " +
                    "mst_currency.name AS `CurrencyName`, " +
                    "sal_customer_purchase_order.`SalesPersonCode`, " +
                    "mst_sales_person.`Name` AS SalesPersonName, " +
                    "sal_customer_purchase_order.`ProjectCode`, " +
                    "mst_project.`Name` AS ProjectName, " +
                    "sal_customer_purchase_order.`RefNo`, " +
                    "sal_customer_purchase_order.`Remark`, " +
                    "sal_customer_purchase_order.`TotalTransactionAmount`, " +
                    "sal_customer_purchase_order.`DiscountPercent`, " +
                    "sal_customer_purchase_order.`DiscountAmount`, " +
                    "(SELECT fn_getAdditionalFee(sal_customer_purchase_order.`Code`))AS TotalAdditionalFeeAmount, " +
                    "sal_customer_purchase_order.`TaxBaseAmount`, " +
                    "sal_customer_purchase_order.`Vatpercent`, " +
                    "sal_customer_purchase_order.`Vatamount`, " +
                    "sal_customer_purchase_order.`GrandTotalAmount` " +
                    "FROM sal_customer_purchase_order " +
                    "INNER JOIN mst_customer ON sal_customer_purchase_order.CustomerCode=mst_customer.Code " +
                    "INNER JOIN `mst_customer` EndUser ON sal_customer_purchase_order.`EndUserCode`=EndUser.`Code` " +
                    "INNER JOIN mst_sales_person ON sal_customer_purchase_order.SalesPersonCode=mst_sales_person.Code " +
                    "INNER JOIN `mst_project` ON sal_customer_purchase_order.`ProjectCode`=mst_project.`Code` " +
                    "INNER JOIN mst_currency ON sal_customer_purchase_order.`CurrencyCode`=mst_currency.Code "+
                    "WHERE sal_customer_purchase_order.ValidStatus=1 " +
                    "AND sal_customer_purchase_order.Code LIKE ='"+code+"'" )
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("custPONo", Hibernate.STRING)
                .addScalar("revision", Hibernate.STRING)
                .addScalar("refCUSTPOCode", Hibernate.STRING) 
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("customerPurchaseOrderNo", Hibernate.STRING)
                .addScalar("customerCode", Hibernate.STRING)
                .addScalar("customerName", Hibernate.STRING)
                .addScalar("endUserCode", Hibernate.STRING)
                .addScalar("endUserName", Hibernate.STRING)                                 
                .addScalar("partialShipmentStatus", Hibernate.STRING) 
                .addScalar("retentionPercent", Hibernate.BIG_DECIMAL)    
                .addScalar("currencyCode", Hibernate.STRING)    
                .addScalar("currencyName", Hibernate.STRING)    
                .addScalar("salesPersonCode", Hibernate.STRING)    
                .addScalar("salesPersonName", Hibernate.STRING)    
                .addScalar("projectCode", Hibernate.STRING)     
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("totalTransactionAmount", Hibernate.BIG_DECIMAL)
                .addScalar("discountPercent", Hibernate.BIG_DECIMAL)
                .addScalar("discountAmount", Hibernate.BIG_DECIMAL)
                .addScalar("totalAdditionalFeeAmount", Hibernate.BIG_DECIMAL)
                .addScalar("taxBaseAmount", Hibernate.BIG_DECIMAL)
                .addScalar("vatPercent", Hibernate.BIG_DECIMAL)
                .addScalar("vatAmount", Hibernate.BIG_DECIMAL)
                .addScalar("grandTotalAmount", Hibernate.BIG_DECIMAL)
                .setResultTransformer(Transformers.aliasToBean(CustomerPurchaseOrder.class))
                .uniqueResult(); 
                 
                return customerPurchaseOrder;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<CustomerPurchaseOrderSalesQuotation> findGetData(String code){
        try {
            List<CustomerPurchaseOrderSalesQuotation> list = (List<CustomerPurchaseOrderSalesQuotation>)hbmSession.hSession.createSQLQuery(
                    "SELECT " +
                    "sal_customer_purchase_order_jn_sales_quotation.HeaderCode AS Code, "+
                    "sal_customer_purchase_order_jn_sales_quotation.SalesQuotationCode, "+
                    "sal_sales_quotation.TransactionDate, "+
                    "sal_sales_quotation.Subject AS SalesQuotationSubject "+
                    "FROM sal_customer_purchase_order " +
                    "INNER JOIN sal_customer_purchase_order_jn_sales_quotation ON sal_customer_purchase_order_jn_sales_quotation.HeaderCode = sal_customer_purchase_order.Code " +
                    "INNER JOIN sal_sales_quotation ON sal_customer_purchase_order_jn_sales_quotation.SalesQuotationCode = sal_sales_quotation.Code " +
                    "WHERE sal_customer_purchase_order_jn_sales_quotation.HeaderCode = '"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("salesQuotationCode", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("salesQuotationSubject", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(CustomerPurchaseOrderSalesQuotation.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public CustomerPurchaseOrder totalAdditionalFeeAmount(String headerCode){
       try {   
            CustomerPurchaseOrder customerPurchaseOrder = (CustomerPurchaseOrder)hbmSession.hSession.createSQLQuery(
                "SELECT " +
                "	sal_customer_purchase_order.TotalTransactionAmount, " +
                "	sal_customer_purchase_order.DiscountPercent, " +
                "	sal_customer_purchase_order.DiscountAmount, " +
                "	fn_getAdditionalFee(sal_customer_purchase_order.Code,'POC') AS totalAdditionalFeeAmount, " +
                "	sal_customer_purchase_order.TaxBaseAmount, " +
                "	sal_customer_purchase_order.Vatpercent, " +
                "	sal_customer_purchase_order.Vatamount, " +
                "	sal_customer_purchase_order.GrandTotalAmount " +
                "FROM sal_customer_purchase_order " +
                "WHERE sal_customer_purchase_order.Code=:prmHeaderCode")
                    
                .addScalar("totalTransactionAmount", Hibernate.BIG_DECIMAL)
                .addScalar("discountPercent", Hibernate.BIG_DECIMAL)
                .addScalar("discountAmount", Hibernate.BIG_DECIMAL)
                .addScalar("totalAdditionalFeeAmount", Hibernate.BIG_DECIMAL)
                .addScalar("taxBaseAmount", Hibernate.BIG_DECIMAL)
                .addScalar("vatPercent", Hibernate.BIG_DECIMAL)
                .addScalar("vatAmount", Hibernate.BIG_DECIMAL)
                .addScalar("grandTotalAmount", Hibernate.BIG_DECIMAL)
                .setParameter("prmHeaderCode", headerCode)
                .setResultTransformer(Transformers.aliasToBean(CustomerPurchaseOrder.class))
                .uniqueResult(); 
                 
                return customerPurchaseOrder;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public String createCode(EnumActivity.ENUM_Activity enumActivity, CustomerPurchaseOrder customerPurchaseOrder){
        try{
            String acronim="";
            String splitter=CommonConst.spliterNoRev;
            int transactionLength=0;
            if(enumActivity.equals(EnumActivity.ENUM_Activity.NEW) || enumActivity.equals(EnumActivity.ENUM_Activity.CLONE)){
                acronim = customerPurchaseOrder.getBranch().getCode()+"/"+EnumTransactionType.ENUM_TransactionType.PCO.toString()+"/"+AutoNumber.formatingDate(customerPurchaseOrder.getTransactionDate(), true, true, false);
                transactionLength=AutoNumber.DEFAULT_TRANSACTION_LENGTH_4;
            }
            
            if(enumActivity.equals(EnumActivity.ENUM_Activity.REVISE)){
                acronim = customerPurchaseOrder.getCustPONo() + splitter;
                transactionLength=AutoNumber.DEFAULT_TRANSACTION_LENGTH_2;
            }

            DetachedCriteria dc = DetachedCriteria.forClass(CustomerPurchaseOrder.class)
                    .setProjection(Projections.max("code"))
                    .add(Restrictions.like("code",acronim + "%" ));

            Criteria criteria = dc.getExecutableCriteria(hbmSession.hSession);
            List list = criteria.list();

           String oldID = "";
            if(list != null){
                if (list.size() > 0)
                    if(list.get(0) != null){
                        if(enumActivity.equals(EnumActivity.ENUM_Activity.NEW)|| enumActivity.equals(EnumActivity.ENUM_Activity.CLONE)){
                            oldID = list.get(0).toString().split(splitter)[0];
                        }
                        if(enumActivity.equals(EnumActivity.ENUM_Activity.REVISE)){
                            oldID = list.get(0).toString();
                        }
                    }
            }
            return AutoNumber.generate_rev(enumActivity,acronim, oldID, transactionLength);
        }
        catch(HibernateException e){
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void save(EnumActivity.ENUM_Activity enumActivity,CustomerPurchaseOrder customerPurchaseOrder,
            List<CustomerPurchaseOrderSalesQuotation> listCustomerPurchaseOrderSalesQuotation, 
            List<CustomerPurchaseOrderItemDetail> listCustomerPurchaseOrderItemDetail,
            List<CustomerPurchaseOrderAdditionalFee> listCustomerPurchaseOrderAdditionalFee,
            List<CustomerPurchaseOrderPaymentTerm> listCustomerPurchaseOrderPaymentTerm,
            List<CustomerPurchaseOrderItemDeliveryDate> listCustomerPurchaseOrderItemDeliveryDate, String moduleCode) throws Exception {
            CustomerBlanketOrder blanketOrder = new CustomerBlanketOrder();
        try {
            
            String headerCode=createCode(enumActivity,customerPurchaseOrder);
            
            hbmSession.hSession.beginTransaction();
            
            customerPurchaseOrder.setCode(headerCode);
            String[] custPONo=customerPurchaseOrder.getCode().split("_REV.");
            customerPurchaseOrder.setCustPONo(custPONo[0]);
            customerPurchaseOrder.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            customerPurchaseOrder.setCreatedDate(new Date());
            
            hbmSession.hSession.save(customerPurchaseOrder);
//            blanketOrder = customerPurchaseOrder;
            
            if (!processDetail(EnumActivity.ENUM_Activity.NEW, 
                    customerPurchaseOrder,listCustomerPurchaseOrderSalesQuotation,listCustomerPurchaseOrderItemDetail,
                    listCustomerPurchaseOrderAdditionalFee,listCustomerPurchaseOrderPaymentTerm,listCustomerPurchaseOrderItemDeliveryDate)) {
                hbmSession.hTransaction.rollback();
            }
            
            if (!saveBlanketOrderHeader(EnumActivity.ENUM_Activity.NEW, 
                    customerPurchaseOrder,listCustomerPurchaseOrderSalesQuotation,listCustomerPurchaseOrderItemDetail,
                    listCustomerPurchaseOrderAdditionalFee,listCustomerPurchaseOrderPaymentTerm,
                    listCustomerPurchaseOrderItemDeliveryDate,moduleCode)) {
                hbmSession.hTransaction.rollback();
            }


            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT), 
                                                                    customerPurchaseOrder.getCode(),EnumActivity.toString(enumActivity)));
            
            hbmSession.hTransaction.commit();
            hbmSession.hSession.clear();
            hbmSession.hSession.close();   
            
            
        }
        catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            hbmSession.hSession.clear();
            hbmSession.hSession.close();
            throw e;
        }
    }
  
    public void update(CustomerPurchaseOrder customerPurchaseOrder,
            List<CustomerPurchaseOrderSalesQuotation> listCustomerPurchaseOrderSalesQuotation, 
            List<CustomerPurchaseOrderItemDetail> listCustomerPurchaseOrderItemDetail,
            List<CustomerPurchaseOrderAdditionalFee> listCustomerPurchaseOrderAdditionalFee,
            List<CustomerPurchaseOrderPaymentTerm> listCustomerPurchaseOrderPaymentTerm,
            List<CustomerPurchaseOrderItemDeliveryDate> listCustomerPurchaseOrderItemDeliveryDate, String moduleCode) throws Exception {
        try {
            
            hbmSession.hSession.beginTransaction();
            
            customerPurchaseOrder.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            customerPurchaseOrder.setUpdatedDate(new Date());
                        
            hbmSession.hSession.update(customerPurchaseOrder);
            
            if (!processDetail(EnumActivity.ENUM_Activity.UPDATE, 
                    customerPurchaseOrder,listCustomerPurchaseOrderSalesQuotation,listCustomerPurchaseOrderItemDetail,
                    listCustomerPurchaseOrderAdditionalFee,listCustomerPurchaseOrderPaymentTerm,listCustomerPurchaseOrderItemDeliveryDate)) {
                hbmSession.hTransaction.rollback();
            }
            if (!updateBlanketOrderHeader(EnumActivity.ENUM_Activity.NEW, 
                    customerPurchaseOrder,listCustomerPurchaseOrderSalesQuotation,listCustomerPurchaseOrderItemDetail,
                    listCustomerPurchaseOrderAdditionalFee,listCustomerPurchaseOrderPaymentTerm,
                    listCustomerPurchaseOrderItemDeliveryDate,moduleCode)) {
                hbmSession.hTransaction.rollback();
            }
                        
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
                                                                    customerPurchaseOrder.getCode(),EnumActivity.toString(EnumActivity.ENUM_Activity.UPDATE)));
            hbmSession.hTransaction.commit();
            hbmSession.hSession.clear();
            hbmSession.hSession.close();                      
        }
        catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            hbmSession.hSession.clear();
            hbmSession.hSession.close();
            throw e;
        }
    }
    
    public void revise(CustomerPurchaseOrder customerPurchaseOrder,
            List<CustomerPurchaseOrderSalesQuotation> listCustomerPurchaseOrderSalesQuotation, 
            List<CustomerPurchaseOrderItemDetail> listCustomerPurchaseOrderItemDetail,
            List<CustomerPurchaseOrderAdditionalFee> listCustomerPurchaseOrderAdditionalFee,
            List<CustomerPurchaseOrderPaymentTerm> listCustomerPurchaseOrderPaymentTerm,
            List<CustomerPurchaseOrderItemDeliveryDate> listCustomerPurchaseOrderItemDeliveryDate, String moduleCode) throws Exception {
        try {
            
            hbmSession.hSession.beginTransaction();
            
            String oldCustomerPurchaseOderCode=customerPurchaseOrder.getRefCUSTPOCode();
            CustomerPurchaseOrder customerPurchaseOrderOld=get(oldCustomerPurchaseOderCode);
            customerPurchaseOrderOld.setValidStatus(false);
            hbmSession.hSession.update(customerPurchaseOrderOld);
  
            hbmSession.hSession.flush();
            
            customerPurchaseOrder.setRefCUSTPOCode(customerPurchaseOrderOld.getCode());
            String headerCode=createCode(EnumActivity.ENUM_Activity.REVISE,customerPurchaseOrder);
            customerPurchaseOrder.setCode(headerCode);
            customerPurchaseOrder.setRevision(customerPurchaseOrder.getCode().substring(customerPurchaseOrder.getCode().length()-2));
            
            hbmSession.hSession.save(customerPurchaseOrder);
            
            //blanket Order
            CustomerBlanketOrderDAO blanketOrderDAO = new CustomerBlanketOrderDAO(hbmSession);
            CustomerBlanketOrder blanketOrderNew = new CustomerBlanketOrder();
            CustomerBlanketOrder blanketOrder = blanketOrderDAO.getFromWoForRevise(oldCustomerPurchaseOderCode);
            
            String oldSalesOrder = blanketOrder.getCode();
            CustomerBlanketOrder blanketOrderOld = blanketOrderDAO.get(oldSalesOrder);
            blanketOrderOld.setValidStatus(false);
            hbmSession.hSession.update(blanketOrderOld);
            
            hbmSession.hSession.flush();
            
            blanketOrder.setRefCUSTBOCode(blanketOrderOld.getCode());
            
            String headerCodeSo = blanketOrderDAO.createCodeRevise(EnumActivity.ENUM_Activity.REVISE, blanketOrderOld);
            blanketOrderNew.setCode(headerCodeSo);
            blanketOrderNew.setRefCUSTBOCode(blanketOrderOld.getCode());
            blanketOrderNew.setRevision(blanketOrderNew.getCode().substring(blanketOrderNew.getCode().length()-2));
            
            String custBoNoRevise = blanketOrder.getCode().split("["+CommonConst.spliterNo+"]")[0];
            blanketOrderNew.setCustBONo(custBoNoRevise);
            blanketOrderNew.setClosingStatus("OPEN");
            
            blanketOrderNew.setTransactionDate(customerPurchaseOrder.getTransactionDate());
            blanketOrderNew.setRequestDeliveryDate(customerPurchaseOrder.getTransactionDate());
            blanketOrderNew.setExpiredDate(customerPurchaseOrder.getTransactionDate());
            
            blanketOrderNew.setRefNo(customerPurchaseOrder.getRefNo());
            blanketOrderNew.setRemark(customerPurchaseOrder.getRemark());
            
            blanketOrderNew.setTotalTransactionAmount(customerPurchaseOrder.getTotalTransactionAmount());
            blanketOrderNew.setDiscountPercent(customerPurchaseOrder.getDiscountPercent());
            blanketOrderNew.setDiscountAmount(customerPurchaseOrder.getDiscountAmount());
            blanketOrderNew.setTaxBaseAmount(customerPurchaseOrder.getTaxBaseAmount());
            blanketOrderNew.setVatPercent(customerPurchaseOrder.getVatPercent());
            blanketOrderNew.setVatAmount(customerPurchaseOrder.getVatAmount());
            blanketOrderNew.setGrandTotalAmount(customerPurchaseOrder.getGrandTotalAmount());

            blanketOrderNew.setBranch(customerPurchaseOrder.getBranch());
            blanketOrderNew.setCustomer(customerPurchaseOrder.getCustomer());
            blanketOrderNew.setEndUser(customerPurchaseOrder.getEndUser());
            blanketOrderNew.setCurrency(customerPurchaseOrder.getCurrency());
            blanketOrderNew.setSalesPerson(customerPurchaseOrder.getSalesPerson());
            blanketOrderNew.setProject(customerPurchaseOrder.getProject());
            blanketOrderNew.setCustomerPurchaseOrder(customerPurchaseOrder);
            
            blanketOrderNew.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            blanketOrderNew.setCreatedDate(new Date());
            hbmSession.hSession.flush();
            hbmSession.hSession.save(blanketOrderNew);
            
            if (!processDetail(EnumActivity.ENUM_Activity.UPDATE, 
                    customerPurchaseOrder,listCustomerPurchaseOrderSalesQuotation,listCustomerPurchaseOrderItemDetail,
                    listCustomerPurchaseOrderAdditionalFee,listCustomerPurchaseOrderPaymentTerm,listCustomerPurchaseOrderItemDeliveryDate)) {
                hbmSession.hTransaction.rollback();
            }
            
            if (!processReviseDetailBlanketOrder(EnumActivity.ENUM_Activity.UPDATE, 
                    blanketOrderNew,customerPurchaseOrder,listCustomerPurchaseOrderSalesQuotation,listCustomerPurchaseOrderItemDetail,
                    listCustomerPurchaseOrderAdditionalFee,listCustomerPurchaseOrderPaymentTerm,listCustomerPurchaseOrderItemDeliveryDate)) {
                hbmSession.hTransaction.rollback();
            }
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode,
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
                                                                    customerPurchaseOrder.getCode(),EnumActivity.toString(EnumActivity.ENUM_Activity.REVISE)));
            hbmSession.hTransaction.commit();
            hbmSession.hSession.clear();
            hbmSession.hSession.close();                      
        }
        catch (Exception e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            hbmSession.hSession.clear();
            hbmSession.hSession.close();
            throw e;
        }
    }

    public void delete(CustomerPurchaseOrder customerPurchaseOrder, String moduleCode){
        try{
            hbmSession.hSession.beginTransaction();
                    
            CustomerBlanketOrder blanketOrder = new CustomerBlanketOrder();
            CustomerBlanketOrderDAO blanketOrderDAO = new CustomerBlanketOrderDAO(hbmSession);
            
            if (!processDetail(EnumActivity.ENUM_Activity.DELETE, customerPurchaseOrder,null,null,null,null,null)) {
                hbmSession.hTransaction.rollback();
            }
            
            hbmSession.hSession.createQuery("DELETE FROM CustomerPurchaseOrder "
                    + " WHERE code  = :prmCode")
                    .setParameter("prmCode", customerPurchaseOrder.getCode())
                    .executeUpdate();
            
            CustomerBlanketOrder blanketOrderUpdate = blanketOrderDAO.getFromWoForRevise(customerPurchaseOrder.getCode());
            
            String oldSalesOrder = blanketOrderUpdate.getCode();
            CustomerBlanketOrder blanketOrderOld = blanketOrderDAO.getBlanketOrderUpdate(oldSalesOrder);
                        
            if (!processDetailBlanketOrder(EnumActivity.ENUM_Activity.DELETE, blanketOrderOld ,null,null,null,null,null)) {
                hbmSession.hTransaction.rollback();
            }
            hbmSession.hSession.createQuery("DELETE FROM CustomerBlanketOrder "
                    + " WHERE code  = :prmCode")
                    .setParameter("prmCode", blanketOrderOld.getCode())
                    .executeUpdate();
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.DELETE), 
                                                                    customerPurchaseOrder.getCode(), EnumActivity.toString(EnumActivity.ENUM_Activity.DELETE)));
            
            hbmSession.hTransaction.commit();
            hbmSession.hSession.clear();
            hbmSession.hSession.close();
            
        }catch(HibernateException e){
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            hbmSession.hSession.clear();
            hbmSession.hSession.close();
            throw e;
        }
    }
       
    private boolean processDetail(EnumActivity.ENUM_Activity enumActivity, CustomerPurchaseOrder customerPurchaseOrder,
            List<CustomerPurchaseOrderSalesQuotation> listCustomerPurchaseOrderSalesQuotation, 
            List<CustomerPurchaseOrderItemDetail> listCustomerPurchaseOrderItemDetail,
            List<CustomerPurchaseOrderAdditionalFee> listCustomerPurchaseOrderAdditionalFee,
            List<CustomerPurchaseOrderPaymentTerm> listCustomerPurchaseOrderPaymentTerm,
            List<CustomerPurchaseOrderItemDeliveryDate> listCustomerPurchaseOrderItemDeliveryDate){
        try{
            
            if(enumActivity.equals(EnumActivity.ENUM_Activity.UPDATE) || enumActivity.equals(EnumActivity.ENUM_Activity.DELETE)){
                hbmSession.hSession.createQuery("DELETE FROM "+CustomerPurchaseOrderSalesQuotationField.BEAN_NAME+" WHERE "+CustomerPurchaseOrderSalesQuotationField.HEADERCODE+" = :prmCode")
                    .setParameter("prmCode", customerPurchaseOrder.getCode())    
                    .executeUpdate();
            
                hbmSession.hSession.createQuery("DELETE FROM "+CustomerPurchaseOrderItemDetailField.BEAN_NAME+" WHERE "+CustomerPurchaseOrderItemDetailField.HEADERCODE+" = :prmCode")
                        .setParameter("prmCode", customerPurchaseOrder.getCode())    
                        .executeUpdate();

                hbmSession.hSession.createQuery("DELETE FROM "+CustomerPurchaseOrderAdditionalFeeField.BEAN_NAME+" WHERE "+CustomerPurchaseOrderAdditionalFeeField.HEADERCODE+" = :prmCode")
                        .setParameter("prmCode", customerPurchaseOrder.getCode())    
                        .executeUpdate();

                hbmSession.hSession.createQuery("DELETE FROM "+CustomerPurchaseOrderPaymentTermField.BEAN_NAME+" WHERE "+CustomerPurchaseOrderPaymentTermField.HEADERCODE+" = :prmCode")
                        .setParameter("prmCode", customerPurchaseOrder.getCode())    
                        .executeUpdate();

                hbmSession.hSession.createQuery("DELETE FROM "+CustomerPurchaseOrderItemDeliveryDateField.BEAN_NAME+" WHERE "+CustomerPurchaseOrderItemDeliveryDateField.HEADERCODE+" = :prmCode")
                        .setParameter("prmCode", customerPurchaseOrder.getCode())    
                        .executeUpdate();
            }
            
            
            if(enumActivity.equals(EnumActivity.ENUM_Activity.UPDATE) || enumActivity.equals(EnumActivity.ENUM_Activity.NEW) || enumActivity.equals(EnumActivity.ENUM_Activity.CLONE)){
                int q = 1;
                for(CustomerPurchaseOrderSalesQuotation customerPurchaseOrderSalesQuotation : listCustomerPurchaseOrderSalesQuotation){

                    String detailCode = customerPurchaseOrder.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(q),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    customerPurchaseOrderSalesQuotation.setCode(detailCode);
                    customerPurchaseOrderSalesQuotation.setHeaderCode(customerPurchaseOrder.getCode());

                    customerPurchaseOrderSalesQuotation.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    customerPurchaseOrderSalesQuotation.setCreatedDate(new Date());

                    hbmSession.hSession.save(customerPurchaseOrderSalesQuotation);

                    q++;
                }

                int i = 1;
                for(CustomerPurchaseOrderItemDetail customerPurchaseOrderItemDetail : listCustomerPurchaseOrderItemDetail){

                    String detailCode = customerPurchaseOrder.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    customerPurchaseOrderItemDetail.setCode(detailCode);
                    customerPurchaseOrderItemDetail.setHeaderCode(customerPurchaseOrder.getCode());

                    customerPurchaseOrderItemDetail.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    customerPurchaseOrderItemDetail.setCreatedDate(new Date());

                    hbmSession.hSession.save(customerPurchaseOrderItemDetail);

                    i++;
                }

                int f = 1;
                for(CustomerPurchaseOrderAdditionalFee customerPurchaseOrderAdditionalFee : listCustomerPurchaseOrderAdditionalFee){

                    String detailCode = customerPurchaseOrder.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(f),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    customerPurchaseOrderAdditionalFee.setCode(detailCode);
                    customerPurchaseOrderAdditionalFee.setHeaderCode(customerPurchaseOrder.getCode());

                    customerPurchaseOrderAdditionalFee.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    customerPurchaseOrderAdditionalFee.setCreatedDate(new Date());

                    hbmSession.hSession.save(customerPurchaseOrderAdditionalFee);

                    f++;
                }

                int p = 1;
                for(CustomerPurchaseOrderPaymentTerm customerPurchaseOrderPaymentTerm : listCustomerPurchaseOrderPaymentTerm){

                    String detailCode = customerPurchaseOrder.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(p),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    customerPurchaseOrderPaymentTerm.setCode(detailCode);
                    customerPurchaseOrderPaymentTerm.setHeaderCode(customerPurchaseOrder.getCode());

                    customerPurchaseOrderPaymentTerm.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    customerPurchaseOrderPaymentTerm.setCreatedDate(new Date());

                    hbmSession.hSession.save(customerPurchaseOrderPaymentTerm);

                    p++;
                }

                int d = 1;
                for(CustomerPurchaseOrderItemDeliveryDate customerPurchaseOrderItemDeliveryDate : listCustomerPurchaseOrderItemDeliveryDate){

                    String detailCode = customerPurchaseOrder.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(d),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    customerPurchaseOrderItemDeliveryDate.setCode(detailCode);
                    customerPurchaseOrderItemDeliveryDate.setHeaderCode(customerPurchaseOrder.getCode());

                    customerPurchaseOrderItemDeliveryDate.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    customerPurchaseOrderItemDeliveryDate.setCreatedDate(new Date());

                    hbmSession.hSession.save(customerPurchaseOrderItemDeliveryDate);

                    d++;
                }
            }
            
            return Boolean.TRUE;
        }catch(HibernateException e){
            e.printStackTrace();
            return Boolean.FALSE;
        }
    }
    
    private boolean processDetailBlanketOrder(EnumActivity.ENUM_Activity enumActivity, CustomerBlanketOrder customerBlanketOrder,
            List<CustomerBlanketOrderSalesQuotation> listCustomerBlanketOrderSalesQuotation, 
            List<CustomerBlanketOrderItemDetail> listCustomerBlanketOrderItemDetail,
            List<CustomerBlanketOrderAdditionalFee> listCustomerBlanketOrderAdditionalFee,
            List<CustomerBlanketOrderPaymentTerm> listCustomerBlanketOrderPaymentTerm,
            List<CustomerBlanketOrderItemDeliveryDate> listCustomerBlanketOrderItemDeliveryDate){
        try{
            
            if(enumActivity.equals(EnumActivity.ENUM_Activity.UPDATE) || enumActivity.equals(EnumActivity.ENUM_Activity.DELETE)){
                hbmSession.hSession.createQuery("DELETE FROM "+CustomerBlanketOrderSalesQuotationField.BEAN_NAME+" WHERE "+CustomerBlanketOrderSalesQuotationField.HEADERCODE+" = :prmCode")
                    .setParameter("prmCode", customerBlanketOrder.getCode())    
                    .executeUpdate();
            
                hbmSession.hSession.createQuery("DELETE FROM "+CustomerBlanketOrderItemDetailField.BEAN_NAME+" WHERE "+CustomerBlanketOrderItemDetailField.HEADERCODE+" = :prmCode")
                        .setParameter("prmCode", customerBlanketOrder.getCode())    
                        .executeUpdate();

                hbmSession.hSession.createQuery("DELETE FROM "+CustomerBlanketOrderAdditionalFeeField.BEAN_NAME+" WHERE "+CustomerBlanketOrderAdditionalFeeField.HEADERCODE+" = :prmCode")
                        .setParameter("prmCode", customerBlanketOrder.getCode())    
                        .executeUpdate();

                hbmSession.hSession.createQuery("DELETE FROM "+CustomerBlanketOrderPaymentTermField.BEAN_NAME+" WHERE "+CustomerBlanketOrderPaymentTermField.HEADERCODE+" = :prmCode")
                        .setParameter("prmCode", customerBlanketOrder.getCode())    
                        .executeUpdate();

                hbmSession.hSession.createQuery("DELETE FROM "+CustomerBlanketOrderItemDeliveryDateField.BEAN_NAME+" WHERE "+CustomerBlanketOrderItemDeliveryDateField.HEADERCODE+" = :prmCode")
                        .setParameter("prmCode", customerBlanketOrder.getCode())    
                        .executeUpdate();
            }
            
            
            if(enumActivity.equals(EnumActivity.ENUM_Activity.UPDATE) || enumActivity.equals(EnumActivity.ENUM_Activity.NEW)){
                int q = 1;
                for(CustomerBlanketOrderSalesQuotation blanketOrderSalesQuotation : listCustomerBlanketOrderSalesQuotation){

                    String detailCode = customerBlanketOrder.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(q),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    blanketOrderSalesQuotation.setCode(detailCode);
                    blanketOrderSalesQuotation.setHeaderCode(customerBlanketOrder.getCode());

                    blanketOrderSalesQuotation.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    blanketOrderSalesQuotation.setCreatedDate(new Date());

                    hbmSession.hSession.save(blanketOrderSalesQuotation);

                    q++;
                }

                int i = 1;
                for(CustomerBlanketOrderItemDetail blanketOrderItemDetail : listCustomerBlanketOrderItemDetail){

                    String detailCode = customerBlanketOrder.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    blanketOrderItemDetail.setCode(detailCode);
                    blanketOrderItemDetail.setHeaderCode(customerBlanketOrder.getCode());

                    blanketOrderItemDetail.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    blanketOrderItemDetail.setCreatedDate(new Date());

                    hbmSession.hSession.save(blanketOrderItemDetail);

                    i++;
                }

                int f = 1;
                for(CustomerBlanketOrderAdditionalFee blanketOrderAdditionalFee : listCustomerBlanketOrderAdditionalFee){

                    String detailCode = customerBlanketOrder.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(f),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    blanketOrderAdditionalFee.setCode(detailCode);
                    blanketOrderAdditionalFee.setHeaderCode(customerBlanketOrder.getCode());

                    blanketOrderAdditionalFee.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    blanketOrderAdditionalFee.setCreatedDate(new Date());

                    hbmSession.hSession.save(blanketOrderAdditionalFee);

                    f++;
                }

                int p = 1;
                for(CustomerBlanketOrderPaymentTerm blanketOrderPaymentTerm : listCustomerBlanketOrderPaymentTerm){

                    String detailCode = customerBlanketOrder.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(p),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    blanketOrderPaymentTerm.setCode(detailCode);
                    blanketOrderPaymentTerm.setHeaderCode(customerBlanketOrder.getCode());

                    blanketOrderPaymentTerm.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    blanketOrderPaymentTerm.setCreatedDate(new Date());

                    hbmSession.hSession.save(blanketOrderPaymentTerm);

                    p++;
                }

                int d = 1;
                for(CustomerBlanketOrderItemDeliveryDate blanketOrderItemDeliveryDate : listCustomerBlanketOrderItemDeliveryDate){

                    String detailCode = customerBlanketOrder.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(d),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    blanketOrderItemDeliveryDate.setCode(detailCode);
                    blanketOrderItemDeliveryDate.setHeaderCode(customerBlanketOrder.getCode());

                    blanketOrderItemDeliveryDate.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    blanketOrderItemDeliveryDate.setCreatedDate(new Date());

                    hbmSession.hSession.save(blanketOrderItemDeliveryDate);

                    d++;
                }
            }
            
            return Boolean.TRUE;
        }catch(HibernateException e){
            e.printStackTrace();
            return Boolean.FALSE;
        }
    }
    
    private boolean saveBlanketOrderHeader(EnumActivity.ENUM_Activity enumActivity,CustomerPurchaseOrder customerPurchaseOrder,
            List<CustomerPurchaseOrderSalesQuotation> listCustomerPurchaseOrderSalesQuotation, 
            List<CustomerPurchaseOrderItemDetail> listCustomerPurchaseOrderItemDetail,
            List<CustomerPurchaseOrderAdditionalFee> listCustomerPurchaseOrderAdditionalFee,
            List<CustomerPurchaseOrderPaymentTerm> listCustomerPurchaseOrderPaymentTerm,
            List<CustomerPurchaseOrderItemDeliveryDate> listCustomerPurchaseOrderItemDeliveryDate, String moduleCode) throws Exception{

            CustomerBlanketOrder blanketOrder = new CustomerBlanketOrder();
            
        try{
        
            CustomerBlanketOrderDAO blanketOrderDAO = new CustomerBlanketOrderDAO(hbmSession);
            
            String headerCode= blanketOrderDAO.createCodeBo(enumActivity, customerPurchaseOrder);
            
            blanketOrder.setCode(headerCode);
            String[] custBONo=blanketOrder.getCode().split("_REV.");
            String custBONo1 = custBONo[0];
            blanketOrder.setCustBONo(custBONo1);
            blanketOrder.setClosingStatus("OPEN");
            blanketOrder.setRevision("00");
            blanketOrder.setTransactionDate(customerPurchaseOrder.getTransactionDate());
            blanketOrder.setRequestDeliveryDate(customerPurchaseOrder.getTransactionDate());
            blanketOrder.setExpiredDate(customerPurchaseOrder.getTransactionDate());
            
            blanketOrder.setRefNo(customerPurchaseOrder.getRefNo());
            blanketOrder.setRemark(customerPurchaseOrder.getRemark());
            
            blanketOrder.setTotalTransactionAmount(customerPurchaseOrder.getTotalTransactionAmount());
            blanketOrder.setDiscountPercent(customerPurchaseOrder.getDiscountPercent());
            blanketOrder.setDiscountAmount(customerPurchaseOrder.getDiscountAmount());
            blanketOrder.setTaxBaseAmount(customerPurchaseOrder.getTaxBaseAmount());
            blanketOrder.setVatPercent(customerPurchaseOrder.getVatPercent());
            blanketOrder.setVatAmount(customerPurchaseOrder.getVatAmount());
            blanketOrder.setGrandTotalAmount(customerPurchaseOrder.getGrandTotalAmount());

            blanketOrder.setBranch(customerPurchaseOrder.getBranch());
            blanketOrder.setCustomer(customerPurchaseOrder.getCustomer());
            blanketOrder.setEndUser(customerPurchaseOrder.getEndUser());
            blanketOrder.setCurrency(customerPurchaseOrder.getCurrency());
            blanketOrder.setSalesPerson(customerPurchaseOrder.getSalesPerson());
            blanketOrder.setProject(customerPurchaseOrder.getProject());
            blanketOrder.setCustomerPurchaseOrder(customerPurchaseOrder);
//            blanketOrder.setOrderType(customerPurchaseOrder.getPurchaseOrderType());
            
            blanketOrder.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            blanketOrder.setCreatedDate(new Date());

            hbmSession.hSession.save(blanketOrder);
            
             // save Detail
            //SalesQuotation
            int q = 1;  
            CustomerBlanketOrderSalesQuotation blanketOrderSalesQuotation = new CustomerBlanketOrderSalesQuotation(); 
                for(CustomerPurchaseOrderSalesQuotation customerPurchaseOrderSalesQuotation : listCustomerPurchaseOrderSalesQuotation){

                    String detailCode = blanketOrder.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(q),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    blanketOrderSalesQuotation.setCode(detailCode);
                    blanketOrderSalesQuotation.setHeaderCode(blanketOrder.getCode());
                    blanketOrderSalesQuotation.setSalesQuotation(customerPurchaseOrderSalesQuotation.getSalesQuotation());

                    blanketOrderSalesQuotation.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    blanketOrderSalesQuotation.setCreatedDate(new Date());

                    hbmSession.hSession.save(blanketOrderSalesQuotation);
                    hbmSession.hSession.flush();
                    hbmSession.hSession.clear();
                    q++;
                }
            
            //Item
            int i = 1;
            CustomerBlanketOrderItemDetail blanketOrderItemDetail = new CustomerBlanketOrderItemDetail();
                for(CustomerPurchaseOrderItemDetail customerPurchaseOrderItemDetail : listCustomerPurchaseOrderItemDetail){

                    String detailCode = blanketOrder.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    
                    blanketOrderItemDetail.setCode(detailCode);
                    blanketOrderItemDetail.setHeaderCode(blanketOrder.getCode());
                    blanketOrderItemDetail.setSalesQuotation(customerPurchaseOrderItemDetail.getSalesQuotation());
                    blanketOrderItemDetail.setSalesQuotationDetail(customerPurchaseOrderItemDetail.getSalesQuotationDetail());
                    blanketOrderItemDetail.setItemFinishGoods(customerPurchaseOrderItemDetail.getItemFinishGoods());
                    blanketOrderItemDetail.setQuantity(customerPurchaseOrderItemDetail.getQuantity());
                    blanketOrderItemDetail.setItemAlias(customerPurchaseOrderItemDetail.getItemAlias());
                    blanketOrderItemDetail.setCustomerPurchaseOrderSortNo(customerPurchaseOrderItemDetail.getCustomerPurchaseOrderSortNo());
                    blanketOrderItemDetail.setValveTag(customerPurchaseOrderItemDetail.getValveTag());
                    blanketOrderItemDetail.setDataSheet(customerPurchaseOrderItemDetail.getDataSheet());
                    blanketOrderItemDetail.setDescription(customerPurchaseOrderItemDetail.getDescription());

                    blanketOrderItemDetail.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    blanketOrderItemDetail.setCreatedDate(new Date());

                    hbmSession.hSession.save(blanketOrderItemDetail);
                    hbmSession.hSession.flush();
                    hbmSession.hSession.clear();
                    i++;
                }
            
            //AdditionalFee
            int f = 1;
            CustomerBlanketOrderAdditionalFee blanketOrderAdditionalFee = new CustomerBlanketOrderAdditionalFee(); 
                for(CustomerPurchaseOrderAdditionalFee customerPurchaseOrderAdditionalFee : listCustomerPurchaseOrderAdditionalFee){

                    String detailCode = blanketOrder.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(f),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    blanketOrderAdditionalFee.setCode(detailCode);
                    blanketOrderAdditionalFee.setHeaderCode(blanketOrder.getCode());
                    blanketOrderAdditionalFee.setRemark(customerPurchaseOrderAdditionalFee.getRemark());
                    blanketOrderAdditionalFee.setQuantity(customerPurchaseOrderAdditionalFee.getQuantity());
                    blanketOrderAdditionalFee.setUnitOfMeasure(customerPurchaseOrderAdditionalFee.getUnitOfMeasure());
                    blanketOrderAdditionalFee.setAdditionalFee(customerPurchaseOrderAdditionalFee.getAdditionalFee());
                    blanketOrderAdditionalFee.setPrice(customerPurchaseOrderAdditionalFee.getPrice());
                    blanketOrderAdditionalFee.setTotal(customerPurchaseOrderAdditionalFee.getTotal());

                    blanketOrderAdditionalFee.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    blanketOrderAdditionalFee.setCreatedDate(new Date());

                    hbmSession.hSession.save(blanketOrderAdditionalFee);
                    hbmSession.hSession.flush();
                    hbmSession.hSession.clear();
                    f++;
                }

            //PaymentTerm
            int p = 1;
            CustomerBlanketOrderPaymentTerm blanketOrderPaymentTerm = new CustomerBlanketOrderPaymentTerm();
            for(CustomerPurchaseOrderPaymentTerm customerPurchaseOrderPaymentTerm : listCustomerPurchaseOrderPaymentTerm){

                String detailCode = blanketOrder.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(p),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                blanketOrderPaymentTerm.setCode(detailCode);
                blanketOrderPaymentTerm.setHeaderCode(blanketOrder.getCode());
                blanketOrderPaymentTerm.setSortNo(customerPurchaseOrderPaymentTerm.getSortNo());
                blanketOrderPaymentTerm.setPaymentTerm(customerPurchaseOrderPaymentTerm.getPaymentTerm());
                blanketOrderPaymentTerm.setPercentage(customerPurchaseOrderPaymentTerm.getPercentage());
                blanketOrderPaymentTerm.setRemark(customerPurchaseOrderPaymentTerm.getRemark());


                blanketOrderPaymentTerm.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                blanketOrderPaymentTerm.setCreatedDate(new Date());

                hbmSession.hSession.save(blanketOrderPaymentTerm);
                hbmSession.hSession.flush();
                hbmSession.hSession.clear();
                p++;
            }
            
            //ItemDeliveryDate
            int d = 1;
                CustomerBlanketOrderItemDeliveryDate blanketOrderItemDeliveryDate = new CustomerBlanketOrderItemDeliveryDate();
                for(CustomerPurchaseOrderItemDeliveryDate customerPurchaseOrderItemDeliveryDate : listCustomerPurchaseOrderItemDeliveryDate){

                    String detailCode = blanketOrder.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(d),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    blanketOrderItemDeliveryDate.setCode(detailCode);
                    blanketOrderItemDeliveryDate.setHeaderCode(blanketOrder.getCode());
                    blanketOrderItemDeliveryDate.setItemFinishGoods(customerPurchaseOrderItemDeliveryDate.getItemFinishGoods());
                    blanketOrderItemDeliveryDate.setQuantity(customerPurchaseOrderItemDeliveryDate.getQuantity());
                    blanketOrderItemDeliveryDate.setDeliveryDate(customerPurchaseOrderItemDeliveryDate.getDeliveryDate());
                    blanketOrderItemDeliveryDate.setSalesQuotation(customerPurchaseOrderItemDeliveryDate.getSalesQuotation());
                    

                    blanketOrderItemDeliveryDate.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    blanketOrderItemDeliveryDate.setCreatedDate(new Date());

                    hbmSession.hSession.save(blanketOrderItemDeliveryDate);
                    hbmSession.hSession.flush();
                    hbmSession.hSession.clear();
                    d++;
                }
            
            return Boolean.TRUE;
        }catch(HibernateException e){
            e.printStackTrace();
            return Boolean.FALSE;
        }
    }
    
    private boolean updateBlanketOrderHeader(EnumActivity.ENUM_Activity enumActivity,CustomerPurchaseOrder customerPurchaseOrder,
            List<CustomerPurchaseOrderSalesQuotation> listCustomerPurchaseOrderSalesQuotation, 
            List<CustomerPurchaseOrderItemDetail> listCustomerPurchaseOrderItemDetail,
            List<CustomerPurchaseOrderAdditionalFee> listCustomerPurchaseOrderAdditionalFee,
            List<CustomerPurchaseOrderPaymentTerm> listCustomerPurchaseOrderPaymentTerm,
            List<CustomerPurchaseOrderItemDeliveryDate> listCustomerPurchaseOrderItemDeliveryDate, String moduleCode) throws Exception{

            CustomerBlanketOrder blanketOrder = new CustomerBlanketOrder();
            
        try{
        
            //get old sales Order
            CustomerBlanketOrderDAO blanketOrderDAO = new CustomerBlanketOrderDAO(hbmSession);
//            CustomerBlanketOrder blanketOrderNew = new CustomerBlanketOrder();
            CustomerBlanketOrder blanketOrderUpdate = blanketOrderDAO.getFromWoForRevise(customerPurchaseOrder.getCode());
            
            String oldSalesOrder = blanketOrderUpdate.getCode();
            CustomerBlanketOrder blanketOrderOld = blanketOrderDAO.getBlanketOrderUpdate(oldSalesOrder);
            
            blanketOrder.setCode(blanketOrderOld.getCode());
            blanketOrder.setCustBONo(blanketOrderOld.getCustBONo());
            blanketOrder.setRevision(blanketOrderOld.getRevision());
            blanketOrder.setTransactionDate(customerPurchaseOrder.getTransactionDate());
            blanketOrder.setRequestDeliveryDate(customerPurchaseOrder.getTransactionDate());
            blanketOrder.setExpiredDate(customerPurchaseOrder.getTransactionDate());
            blanketOrder.setClosingStatus("OPEN");
            
            blanketOrder.setRefNo(customerPurchaseOrder.getRefNo());
            blanketOrder.setRemark(customerPurchaseOrder.getRemark());
            
            blanketOrder.setTotalTransactionAmount(customerPurchaseOrder.getTotalTransactionAmount());
            blanketOrder.setDiscountPercent(customerPurchaseOrder.getDiscountPercent());
            blanketOrder.setDiscountAmount(customerPurchaseOrder.getDiscountAmount());
            blanketOrder.setTaxBaseAmount(customerPurchaseOrder.getTaxBaseAmount());
            blanketOrder.setVatPercent(customerPurchaseOrder.getVatPercent());
            blanketOrder.setVatAmount(customerPurchaseOrder.getVatAmount());
            blanketOrder.setGrandTotalAmount(customerPurchaseOrder.getGrandTotalAmount());

            blanketOrder.setBranch(customerPurchaseOrder.getBranch());
            blanketOrder.setCustomer(customerPurchaseOrder.getCustomer());
            blanketOrder.setEndUser(customerPurchaseOrder.getEndUser());
            blanketOrder.setCurrency(customerPurchaseOrder.getCurrency());
            blanketOrder.setSalesPerson(customerPurchaseOrder.getSalesPerson());
            blanketOrder.setProject(customerPurchaseOrder.getProject());
            blanketOrder.setCustomerPurchaseOrder(customerPurchaseOrder);
            
            blanketOrder.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            blanketOrder.setCreatedDate(new Date());

            hbmSession.hSession.update(blanketOrder);
            
            // update Detail
            hbmSession.hSession.createQuery("DELETE FROM "+CustomerBlanketOrderSalesQuotationField.BEAN_NAME+" WHERE "+ CustomerBlanketOrderSalesQuotationField.HEADERCODE+" = :prmCode")
                .setParameter("prmCode", blanketOrderOld.getCode())    
                .executeUpdate();

            hbmSession.hSession.createQuery("DELETE FROM "+CustomerBlanketOrderItemDetailField.BEAN_NAME+" WHERE "+ CustomerBlanketOrderItemDetailField.HEADERCODE+" = :prmCode")
                    .setParameter("prmCode", blanketOrderOld.getCode())    
                    .executeUpdate();

            hbmSession.hSession.createQuery("DELETE FROM "+CustomerBlanketOrderAdditionalFeeField.BEAN_NAME+" WHERE "+ CustomerBlanketOrderAdditionalFeeField.HEADERCODE+" = :prmCode")
                    .setParameter("prmCode", blanketOrderOld.getCode())    
                    .executeUpdate();

            hbmSession.hSession.createQuery("DELETE FROM "+CustomerBlanketOrderPaymentTermField.BEAN_NAME+" WHERE "+ CustomerBlanketOrderPaymentTermField.HEADERCODE+" = :prmCode")
                    .setParameter("prmCode", blanketOrderOld.getCode())    
                    .executeUpdate();

            hbmSession.hSession.createQuery("DELETE FROM "+CustomerBlanketOrderItemDeliveryDateField.BEAN_NAME+" WHERE "+ CustomerBlanketOrderItemDeliveryDateField.HEADERCODE+" = :prmCode")
                    .setParameter("prmCode", blanketOrderOld.getCode())    
                    .executeUpdate(); 
            //SalesQuotation
            int q = 1;  
            CustomerBlanketOrderSalesQuotation blanketOrderSalesQuotation = new CustomerBlanketOrderSalesQuotation(); 
                for(CustomerPurchaseOrderSalesQuotation customerPurchaseOrderSalesQuotation : listCustomerPurchaseOrderSalesQuotation){

                    String detailCode = blanketOrder.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(q),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    blanketOrderSalesQuotation.setCode(detailCode);
                    blanketOrderSalesQuotation.setHeaderCode(blanketOrder.getCode());
                    blanketOrderSalesQuotation.setSalesQuotation(customerPurchaseOrderSalesQuotation.getSalesQuotation());

                    blanketOrderSalesQuotation.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    blanketOrderSalesQuotation.setCreatedDate(new Date());

                    hbmSession.hSession.save(blanketOrderSalesQuotation);
                    hbmSession.hSession.flush();
                    hbmSession.hSession.clear();
                    q++;
                }
            
            //Item
            int i = 1;
            CustomerBlanketOrderItemDetail blanketOrderItemDetail = new CustomerBlanketOrderItemDetail();
                for(CustomerPurchaseOrderItemDetail customerPurchaseOrderItemDetail : listCustomerPurchaseOrderItemDetail){

                    String detailCode = blanketOrder.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    
                    blanketOrderItemDetail.setCode(detailCode);
                    blanketOrderItemDetail.setHeaderCode(blanketOrder.getCode());
                    blanketOrderItemDetail.setSalesQuotation(customerPurchaseOrderItemDetail.getSalesQuotation());
                    blanketOrderItemDetail.setSalesQuotationDetail(customerPurchaseOrderItemDetail.getSalesQuotationDetail());
                    blanketOrderItemDetail.setItemFinishGoods(customerPurchaseOrderItemDetail.getItemFinishGoods());
                    blanketOrderItemDetail.setQuantity(customerPurchaseOrderItemDetail.getQuantity());
                    blanketOrderItemDetail.setItemAlias(customerPurchaseOrderItemDetail.getItemAlias());
                    blanketOrderItemDetail.setCustomerPurchaseOrderSortNo(customerPurchaseOrderItemDetail.getCustomerPurchaseOrderSortNo());
                    blanketOrderItemDetail.setValveTag(customerPurchaseOrderItemDetail.getValveTag());
                    blanketOrderItemDetail.setDataSheet(customerPurchaseOrderItemDetail.getDataSheet());
                    blanketOrderItemDetail.setDescription(customerPurchaseOrderItemDetail.getDescription());

                    blanketOrderItemDetail.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    blanketOrderItemDetail.setCreatedDate(new Date());

                    hbmSession.hSession.save(blanketOrderItemDetail);
                    hbmSession.hSession.flush();
                    hbmSession.hSession.clear();
                    i++;
                }
            
            //AdditionalFee
            int f = 1;
            CustomerBlanketOrderAdditionalFee blanketOrderAdditionalFee = new CustomerBlanketOrderAdditionalFee(); 
                for(CustomerPurchaseOrderAdditionalFee customerPurchaseOrderAdditionalFee : listCustomerPurchaseOrderAdditionalFee){

                    String detailCode = blanketOrder.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(f),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    blanketOrderAdditionalFee.setCode(detailCode);
                    blanketOrderAdditionalFee.setHeaderCode(blanketOrder.getCode());
                    blanketOrderAdditionalFee.setRemark(customerPurchaseOrderAdditionalFee.getRemark());
                    blanketOrderAdditionalFee.setQuantity(customerPurchaseOrderAdditionalFee.getQuantity());
                    blanketOrderAdditionalFee.setUnitOfMeasure(customerPurchaseOrderAdditionalFee.getUnitOfMeasure());
                    blanketOrderAdditionalFee.setAdditionalFee(customerPurchaseOrderAdditionalFee.getAdditionalFee());
                    blanketOrderAdditionalFee.setPrice(customerPurchaseOrderAdditionalFee.getPrice());
                    blanketOrderAdditionalFee.setTotal(customerPurchaseOrderAdditionalFee.getTotal());

                    blanketOrderAdditionalFee.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    blanketOrderAdditionalFee.setCreatedDate(new Date());

                    hbmSession.hSession.save(blanketOrderAdditionalFee);
                    hbmSession.hSession.flush();
                    hbmSession.hSession.clear();
                    f++;
                }

            //PaymentTerm
            int p = 1;
            CustomerBlanketOrderPaymentTerm blanketOrderPaymentTerm = new CustomerBlanketOrderPaymentTerm();
            for(CustomerPurchaseOrderPaymentTerm customerPurchaseOrderPaymentTerm : listCustomerPurchaseOrderPaymentTerm){

                String detailCode = blanketOrder.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(p),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                blanketOrderPaymentTerm.setCode(detailCode);
                blanketOrderPaymentTerm.setHeaderCode(blanketOrder.getCode());
                blanketOrderPaymentTerm.setSortNo(customerPurchaseOrderPaymentTerm.getSortNo());
                blanketOrderPaymentTerm.setPaymentTerm(customerPurchaseOrderPaymentTerm.getPaymentTerm());
                blanketOrderPaymentTerm.setPercentage(customerPurchaseOrderPaymentTerm.getPercentage());
                blanketOrderPaymentTerm.setRemark(customerPurchaseOrderPaymentTerm.getRemark());


                blanketOrderPaymentTerm.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                blanketOrderPaymentTerm.setCreatedDate(new Date());

                hbmSession.hSession.save(blanketOrderPaymentTerm);
                hbmSession.hSession.flush();
                hbmSession.hSession.clear();
                p++;
            }
            
            //ItemDeliveryDate
            int d = 1;
                CustomerBlanketOrderItemDeliveryDate blanketOrderItemDeliveryDate = new CustomerBlanketOrderItemDeliveryDate();
                for(CustomerPurchaseOrderItemDeliveryDate customerPurchaseOrderItemDeliveryDate : listCustomerPurchaseOrderItemDeliveryDate){

                    String detailCode = blanketOrder.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(d),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    blanketOrderItemDeliveryDate.setCode(detailCode);
                    blanketOrderItemDeliveryDate.setHeaderCode(blanketOrder.getCode());
                    blanketOrderItemDeliveryDate.setItemFinishGoods(customerPurchaseOrderItemDeliveryDate.getItemFinishGoods());
                    blanketOrderItemDeliveryDate.setQuantity(customerPurchaseOrderItemDeliveryDate.getQuantity());
                    blanketOrderItemDeliveryDate.setDeliveryDate(customerPurchaseOrderItemDeliveryDate.getDeliveryDate());
                    blanketOrderItemDeliveryDate.setSalesQuotation(customerPurchaseOrderItemDeliveryDate.getSalesQuotation());
                    

                    blanketOrderItemDeliveryDate.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    blanketOrderItemDeliveryDate.setCreatedDate(new Date());

                    hbmSession.hSession.save(blanketOrderItemDeliveryDate);
                    hbmSession.hSession.flush();
                    hbmSession.hSession.clear();
                    d++;
                }
            
            return Boolean.TRUE;
        }catch(HibernateException e){
            e.printStackTrace();
            return Boolean.FALSE;
        }
    }
    
    private boolean processReviseDetailBlanketOrder(EnumActivity.ENUM_Activity enumActivity, 
            CustomerBlanketOrder blanketOrder,
            CustomerPurchaseOrder customerPurchaseOrder,
            List<CustomerPurchaseOrderSalesQuotation> listCustomerPurchaseOrderSalesQuotation, 
            List<CustomerPurchaseOrderItemDetail> listCustomerPurchaseOrderItemDetail,
            List<CustomerPurchaseOrderAdditionalFee> listCustomerPurchaseOrderAdditionalFee,
            List<CustomerPurchaseOrderPaymentTerm> listCustomerPurchaseOrderPaymentTerm,
            List<CustomerPurchaseOrderItemDeliveryDate> listCustomerPurchaseOrderItemDeliveryDate){
        try{
            CustomerBlanketOrderDAO blanketOrderDAO = new CustomerBlanketOrderDAO(hbmSession);
           
            //SalesQuotation
            int q = 1;  
            CustomerBlanketOrderSalesQuotation blanketOrderSalesQuotation = new CustomerBlanketOrderSalesQuotation(); 
                for(CustomerPurchaseOrderSalesQuotation customerPurchaseOrderSalesQuotation : listCustomerPurchaseOrderSalesQuotation){

                    String detailCode = blanketOrder.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(q),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    blanketOrderSalesQuotation.setCode(detailCode);
                    blanketOrderSalesQuotation.setHeaderCode(blanketOrder.getCode());
                    blanketOrderSalesQuotation.setSalesQuotation(customerPurchaseOrderSalesQuotation.getSalesQuotation());

                    blanketOrderSalesQuotation.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    blanketOrderSalesQuotation.setCreatedDate(new Date());

                    hbmSession.hSession.save(blanketOrderSalesQuotation);
                    hbmSession.hSession.flush();
                    hbmSession.hSession.clear();
                    q++;
                }
            
            //Item
            int i = 1;
            CustomerBlanketOrderItemDetail blanketOrderItemDetail = new CustomerBlanketOrderItemDetail();
                for(CustomerPurchaseOrderItemDetail customerPurchaseOrderItemDetail : listCustomerPurchaseOrderItemDetail){

                    String detailCode = blanketOrder.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    
                    blanketOrderItemDetail.setCode(detailCode);
                    blanketOrderItemDetail.setHeaderCode(blanketOrder.getCode());
                    blanketOrderItemDetail.setSalesQuotation(customerPurchaseOrderItemDetail.getSalesQuotation());
                    blanketOrderItemDetail.setItemFinishGoods(customerPurchaseOrderItemDetail.getItemFinishGoods());
                    blanketOrderItemDetail.setSalesQuotationDetail(customerPurchaseOrderItemDetail.getSalesQuotationDetail());
                    blanketOrderItemDetail.setQuantity(customerPurchaseOrderItemDetail.getQuantity());
                    blanketOrderItemDetail.setCustomerPurchaseOrderSortNo(customerPurchaseOrderItemDetail.getCustomerPurchaseOrderSortNo());
                    blanketOrderItemDetail.setValveTag(customerPurchaseOrderItemDetail.getValveTag());
                    blanketOrderItemDetail.setDataSheet(customerPurchaseOrderItemDetail.getDataSheet());
                    blanketOrderItemDetail.setDescription(customerPurchaseOrderItemDetail.getDescription());

                    blanketOrderItemDetail.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    blanketOrderItemDetail.setCreatedDate(new Date());

                    hbmSession.hSession.save(blanketOrderItemDetail);
                    hbmSession.hSession.flush();
                    hbmSession.hSession.clear();
                    i++;
                }
            
            //AdditionalFee
            int f = 1;
            CustomerBlanketOrderAdditionalFee blanketOrderAdditionalFee = new CustomerBlanketOrderAdditionalFee(); 
                for(CustomerPurchaseOrderAdditionalFee customerPurchaseOrderAdditionalFee : listCustomerPurchaseOrderAdditionalFee){

                    String detailCode = blanketOrder.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(f),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    blanketOrderAdditionalFee.setCode(detailCode);
                    blanketOrderAdditionalFee.setHeaderCode(blanketOrder.getCode());
                    blanketOrderAdditionalFee.setRemark(customerPurchaseOrderAdditionalFee.getRemark());
                    blanketOrderAdditionalFee.setAdditionalFee(customerPurchaseOrderAdditionalFee.getAdditionalFee());
                    blanketOrderAdditionalFee.setQuantity(customerPurchaseOrderAdditionalFee.getQuantity());
                    blanketOrderAdditionalFee.setUnitOfMeasure(customerPurchaseOrderAdditionalFee.getUnitOfMeasure());
                    blanketOrderAdditionalFee.setPrice(customerPurchaseOrderAdditionalFee.getPrice());
                    blanketOrderAdditionalFee.setTotal(customerPurchaseOrderAdditionalFee.getTotal());

                    blanketOrderAdditionalFee.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    blanketOrderAdditionalFee.setCreatedDate(new Date());

                    hbmSession.hSession.save(blanketOrderAdditionalFee);
                    hbmSession.hSession.flush();
                    hbmSession.hSession.clear();
                    f++;
                }

            //PaymentTerm
            int p = 1;
            CustomerBlanketOrderPaymentTerm blanketOrderPaymentTerm = new CustomerBlanketOrderPaymentTerm();
            for(CustomerPurchaseOrderPaymentTerm customerPurchaseOrderPaymentTerm : listCustomerPurchaseOrderPaymentTerm){

                String detailCode = blanketOrder.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(p),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                blanketOrderPaymentTerm.setCode(detailCode);
                blanketOrderPaymentTerm.setHeaderCode(blanketOrder.getCode());
                blanketOrderPaymentTerm.setSortNo(customerPurchaseOrderPaymentTerm.getSortNo());
                blanketOrderPaymentTerm.setPaymentTerm(customerPurchaseOrderPaymentTerm.getPaymentTerm());
                blanketOrderPaymentTerm.setPercentage(customerPurchaseOrderPaymentTerm.getPercentage());
                blanketOrderPaymentTerm.setRemark(customerPurchaseOrderPaymentTerm.getRemark());

                blanketOrderPaymentTerm.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                blanketOrderPaymentTerm.setCreatedDate(new Date());

                hbmSession.hSession.save(blanketOrderPaymentTerm);
                hbmSession.hSession.flush();
                hbmSession.hSession.clear();
                p++;
            }
            
            //ItemDeliveryDate
            int d = 1;
                CustomerBlanketOrderItemDeliveryDate blanketOrderItemDeliveryDate = new CustomerBlanketOrderItemDeliveryDate();
                for(CustomerPurchaseOrderItemDeliveryDate customerPurchaseOrderItemDeliveryDate : listCustomerPurchaseOrderItemDeliveryDate){

                    String detailCode = blanketOrder.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(d),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    blanketOrderItemDeliveryDate.setCode(detailCode);
                    blanketOrderItemDeliveryDate.setHeaderCode(blanketOrder.getCode());
                    blanketOrderItemDeliveryDate.setItemFinishGoods(customerPurchaseOrderItemDeliveryDate.getItemFinishGoods());
                    blanketOrderItemDeliveryDate.setQuantity(customerPurchaseOrderItemDeliveryDate.getQuantity());
                    blanketOrderItemDeliveryDate.setDeliveryDate(customerPurchaseOrderItemDeliveryDate.getDeliveryDate());
                    blanketOrderItemDeliveryDate.setSalesQuotation(customerPurchaseOrderItemDeliveryDate.getSalesQuotation());

                    blanketOrderItemDeliveryDate.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    blanketOrderItemDeliveryDate.setCreatedDate(new Date());

                    hbmSession.hSession.save(blanketOrderItemDeliveryDate);
                    hbmSession.hSession.flush();
                    hbmSession.hSession.clear();
                    d++;
                }
            
            
            return Boolean.TRUE;
        }catch(HibernateException e){
            e.printStackTrace();
            return Boolean.FALSE;
        }
    }
  
}

    

