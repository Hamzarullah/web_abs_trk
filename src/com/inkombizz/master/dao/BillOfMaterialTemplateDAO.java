/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.master.dao;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.dao.common.AutoNumber;
import com.inkombizz.master.model.BillOfMaterialTemplate;
import com.inkombizz.master.model.BillOfMaterialTemplateDetail;
import com.inkombizz.master.model.BillOfMaterialTemplateDetailField;
import com.inkombizz.master.model.BillOfMaterialTemplateField;
import com.inkombizz.master.model.BillOfMaterialTemplateTemp;
import com.inkombizz.ppic.model.ProductionPlanningOrder;
import com.inkombizz.ppic.model.ProductionPlanningOrderItemDetail;
import com.inkombizz.system.dao.TransactionLogDAO;
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

public class BillOfMaterialTemplateDAO {
    
    private HBMSession hbmSession;

    public BillOfMaterialTemplateDAO (HBMSession session) {
        this.hbmSession = session;
    }
    
    public int countData(BillOfMaterialTemplate billOfMaterialTemplate) {
        try {

            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                "CALL usp_bill_of_material_template_list(:prmFlag,:prmCode,0,0)")
                .setParameter("prmFlag", "COUNT")
                .setParameter("prmCode", "%"+billOfMaterialTemplate.getCode()+"%")
                .uniqueResult();
            return temp.intValue();

        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<BillOfMaterialTemplate> findData(BillOfMaterialTemplate billOfMaterialTemplate,int from, int row) {
        try {

            List<BillOfMaterialTemplate> list = (List<BillOfMaterialTemplate>)hbmSession.hSession.createSQLQuery(
                "CALL usp_bill_of_material_template_list(:prmFlag,:prmCode,:prmLimitFrom,:prmLimitUpTo)")                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("itemFinishGoodsCode", Hibernate.STRING)
                .addScalar("valveTypeCode", Hibernate.STRING)
                .addScalar("valveTypeName", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                    
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
                    
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                
                .setParameter("prmFlag", "LISTS")
                .setParameter("prmCode", "%"+billOfMaterialTemplate.getCode()+"%")
                .setParameter("prmLimitFrom", from)
                .setParameter("prmLimitUpTo", row)
                .setResultTransformer(Transformers.aliasToBean(BillOfMaterialTemplate.class))
                .list(); 
                 
                return list;
        } catch (HibernateException e) {
            throw e;
        }
    }
    
    public BillOfMaterialTemplateTemp findData(String code) {
        try {
               BillOfMaterialTemplateTemp billOfMaterialTemplateTemp = (BillOfMaterialTemplateTemp) hbmSession.hSession.createSQLQuery( 
                " SELECT "
                + " mst_bill_of_material_template.Code,  "
                + " mst_bill_of_material_template.TransactionDate,  "
                + " mst_bill_of_material_template.ItemFinishGoodsCode, "
                + " mst_valve_type.Code AS valveTypeCode, "
                + " mst_valve_type.Name AS valveTypeName, "
                + " mst_customer.Code AS endUserCode, "
                + " mst_customer.Name AS endUserName, "
                + " IFNULL(mst_item_finish_goods.ItemBodyConstructionCode,'') AS itemBodyConstructionCode,  "
                + " IFNULL(mst_item_body_construction.Name,'') AS itemBodyConstructionName,  "
                + " IFNULL(mst_item_finish_goods.ItemTypeDesignCode,'') AS itemTypeDesignCode,  "
                + " IFNULL(mst_item_type_design.Name,'') AS itemTypeDesignName,  "
                + " IFNULL(mst_item_finish_goods.ItemSeatDesignCode,'') AS itemSeatDesignCode,  "
                + " IFNULL(mst_item_seat_design.Name,'') AS itemSeatDesignName,  "
                + " IFNULL(mst_item_finish_goods.ItemSizeCode,'') AS itemSizeCode,  "
                + " IFNULL(mst_item_size.Name,'') AS itemSizeName,  "
                + " IFNULL(mst_item_finish_goods.ItemRatingCode,'') AS itemRatingCode, " 
                + " IFNULL(mst_item_rating.Name,'') AS itemRatingName,  "
                + " IFNULL(mst_item_finish_goods.ItemBoreCode,'') AS itemBoreCode,  "
                + " IFNULL(mst_item_bore.Name,'') AS itemBoreName, " 

                + " IFNULL(mst_item_finish_goods.ItemEndConCode,'') AS itemEndConCode,  "
                + " IFNULL(mst_item_end_con.Name,'') AS itemEndConName,  "
                + " IFNULL(mst_item_finish_goods.ItemBodyCode,'') AS itemBodyCode,  "
                + " IFNULL(mst_item_body.Name,'') AS itemBodyName,  "
                + " IFNULL(mst_item_finish_goods.ItemBallCode,'') AS itemBallCode, " 
                + " IFNULL(mst_item_ball.Name,'') AS itemBallName,  "
                + " IFNULL(mst_item_finish_goods.ItemSeatCode,'') AS itemSeatCode,  "
                + " IFNULL(mst_item_seat.Name,'') AS itemSeatName,  "
                + " IFNULL(mst_item_finish_goods.ItemSeatInsertCode,'') AS itemSeatInsertCode,  "
                + " IFNULL(mst_item_seat_insert.Name,'') AS itemSeatInsertName,  "
                + " IFNULL(mst_item_finish_goods.ItemStemCode,'') AS itemStemCode,  "
                + " IFNULL(mst_item_stem.Name,'') AS itemStemName,  "

                + " IFNULL(mst_item_finish_goods.ItemSealCode,'') AS itemSealCode,  "
                + " IFNULL(mst_item_seal.Name,'') AS itemSealName,  "
                + " IFNULL(mst_item_finish_goods.ItemBoltCode,'') AS itemBoltCode,  "
                + " IFNULL(mst_item_bolt.Name,'') AS itemBoltName,  "
                + " IFNULL(mst_item_finish_goods.ItemDiscCode,'') AS itemDiscCode,  "
                + " IFNULL(mst_item_disc.Name,'') AS itemDiscName,  "
                + " IFNULL(mst_item_finish_goods.ItemPlatesCode,'') AS itemPlatesCode,  "
                + " IFNULL(mst_item_plates.Name,'') AS itemPlatesName,  "
                + " IFNULL(mst_item_finish_goods.ItemShaftCode,'') AS itemShaftCode,  "
                + " IFNULL(mst_item_shaft.Name,'') AS itemShaftName,  "
                + " IFNULL(mst_item_finish_goods.ItemSpringCode,'') AS itemSpringCode,  "
                + " IFNULL(mst_item_spring.Name,'') ItemSpringName,  "

                + " IFNULL(mst_item_finish_goods.ItemArmPinCode,'') AS itemArmPinCode,  "
                + " IFNULL(mst_item_arm.Name,'') AS itemArmPinName,  "
                + " IFNULL(mst_item_finish_goods.ItemBackSeatCode,'') AS itemBackSeatCode,  "
                + " IFNULL(mst_item_backseat.Name,'') AS itemBackSeatName,  "
                + " IFNULL(mst_item_finish_goods.ItemArmCode,'') AS itemArmCode,  "
                + " IFNULL(mst_item_arm.Name,'') AS itemArmName,  "
                + " IFNULL(mst_item_finish_goods.ItemHingePinCode,'') AS itemHingePinCode,  "
                + " IFNULL(mst_item_hinge_pin.Name,'') AS itemHingePinName,  "
                + " IFNULL(mst_item_finish_goods.ItemStopPinCode,'') AS itemStopPinCode,  "
                + " IFNULL(mst_item_stop_pin.Name,'') AS itemStopPinName,  "
                + " IFNULL(mst_item_finish_goods.ItemOperatorCode,'') AS itemOperatorCode,  "
                + " IFNULL(mst_item_operator.Name,'') AS itemOperatorName, "

                + " mst_bill_of_material_template.RefNo,  "
                + " mst_bill_of_material_template.Remark  "
                + " FROM mst_bill_of_material_template "
                + " INNER JOIN mst_item_finish_goods ON mst_item_finish_goods.Code = mst_bill_of_material_template.ItemFinishGoodsCode "
                + " INNER JOIN mst_valve_type ON mst_valve_type.Code = mst_item_finish_goods.ValveTypeCode "
                + " INNER JOIN mst_customer ON mst_customer.Code = mst_item_finish_goods.EndUserCode "
                + " LEFT JOIN mst_item_body_construction ON mst_item_body_construction.Code = mst_item_finish_goods.ItemBodyConstructionCode  "

                + " LEFT JOIN mst_item_type_design ON mst_item_type_design.Code = mst_item_finish_goods.ItemTypeDesignCode  "
                + " LEFT JOIN mst_item_seat_design ON mst_item_seat_design.Code = mst_item_finish_goods.ItemSeatDesignCode  "
                + " LEFT JOIN mst_item_size ON mst_item_size.Code = mst_item_finish_goods.ItemSizeCode  "
                + " LEFT JOIN mst_item_rating ON mst_item_rating.Code = mst_item_finish_goods.ItemRatingCode  "
                + " LEFT JOIN mst_item_bore ON mst_item_bore.Code = mst_item_finish_goods.ItemBoreCode  "

                + " LEFT JOIN mst_item_end_con ON mst_item_end_con.Code = mst_item_finish_goods.ItemEndConCode  "
                + " LEFT JOIN mst_item_body ON mst_item_body.Code = mst_item_finish_goods.ItemBodyCode  "
                + " LEFT JOIN mst_item_ball ON mst_item_ball.Code = mst_item_finish_goods.ItemBallCode  "
                + " LEFT JOIN mst_item_seat ON mst_item_seat.Code = mst_item_finish_goods.ItemSeatCode  "
                + " LEFT JOIN mst_item_seat_insert ON mst_item_seat_insert.Code = mst_item_finish_goods.ItemSeatInsertCode  "
                + " LEFT JOIN mst_item_stem ON mst_item_stem.Code = mst_item_finish_goods.ItemStemCode  "

                + " LEFT JOIN mst_item_seal ON mst_item_seal.Code = mst_item_finish_goods.ItemSealCode  "
                + " LEFT JOIN mst_item_bolt ON mst_item_bolt.Code = mst_item_finish_goods.ItemBoltCode  "
                + " LEFT JOIN mst_item_disc ON mst_item_disc.Code = mst_item_finish_goods.ItemDiscCode  "
                + " LEFT JOIN mst_item_plates ON mst_item_plates.Code = mst_item_finish_goods.ItemPlatesCode  "
                + " LEFT JOIN mst_item_shaft ON mst_item_shaft.Code = mst_item_finish_goods.ItemShaftCode  "
                + " LEFT JOIN mst_item_spring ON mst_item_spring.Code = mst_item_finish_goods.ItemSpringCode  "

                + " LEFT JOIN mst_item_arm_pin ON mst_item_arm_pin.Code = mst_item_finish_goods.ItemArmPinCode  "
                + " LEFT JOIN mst_item_backseat ON mst_item_backseat.Code = mst_item_finish_goods.ItemBackSeatCode  "
                + " LEFT JOIN mst_item_arm ON mst_item_arm.Code = mst_item_finish_goods.ItemArmCode  "
                + " LEFT JOIN mst_item_hinge_pin ON mst_item_hinge_pin.Code = mst_item_finish_goods.ItemHingePinCode  "
                + " LEFT JOIN mst_item_stop_pin ON mst_item_stop_pin.Code = mst_item_finish_goods.ItemStopPinCode  "
                + " LEFT JOIN mst_item_operator ON mst_item_operator.Code = mst_item_finish_goods.ItemOperatorCode "
                    + " WHERE mst_bill_of_material_template.Code ='"+code+"' ")
                
                .addScalar("code", Hibernate.STRING)
                .addScalar("endUserCode", Hibernate.STRING)
                .addScalar("endUserName", Hibernate.STRING)
                .addScalar("valveTypeCode", Hibernate.STRING)
                .addScalar("valveTypeName", Hibernate.STRING)
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
                .setResultTransformer(Transformers.aliasToBean(BillOfMaterialTemplateTemp.class))
                .uniqueResult(); 
                 
                return billOfMaterialTemplateTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<BillOfMaterialTemplateDetail> findDataDetail(String headerCode) {
        try {
            
            List<BillOfMaterialTemplateDetail> list = (List<BillOfMaterialTemplateDetail>)hbmSession.hSession.createSQLQuery(
                    " SELECT "
                + " mst_bill_of_material_template_detail.Code, "
                + " mst_bill_of_material_template_detail.HeaderCode, "
                + " mst_bill_of_material_template_detail.SortNo, "
                + " mst_bill_of_material_template_detail.PartNo, "
                + " mst_part.Code AS partCode, "
                + " mst_part.Name AS partName, "
                + " mst_bill_of_material_template_detail.DrawingCode, "
                + " mst_bill_of_material_template_detail.Dimension, "
                + " mst_bill_of_material_template_detail.RequiredLength, "
                + " mst_bill_of_material_template_detail.Material, "
                + " mst_bill_of_material_template_detail.Quantity, "
                + " mst_bill_of_material_template_detail.Requirement, "
                + " mst_bill_of_material_template_detail.ProcessedStatus, "
                + " CASE "
                    + " WHEN mst_bill_of_material_template_detail.ActiveStatus = 1 "
                        + " THEN 'YES' "
                    + " WHEN mst_bill_of_material_template_detail.ActiveStatus = 0 "
                        + " THEN 'NO' "
                + " END AS activeStatusDetail, "
                + " mst_bill_of_material_template_detail.X, "
                + " mst_bill_of_material_template_detail.remark "
                    + " FROM "
                + " mst_bill_of_material_template_detail "
                + " INNER JOIN mst_part ON mst_part.Code = mst_bill_of_material_template_detail.PartCode "
                + " WHERE mst_bill_of_material_template_detail.HeaderCode= :prmHeaderCode "
            )
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("headerCode", Hibernate.STRING)
                .addScalar("sortNo", Hibernate.BIG_DECIMAL)
                .addScalar("partNo", Hibernate.STRING)
                .addScalar("partCode", Hibernate.STRING)
                .addScalar("partName", Hibernate.STRING)
                .addScalar("drawingCode", Hibernate.STRING)
                .addScalar("dimension", Hibernate.STRING)
                .addScalar("requiredLength", Hibernate.BIG_DECIMAL)
                .addScalar("material", Hibernate.STRING)
                .addScalar("quantity", Hibernate.BIG_DECIMAL)
                .addScalar("requirement", Hibernate.STRING)
                .addScalar("processedStatus", Hibernate.STRING)
                .addScalar("activeStatusDetail", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("x", Hibernate.STRING)
                .setParameter("prmHeaderCode", headerCode)
                .setResultTransformer(Transformers.aliasToBean(BillOfMaterialTemplateDetail.class))
                .list(); 
                 
            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<BillOfMaterialTemplateDetail> findDataDetailTemplate(String headerCode) {
        try {
            
            List<BillOfMaterialTemplateDetail> list = (List<BillOfMaterialTemplateDetail>)hbmSession.hSession.createSQLQuery(
                    "CALL usp_bom_template_detail_list(:prmHeaderCode)")
                    
                .addScalar("headerCode", Hibernate.STRING)
                .addScalar("sortNo", Hibernate.BIG_DECIMAL)
                .addScalar("partNo", Hibernate.STRING)
                .addScalar("partCode", Hibernate.STRING)
                .addScalar("partName", Hibernate.STRING)
                .addScalar("drawingCode", Hibernate.STRING)
                .addScalar("requiredLength", Hibernate.BIG_DECIMAL)
                .addScalar("dimension", Hibernate.STRING)
                .addScalar("material", Hibernate.STRING)
                .addScalar("quantity", Hibernate.BIG_DECIMAL)
                .addScalar("requirement", Hibernate.STRING)
                .addScalar("processedStatus", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("x", Hibernate.STRING)
                .setParameter("prmHeaderCode", headerCode)
                .setResultTransformer(Transformers.aliasToBean(BillOfMaterialTemplateDetail.class))
                .list(); 
                 
            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public BillOfMaterialTemplate get(String code) {
        try {
               return (BillOfMaterialTemplate) hbmSession.hSession.get(BillOfMaterialTemplate.class, code);
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
    
    private String createCode(BillOfMaterialTemplate billOfMaterialTemplate) {
        try {
            String tempKode = "BOM_TMP";
            String acronim = tempKode + "/"+AutoNumber.formatingDate(billOfMaterialTemplate.getTransactionDate(), true, true, true)+ "/";
            
            DetachedCriteria dc = DetachedCriteria.forClass(BillOfMaterialTemplate.class)
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
            return AutoNumber.generate(acronim, oldID, AutoNumber.DEFAULT_TRANSACTION_LENGTH_5);
        } catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void save(BillOfMaterialTemplate billOfMaterialTemplate, List<BillOfMaterialTemplateDetail> listBillOfMaterialTemplateDetail, String moduleCode) throws Exception {
        try {
            hbmSession.hSession.beginTransaction();
            String headerCode = createCode(billOfMaterialTemplate);
             
            billOfMaterialTemplate.setCode(headerCode);
            billOfMaterialTemplate.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            billOfMaterialTemplate.setCreatedDate(new Date());
            
            hbmSession.hSession.save(billOfMaterialTemplate);
            
            if (listBillOfMaterialTemplateDetail == null) {
                hbmSession.hTransaction.rollback();
                throw new Exception("FAILED DATA ITEM DETAIL INPUT!<br/><br/><B>e.g. Detail Null!<B/>");
            }
            
            int i = 1;
            for (BillOfMaterialTemplateDetail billOfMaterialTemplateDetail : listBillOfMaterialTemplateDetail) {
                String detailCode = billOfMaterialTemplate.getCode() + "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i), AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                
                billOfMaterialTemplateDetail.setCode(detailCode);
                billOfMaterialTemplateDetail.setHeaderCode(headerCode);
                
                hbmSession.hSession.save(billOfMaterialTemplateDetail);

                i++;
            }
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT), 
                                                                    billOfMaterialTemplate.getCode(), ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(BillOfMaterialTemplate billOfMaterialTemplate,List<BillOfMaterialTemplateDetail> listBillOfMaterialTemplateDetail, String moduleCode) throws Exception {
        try {
            hbmSession.hSession.beginTransaction();
            
            if (!updateDetail(billOfMaterialTemplate, listBillOfMaterialTemplateDetail)) {
                hbmSession.hTransaction.rollback();
            }
            
            billOfMaterialTemplate.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            billOfMaterialTemplate.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(billOfMaterialTemplate);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
                                                                    billOfMaterialTemplate.getCode(), ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    private boolean updateDetail(BillOfMaterialTemplate billOfMaterialTemplate, List<BillOfMaterialTemplateDetail> listBillOfMaterialTemplateDetail) throws Exception {
        try {
            hbmSession.hSession.createQuery("DELETE FROM " + BillOfMaterialTemplateDetailField.BEAN_NAME
                    + " WHERE " + BillOfMaterialTemplateDetailField.HEADERCODE + " = :prmHeaderCode")
                    .setParameter("prmHeaderCode", billOfMaterialTemplate.getCode())
                    .executeUpdate();

            int i = 1;
            for (BillOfMaterialTemplateDetail billOfMaterialTemplateDetail : listBillOfMaterialTemplateDetail) {

                billOfMaterialTemplateDetail.setHeaderCode(billOfMaterialTemplate.getCode());
                String detailCode = billOfMaterialTemplate.getCode() + "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i), AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                billOfMaterialTemplateDetail.setCode(detailCode);

                hbmSession.hSession.save(billOfMaterialTemplateDetail);

                i++;

            }

            return Boolean.TRUE;

        } catch (HibernateException e) {
            e.printStackTrace();
            return Boolean.FALSE;
        }
    }
    
    public void delete(String code, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            hbmSession.hSession.createQuery("DELETE FROM " + BillOfMaterialTemplateField.BEAN_NAME + " WHERE " + BillOfMaterialTemplateField.CODE + " = :prmCode")
                    .setParameter("prmCode", code)
                    .executeUpdate();
            
            hbmSession.hSession.flush();

            hbmSession.hSession.createQuery("DELETE FROM " + BillOfMaterialTemplateDetailField.BEAN_NAME
                    + " WHERE " + BillOfMaterialTemplateDetailField.HEADERCODE + " = :prmHeaderCode")
                    .setParameter("prmHeaderCode", code)
                    .executeUpdate();
                    
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
    
    
}
