/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.master.dao;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.common.enumeration.EnumTransactionType;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.dao.common.AutoNumber;
import com.inkombizz.master.model.ItemFinishGoods;
import com.inkombizz.master.model.ItemFinishGoodsField;
import com.inkombizz.master.model.ItemFinishGoodsTemp;
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

/**
 *
 * @author ikb
 */
public class ItemFinishGoodsDAO {
    private HBMSession hbmSession;
    
    public ItemFinishGoodsDAO (HBMSession session) {
        this.hbmSession = session;
    }
    
    public int countData(String code,String name,String active){
        try{
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_item_finish_goods.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(mst_item_finish_goods.code) " 
                + "FROM mst_item_finish_goods "
                + "INNER JOIN mst_customer ON mst_item_finish_goods.EndUserCode = mst_customer.Code "
                + "INNER JOIN mst_valve_type ON mst_item_finish_goods.ValveTypeCode=mst_valve_type.Code "
                + "LEFT JOIN mst_item_type_design ON mst_item_finish_goods.ItemTypeDesignCode=mst_item_type_design.Code "
                + "LEFT JOIN mst_item_size ON mst_item_finish_goods.ItemSizeCode=mst_item_size.Code "
                + "LEFT JOIN mst_item_rating ON mst_item_finish_goods.ItemRatingCode=mst_item_rating.Code "
                + "LEFT JOIN mst_item_bore ON mst_item_finish_goods.ItemBoreCode=mst_item_bore.Code "
                + "LEFT JOIN mst_item_end_con ON mst_item_finish_goods.ItemEndConCode=mst_item_end_con.Code "
                + "LEFT JOIN mst_item_body ON mst_item_finish_goods.ItemBodyCode=mst_item_body.Code "
                + "LEFT JOIN mst_item_stem ON mst_item_finish_goods.ItemStemCode=mst_item_stem.Code "
                + "LEFT JOIN mst_item_seal ON mst_item_finish_goods.ItemSealCode=mst_item_seal.Code "
                + "LEFT JOIN mst_item_seat ON mst_item_finish_goods.ItemSeatCode=mst_item_seat.Code "
                + "LEFT JOIN mst_item_seat_insert ON mst_item_finish_goods.ItemSeatInsertCode=mst_item_seat_insert.Code "
                + "LEFT JOIN mst_item_bolt ON mst_item_finish_goods.ItemBoltCode=mst_item_bolt.Code "
                + "LEFT JOIN mst_item_seat_design ON mst_item_finish_goods.ItemSeatDesignCode=mst_item_seat_design.Code "
                + "LEFT JOIN mst_item_body_construction ON mst_item_finish_goods.ItemBodyConstructionCode=mst_item_body_construction.Code "
                + "LEFT JOIN mst_item_arm_pin ON mst_item_finish_goods.ItemArmPinCode=mst_item_arm_pin.Code "
                + "LEFT JOIN mst_item_disc ON mst_item_finish_goods.ItemDiscCode=mst_item_disc.Code "
                + "LEFT JOIN mst_item_backseat ON mst_item_finish_goods.ItemBackseatCode=mst_item_backseat.Code "
                + "LEFT JOIN mst_item_spring ON mst_item_finish_goods.ItemSpringCode=mst_item_spring.Code "
                + "LEFT JOIN mst_item_plates ON mst_item_finish_goods.ItemPlatesCode=mst_item_plates.Code "
                + "LEFT JOIN mst_item_shaft ON mst_item_finish_goods.ItemShaftCode=mst_item_shaft.Code "
                + "LEFT JOIN mst_item_arm ON mst_item_finish_goods.ItemArmCode=mst_item_arm.Code "
                + "LEFT JOIN mst_item_hinge_pin ON mst_item_finish_goods.ItemHingePinCode=mst_item_hinge_pin.Code "
                + "LEFT JOIN mst_item_stop_pin ON mst_item_finish_goods.ItemStopPinCode=mst_item_stop_pin.Code "
                + "WHERE mst_item_finish_goods.code LIKE '%"+code+"%' "
                + "AND mst_item_finish_goods.name LIKE '%"+name+"%' "
                + concat_qry
            ).uniqueResult();
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
    
    public List<ItemFinishGoodsTemp> findData(String code, String name,String active,int from, int row) {
        try {   
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_item_finish_goods.ActiveStatus="+active+" ";
            }
            List<ItemFinishGoodsTemp> list = (List<ItemFinishGoodsTemp>)hbmSession.hSession.createSQLQuery(
                   "SELECT "
                + "mst_item_finish_goods.Code, "
                + "mst_item_finish_goods.name, "
                + "mst_item_finish_goods.EndUserCode AS customerCode, "
                + "mst_customer.name AS customerName, "
                + "mst_valve_type.Code as valveTypeCode, "
                + "mst_valve_type.Name AS valveTypeName, "
                + "mst_item_finish_goods.ItemTypeDesignCode, "
                + "mst_item_type_design.name AS itemTypeDesignName, "
                + "mst_item_finish_goods.ItemSizeCode, "
                + "mst_item_size.name AS itemSizeName, "
                + "mst_item_finish_goods.ItemRatingCode, "
                + "mst_item_rating.name AS itemRatingName, "
                + "mst_item_finish_goods.ItemBoreCode, "
                + "mst_item_bore.name AS itemBoreName, "
                + "mst_item_finish_goods.ItemEndConCode, "
                + "mst_item_end_con.name AS itemEndConName, "
                + "mst_item_finish_goods.ItemBodyCode, "
                + "mst_item_body.name AS itemBodyName, "
                + "mst_item_finish_goods.ItemBallCode, "
                + "mst_item_ball.name AS itemBallName, "
                + "mst_item_finish_goods.ItemStemCode, "
                + "mst_item_stem.name AS itemStemName, "
                + "mst_item_finish_goods.ItemSealCode, "
                + "mst_item_seal.name AS itemSealName, "
                + "mst_item_finish_goods.ItemSeatCode, "
                + "mst_item_seat.name AS itemSeatName, "
                + "mst_item_finish_goods.ItemSeatInsertCode, "
                + "mst_item_seat_insert.name AS itemSeatInsertName, "
                + "mst_item_finish_goods.ItemBoltCode, "
                + "mst_item_bolt.name AS itemBoltName, "
                + "mst_item_finish_goods.ItemSeatDesignCode, "
                + "mst_item_seat_design.name AS itemSeatDesignName, "
                + "mst_item_finish_goods.ItemOperatorCode, "
                + "mst_item_operator.name AS itemOperatorName, "
                + "mst_item_finish_goods.ItemBodyConstructionCode, "
                + "mst_item_body_construction.name AS itemBodyConstructionName, "
                + "mst_item_finish_goods.itemArmPinCode, "
                + "mst_item_arm_pin.name AS itemArmPinName, "
                + "mst_item_finish_goods.ItemDiscCode, "
                + "mst_item_disc.name AS itemDiscName, "
                + "mst_item_finish_goods.itemBackseatCode, "
                + "mst_item_backseat.name AS itemBackseatName, "
                + "mst_item_finish_goods.itemSpringCode, "
                + "mst_item_spring.name AS itemSpringName, "
                + "mst_item_finish_goods.itemPlatesCode, "
                + "mst_item_plates.name AS itemPlatesName, "
                + "mst_item_finish_goods.itemShaftCode, "
                + "mst_item_shaft.name AS itemShaftName, "
                + "mst_item_finish_goods.itemArmCode, "
                + "mst_item_arm.name AS itemArmName, "
                + "mst_item_finish_goods.itemHingePinCode, "
                + "mst_item_hinge_pin.name AS itemHingePinName, "
                + "mst_item_finish_goods.itemStopPinCode, "
                + "mst_item_stop_pin.name AS itemStopPinName, "
                + "mst_item_finish_goods.remark, "
                + "mst_item_finish_goods.InActiveBy, "
                + "mst_item_finish_goods.InActiveDate, "
                + "mst_item_finish_goods.activeStatus, "
                + "mst_item_finish_goods.createdBy, "
                + "mst_item_finish_goods.createdDate "
                + "FROM mst_item_finish_goods "
                + "INNER JOIN mst_customer ON mst_item_finish_goods.EndUserCode=mst_customer.Code "
                + "INNER JOIN mst_valve_type ON mst_item_finish_goods.ValveTypeCode=mst_valve_type.Code "
                + "LEFT JOIN mst_item_type_design ON mst_item_finish_goods.ItemTypeDesignCode=mst_item_type_design.Code "
                + "LEFT JOIN mst_item_size ON mst_item_finish_goods.ItemSizeCode=mst_item_size.Code "
                + "LEFT JOIN mst_item_rating ON mst_item_finish_goods.ItemRatingCode=mst_item_rating.Code "
                + "LEFT JOIN mst_item_bore ON mst_item_finish_goods.ItemBoreCode=mst_item_bore.Code "
                + "LEFT JOIN mst_item_end_con ON mst_item_finish_goods.ItemEndConCode=mst_item_end_con.Code "
                + "LEFT JOIN mst_item_body ON mst_item_finish_goods.ItemBodyCode=mst_item_body.Code "
                + "LEFT JOIN mst_item_ball ON mst_item_finish_goods.ItemBallCode=mst_item_ball.Code "
                + "LEFT JOIN mst_item_stem ON mst_item_finish_goods.ItemStemCode=mst_item_stem.Code "
                + "LEFT JOIN mst_item_seal ON mst_item_finish_goods.ItemSealCode=mst_item_seal.Code "
                + "LEFT JOIN mst_item_seat ON mst_item_finish_goods.ItemSeatCode=mst_item_seat.Code "
                + "LEFT JOIN mst_item_seat_insert ON mst_item_finish_goods.ItemSeatInsertCode=mst_item_seat_insert.Code "
                + "LEFT JOIN mst_item_bolt ON mst_item_finish_goods.ItemBoltCode=mst_item_bolt.Code "
                + "LEFT JOIN mst_item_seat_design ON mst_item_finish_goods.ItemSeatDesignCode=mst_item_seat_design.Code "
                + "LEFT JOIN mst_item_operator ON mst_item_finish_goods.ItemOperatorCode=mst_item_operator.Code "
                + "LEFT JOIN mst_item_body_construction ON mst_item_finish_goods.ItemBodyConstructionCode=mst_item_body_construction.Code "
                + "LEFT JOIN mst_item_arm_pin ON mst_item_finish_goods.ItemArmPinCode=mst_item_arm_pin.Code "
                + "LEFT JOIN mst_item_disc ON mst_item_finish_goods.ItemDiscCode=mst_item_disc.Code "
                + "LEFT JOIN mst_item_backseat ON mst_item_finish_goods.ItemBackseatCode=mst_item_backseat.Code "
                + "LEFT JOIN mst_item_spring ON mst_item_finish_goods.ItemSpringCode=mst_item_spring.Code "
                + "LEFT JOIN mst_item_plates ON mst_item_finish_goods.ItemPlatesCode=mst_item_plates.Code "
                + "LEFT JOIN mst_item_shaft ON mst_item_finish_goods.ItemShaftCode=mst_item_shaft.Code "
                + "LEFT JOIN mst_item_arm ON mst_item_finish_goods.ItemArmCode=mst_item_arm.Code "
                + "LEFT JOIN mst_item_hinge_pin ON mst_item_finish_goods.ItemHingePinCode=mst_item_hinge_pin.Code "
                + "LEFT JOIN mst_item_stop_pin ON mst_item_finish_goods.ItemStopPinCode=mst_item_stop_pin.Code "           
                + "WHERE mst_item_finish_goods.code LIKE '%"+code+"%' "
                + "AND mst_item_finish_goods.name LIKE '%"+name+"%' "
                + concat_qry
                + "ORDER BY mst_item_finish_goods.code ASC "
                + "LIMIT "+from+","+row+"")
    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("customerCode", Hibernate.STRING)
                .addScalar("customerName", Hibernate.STRING)
                .addScalar("valveTypeCode", Hibernate.STRING)
                .addScalar("valveTypeName", Hibernate.STRING)
                .addScalar("itemTypeDesignCode", Hibernate.STRING)
                .addScalar("itemTypeDesignName", Hibernate.STRING)
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
                .addScalar("itemStemCode", Hibernate.STRING)
                .addScalar("itemStemName", Hibernate.STRING)
                .addScalar("itemSealCode", Hibernate.STRING)
                .addScalar("itemSealName", Hibernate.STRING)
                .addScalar("itemSeatCode", Hibernate.STRING)
                .addScalar("itemSeatName", Hibernate.STRING)
                .addScalar("itemSeatInsertCode", Hibernate.STRING)
                .addScalar("itemSeatInsertName", Hibernate.STRING)
                .addScalar("itemBoltCode", Hibernate.STRING)
                .addScalar("itemBoltName", Hibernate.STRING)
                .addScalar("itemSeatDesignCode", Hibernate.STRING)
                .addScalar("itemSeatDesignName", Hibernate.STRING)
                .addScalar("itemOperatorCode", Hibernate.STRING)
                .addScalar("itemOperatorName", Hibernate.STRING)
                .addScalar("itemBodyConstructionCode", Hibernate.STRING)
                .addScalar("itemBodyConstructionName", Hibernate.STRING)
                .addScalar("itemArmPinCode", Hibernate.STRING)
                .addScalar("itemArmPinName", Hibernate.STRING)
                .addScalar("itemDiscCode", Hibernate.STRING)
                .addScalar("itemDiscName", Hibernate.STRING)
                .addScalar("itemBackseatCode", Hibernate.STRING)
                .addScalar("itemBackseatName", Hibernate.STRING)
                .addScalar("itemSpringCode", Hibernate.STRING)
                .addScalar("itemSpringName", Hibernate.STRING)
                .addScalar("itemPlatesCode", Hibernate.STRING)
                .addScalar("itemPlatesName", Hibernate.STRING)
                .addScalar("itemShaftCode", Hibernate.STRING)
                .addScalar("itemShaftName", Hibernate.STRING)
                .addScalar("itemArmCode", Hibernate.STRING)
                .addScalar("itemArmName", Hibernate.STRING)
                .addScalar("itemHingePinCode", Hibernate.STRING)
                .addScalar("itemHingePinName", Hibernate.STRING)
                .addScalar("itemStopPinCode", Hibernate.STRING)
                .addScalar("itemStopPinName", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(ItemFinishGoodsTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
//    Update
    public ItemFinishGoodsTemp findData(String code) {
        try {
                ItemFinishGoodsTemp itemFinishGoodTemp = (ItemFinishGoodsTemp) hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_finish_goods.Code, "
                + "mst_item_finish_goods.name, "
                + "mst_item_finish_goods.ValveTypeCode as valveTypeCode, "
                + "mst_valve_type.Name as valveTypeName, "
                + "mst_item_finish_goods.EndUserCode AS customerCode, "
                + "mst_customer.name AS customerName, "
                + "mst_item_finish_goods.itemTypeDesignCode, "
                + "mst_item_type_design.name AS itemTypeDesignName, "
                + "mst_item_finish_goods.ItemSizeCode, "
                + "mst_item_size.name AS itemSizeName, "
                + "mst_item_finish_goods.ItemRatingCode, "
                + "mst_item_rating.name AS itemRatingName, "
                + "mst_item_finish_goods.ItemBoreCode, "
                + "mst_item_bore.name AS itemBoreName, "
                + "mst_item_finish_goods.ItemEndConCode, "
                + "mst_item_end_con.name AS itemEndConName, "
                + "mst_item_finish_goods.ItemBallCode, "
                + "mst_item_ball.name AS itemBallName, "
                + "mst_item_finish_goods.ItemBodyCode, "
                + "mst_item_body.name AS itemBodyName, "
                + "mst_item_finish_goods.ItemStemCode, "
                + "mst_item_stem.name AS itemStemName, "
                + "mst_item_finish_goods.ItemSealCode, "
                + "mst_item_seal.name AS itemSealName, "
                + "mst_item_finish_goods.ItemSeatCode, "
                + "mst_item_seat.name AS itemSeatName, "
                + "mst_item_finish_goods.ItemSeatInsertCode, "
                + "mst_item_seat_insert.name AS itemSeatInsertName, "
                + "mst_item_finish_goods.ItemBoltCode, "
                + "mst_item_bolt.name AS itemBoltName, "
                + "mst_item_finish_goods.ItemSeatDesignCode, "
                + "mst_item_seat_design.name AS itemSeatDesignName, "
                + "mst_item_finish_goods.ItemOperatorCode, "
                + "mst_item_operator.name AS itemOperatorName, "
                + "mst_item_finish_goods.ItemBodyConstructionCode, "
                + "mst_item_body_construction.name AS itemBodyConstructionName, "
                + "mst_item_finish_goods.itemArmPinCode, "
                + "mst_item_arm_pin.name AS itemArmPinName, "
                + "mst_item_finish_goods.ItemDiscCode, "
                + "mst_item_disc.name AS itemDiscName, "
                + "mst_item_finish_goods.itemBackseatCode, "
                + "mst_item_backseat.name AS itemBackseatName, "
                + "mst_item_finish_goods.itemSpringCode, "
                + "mst_item_spring.name AS itemSpringName, "
                + "mst_item_finish_goods.itemPlatesCode, "
                + "mst_item_plates.name AS itemPlatesName, "
                + "mst_item_finish_goods.itemShaftCode, "
                + "mst_item_shaft.name AS itemShaftName, "            
                + "mst_item_finish_goods.itemArmCode, "
                + "mst_item_arm.name AS itemArmName, "
                + "mst_item_finish_goods.itemHingePinCode, "
                + "mst_item_hinge_pin.name AS itemHingePinName, "
                + "mst_item_finish_goods.itemStopPinCode, "
                + "mst_item_stop_pin.name AS itemStopPinName, "
                + "mst_item_finish_goods.remark, "
                + "mst_item_finish_goods.InActiveBy, "
                + "mst_item_finish_goods.InActiveDate, "
                + "mst_item_finish_goods.activeStatus, "
                + "mst_item_finish_goods.createdBy, "
                + "mst_item_finish_goods.createdDate "
                + "FROM mst_item_finish_goods "
                + "INNER JOIN mst_customer ON mst_item_finish_goods.EndUserCode=mst_customer.Code "
                + "INNER JOIN mst_valve_type ON mst_item_finish_goods.ValveTypeCode=mst_valve_type.Code "
                + "LEFT JOIN mst_item_type_design ON mst_item_finish_goods.ItemTypeDesignCode=mst_item_type_design.Code "
                + "LEFT JOIN mst_item_size ON mst_item_finish_goods.ItemSizeCode=mst_item_size.Code "
                + "LEFT JOIN mst_item_rating ON mst_item_finish_goods.ItemRatingCode=mst_item_rating.Code "
                + "LEFT JOIN mst_item_bore ON mst_item_finish_goods.ItemBoreCode=mst_item_bore.Code "
                + "LEFT JOIN mst_item_end_con ON mst_item_finish_goods.ItemEndConCode=mst_item_end_con.Code "
                + "LEFT JOIN mst_item_body ON mst_item_finish_goods.ItemBodyCode=mst_item_body.Code "
                + "LEFT JOIN mst_item_ball ON mst_item_finish_goods.ItemBallCode=mst_item_ball.Code "
                + "LEFT JOIN mst_item_stem ON mst_item_finish_goods.ItemStemCode=mst_item_stem.Code "
                + "LEFT JOIN mst_item_seal ON mst_item_finish_goods.ItemSealCode=mst_item_seal.Code "
                + "LEFT JOIN mst_item_seat ON mst_item_finish_goods.ItemSeatCode=mst_item_seat.Code "
                + "LEFT JOIN mst_item_seat_insert ON mst_item_finish_goods.ItemSeatInsertCode=mst_item_seat_insert.Code "
                + "LEFT JOIN mst_item_bolt ON mst_item_finish_goods.ItemBoltCode=mst_item_bolt.Code "
                + "LEFT JOIN mst_item_seat_design ON mst_item_finish_goods.ItemSeatDesignCode=mst_item_seat_design.Code "
                + "LEFT JOIN mst_item_operator ON mst_item_finish_goods.ItemOperatorCode=mst_item_operator.Code "
                + "LEFT JOIN mst_item_body_construction ON mst_item_finish_goods.ItemBodyConstructionCode=mst_item_body_construction.Code "
                + "LEFT JOIN mst_item_arm_pin ON mst_item_finish_goods.ItemArmPinCode=mst_item_arm_pin.Code "
                + "LEFT JOIN mst_item_disc ON mst_item_finish_goods.ItemDiscCode=mst_item_disc.Code "
                + "LEFT JOIN mst_item_backseat ON mst_item_finish_goods.ItemBackseatCode=mst_item_backseat.Code "
                + "LEFT JOIN mst_item_spring ON mst_item_finish_goods.ItemSpringCode=mst_item_spring.Code "
                + "LEFT JOIN mst_item_plates ON mst_item_finish_goods.ItemPlatesCode=mst_item_plates.Code "
                + "LEFT JOIN mst_item_shaft ON mst_item_finish_goods.ItemShaftCode=mst_item_shaft.Code "
                + "LEFT JOIN mst_item_arm ON mst_item_finish_goods.ItemArmCode=mst_item_arm.Code "
                + "LEFT JOIN mst_item_hinge_pin ON mst_item_finish_goods.ItemHingePinCode=mst_item_hinge_pin.Code "
                + "LEFT JOIN mst_item_stop_pin ON mst_item_finish_goods.ItemStopPinCode=mst_item_stop_pin.Code "              
                + "WHERE mst_item_finish_goods.code ='"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("valveTypeCode", Hibernate.STRING)
                .addScalar("valveTypeName", Hibernate.STRING)
                .addScalar("customerCode", Hibernate.STRING)
                .addScalar("customerName", Hibernate.STRING)
                .addScalar("itemTypeDesignCode", Hibernate.STRING)
                .addScalar("itemTypeDesignName", Hibernate.STRING)
                .addScalar("itemSizeCode", Hibernate.STRING)
                .addScalar("itemSizeName", Hibernate.STRING)
                .addScalar("itemRatingCode", Hibernate.STRING)
                .addScalar("itemRatingName", Hibernate.STRING)
                .addScalar("itemBoreCode", Hibernate.STRING)
                .addScalar("itemBoreName", Hibernate.STRING)
                .addScalar("itemEndConCode", Hibernate.STRING)
                .addScalar("itemEndConName", Hibernate.STRING)
                .addScalar("itemBallCode", Hibernate.STRING)
                .addScalar("itemBallName", Hibernate.STRING)
                .addScalar("itemBodyCode", Hibernate.STRING)
                .addScalar("itemBodyName", Hibernate.STRING)
                .addScalar("itemStemCode", Hibernate.STRING)
                .addScalar("itemStemName", Hibernate.STRING)
                .addScalar("itemSealCode", Hibernate.STRING)
                .addScalar("itemSealName", Hibernate.STRING)
                .addScalar("itemSeatCode", Hibernate.STRING)
                .addScalar("itemSeatName", Hibernate.STRING)
                .addScalar("itemSeatInsertCode", Hibernate.STRING)
                .addScalar("itemSeatInsertName", Hibernate.STRING)
                .addScalar("itemBoltCode", Hibernate.STRING)
                .addScalar("itemBoltName", Hibernate.STRING)
                .addScalar("itemSeatDesignCode", Hibernate.STRING)
                .addScalar("itemSeatDesignName", Hibernate.STRING)
                .addScalar("itemOperatorCode", Hibernate.STRING)
                .addScalar("itemOperatorName", Hibernate.STRING)
                .addScalar("itemBodyConstructionCode", Hibernate.STRING)
                .addScalar("itemBodyConstructionName", Hibernate.STRING)
                .addScalar("itemArmPinCode", Hibernate.STRING)
                .addScalar("itemArmPinName", Hibernate.STRING)
                .addScalar("itemDiscCode", Hibernate.STRING)
                .addScalar("itemDiscName", Hibernate.STRING)
                .addScalar("itemBackseatCode", Hibernate.STRING)
                .addScalar("itemBackseatName", Hibernate.STRING)
                .addScalar("itemSpringCode", Hibernate.STRING)
                .addScalar("itemSpringName", Hibernate.STRING)
                .addScalar("itemPlatesCode", Hibernate.STRING)
                .addScalar("itemPlatesName", Hibernate.STRING)
                .addScalar("itemShaftCode", Hibernate.STRING)
                .addScalar("itemShaftName", Hibernate.STRING)
                .addScalar("itemArmCode", Hibernate.STRING)
                .addScalar("itemArmName", Hibernate.STRING)
                .addScalar("itemHingePinCode", Hibernate.STRING)
                .addScalar("itemHingePinName", Hibernate.STRING)
                .addScalar("itemStopPinCode", Hibernate.STRING)
                .addScalar("itemStopPinName", Hibernate.STRING)        
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                .setResultTransformer(Transformers.aliasToBean(ItemFinishGoodsTemp.class))
                .uniqueResult(); 
                 
                return itemFinishGoodTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public int countDataSearch(String code,String customerCode,String active){
        try{
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND mst_item_finish_goods.ActiveStatus="+active+"";
            }

            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(mst_item_finish_goods.code) " 
                + "FROM mst_item_finish_goods "
                + "INNER JOIN mst_customer ON mst_item_finish_goods.EndUserCode=mst_customer.Code "
                + "INNER JOIN mst_valve_type ON mst_item_finish_goods.ValveTypeCode=mst_valve_type.Code "
                + "LEFT JOIN mst_item_type_design ON mst_item_finish_goods.ItemTypeDesignCode=mst_item_type_design.Code "
                + "LEFT JOIN mst_item_size ON mst_item_finish_goods.ItemSizeCode=mst_item_size.Code "
                + "LEFT JOIN mst_item_rating ON mst_item_finish_goods.ItemRatingCode=mst_item_rating.Code "
                + "LEFT JOIN mst_item_bore ON mst_item_finish_goods.ItemBoreCode=mst_item_bore.Code "
                + "LEFT JOIN mst_item_end_con ON mst_item_finish_goods.ItemEndConCode=mst_item_end_con.Code "
                + "LEFT JOIN mst_item_body ON mst_item_finish_goods.ItemBodyCode=mst_item_body.Code "
                + "LEFT JOIN mst_item_stem ON mst_item_finish_goods.ItemStemCode=mst_item_stem.Code "
                + "LEFT JOIN mst_item_seal ON mst_item_finish_goods.ItemSealCode=mst_item_seal.Code "
                + "LEFT JOIN mst_item_seat ON mst_item_finish_goods.ItemSeatCode=mst_item_seat.Code "
                + "LEFT JOIN mst_item_seat_insert ON mst_item_finish_goods.ItemSeatInsertCode=mst_item_seat_insert.Code "
                + "LEFT JOIN mst_item_bolt ON mst_item_finish_goods.ItemBoltCode=mst_item_bolt.Code "
                + "LEFT JOIN mst_item_seat_design ON mst_item_finish_goods.ItemSeatDesignCode=mst_item_seat_design.Code "
                + "LEFT JOIN mst_item_operator ON mst_item_finish_goods.ItemOperatorCode=mst_item_operator.Code "
                + "LEFT JOIN mst_item_body_construction ON mst_item_finish_goods.ItemBodyConstructionCode=mst_item_body_construction.Code "
                + "LEFT JOIN mst_item_arm_pin ON mst_item_finish_goods.ItemArmPinCode=mst_item_arm_pin.Code "
                + "LEFT JOIN mst_item_disc ON mst_item_finish_goods.ItemDiscCode=mst_item_disc.Code "
                + "LEFT JOIN mst_item_backseat ON mst_item_finish_goods.ItemBackseatCode=mst_item_backseat.Code "
                + "LEFT JOIN mst_item_spring ON mst_item_finish_goods.ItemSpringCode=mst_item_spring.Code "
                + "LEFT JOIN mst_item_plates ON mst_item_finish_goods.ItemPlatesCode=mst_item_plates.Code "
                + "LEFT JOIN mst_item_shaft ON mst_item_finish_goods.ItemShaftCode=mst_item_shaft.Code "
                + "LEFT JOIN mst_item_arm ON mst_item_finish_goods.ItemArmCode=mst_item_arm.Code "
                + "LEFT JOIN mst_item_hinge_pin ON mst_item_finish_goods.ItemHingePinCode=mst_item_hinge_pin.Code "
                + "LEFT JOIN mst_item_stop_pin ON mst_item_finish_goods.ItemStopPinCode=mst_item_stop_pin.Code "               
                + "WHERE mst_item_finish_goods.code LIKE '%"+code+"%' "
                + "AND mst_item_finish_goods.EndUserCode LIKE '%"+customerCode+"%' "
                + concat_qry
            ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<ItemFinishGoodsTemp>  findDataSearch(String code,String customerCode,String active,int from, int row) {
        try {
            String concat_qry="";
            if(active.equals("ALL")){
                concat_qry="";
            }
            if(active.equals("YES")){
                concat_qry="AND mst_item_finish_goods.ActiveStatus=1 ";
            }
            if(active.equals("NO")){
                concat_qry="AND mst_item_finish_goods.ActiveStatus=0 ";
            }
            
            
               List<ItemFinishGoodsTemp> list = (List<ItemFinishGoodsTemp>) hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_item_finish_goods.Code, "
                + "mst_item_finish_goods.name, "
                + "mst_item_finish_goods.EndUserCode AS endUserCode, "
                + "mst_customer.name AS endUserName, "
                + "mst_valve_type.Code as valveTypeCode, "
                + "mst_valve_type.Name AS valveTypeName, "
                + "mst_item_finish_goods.ItemTypeDesignCode, "
                + "mst_item_type_design.name AS itemTypeDesignName, "
                + "mst_item_finish_goods.ItemSizeCode, "
                + "mst_item_size.name AS itemSizeName, "
                + "mst_item_finish_goods.ItemRatingCode, "
                + "mst_item_rating.name AS itemRatingName, "
                + "mst_item_finish_goods.ItemBoreCode, "
                + "mst_item_bore.name AS itemBoreName, "
                + "mst_item_finish_goods.ItemEndConCode, "
                + "mst_item_end_con.name AS itemEndConName, "
                + "mst_item_finish_goods.ItemBodyCode, "
                + "mst_item_body.name AS itemBodyName, "
                + "mst_item_finish_goods.ItemBallCode, "
                + "mst_item_ball.name AS itemBallName, "
                + "mst_item_finish_goods.ItemStemCode, "
                + "mst_item_stem.name AS itemStemName, "
                + "mst_item_finish_goods.ItemSealCode, "
                + "mst_item_seal.name AS itemSealName, "
                + "mst_item_finish_goods.ItemSeatCode, "
                + "mst_item_seat.name AS itemSeatName, "
                + "mst_item_finish_goods.ItemSeatInsertCode, "
                + "mst_item_seat_insert.name AS itemSeatInsertName, "
                + "mst_item_finish_goods.ItemBoltCode, "
                + "mst_item_bolt.name AS itemBoltName, "
                + "mst_item_finish_goods.ItemSeatDesignCode, "
                + "mst_item_seat_design.name AS itemSeatDesignName, "
                + "mst_item_finish_goods.ItemOperatorCode, "
                + "mst_item_operator.name AS itemOperatorName, "
                + "mst_item_finish_goods.ItemBodyConstructionCode, "
                + "mst_item_body_construction.name AS itemBodyConstructionName, "
                + "mst_item_finish_goods.itemArmPinCode, "
                + "mst_item_arm_pin.name AS itemArmPinName, "
                + "mst_item_finish_goods.ItemDiscCode, "
                + "mst_item_disc.name AS itemDiscName, "
                + "mst_item_finish_goods.itemBackseatCode, "
                + "mst_item_backseat.name AS itemBackseatName, "
                + "mst_item_finish_goods.itemSpringCode, "
                + "mst_item_spring.name AS itemSpringName, "
                + "mst_item_finish_goods.itemPlatesCode, "
                + "mst_item_plates.name AS itemPlatesName, "
                + "mst_item_finish_goods.itemShaftCode, "
                + "mst_item_shaft.name AS itemShaftName, "
                + "mst_item_finish_goods.itemArmCode, "
                + "mst_item_arm.name AS itemArmName, "
                + "mst_item_finish_goods.itemHingePinCode, "
                + "mst_item_hinge_pin.name AS itemHingePinName, "
                + "mst_item_finish_goods.itemStopPinCode, "
                + "mst_item_stop_pin.name AS itemStopPinName, "
                + "mst_item_finish_goods.remark, "
                + "mst_item_finish_goods.InActiveBy, "
                + "mst_item_finish_goods.InActiveDate, "
                + "mst_item_finish_goods.activeStatus, "
                + "mst_item_finish_goods.createdBy, "
                + "mst_item_finish_goods.createdDate "
                + "FROM mst_item_finish_goods "
                + "INNER JOIN mst_customer ON mst_item_finish_goods.EndUserCode=mst_customer.Code "
                + "INNER JOIN mst_valve_type ON mst_item_finish_goods.ValveTypeCode=mst_valve_type.Code "
                + "LEFT JOIN mst_item_type_design ON mst_item_finish_goods.ItemTypeDesignCode=mst_item_type_design.Code "
                + "LEFT JOIN mst_item_size ON mst_item_finish_goods.ItemSizeCode=mst_item_size.Code "
                + "LEFT JOIN mst_item_rating ON mst_item_finish_goods.ItemRatingCode=mst_item_rating.Code "
                + "LEFT JOIN mst_item_bore ON mst_item_finish_goods.ItemBoreCode=mst_item_bore.Code "
                + "LEFT JOIN mst_item_end_con ON mst_item_finish_goods.ItemEndConCode=mst_item_end_con.Code "
                + "LEFT JOIN mst_item_body ON mst_item_finish_goods.ItemBodyCode=mst_item_body.Code "
                + "LEFT JOIN mst_item_ball ON mst_item_finish_goods.ItemBallCode=mst_item_ball.Code "
                + "LEFT JOIN mst_item_stem ON mst_item_finish_goods.ItemStemCode=mst_item_stem.Code "
                + "LEFT JOIN mst_item_seal ON mst_item_finish_goods.ItemSealCode=mst_item_seal.Code "
                + "LEFT JOIN mst_item_seat ON mst_item_finish_goods.ItemSeatCode=mst_item_seat.Code "
                + "LEFT JOIN mst_item_seat_insert ON mst_item_finish_goods.ItemSeatInsertCode=mst_item_seat_insert.Code "
                + "LEFT JOIN mst_item_bolt ON mst_item_finish_goods.ItemBoltCode=mst_item_bolt.Code "
                + "LEFT JOIN mst_item_seat_design ON mst_item_finish_goods.ItemSeatDesignCode=mst_item_seat_design.Code "
                + "LEFT JOIN mst_item_operator ON mst_item_finish_goods.ItemOperatorCode=mst_item_operator.Code "
                + "LEFT JOIN mst_item_body_construction ON mst_item_finish_goods.ItemBodyConstructionCode=mst_item_body_construction.Code "
                + "LEFT JOIN mst_item_arm_pin ON mst_item_finish_goods.ItemArmPinCode=mst_item_arm_pin.Code "
                + "LEFT JOIN mst_item_disc ON mst_item_finish_goods.ItemDiscCode=mst_item_disc.Code "
                + "LEFT JOIN mst_item_backseat ON mst_item_finish_goods.ItemBackseatCode=mst_item_backseat.Code "
                + "LEFT JOIN mst_item_spring ON mst_item_finish_goods.ItemSpringCode=mst_item_spring.Code "
                + "LEFT JOIN mst_item_plates ON mst_item_finish_goods.ItemPlatesCode=mst_item_plates.Code "
                + "LEFT JOIN mst_item_shaft ON mst_item_finish_goods.ItemShaftCode=mst_item_shaft.Code "
                + "LEFT JOIN mst_item_arm ON mst_item_finish_goods.ItemArmCode=mst_item_arm.Code "
                + "LEFT JOIN mst_item_hinge_pin ON mst_item_finish_goods.ItemHingePinCode=mst_item_hinge_pin.Code "
                + "LEFT JOIN mst_item_stop_pin ON mst_item_finish_goods.ItemStopPinCode=mst_item_stop_pin.Code "      
                + "WHERE mst_item_finish_goods.code LIKE '%"+code+"%' "
                + "AND mst_item_finish_goods.EndUserCode LIKE '%"+customerCode+"%' "            
                + concat_qry)
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("endUserCode", Hibernate.STRING)
                .addScalar("endUserName", Hibernate.STRING)
                .addScalar("valveTypeCode", Hibernate.STRING)
                .addScalar("valveTypeName", Hibernate.STRING)       
                .addScalar("itemTypeDesignCode", Hibernate.STRING)
                .addScalar("itemTypeDesignName", Hibernate.STRING)
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
                .addScalar("itemStemCode", Hibernate.STRING)
                .addScalar("itemStemName", Hibernate.STRING)
                .addScalar("itemSealCode", Hibernate.STRING)
                .addScalar("itemSealName", Hibernate.STRING)
                .addScalar("itemSeatCode", Hibernate.STRING)
                .addScalar("itemSeatName", Hibernate.STRING)
                .addScalar("itemSeatInsertCode", Hibernate.STRING)
                .addScalar("itemSeatInsertName", Hibernate.STRING)
                .addScalar("itemBoltCode", Hibernate.STRING)
                .addScalar("itemBoltName", Hibernate.STRING)
                .addScalar("itemSeatDesignCode", Hibernate.STRING)
                .addScalar("itemSeatDesignName", Hibernate.STRING)
                .addScalar("itemOperatorCode", Hibernate.STRING)
                .addScalar("itemOperatorName", Hibernate.STRING)
                .addScalar("itemBodyConstructionCode", Hibernate.STRING)
                .addScalar("itemBodyConstructionName", Hibernate.STRING)
                .addScalar("itemArmPinCode", Hibernate.STRING)
                .addScalar("itemArmPinName", Hibernate.STRING)
                .addScalar("itemDiscCode", Hibernate.STRING)
                .addScalar("itemDiscName", Hibernate.STRING)
                .addScalar("itemBackseatCode", Hibernate.STRING)
                .addScalar("itemBackseatName", Hibernate.STRING)
                .addScalar("itemSpringCode", Hibernate.STRING)
                .addScalar("itemSpringName", Hibernate.STRING)
                .addScalar("itemPlatesCode", Hibernate.STRING)
                .addScalar("itemPlatesName", Hibernate.STRING)
                .addScalar("itemShaftCode", Hibernate.STRING)
                .addScalar("itemShaftName", Hibernate.STRING)    
                .addScalar("itemArmCode", Hibernate.STRING)
                .addScalar("itemArmName", Hibernate.STRING)
                .addScalar("itemHingePinCode", Hibernate.STRING)
                .addScalar("itemHingePinName", Hibernate.STRING)
                .addScalar("itemStopPinCode", Hibernate.STRING)
                .addScalar("itemStopPinName", Hibernate.STRING)               
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("inActiveBy", Hibernate.STRING)
                .addScalar("inActiveDate", Hibernate.TIMESTAMP)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.TIMESTAMP)
                .setResultTransformer(Transformers.aliasToBean(ItemFinishGoodsTemp.class))
                .list(); 
               
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public String createCode(ItemFinishGoods itemFinishGood){        
        try{
            
            String itemTypeDesign="";
            if (itemFinishGood.getItemTypeDesign().getCode().equals("")){
                itemTypeDesign="";
            }else{
                itemTypeDesign="_"+itemFinishGood.getItemTypeDesign().getCode();
            }
            
            String itemSize="";
            if (itemFinishGood.getItemSize().getCode().equals("")){
                itemSize="";
            }else{
                itemSize="_"+itemFinishGood.getItemSize().getCode();
            }
            
            String itemRating="";
            if (itemFinishGood.getItemRating().getCode().equals("")){
                itemRating="";
            }else{
                itemRating="_"+itemFinishGood.getItemRating().getCode();
            }
            
            String itemBore="";
            if (itemFinishGood.getItemBore().getCode().equals("")){
                itemBore="";
            }else{
                itemBore="_"+itemFinishGood.getItemBore().getCode();
            }
            
            String itemEndCon="";
            if (itemFinishGood.getItemEndCon().getCode().equals("")){
                itemEndCon="";
            }else{
                itemEndCon="_"+itemFinishGood.getItemEndCon().getCode();
            }
            
            String itemBall="";
            if (itemFinishGood.getItemBall().getCode().equals("")){
                itemBall="";
            }else{
                itemBall="_"+itemFinishGood.getItemBall().getCode();
            }
            
            String itemBody="";
            if (itemFinishGood.getItemBody().getCode().equals("")){
                itemBody="";
            }else{
                itemBody="_"+itemFinishGood.getItemBody().getCode();
            }
            
            String itemStem="";
            if (itemFinishGood.getItemStem().getCode().equals("")){
                itemStem="";
            }else{
                itemStem="_"+itemFinishGood.getItemStem().getCode();
            }
            
            String itemSeal="";
            if (itemFinishGood.getItemSeal().getCode().equals("")){
                itemSeal="";
            }else{
                itemSeal="_"+itemFinishGood.getItemSeal().getCode();
            }
            
            String itemSeat="";
            if (itemFinishGood.getItemSeat().getCode().equals("")){
                itemSeat="";
            }else{
                itemSeat="_"+itemFinishGood.getItemSeat().getCode();
            }
            
            String itemSeatInsert="";
            if (itemFinishGood.getItemSeatInsert().getCode().equals("")){
                itemSeatInsert="";
            }else{
                itemSeatInsert="_"+itemFinishGood.getItemSeatInsert().getCode();
            }
            
            String itemBolt="";
            if (itemFinishGood.getItemBolt().getCode().equals("")){
                itemBolt="";
            }else{
                itemBolt="_"+itemFinishGood.getItemBolt().getCode();
            }
            
            String itemSeatDesign="";
            if (itemFinishGood.getItemSeatDesign().getCode().equals("")){
                itemSeatDesign="";
            }else{
                itemSeatDesign="_"+itemFinishGood.getItemSeatDesign().getCode();
            }
            
            String itemOperator="";
            if (itemFinishGood.getItemOperator().getCode().equals("")){
                itemOperator="";
            }else{
                itemOperator="_"+itemFinishGood.getItemOperator().getCode();
            }
            
            String itemBodyConstruction="";
            if (itemFinishGood.getItemBodyConstruction().getCode().equals("")){
                itemBodyConstruction="";
            }else{
                itemBodyConstruction="_"+itemFinishGood.getItemBodyConstruction().getCode();
            }
            
            String itemDisc="";
            if (itemFinishGood.getItemDisc().getCode().equals("")){
                itemDisc="";
            }else{
                itemDisc="_"+itemFinishGood.getItemDisc().getCode();
            }
            
            String itemPlates="";
            if (itemFinishGood.getItemPlates().getCode().equals("")){
                itemDisc="";
            }else{
                itemDisc="_"+itemFinishGood.getItemPlates().getCode();
            }
            
            String itemShaft="";
            if (itemFinishGood.getItemShaft().getCode().equals("")){
                itemShaft="";
            }else{
                itemShaft="_"+itemFinishGood.getItemShaft().getCode();
            }
            
            String itemSpring="";
            if (itemFinishGood.getItemSpring().getCode().equals("")){
                itemSpring="";
            }else{
                itemSpring="_"+itemFinishGood.getItemSpring().getCode();
            }
            
            String itemArmPin="";
            if (itemFinishGood.getItemArmPin().getCode().equals("")){
                itemArmPin="";
            }else{
                itemArmPin="_"+itemFinishGood.getItemArmPin().getCode();
            }
            
            String itemBackseat="";
            if (itemFinishGood.getItemBackseat().getCode().equals("")){
                itemArmPin="";
            }else{
                itemArmPin="_"+itemFinishGood.getItemBackseat().getCode();
            }
            
            String itemArm="";
            if (itemFinishGood.getItemArm().getCode().equals("")){
                itemArm="";
            }else{
                itemArm="_"+itemFinishGood.getItemArm().getCode();
            }
            
            String itemHingePin="";
            if (itemFinishGood.getItemHingePin().getCode().equals("")){
                itemHingePin="";
            }else{
                itemHingePin="_"+itemFinishGood.getItemHingePin().getCode();
            }
            
            String itemStopPin="";
            if (itemFinishGood.getItemBackseat().getCode().equals("")){
                itemStopPin="";
            }else{
                itemStopPin="_"+itemFinishGood.getItemBackseat().getCode();
            }
            
            
            String acronim =  itemFinishGood.getEndUser().getCode()+itemBodyConstruction+itemTypeDesign+itemSeatDesign+itemSize+itemRating+itemBore
                              +itemEndCon+itemBody+itemBall+itemSeat+itemSeatInsert+itemStem+itemSeal+itemBolt+itemOperator
                              +itemDisc+itemPlates+itemShaft+itemSpring+itemArmPin+itemBackseat+itemArm+itemHingePin+itemStopPin;

            DetachedCriteria dc = DetachedCriteria.forClass(ItemFinishGoods.class)
                    .setProjection(Projections.max("code"))
                    .add(Restrictions.like("code", acronim + "%" ));

            return acronim;
        }
        catch(HibernateException e){
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
     public void save(ItemFinishGoods itemFinishGood, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            itemFinishGood.setCode(createCode(itemFinishGood));
            
            if(itemFinishGood.isActiveStatus()){
                itemFinishGood.setInActiveBy("");                
            }else{
                itemFinishGood.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                itemFinishGood.setInActiveDate(new Date());
            }
            itemFinishGood.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            itemFinishGood.setCreatedDate(new Date()); 
            hbmSession.hSession.save(itemFinishGood);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT), 
                                                                    itemFinishGood.getCode(), ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(ItemFinishGoods itemFinishGood, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            
            if(itemFinishGood.isActiveStatus()){
                itemFinishGood.setInActiveBy("");                
            }else{
                itemFinishGood.setInActiveBy(BaseSession.loadProgramSession().getUserName());
                itemFinishGood.setInActiveDate(new Date());
            }
            itemFinishGood.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            itemFinishGood.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(itemFinishGood);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
                                                                    itemFinishGood.getCode(), ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void delete(String code, String moduleCode) {
        try {
            hbmSession.hSession.beginTransaction();
            hbmSession.hSession.createQuery("DELETE FROM " + ItemFinishGoodsField.BEAN_NAME + " WHERE " + ItemFinishGoodsField.CODE + " = :prmCode")
                    .setParameter("prmCode", code)
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
