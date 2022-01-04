/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.inkombizz.common;

import java.util.List;

/**
 *
 * @author laptop_05
 */
public class ListPaging<C> {
    private Paging paging;
    private List<C> list;

    public List<C> getList() {
        return list;
    }

    public void setList(List<C> list) {
        this.list = list;
    }

    public Paging getPaging() {
        return paging;
    }

    public void setPaging(Paging paging) {
        this.paging = paging;
    }


}
