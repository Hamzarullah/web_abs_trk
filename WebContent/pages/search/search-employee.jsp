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
    <link href="../../css/pagestyle.css" rel="stylesheet" type="text/css" />
    <style>
        html {
            overflow: scroll;
        }
    </style>
<script type = "text/javascript">
    
    var search_employee_type= '<%= request.getParameter("type") %>';
    var id_document = '<%= request.getParameter("iddoc") %>';
    var id_subdoc= '<%= request.getParameter("idsubdoc") %>';
    
    jQuery(document).ready(function(){  
        
        $("#btn_dlg_EmployeeSearch").click(function(ev) {
            $("#dlgSearch_employee_grid").jqGrid("setGridParam",{url:"master/employee-data?" + $("#frmEmployeeSearch").serialize(), page:1});
            $("#dlgSearch_employee_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#dlgEmployee_okButton").click(function(ev) {
            selectedRowId = $("#dlgSearch_employee_grid").jqGrid("getGridParam","selrow");
        
            if(selectedRowId === null){
                alert("Please Select Row Employee!");
                return;
            }

            var data_search_employee = $("#dlgSearch_employee_grid").jqGrid('getRowData', selectedRowId);

            if (search_employee_type === "grid" ) {
                var selectedRowID = $("#"+id_document+"Input_grid",opener.document).jqGrid("getGridParam", "selrow");
                $("#"+selectedRowID+"_"+id_document+"EmployeeCode",opener.document).val(data_search_employee.code);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"EmployeeName", data_search_employee.name);            
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"EmployeeEmail", data_search_employee.email);            
            }
            else {
                $("#"+id_document+"\\."+id_subdoc+"\\.code",opener.document).val(data_search_employee.code);
                $("#"+id_document+"\\."+id_subdoc+"\\.name",opener.document).val(data_search_employee.name);
                $("#"+id_document+"\\."+id_subdoc+"\\.address",opener.document).val(data_search_employee.address);
                $("#"+id_document+"\\."+id_subdoc+"\\.zipCode",opener.document).val(data_search_employee.zipCode);
                $("#"+id_document+"\\."+id_subdoc+"\\.city\\.code",opener.document).val(data_search_employee.cityCode);
                $("#"+id_document+"\\."+id_subdoc+"\\.city\\.name",opener.document).val(data_search_employee.cityName);
                $("#"+id_document+"\\."+id_subdoc+"\\.city\\.province\\.island\\.country\\.code",opener.document).val(data_search_employee.countryCode);
                $("#"+id_document+"\\."+id_subdoc+"\\.city\\.province\\.island\\.country\\.name",opener.document).val(data_search_employee.countryName);
                $("#"+id_document+"\\."+id_subdoc+"\\.phone",opener.document).val(data_search_employee.phone);
                $("#"+id_document+"\\."+id_subdoc+"\\.mobileNo1",opener.document).val(data_search_employee.mobileNo1);
                $("#"+id_document+"\\."+id_subdoc+"\\.mobileNo2",opener.document).val(data_search_employee.mobileNo2);
                $("#"+id_document+"\\."+id_subdoc+"\\.phone1",opener.document).val(data_search_employee.phone);
                $("#"+id_document+"\\."+id_subdoc+"\\.phone2",opener.document).val(data_search_employee.mobileNo1);
                $("#"+id_document+"\\."+id_subdoc+"\\.email",opener.document).val(data_search_employee.email);
                $("#"+id_document+"\\."+id_subdoc+"\\.fax",opener.document).val(data_search_employee.fax);
                $("#"+id_document+"\\.employee\\.code",opener.document).val(data_search_employee.code);
                $("#"+id_document+"\\.employee\\.name",opener.document).val(data_search_employee.name);
                
                if(id_document==="driver" || id_document==="coDriver"){
                    $("#"+id_document+"\\.name",opener.document).val(data_search_employee.name); 
                    $("#"+id_document+"\\.address",opener.document).val(data_search_employee.address);
                    $("#"+id_document+"\\.zipCode",opener.document).val(data_search_employee.zipCode);
                    $("#"+id_document+"\\.city\\.code",opener.document).val(data_search_employee.cityCode);
                    $("#"+id_document+"\\.city\\.name",opener.document).val(data_search_employee.cityName);
                    $("#"+id_document+"\\.city\\.province\\.island\\.country\\.code",opener.document).val(data_search_employee.countryCode);
                    $("#"+id_document+"\\.city\\.province\\.island\\.country\\.name",opener.document).val(data_search_employee.countryName);
                    $("#"+id_document+"\\.phone1",opener.document).val(data_search_employee.phone);
                    $("#"+id_document+"\\.phone2",opener.document).val(data_search_employee.mobileNo1);
                    $("#"+id_document+"\\.email",opener.document).val(data_search_employee.email);
                    $("#"+id_document+"\\.fax",opener.document).val(data_search_employee.fax);
                }
            }

            window.close();
        });
        
        $("#dlgEmployee_cancelButton").click(function(ev) {
            window.close();
        });
        
    });    
    
