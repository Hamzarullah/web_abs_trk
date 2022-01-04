<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">        
    <sj:head
        loadAtOnce="true"
        compressed="false"
        jqueryui="true"
        jquerytheme="cupertino"
        loadFromGoogle="false"
        debug="true" />

    <script type="text/javascript" src="../../js/jquery.layout.js"></script>
    <script type="text/javascript" src="../../js/jquery_ready.js"></script>
    <script type="text/javascript" src="../../js/jquery.block.ui.js"></script>
    <script type="text/javascript" src="../../js/jquery.json-2.2.min.js"></script>
    <script type="text/javascript" src="../../js/jquery.validate.min.js"></script>

    <link href="../../css/mainstyle.css" rel="stylesheet" type="text/css" />
    
    <style>
        html {
            overflow-x: hidden;
            overflow-y: auto;
            overflow: scroll;
            /*overflow: -moz-scrollbars-vertical;*/
        }
        input{border-radius: 3px;height:18px}
    </style>
    
<script type = "text/javascript">
    
    var search_reason_type= '<%= request.getParameter("type") %>';
    var id_document = '<%= request.getParameter("iddoc") %>';
    var id_subdoc= '<%= request.getParameter("idsubdoc") %>';
        
    jQuery(document).ready(function(){  
        
        $("#dlgReason_okButton").click(function(ev) { 
            
            selectedRowId = $("#dlgSearch_reason_grid").jqGrid("getGridParam","selrow");

            if(selectedRowId === null){
                alert("Please Select Row Reason!");
                return;
            }

            var data_search_reason = $("#dlgSearch_reason_grid").jqGrid('getRowData', selectedRowId);

            if (search_reason_type === "grid" ) {
                var selectedRowID = $("#"+id_document+"Input_grid",opener.document).jqGrid("getGridParam", "selrow");
                $("#"+selectedRowID+"_"+id_document+"ReasonCode",opener.document).val(data_search_reason.code);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ReasonName", data_search_reason.name);           
            }
            else {
                $("#"+id_document+"\\."+id_subdoc+"\\.code",opener.document).val(data_search_reason.code);
                $("#"+id_document+"\\."+id_subdoc+"\\.name",opener.document).val(data_search_reason.name);
                }

            window.close();
        });


        $("#dlgReason_cancelButton").click(function(ev) { 
            data_search_reason = null;
            window.close();
        });
    
    
        $("#btn_dlg_ReasonSearch").click(function(ev) {
            $("#dlgSearch_reason_grid").jqGrid("setGridParam",{url:"master/reason-data?" + $("#frmReasonSearch").serialize(), page:1});
            $("#dlgSearch_reason_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        
     });
    
</script>
    
<body>
<s:url id="remoteurlReasonSearch" action="" />
        <div class="ui-widget">
            <s:form id="frmReasonSearch">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right">Code</td>
                    <td><s:textfield id="reasonSearchCode" name="reasonSearchCode" label="Code "></s:textfield></td>
                </tr>
                <tr>
                    <td align="right">Name</td>
                    <td><s:textfield id="reasonSearchName" name="reasonSearchName" size="50"></s:textfield></td>
                </tr>
                <tr>
                    <td colspan="2"><sj:a href="#" id="btn_dlg_ReasonSearch" button="true">Search</sj:a></td>
                </tr>
                <td align="right">
                    <s:textfield id="reasonSearchActiveStatus" name="reasonSearchActiveStatus" readonly="false" size="5" style="display:none" value="true"></s:textfield>
                </td>
            </table>
            </s:form>
        </div>

        <div class="ui-widget ui-widget-content">
            <sjg:grid
                id="dlgSearch_reason_grid"
                dataType="json"
                href="%{remoteurlReasonSearch}"
                pager="true"
                navigator="true"
                navigatorView="false"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                navigatorSearch="false"
                gridModel="listReasonTemp"
                rowList="10,20,30"
                rowNum="10"
                viewrecords="true"
                rownumbers="true"
                shrinkToFit="false"
                width="$('#tabmnureason').width()"
            >
                <sjg:gridColumn
                    name="code" index="code" key="code" title="Code" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="name" index="name" title="Name" width="150" sortable="true"
                />
                <sjg:gridColumn
                    name="activeStatus" index="activeStatus" title="Active" width="50" formatter="checkbox" align="center"
                />
            </sjg:grid >

        </div>
            <br/>
            <br/>

            <sj:a href="#" id="dlgReason_okButton" button="true">Ok</sj:a>
            <sj:a href="#" id="dlgReason_cancelButton" button="true">Cancel</sj:a>
            
    </body>
</html>