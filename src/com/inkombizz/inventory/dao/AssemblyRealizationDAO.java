/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.inventory.dao;

/**
 *
 * @author Rayis
 */

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.dao.common.AutoNumber;
import com.inkombizz.inventory.model.InventoryActualStockField;
import com.inkombizz.inventory.model.AssemblyRealization;
import com.inkombizz.inventory.model.AssemblyRealizationCOGS;
import com.inkombizz.inventory.model.AssemblyRealizationItemDetail;
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

public class AssemblyRealizationDAO {
    
    private HBMSession hbmSession;
    
    public AssemblyRealizationDAO(HBMSession session) {
        this.hbmSession = session;
    }

    public int countData(Date firstDate, Date lastDate,String code,String assemblyRealizationCode, 
            String finishGoodsCode,String finishGoodsName,String refNo,String remark) {
        try {

            BigInteger temp = (BigInteger) hbmSession.hSession.createSQLQuery(
                    "CALL usp_assembly_realization_list_count(:prmCode,:prmAssemblyRealizationCode,:prmFinishGoodsCode,:prmFinishGoodsName,"
                            + ":prmRefNo,:prmRemark,:prmFirstDate,:prmLastDate)"
            )
            .setParameter("prmCode", "%"+code+"%")
            .setParameter("prmAssemblyRealizationCode", "%"+assemblyRealizationCode+"%")
            .setParameter("prmFinishGoodsCode", "%"+finishGoodsCode+"%")
            .setParameter("prmFinishGoodsName", "%"+finishGoodsName+"%")
            .setParameter("prmRefNo", "%"+refNo+"%")
            .setParameter("prmRemark", "%"+remark+"%")
            .setParameter("prmFirstDate", firstDate)
            .setParameter("prmLastDate", lastDate)
            .uniqueResult();

            return temp.intValue();

        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
    
    public int countSearchData(Date firstDate, Date lastDate,String code,String assemblyRealizationCode, 
            String finishGoodsCode,String finishGoodsName,String refNo,String remark) {
        try {

            BigInteger temp = (BigInteger) hbmSession.hSession.createSQLQuery(
                    "CALL usp_assembly_realization_search_list_count(:prmCode,:prmAssemblyRealizationCode,:prmFinishGoodsCode,:prmFinishGoodsName,"
                            + ":prmRefNo,:prmRemark,:prmFirstDate,:prmLastDate)"
            )
            .setParameter("prmCode", "%"+code+"%")
            .setParameter("prmAssemblyRealizationCode", "%"+assemblyRealizationCode+"%")
            .setParameter("prmFinishGoodsCode", "%"+finishGoodsCode+"%")
            .setParameter("prmFinishGoodsName", "%"+finishGoodsName+"%")
            .setParameter("prmRefNo", "%"+refNo+"%")
            .setParameter("prmRemark", "%"+remark+"%")
            .setParameter("prmFirstDate", firstDate)
            .setParameter("prmLastDate", lastDate)
            .uniqueResult();

            return temp.intValue();

        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<AssemblyRealization> findData(Date firstDate, Date lastDate,String code,String assemblyRealizationCode, 
            String finishGoodsCode,String finishGoodsName,String refNo,String remark, int from, int to) {
        try {
            
            List<AssemblyRealization> list = (List<AssemblyRealization>) hbmSession.hSession.createSQLQuery(
                    "CALL usp_assembly_realization_list(:prmCode,:prmAssemblyJobOrderCode,:prmFinishGoodsCode,:prmFinishGoodsName,"
                            + ":prmRefNo,:prmRemark,:prmFirstDate,:prmLastDate,:prmLimitFrom,:prmLimitUpTo)")
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("assemblyJobOrderCode", Hibernate.STRING)
                    .addScalar("branchCode", Hibernate.STRING)
                    .addScalar("branchName", Hibernate.STRING)
                    .addScalar("transactionDate", Hibernate.TIMESTAMP)
                    .addScalar("assemblyJobOrderDate", Hibernate.TIMESTAMP)
                    .addScalar("finishGoodsCode", Hibernate.STRING)
                    .addScalar("finishGoodsName", Hibernate.STRING)
                    .addScalar("realizationQuantity", Hibernate.BIG_DECIMAL)
                    .addScalar("billOfMaterialCode", Hibernate.STRING)
                    .addScalar("billOfMaterialName", Hibernate.STRING)
                    .addScalar("refNo", Hibernate.STRING)
                    .addScalar("remark", Hibernate.STRING)
                    .setParameter("prmCode", "%"+code+"%")
                    .setParameter("prmAssemblyJobOrderCode", "%"+assemblyRealizationCode+"%")
                    .setParameter("prmFinishGoodsCode", "%"+finishGoodsCode+"%")
                    .setParameter("prmFinishGoodsName", "%"+finishGoodsName+"%")
                    .setParameter("prmRefNo", "%"+refNo+"%")
                    .setParameter("prmRemark", "%"+remark+"%")
                    .setParameter("prmFirstDate", firstDate)
                    .setParameter("prmLastDate", lastDate)
                    .setParameter("prmLimitFrom", from)
                    .setParameter("prmLimitUpTo", to)
                    .setResultTransformer(Transformers.aliasToBean(AssemblyRealization.class))
                    .list();

            return list;
        } catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<AssemblyRealization> searchData(Date firstDate, Date lastDate,String code,String assemblyRealizationCode, 
            String finishGoodsCode,String finishGoodsName,String refNo,String remark, int from, int to) {
        try {
            
            List<AssemblyRealization> list = (List<AssemblyRealization>) hbmSession.hSession.createSQLQuery(
                    "CALL usp_assembly_realization_search_list(:prmCode,:prmAssemblyJobOrderCode,:prmFinishGoodsCode,:prmFinishGoodsName,"
                            + ":prmRefNo,:prmRemark,:prmFirstDate,:prmLastDate,:prmLimitFrom,:prmLimitUpTo)")
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("assemblyJobOrderCode", Hibernate.STRING)
                    .addScalar("branchCode", Hibernate.STRING)
                    .addScalar("branchName", Hibernate.STRING)
                    .addScalar("transactionDate", Hibernate.TIMESTAMP)
                    .addScalar("assemblyJobOrderDate", Hibernate.TIMESTAMP)
                    .addScalar("finishGoodsCode", Hibernate.STRING)
                    .addScalar("finishGoodsName", Hibernate.STRING)
                    .addScalar("defaultUnitOfMeasureCode", Hibernate.STRING)
                    .addScalar("realizationQuantity", Hibernate.BIG_DECIMAL)
                    .addScalar("billOfMaterialCode", Hibernate.STRING)
                    .addScalar("billOfMaterialName", Hibernate.STRING)
                    .addScalar("refNo", Hibernate.STRING)
                    .addScalar("remark", Hibernate.STRING)
                    .setParameter("prmCode", "%"+code+"%")
                    .setParameter("prmAssemblyJobOrderCode", "%"+assemblyRealizationCode+"%")
                    .setParameter("prmFinishGoodsCode", "%"+finishGoodsCode+"%")
                    .setParameter("prmFinishGoodsName", "%"+finishGoodsName+"%")
                    .setParameter("prmRefNo", "%"+refNo+"%")
                    .setParameter("prmRemark", "%"+remark+"%")
                    .setParameter("prmFirstDate", firstDate)
                    .setParameter("prmLastDate", lastDate)
                    .setParameter("prmLimitFrom", from)
                    .setParameter("prmLimitUpTo", to)
                    .setResultTransformer(Transformers.aliasToBean(AssemblyRealization.class))
                    .list();

            return list;
        } catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<AssemblyRealizationItemDetail> findDataItemDetail(String headerCode) {
        try {
            List<AssemblyRealizationItemDetail> list = (List<AssemblyRealizationItemDetail>) hbmSession.hSession.createSQLQuery(
                    "CALL usp_assembly_realization_item_detail_list(:prmHeaderCode)")
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("headerCode", Hibernate.STRING)
                    .addScalar("itemMaterialCode", Hibernate.STRING)
                    .addScalar("itemMaterialName", Hibernate.STRING)
                    .addScalar("unitOfMeasureCode", Hibernate.STRING)
                    .addScalar("rackCode", Hibernate.STRING)
                    .addScalar("rackName", Hibernate.STRING)
                    .addScalar("remark", Hibernate.STRING)
                    .addScalar("quantity", Hibernate.BIG_DECIMAL)
                    .setParameter("prmHeaderCode", headerCode)
                    .setResultTransformer(Transformers.aliasToBean(AssemblyRealizationItemDetail.class))
                    .list();

            return list;
        } catch (HibernateException e) {
            e.printStackTrace();
            throw e;
        }
    }
    
    public List<AssemblyRealizationCOGS> findDataCOGS(String headerCode) {
        try {
            List<AssemblyRealizationCOGS> list = (List<AssemblyRealizationCOGS>) hbmSession.hSession.createSQLQuery(
                    "CALL usp_assembly_realization_cogs_list(:prmHeaderCode)")
                    .addScalar("itemCode", Hibernate.STRING)
                    .addScalar("itemName", Hibernate.STRING)
                    .addScalar("warehouseCode", Hibernate.STRING)
                    .addScalar("warehouseName", Hibernate.STRING)
                    .addScalar("itemAlias", Hibernate.STRING)
                    .addScalar("unitOfMeasureCode", Hibernate.STRING)
                    .addScalar("quantity", Hibernate.BIG_DECIMAL)
                    .addScalar("conversion", Hibernate.BIG_DECIMAL)
                    .addScalar("cogsIdr", Hibernate.BIG_DECIMAL)
                    .addScalar("itemBrandCode", Hibernate.STRING)
                    .addScalar("lotNo", Hibernate.STRING)
                    .addScalar("batchNo", Hibernate.STRING)
                    .addScalar("rackCode", Hibernate.STRING)
                    .addScalar("rackName", Hibernate.STRING)
                    .addScalar("productionDate", Hibernate.DATE)
                    .addScalar("itemDate", Hibernate.DATE)
                    .addScalar("expiredDate", Hibernate.DATE)
                    .addScalar("inDocumentType", Hibernate.STRING)
                    .addScalar("InTransactionNo", Hibernate.STRING)
                    .setParameter("prmHeaderCode", headerCode)
                    .setResultTransformer(Transformers.aliasToBean(AssemblyRealizationCOGS.class))
                    .list();

            return list;
        } catch (HibernateException e) {
            e.printStackTrace();
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

    private String createCode(AssemblyRealization assemblyRealization) {
        try {
            String tempKode = assemblyRealization.getBranch().getCode() + "/" + "ASM-WO";
            String acronim = tempKode + "/"+ AutoNumber.formatingDate(assemblyRealization.getTransactionDate(), true, true, false);

            DetachedCriteria dc = DetachedCriteria.forClass(AssemblyRealization.class)
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

    public void save(AssemblyRealization assemblyRealization,
            List<AssemblyRealizationItemDetail> listAssemblyRealizationItemDetail,
            List<AssemblyRealizationCOGS> listAssemblyRealizationCOGS,String MODULECODE) throws Exception {
        try {
            hbmSession.hSession.beginTransaction();
            
            assemblyRealization.setBranch(assemblyRealization.getAssemblyJobOrder().getBranch());
            String headerCode = createCode(assemblyRealization);
            assemblyRealization.setCode(headerCode);
            assemblyRealization.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            assemblyRealization.setCreatedDate(new Date());

            hbmSession.hSession.save(assemblyRealization);

            hbmSession.hSession.flush();
            
            int n = 1;
            for (AssemblyRealizationItemDetail assemblyRealizationItemDetail : listAssemblyRealizationItemDetail) {
                String detailCode = assemblyRealization.getCode() + "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(n), AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                assemblyRealizationItemDetail.setCode(detailCode);
                assemblyRealizationItemDetail.setHeaderCode(headerCode);
                assemblyRealizationItemDetail.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                assemblyRealizationItemDetail.setCreatedDate(new Date());
                assemblyRealizationItemDetail.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
                assemblyRealizationItemDetail.setUpdatedDate(new Date());

                hbmSession.hSession.save(assemblyRealizationItemDetail);
                hbmSession.hSession.flush();
                n++;
                
            }
            
            int i = 1;
            for (AssemblyRealizationCOGS assemblyRealizationCOGS : listAssemblyRealizationCOGS) {
                String detailCode = assemblyRealization.getCode() + "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i), AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                assemblyRealizationCOGS.setCode(detailCode);
                assemblyRealizationCOGS.setHeaderCode(headerCode);
                assemblyRealizationCOGS.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                assemblyRealizationCOGS.setCreatedDate(new Date());
                assemblyRealizationCOGS.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
                assemblyRealizationCOGS.setUpdatedDate(new Date());

                hbmSession.hSession.save(assemblyRealizationCOGS);
                hbmSession.hSession.flush();
                
            //    BigDecimal conversion = unitOfMeasureConversionDAO.getConversionByItemCode(assemblyRealizationCOGS.getItem().getCode());
                BigDecimal totalQuantity = assemblyRealizationCOGS.getQuantity();

                /* UPDATE BOOKED STOCK */
                hbmSession.hSession.createQuery("UPDATE " + InventoryActualStockField.BEAN_NAME + "  "
                + "SET " + InventoryActualStockField.ACTUALSTOCK + "= " + InventoryActualStockField.ACTUALSTOCK + "+ :prmUsedStockQuantity  "
                + "WHERE warehouse.code = :prmWarehouseCode AND item.code = :prmItemCode "
                + "AND rack.code = :prmRackCode ")
                .setParameter("prmUsedStockQuantity", totalQuantity.doubleValue())
                .setParameter("prmWarehouseCode", assemblyRealizationCOGS.getWarehouse().getCode())
                .setParameter("prmItemCode", assemblyRealizationCOGS.getItem().getCode())
                .setParameter("prmRackCode", assemblyRealizationCOGS.getRack().getCode())
                .executeUpdate();

                hbmSession.hSession.flush();
                
                i++;

            }
            
//            hbmSession.hSession.createSQLQuery("UPDATE ivt_assembly_job_order  "
//                + "SET LastStatus ='WORK' "
//                + "WHERE code = :prmCode ")
//                .setParameter("prmCode", assemblyRealization.getAssemblyJobOrder().getCode())
//                .executeUpdate();
//            hbmSession.hSession.flush();
                
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(MODULECODE,
                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT),
                    assemblyRealization.getCode(), ""));
            hbmSession.hTransaction.commit();

        } catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }

    public void update(AssemblyRealization assemblyRealization,
            List<AssemblyRealizationItemDetail> listAssemblyRealizationItemDetail,
            List<AssemblyRealizationCOGS> listAssemblyRealizationCOGS,String moduleCode) throws Exception {
        try {
            hbmSession.hSession.beginTransaction();

            assemblyRealization.setBranch(assemblyRealization.getAssemblyJobOrder().getBranch());
            assemblyRealization.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            assemblyRealization.setUpdatedDate(new Date());

            hbmSession.hSession.update(assemblyRealization);

            hbmSession.hSession.flush();
            
            if (!updateDetail(assemblyRealization,listAssemblyRealizationItemDetail,listAssemblyRealizationCOGS)) {
                hbmSession.hTransaction.rollback();
            }
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode,
                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE),
                    assemblyRealization.getCode(), ""));

            hbmSession.hTransaction.commit();
        } catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
        }
    }

    private Boolean updateDetail(AssemblyRealization assemblyRealization,
            List<AssemblyRealizationItemDetail> listAssemblyRealizationItemDetail,
            List<AssemblyRealizationCOGS> listAssemblyRealizationCOGS) throws Exception {
        try {
            
            List<AssemblyRealizationCOGS> list = findDataCOGS(assemblyRealization.getCode());

            hbmSession.hSession.createSQLQuery("DELETE FROM ivt_assembly_realization_item_detail "
                    + " WHERE HeaderCode = :prmHeaderCode")
                    .setParameter("prmHeaderCode", assemblyRealization.getCode())
                    .executeUpdate();

            hbmSession.hSession.flush();
            
            hbmSession.hSession.createSQLQuery("DELETE FROM ivt_assembly_realization_cogs "
                    + " WHERE HeaderCode = :prmHeaderCode")
                    .setParameter("prmHeaderCode", assemblyRealization.getCode())
                    .executeUpdate();

            hbmSession.hSession.flush();

            for (AssemblyRealizationCOGS detail : list) {
                
                BigDecimal totalQuantity = detail.getQuantity().multiply(detail.getConversion());
    
                /* UPDATE BOOKED STOCK */
                hbmSession.hSession.createQuery("UPDATE " + InventoryActualStockField.BEAN_NAME + "  "
                + "SET " + InventoryActualStockField.ACTUALSTOCK + "= " + InventoryActualStockField.ACTUALSTOCK + "- :prmUsedStockQuantity  "
                + "WHERE warehouse.code = :prmWarehouseCode AND item.code = :prmItemCode "
                + "AND rack.code = :prmRackCode ")
                .setParameter("prmUsedStockQuantity", totalQuantity.doubleValue())
                .setParameter("prmWarehouseCode", detail.getWarehouseCode())
                .setParameter("prmItemCode", detail.getItemCode())
                .setParameter("prmRackCode", detail.getRackCode())
                .executeUpdate();

                hbmSession.hSession.flush();

            }
            
            int n = 1;
            for (AssemblyRealizationItemDetail assemblyRealizationItemDetail : listAssemblyRealizationItemDetail) {
                String detailCode = assemblyRealization.getCode() + "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(n), AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                assemblyRealizationItemDetail.setCode(detailCode);
                assemblyRealizationItemDetail.setHeaderCode(assemblyRealization.getCode());
                assemblyRealizationItemDetail.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                assemblyRealizationItemDetail.setCreatedDate(new Date());
                assemblyRealizationItemDetail.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
                assemblyRealizationItemDetail.setUpdatedDate(new Date());

                hbmSession.hSession.save(assemblyRealizationItemDetail);
                
                n++;

            }
            
            int i = 1;
            for (AssemblyRealizationCOGS assemblyRealizationCOGS : listAssemblyRealizationCOGS) {
                String detailCode = assemblyRealization.getCode() + "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i), AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                assemblyRealizationCOGS.setCode(detailCode);
                assemblyRealizationCOGS.setHeaderCode(assemblyRealization.getCode());
                assemblyRealizationCOGS.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                assemblyRealizationCOGS.setCreatedDate(new Date());
                assemblyRealizationCOGS.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
                assemblyRealizationCOGS.setUpdatedDate(new Date());

                hbmSession.hSession.save(assemblyRealizationCOGS);
                
                BigDecimal totalQuantity = assemblyRealizationCOGS.getQuantity();

                /* UPDATE BOOKED STOCK */
                hbmSession.hSession.createQuery("UPDATE " + InventoryActualStockField.BEAN_NAME + "  "
                + "SET " + InventoryActualStockField.ACTUALSTOCK + "= " + InventoryActualStockField.ACTUALSTOCK + "+ :prmUsedStockQuantity  "
                + "WHERE warehouse.code = :prmWarehouseCode AND item.code = :prmItemCode "
                + "AND rack.code = :prmRackCode ")
                .setParameter("prmUsedStockQuantity", totalQuantity.doubleValue())
                .setParameter("prmWarehouseCode", assemblyRealizationCOGS.getWarehouse().getCode())
                .setParameter("prmItemCode", assemblyRealizationCOGS.getItem().getCode())
                .setParameter("prmRackCode", assemblyRealizationCOGS.getRack().getCode())
                .executeUpdate();

                hbmSession.hSession.flush();
                
                i++;

            }

            return Boolean.TRUE;

        } catch (HibernateException e) {
            e.printStackTrace();
            return Boolean.FALSE;
        }
    }
    public int countDataAssemblyRealization(String code){
        try {
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(""
                        +"SELECT " 
                        +"COUNT(*) "
                        +"FROM "
                        +"ivt_assembly_confirmation "
                        +"WHERE ivt_assembly_confirmation.AssemblyRealizationCode='"+code+"' ")
                .uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    public void delete(String code, String MODULECODE) throws Exception {
        try {
            hbmSession.hSession.beginTransaction();

            List<AssemblyRealizationCOGS> list = findDataCOGS(code);
            
            hbmSession.hSession.createQuery("DELETE FROM AssemblyRealizationCOGS "
                    + " WHERE headerCode = :prmHeaderCode")
                    .setParameter("prmHeaderCode", code)
                    .executeUpdate();

            hbmSession.hSession.flush();
            
            hbmSession.hSession.createQuery("DELETE FROM AssemblyRealizationItemDetail "
                    + " WHERE headerCode = :prmHeaderCode")
                    .setParameter("prmHeaderCode", code)
                    .executeUpdate();

            hbmSession.hSession.flush();
           
            hbmSession.hSession.createQuery("DELETE FROM AssemblyRealization "
                    + " WHERE code  = :prmCode")
                    .setParameter("prmCode", code)
                    .executeUpdate();

            hbmSession.hSession.flush();
            
            for (AssemblyRealizationCOGS detail : list) {
                BigDecimal totalQuantity = detail.getQuantity().multiply(detail.getConversion());
    
                /* UPDATE BOOKED STOCK */
                hbmSession.hSession.createQuery("UPDATE " + InventoryActualStockField.BEAN_NAME + "  "
                + "SET " + InventoryActualStockField.ACTUALSTOCK + "= " + InventoryActualStockField.ACTUALSTOCK + "- :prmUsedStockQuantity  "
                + "WHERE warehouse.code = :prmWarehouseCode AND item.code = :prmItemCode "
                + "AND rack.code = :prmRackCode")
                .setParameter("prmUsedStockQuantity", totalQuantity.doubleValue())
                .setParameter("prmWarehouseCode", detail.getWarehouseCode())
                .setParameter("prmItemCode", detail.getItemCode())
                .setParameter("prmRackCode", detail.getRackCode())
                .executeUpdate();

                hbmSession.hSession.flush();
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
    
}