</script>
<body>
<s:url id="remoteurlEmployeeSearch" action="" />

    <div class="ui-widget">
        <s:form id="frmEmployeeSearch">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right">Code</td>
                <td><s:textfield id="employeeSearchCode" name="employeeSearchCode" label="Code"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">Name</td>
                <td><s:textfield id="employeeSearchName" name="employeeSearchName" size="50" label="Name"></s:textfield></td>
            </tr>
            <tr>
                <td colspan="2"><sj:a href="#" id="btn_dlg_EmployeeSearch" button="true">Search</sj:a></td>
            </tr>
            <td align="right">
                    <s:textfield id="employeeSearchActiveStatus" name="employeeSearchActiveStatus" readonly="false" size="5" style="display:none" value="true"></s:textfield>
            </td>
        </table>
        </s:form>
    </div>
    
    <div class="ui-widget ui-widget-content">
        <sjg:grid
            id="dlgSearch_employee_grid"
            dataType="json"
            href="%{remoteurlEmployeeSearch}"
            pager="true"
            navigator="true"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            navigatorSearch="false"
            gridModel="listEmployeeTemp"
            rowList="10,20,30"
            rowNum="10"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnuemployee').width()"
        >
            <sjg:gridColumn
                name="code" index="code" key="code" title="Code" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="name" index="name" title="Name" width="300" sortable="true"
            />
            <sjg:gridColumn
                name="address" index="address" title="Address" width="300" sortable="true"
            />
            <sjg:gridColumn
                name="zipCode" index="zipCode" title="ZipCode" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="cityCode" index="cityCode" title="City Code" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="cityName" index="cityName" title="City Name" width="200" sortable="true"
            />
            <sjg:gridColumn
                name="countryCode" index="countryCode" title="Country" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="countryName" index="countryName" title="Country" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="phone" index="phone" title="Phone" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="mobileNo1" index="mobileNo1" title="MobileNo 1" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="mobileNo2" index="mobileNo2" title="MobileNo 2" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="zipCode" index="zipCode" title="ZipCode" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="email" index="email" title="Email" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="fax" index="fax" title="Fax" width="100" sortable="true"
            />
             <sjg:gridColumn
                name="employeeCode" index="employeeCode" title="Employee Code" width="150" sortable="true"
            />
           <sjg:gridColumn
                name="employeeName" index="employeeName" title="Employee Name" width="150" sortable="true"
            />
            <sjg:gridColumn
                name="activeStatus" index="activeStatus" title="Active" width="50" formatter="checkbox" align="center"
            />       
        </sjg:grid >
        
    </div>
<br></br>
    <sj:a href="#" id="dlgEmployee_okButton" button="true">Ok</sj:a>
    <sj:a href="#" id="dlgEmployee_cancelButton" button="true">Cancel</sj:a>
</body>
</html>