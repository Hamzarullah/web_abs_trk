package com.inkombizz.master.bll;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.common.enumeration.EnumTriState.Enum_TriState;
import com.inkombizz.master.dao.DistributionChannelDAO;
import com.inkombizz.master.model.DistributionChannel;
import com.inkombizz.master.model.DistributionChannelField;
import com.inkombizz.master.model.DistributionChannelTemp;
import org.hibernate.criterion.Restrictions;

public class DistributionChannelBLL {
    public static final String MODULECODE = "006_MST_DISTRIBUTION_CHANNEL";
    
    private DistributionChannelDAO distributionChannelDAO;
    
    public DistributionChannelBLL(HBMSession hbmSession) {
        this.distributionChannelDAO = new DistributionChannelDAO(hbmSession);
    }
    public ListPaging<DistributionChannelTemp> findSearchData(Paging paging,String code, String name,String active) throws Exception {
        try {

            paging.setRecords(distributionChannelDAO.countSearchData(code,name,active));
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<DistributionChannelTemp> listDistributionChannelTemp = distributionChannelDAO.findSearchData(code,name,active,paging.getFromRow(), paging.getToRow());
            
            ListPaging<DistributionChannelTemp> listPaging = new ListPaging<DistributionChannelTemp>();
            
            listPaging.setList(listDistributionChannelTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    } 
    public ListPaging<DistributionChannel> get(Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(DistributionChannel.class);

            paging.setRecords(distributionChannelDAO.countByCriteria(criteria));

            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria = paging.addOrderCriteria(criteria);

            paging.setTotal( (int) Math.ceil((double) paging.getRecords()  / (double) paging.getRows()) );

            List<DistributionChannel> listDistributionChannel = distributionChannelDAO.findByCriteria(criteria, paging.getFromRow(), paging.getToRow());

            ListPaging<DistributionChannel> listPaging = new ListPaging<DistributionChannel>();

            listPaging.setList(listDistributionChannel);
            listPaging.setPaging(paging);

                return listPaging;
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public ListPaging<DistributionChannel> search(Paging paging, String code, String name, Enum_TriState activeStatus) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(DistributionChannel.class)
                    .add(Restrictions.like(DistributionChannelField.CODE, code + "%" ))
                    .add(Restrictions.like(DistributionChannelField.NAME, "%" + name + "%"));
            
            if (activeStatus == activeStatus.YES)
                criteria.add(Restrictions.eq(DistributionChannelField.ACTIVESTATUS, true));
            else if (activeStatus == activeStatus.NO)
                criteria.add(Restrictions.eq(DistributionChannelField.ACTIVESTATUS, false));
            
            paging.setRecords(distributionChannelDAO.countByCriteria(criteria));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria = paging.addOrderCriteria(criteria);
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<DistributionChannel> listDistributionChannel = distributionChannelDAO.findByCriteria(criteria, paging.getFromRow(), paging.getToRow());
            
            ListPaging<DistributionChannel> listPaging = new ListPaging<DistributionChannel>();
            
            listPaging.setList(listDistributionChannel);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<DistributionChannel> getList() throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(DistributionChannel.class);
            List<DistributionChannel> listDistributionChannel = distributionChannelDAO.findByCriteria(criteria);
            return listDistributionChannel;
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public DistributionChannel get(String id) throws Exception {
        try {
            return (DistributionChannel) distributionChannelDAO.get(id);
        }
        catch (Exception e) {
            throw e;
        }
    }

    public void save(DistributionChannel distributionChannel) throws Exception {
        try {
            distributionChannelDAO.save(distributionChannel, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }

    public void update(DistributionChannel distributionChannel) throws Exception {
        try {
            distributionChannelDAO.update(distributionChannel, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }

    public void delete(String id) throws Exception {
        try {
            distributionChannelDAO.delete(id, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }

    public DistributionChannelDAO getDistributionChannelDAO() {
        return distributionChannelDAO;
    }

    public void setDistributionChannelDAO(DistributionChannelDAO distributionChannelDAO) {
        this.distributionChannelDAO = distributionChannelDAO;
    }
    
}