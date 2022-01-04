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
import com.inkombizz.inventory.model.AssemblyJobOrder;
import com.inkombizz.inventory.model.AssemblyJobOrderItemDetail;
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

public class AssemblyJobOrderDAO {
    
    private HBMSession hbmSession;
  
    public AssemblyJobOrderDAO(HBMSession session) {
        this.hbmSession = session;
    }

    public int countData(Date firstDate, Date lastDate,String code, 
            String finishGoodsCode,String finishGoodsName,String refNo,String remark) {
        try {

            BigInteger temp = (BigInteger) hbmSession.hSession.createSQLQuery(
                    "CALL usp_assembly_job_order_list_count(:prmCode,:prmFinishGoodsCode,:prmFinishGoodsName,"
                            + ":prmRefNo,:prmRemark,:prmFirstDate,:prmLastDate)"
            )
            .setParameter("prmCode", "%"+code+"%")
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
     public int countDataAssemblyJobOrder(String code){
        try {
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(""
                        +"SELECT " 
                        +"COUNT(*) "
                        +"FROM "
                        +"ivt_assembly_job_order "
                        +"WHERE ivt_assembly_job_order.AssemblyJobOrderCode='"+code+"' ")
                .uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    public int countSearchData(Date firstDate, Date lastDate,String code, 
            String finishGoodsCode,String finishGoodsName,String refNo,String remark) {
        try {

            BigInteger temp = (BigInteger) hbmSession.hSession.createSQLQuery(
                    "CALL usp_assembly_job_order_search_list_count(:prmCode,:prmFinishGoodsCode,:prmFinishGoodsName,"
                            + ":prmRefNo,:prmRemark,:prmFirstDate,:prmLastDate)"
            )
            .setParameter("prmCode", "%"+code+"%")
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
    
    public List<AssemblyJobOrder> findData(Date firstDate, Date lastDate,String code,
            String finishGoodsCode,String finishGoodsName,String refNo,String remark, int from, int to) {
        try {
            
            List<AssemblyJobOrder> list = (List<AssemblyJobOrder>) hbmSession.hSession.createSQLQuery(
                    "CALL usp_assembly_job_order_list(:prmCode,:prmFinishGoodsCode,:prmFinishGoodsName,"
                            + ":prmRefNo,:prmRemark,:prmFirstDate,:prmLastDate,:prmLimitFrom,:prmLimitUpTo)")
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("branchCode", Hibernate.STRING)
                    .addScalar("branchName", Hibernate.STRING)
                    .addScalar("transactionDate", Hibernate.TIMESTAMP)
                    .addScalar("unitOfMeasureCode", Hibernate.STRING)
                    .addScalar("finishGoodsCode", Hibernate.STRING)
                    .addScalar("finishGoodsName", Hibernate.STRING)
                    .addScalar("finishGoodsQuantity", Hibernate.BIG_DECIMAL)
                    .addScalar("billOfMaterialCode", Hibernate.STRING)
                    .addScalar("billOfMaterialName", Hibernate.STRING)
                    .addScalar("refNo", Hibernate.STRING)
                    .addScalar("remark", Hibernate.STRING)
                    .setParameter("prmCode", "%"+code+"%")
                    .setParameter("prmFinishGoodsCode", "%"+finishGoodsCode+"%")
                    .setParameter("prmFinishGoodsName", "%"+finishGoodsName+"%")
                    .setParameter("prmRefNo", "%"+refNo+"%")
                    .setParameter("prmRemark", "%"+remark+"%")
                    .setParameter("prmFirstDate", firstDate)
                    .setParameter("prmLastDate", lastDate)
                    .setParameter("prmLimitFrom", from)
                    .setParameter("prmLimitUpTo", to)
                    .setResultTransformer(Transformers.aliasToBean(AssemblyJobOrder.class))
                    .list();

            return list;
        } catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<AssemblyJobOrder> searchData(Date firstDate, Date lastDate,String code,
            String finishGoodsCode,String finishGoodsName,String refNo,String remark, int from, int to) {
        try {
            
            List<AssemblyJobOrder> list = (List<AssemblyJobOrder>) hbmSession.hSession.createSQLQuery(
                    "CALL usp_assembly_job_order_search_list(:prmCode,:prmFinishGoodsCode,:prmFinishGoodsName,"
                            + ":prmRefNo,:prmRemark,:prmFirstDate,:prmLastDate,:prmLimitFrom,:prmLimitUpTo)")
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("branchCode", Hibernate.STRING)
                    .addScalar("branchName", Hibernate.STRING)
                    .addScalar("branchName", Hibernate.STRING)
                    .addScalar("transactionDate", Hibernate.TIMESTAMP)
                    .addScalar("finishGoodsCode", Hibernate.STRING)
                    .addScalar("finishGoodsName", Hibernate.STRING)
                    .addScalar("finishGoodsQuantity", Hibernate.BIG_DECIMAL)
                    .addScalar("finishGoodsQuantityProcess", Hibernate.BIG_DECIMAL)
                    .addScalar("billOfMaterialCode", Hibernate.STRING)
                    .addScalar("billOfMaterialName", Hibernate.STRING)
                    .addScalar("refNo", Hibernate.STRING)
                    .addScalar("remark", Hibernate.STRING)
                    .setParameter("prmCode", "%"+code+"%")
                    .setParameter("prmFinishGoodsCode", "%"+finishGoodsCode+"%")
                    .setParameter("prmFinishGoodsName", "%"+finishGoodsName+"%")
                    .setParameter("prmRefNo", "%"+refNo+"%")
                    .setParameter("prmRemark", "%"+remark+"%")
                    .setParameter("prmFirstDate", firstDate)
                    .setParameter("prmLastDate", lastDate)
                    .setParameter("prmLimitFrom", from)
                    .setParameter("prmLimitUpTo", to)
                    .setResultTransformer(Transformers.aliasToBean(AssemblyJobOrder.class))
                    .list();

            return list;
        } catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<AssemblyJobOrderItemDetail> findDataItemDetail(String headerCode) {
        try {
            List<AssemblyJobOrderItemDetail> list = (List<AssemblyJobOrderItemDetail>) hbmSession.hSession.createSQLQuery(
                    "CALL usp_assembly_job_order_item_detail_list(:prmHeaderCode)")
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("headerCode", Hibernate.STRING)
                    .addScalar("itemMaterialCode", Hibernate.STRING)
                    .addScalar("itemMaterialName", Hibernate.STRING)
                    .addScalar("unitOfMeasureCode", Hibernate.STRING)
                    .addScalar("quantity", Hibernate.BIG_DECIMAL)
                    .setParameter("prmHeaderCode", headerCode)
                    .setResultTransformer(Transformers.aliasToBean(AssemblyJobOrderItemDetail.class))
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

    private String createCode(AssemblyJobOrder assemblyJobOrder) {
        try {
            String tempKode = assemblyJobOrder.getBranch().getCode() + "/" + "ASM-JOB";
            String acronim = tempKode + "/"+ AutoNumber.formatingDate(assemblyJobOrder.getTransactionDate(), true, true, false);

            DetachedCriteria dc = DetachedCriteria.forClass(AssemblyJobOrder.class)
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

    public void save(AssemblyJobOrder assemblyJobOrder,
            List<AssemblyJobOrderItemDetail> listAssemblyJobOrderItemDetail,String MODULECODE) throws Exception {
        try {

            String headerCode = createCode(assemblyJobOrder);

            hbmSession.hSession.beginTransaction();

            assemblyJobOrder.setCode(headerCode);
            assemblyJobOrder.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            assemblyJobOrder.setCreatedDate(new Date());

            hbmSession.hSession.save(assemblyJobOrder);

            hbmSession.hSession.flush();
            
            int n = 1;
            for (AssemblyJobOrderItemDetail assemblyJobOrderItemDetail : listAssemblyJobOrderItemDetail) {
                String detailCode = assemblyJobOrder.getCode() + "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(n), AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                assemblyJobOrderItemDetail.setCode(detailCode);
                assemblyJobOrderItemDetail.setHeaderCode(headerCode);
                assemblyJobOrderItemDetail.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                assemblyJobOrderItemDetail.setCreatedDate(new Date());
                assemblyJobOrderItemDetail.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
                assemblyJobOrderItemDetail.setUpdatedDate(new Date());

                hbmSession.hSession.save(assemblyJobOrderItemDetail);
                
                n++;

            }

            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(MODULECODE,
                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT),
                    assemblyJobOrder.getCode(), ""));
            hbmSession.hTransaction.commit();

        } catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }

    public void update(AssemblyJobOrder assemblyJobOrder,
            List<AssemblyJobOrderItemDetail> listAssemblyJobOrderItemDetail, String moduleCode) throws Exception {
        try {
            hbmSession.hSession.beginTransaction();

            assemblyJobOrder.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            assemblyJobOrder.setUpdatedDate(new Date());

            hbmSession.hSession.update(assemblyJobOrder);

            hbmSession.hSession.flush();
            
            if (!updateDetail(assemblyJobOrder,listAssemblyJobOrderItemDetail)) {
                hbmSession.hTransaction.rollback();
            }
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode,
                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE),
                    assemblyJobOrder.getCode(), ""));

            hbmSession.hTransaction.commit();
        } catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
        }
    }

    private Boolean updateDetail(AssemblyJobOrder assemblyJobOrder,
            List<AssemblyJobOrderItemDetail> listAssemblyJobOrderItemDetail) throws Exception {
        try {
            
            hbmSession.hSession.createSQLQuery("DELETE FROM prd_assembly_job_order_item_detail "
                    + " WHERE HeaderCode = :prmHeaderCode")
                    .setParameter("prmHeaderCode", assemblyJobOrder.getCode())
                    .executeUpdate();

            hbmSession.hSession.flush();


            int n = 1;
            for (AssemblyJobOrderItemDetail assemblyJobOrderItemDetail : listAssemblyJobOrderItemDetail) {
                String detailCode = assemblyJobOrder.getCode() + "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(n), AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                assemblyJobOrderItemDetail.setCode(detailCode);
                assemblyJobOrderItemDetail.setHeaderCode(assemblyJobOrder.getCode());
                assemblyJobOrderItemDetail.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                assemblyJobOrderItemDetail.setCreatedDate(new Date());
                assemblyJobOrderItemDetail.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
                assemblyJobOrderItemDetail.setUpdatedDate(new Date());

                hbmSession.hSession.save(assemblyJobOrderItemDetail);
                
                n++;

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

            hbmSession.hSession.createQuery("DELETE FROM AssemblyJobOrderItemDetail "
                    + " WHERE headerCode = :prmHeaderCode")
                    .setParameter("prmHeaderCode", code)
                    .executeUpdate();

            hbmSession.hSession.flush();
           
            hbmSession.hSession.createQuery("DELETE FROM AssemblyJobOrder "
                    + " WHERE code  = :prmCode")
                    .setParameter("prmCode", code)
                    .executeUpdate();

            
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

