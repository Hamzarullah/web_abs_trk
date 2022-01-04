
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
    #moduleInput_grid_pager_center{
        display: none;
    }
</style>
<script type="text/javascript">
    
    var module_lastSel = -1, module_lastRowId = 0;
        
    $(document).ready(function() {

        $.subscribe("moduleInput_grid_onSelect", function(event, data) {

           var selectedRowID = $("#moduleInput_grid").jqGrid("getGridParam", "selrow");

           if(selectedRowID!==module_lastSel) {
               $('#moduleInput_grid').jqGrid("saveRow",module_lastSel); 
               $('#moduleInput_grid').jqGrid("editRow",selectedRowID,true); 
               module_lastSel=selectedRowID;
           }
           else
               $('#moduleInput_grid').jqGrid("saveRow",selectedRowID);

        });
            
        $('#btnModuleSave').click(function(ev) {
            if(module_lastSel !== -1) {
                $('#moduleInput_grid').jqGrid("saveRow",module_lastSel); 
            }

            var listModule = new Array();
            var ids = jQuery("#moduleInput_grid").jqGrid('getDataIDs'); 

            for(var i=0;i < ids.length;i++){ 
                var module_data = $("#moduleInput_grid").jqGrid('getRowData',ids[i]); 
                
                if(module_data.moduleBranchCode===""){
                    alertMessage("Branch Can't Empty!");
                    return;
                }
                
                if(module_data.moduleCompanyCode===""){
                    alertMessage("Company Can't Empty!");
                    return;
                }
                
                var module = {
                    code                : module_data.code,
                    branch              : {code:module_data.moduleBranchCode},
                    company             : {code:module_data.moduleCompanyCode}                   
                };

                listModule[i] = module;
            }
            
            var url = "system/module-update";            
            var params = "listModuleJSON=" + $.toJSON(listModule);
            showLoading();

            $.post(url, params, function(data) {
                closeLoading();
                if (data.error) {
                    alert(data.errorMessage);
                    return;
                }

                alertMessage(data.message);
                var url = "system/module";
                var params = "";
                pageLoad(url, params, "#tabmnuMODULE");
            });

            ev.preventDefault();
        });

        $('#btnModuleCancel').click(function(ev) {            
            var url = "system/module";
            var params = "";
            pageLoad(url, params, "#tabmnuMODULE"); 
        });
        
        moduleLoadData();
    });
    
    function moduleLoadData() {
        var url = "system/module-for-update-data";
        var params = "";

        showLoading();
        $.post(url, params, function(data) {
            closeLoading();
            module_lastRowId = 0;
            
            for (var i=0; i<data.listModuleTemp.length; i++) {
                module_lastRowId++;
                $("#moduleInput_grid").jqGrid("addRowData", module_lastRowId, data.listModuleTemp[i]);
                $("#moduleInput_grid").jqGrid('setRowData', module_lastRowId,{
                    code                : data.listModuleTemp[i].code,
                    name                : data.listModuleTemp[i].name,
                    activeStatus        : data.listModuleTemp[i].activeStatus,
                    moduleBranchCode    : data.listModuleTemp[i].branchCode,
                    moduleBranchName    : data.listModuleTemp[i].branchName,
                    moduleCompanyCode   : data.listModuleTemp[i].companyCode,
                    moduleCompanyName   : data.listModuleTemp[i].companyName,
                    moduleInputStatus   : data.listModuleTemp[i].moduleInputStatus,
                    createdBy           : data.listModuleTemp[i].createdBy,
                    createdDate         : data.listModuleTemp[i].createdDate
                });
            }

        });
    }
    
    function onChangeModuleBranch(){
        var selectedRowID = $("#moduleInput_grid").jqGrid("getGridParam", "selrow");
        var branchCode = $("#" + selectedRowID + "_moduleBranchCode").val();

        var url = "master/branch-get";
        var params = "branch.code=" + branchCode;
            params += "&branch.activeStatus=TRUE";

        if(branchCode===""){
            $("#moduleInput_grid").jqGrid("setCell", selectedRowID,"moduleBranchName"," ");                
            return;
        }

        $.post(url, params, function(result) {
            var data = (result);
            if (data.branchTemp){
                $("#" + selectedRowID + "_moduleBranchCode").val(data.branchTemp.code);
                $("#moduleInput_grid").jqGrid("setCell", selectedRowID,"moduleBranchName",data.branchTemp.name);
            }
            else{
                alertMessage("Branch Not Found!",$("#" + selectedRowID + "_moduleBranchCode"));
                $("#" + selectedRowID + "_moduleBranchCode").val("");
                $("#moduleInput_grid").jqGrid("setCell", selectedRowID,"moduleBranchName"," ");
            }
        });
    }
    
    function onChangeModuleCompany(){
        var selectedRowID = $("#moduleInput_grid").jqGrid("getGridParam", "selrow");
        var companyCode = $("#" + selectedRowID + "_moduleCompanyCode").val();

        var url = "master/company-get";
        var params = "company.code=" + companyCode;
            params += "&company.activeStatus=TRUE";

        if(companyCode===""){
            $("#moduleInput_grid").jqGrid("setCell", selectedRowID,"moduleCompanyName"," ");                
            return;
        }

        $.post(url, params, function(result) {
            var data = (result);
            if (data.companyTemp){
                $("#" + selectedRowID + "_moduleCompanyCode").val(data.companyTemp.code);
                $("#moduleInput_grid").jqGrid("setCell", selectedRowID,"moduleCompanyName",data.companyTemp.name);
            }
            else{
                alertMessage("Company Not Found!",$("#" + selectedRowID + "_moduleCompanyCode"));
                $("#" + selectedRowID + "_moduleCompanyCode").val("");
                $("#moduleInput_grid").jqGrid("setCell", selectedRowID,"moduleCompanyName"," ");
            }
        });
    }
    
    function moduleInputGrid_SearchBranch_OnClick(){
        window.open("./pages/search/search-branch.jsp?iddoc=module&idsubdoc=Branch&type=grid","Search", "scrollbars=1,width=600, height=500");
    }

    function moduleInputGrid_SearchCompany_OnClick(){
        window.open("./pages/search/search-company.jsp?iddoc=module&idsubdoc=Company&type=grid","Search", "scrollbars=1,width=600, height=500");
    }
        
