package com.inkombizz.security.model;

import java.io.Serializable;
import java.util.List;

public class MenuTree implements Serializable {
    private String code;
    private String text;
    private String classes;
    private String parentCode;
    private String link;
    private List<MenuTree> children;
    private Double sortNo;
            
    public String getCode() {
            return code;
    }
    public void setCode(String code) {
            this.code = code;
    }

    public String getText() {
            return text;
    }
    public void setText(String text) {
            this.text = text;
    }

    public String getClasses() {
            return classes;
    }
    public void setClasses(String classes) {
            this.classes = classes;
    }

    public String getParentCode() {
            return parentCode;
    }
    public void setParentCode(String parentCode) {
            this.parentCode = parentCode;
    }

    public List<MenuTree> getChildren() {
            return children;
    }
    public void setChildren(List<MenuTree> children) {
            this.children = children;
    }

    public String getLink() {
            return link;
    }
    public void setLink(String link) {
            this.link = link;
    }

    public Double getSortNo() {
        return sortNo;
    }

    public void setSortNo(Double sortNo) {
        this.sortNo = sortNo;
    }
    
    public void addChildren(List<MenuTree> children){
        this.children.addAll(children);
    }
}