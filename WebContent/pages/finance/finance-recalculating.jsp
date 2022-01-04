<%-- 
    Document   : payment-recalculating
    Created on : Nov 6, 2019, 11:42:34 PM
    Author     : Rayis
--%>


<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
    
    $(document).ready(function(){
        hoverButton();
        
        $('#btnFinanceRecalculatingProses').click(function(ev) {
            if (confirm("Are You Sure To Process Recalculating?")) {
                var url = "finance/finance-recalculating-process";
                var params="";

                showLoading();
                $.post(url, params, function(data) {
                    closeLoading();
                    if (data.error) {
                        alertMessage(data.errorMessage);
                        return;
                    }else {
                        alertMessage(data.message);
                    }
                });
            }
        });
        
    });
       
</script>
    
    <b>FINANCE RECALCULATING</b>
    <hr/>
    <br class="spacer" />

    <div id="automaticPostingInputSearch" class="content ui-widget">
        <s:form id="frmAutomaticPostingProcess">
            <br />
            <sj:a href="#" id="btnFinanceRecalculatingProses" button="true">Process</sj:a>
            <br />
        </s:form>
    </div>
    <br /><br />