</script>

<s:url id="remotedetailurlModuleInput" action="" />
<b>MODULE</b>
<hr>
<br class="spacer" />
<div id="moduleInput" class="content ui-widget">
    <s:form id="frmModuleInput">
        <br class="spacer" />
        <div id="moduleInputGrid">
            <sjg:grid
                id="moduleInput_grid"
                dataType="local"
                pager="true"
                navigator="false"
                navigatorView="false"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                gridModel="listModuleTemp"
                rowNum="10000"
                viewrecords="true"
                rownumbers="true"
                shrinkToFit="false"
                width="$('#tabmnumodule').width()"
                editinline="true"
                editurl="%{remotedetailurlModuleInput}"
                onSelectRowTopics="moduleInput_grid_onSelect"
                >
                <sjg:gridColumn
                    name="code" index="code" key="code" title="Code" width="300" sortable="true" hidden="true"
                />
                <sjg:gridColumn
                    name="name" index="name" key="name" title="Name" width="400" sortable="true" 
                />
                <sjg:gridColumn
                    name="mouduleBranchSearch" index="mouduleBranchSearch" title="" width="25" align="centre"
                    editable="true" dataType="html" edittype="button"  
                    editoptions="{onClick:'moduleInputGrid_SearchBranch_OnClick()', value:'...'}"
                />
                <sjg:gridColumn
                    name="moduleBranchCode" index="moduleBranchCode" key="moduleBranchCode" title="BranchCode" width="100" sortable="true"  editable="true"
                    editoptions="{onChange:'onChangeModuleBranch()'}"
                />
                <sjg:gridColumn
                    name="moduleBranchName" index="moduleBranchName" key="moduleBranchName" title="Branch Name" width="200" sortable="true" 
                />
                <sjg:gridColumn
                    name="mouduleCompanySearch" index="mouduleCompanySearch" title="" width="25" align="centre"
                    editable="true" dataType="html" edittype="button"  
                    editoptions="{onClick:'moduleInputGrid_SearchCompany_OnClick()', value:'...'}"
                />
                <sjg:gridColumn
                    name="moduleCompanyCode" index="moduleCompanyCode" key="moduleCompanyCode" title="Company Code" width="100" sortable="true" editable="true"
                    editoptions="{onChange:'onChangeModuleCompany()'}"
                />
                <sjg:gridColumn
                    name="moduleCompanyName" index="moduleCompanyName" key="moduleCompanyName" title="Company Name" width="200" sortable="true" 
                />
            </sjg:grid>
        </div>
        <br class="spacer" />
        <sj:a href="#" id="btnModuleSave" button="true">Save</sj:a>
        <sj:a href="#" id="btnModuleCancel" button="true">Cancel</sj:a>
        <br class="spacer" />
    </s:form>
</div>

