package com.inkombizz.master.bll;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.common.enumeration.EnumTriState.Enum_TriState;
import com.inkombizz.master.dao.PriceTypeDAO;
import com.inkombizz.master.model.PriceType;
import com.inkombizz.master.model.PriceTypeField;
import com.inkombizz.master.model.PriceTypeTemp;
import org.hibernate.criterion.Restrictions;

public class PriceTypeBLL {
    public static final String MODULECODE = "006_MST_PRICE_TYPE";
    
    private PriceTypeDAO priceTypeDAO;
    
    public PriceTypeBLL(HBMSession hbmSession) {
        this.priceTypeDAO = new PriceTypeDAO(hbmSession);
    }
    public ListPaging<PriceTypeTemp> findSearchData(Paging paging,String code, String name,String active) throws Exception {
        try {

            paging.setRecords(priceTypeDAO.countSearchData(code,name,active));
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<PriceTypeTemp> listPriceTypeTemp = priceTypeDAO.findSearchData(code,name,active,paging.getFromRow(), paging.getToRow());
            
            ListPaging<PriceTypeTemp> listPaging = new ListPaging<PriceTypeTemp>();
            
            listPaging.setList(listPriceTypeTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    } 
    public ListPaging<PriceType> get(Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(PriceType.class);

            paging.setRecords(priceTypeDAO.countByCriteria(criteria));

            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria = paging.addOrderCriteria(criteria);

            paging.setTotal( (int) Math.ceil((double) paging.getRecords()  / (double) paging.getRows()) );

            List<PriceType> listPriceType = priceTypeDAO.findByCriteria(criteria, paging.getFromRow(), paging.getToRow());

            ListPaging<PriceType> listPaging = new ListPaging<PriceType>();

            listPaging.setList(listPriceType);
            listPaging.setPaging(paging);

                return listPaging;
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public ListPaging<PriceType> search(Paging paging, String code, String name, Enum_TriState activeStatus) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(PriceType.class)
                    .add(Restrictions.like(PriceTypeField.CODE, code + "%" ))
                    .add(Restrictions.like(PriceTypeField.NAME, "%" + name + "%"));
            
            if (activeStatus == activeStatus.YES)
                criteria.add(Restrictions.eq(PriceTypeField.ACTIVESTATUS, true));
            else if (activeStatus == activeStatus.NO)
                criteria.add(Restrictions.eq(PriceTypeField.ACTIVESTATUS, false));
            
            paging.setRecords(priceTypeDAO.countByCriteria(criteria));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria = paging.addOrderCriteria(criteria);
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<PriceType> listPriceType = priceTypeDAO.findByCriteria(criteria, paging.getFromRow(), paging.getToRow());
            
            ListPaging<PriceType> listPaging = new ListPaging<PriceType>();
            
            listPaging.setList(listPriceType);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<PriceType> getList() throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(PriceType.class);
            List<PriceType> listPriceType = priceTypeDAO.findByCriteria(criteria);
            return listPriceType;
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public PriceType get(String id) throws Exception {
        try {
            return (PriceType) priceTypeDAO.get(id);
        }
        catch (Exception e) {
            throw e;
        }
    }

    public void save(PriceType priceType) throws Exception {
        try {
            priceTypeDAO.save(priceType, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }

    public void update(PriceType priceType) throws Exception {
        try {
            priceTypeDAO.update(priceType, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }

    public void delete(String id) throws Exception {
        try {
            priceTypeDAO.delete(id, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }

    public PriceTypeDAO getPriceTypeDAO() {
        return priceTypeDAO;
    }

    public void setPriceTypeDAO(PriceTypeDAO priceTypeDAO) {
        this.priceTypeDAO = priceTypeDAO;
    }
    
}