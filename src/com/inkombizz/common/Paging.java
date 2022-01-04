/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.inkombizz.common;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;

/**
 *
 * @author laptop_05
 */
public class Paging {

    private Integer rows = 0;
    private Integer page = 0;
    private String sord = "asc";
    private String sidx;
    private String searchField;
    private String searchString;
    //['eq','ne','lt','le','gt','ge','bw','bn','in','ni','ew','en','cn','nc']
    private String searchOper;
    private Integer total = 0;
    private Integer records = 0;

    public Integer getRows() {
        return rows;
    }
    public void setRows(Integer rows) {
        this.rows = rows;
    }

    public Integer getPage() {
        return page;
    }
    public void setPage(Integer page) {
        this.page = page;
    }

    public Integer getTotal() {
        return total;
    }
    public void setTotal(Integer total) {
        this.total = total;
    }

    public Integer getRecords() {
        return records;
    }
    public void setRecords(Integer records) {
        this.records = records;

        if (this.records > 0 && this.rows > 0)
            this.total = (int) Math.ceil((double) this.records / (double) this.rows);
        else
            this.total = 0;
    }

    public String getSord() {
        return sord;
    }
    public void setSord(String sord) {
        this.sord = sord;
    }

    public String getSidx() {
        return sidx;
    }
    public void setSidx(String sidx) {
        this.sidx = sidx;
    }

    public void setSearchField(String searchField) {
        this.searchField = searchField;
    }
    public void setSearchString(String searchString) {
        this.searchString = searchString;
    }
    public void setSearchOper(String searchOper) {
        this.searchOper = searchOper;
    }

    // </editor-fold>

// </editor-fold>

// <editor-fold defaultstate="collapsed" desc="PUBLIC METHOD">
    public int getToRow() {
        int to = this.getRows() * this.getPage();
        
        if (to==0) {
            return this.getRows();
        }

        if (to > this.records)
            return this.records;
        else
            return to;
    }

    public int getFromRow() {
        if (this.getRows() == 0)
            return 0;
        
        int to = getToRow();
        if (to == this.records) {
            return to - (to - this.getRows() * (this.getPage()-1));
        }
        else
            return to - this.getRows();
    }

    public DetachedCriteria addOrderCriteria(DetachedCriteria criteria) {
        // Handle Order By
	if (this.getSidx() != null && !this.getSidx().equals("")) {
            if (this.getSord().equals("asc")) criteria.addOrder(Order.asc(this.getSidx()));
            else criteria.addOrder(Order.desc(this.getSidx()));
	}

	return criteria;
    }
// </editor-fold>

}
