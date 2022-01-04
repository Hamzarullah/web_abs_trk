/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.inkombizz.dao;

import com.googlecode.s2hibernate.struts2.plugin.annotations.SessionTarget;
import com.googlecode.s2hibernate.struts2.plugin.annotations.TransactionTarget;
import org.hibernate.Session;
import org.hibernate.Transaction;
/**
 *
 * @author laptop_05
 */
public class HBMSession {
    @SessionTarget
    public Session       hSession;

    @TransactionTarget
    public Transaction   hTransaction;
}
