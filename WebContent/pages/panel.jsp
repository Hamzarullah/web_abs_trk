<%@page import="com.inkombizz.action.BaseSession"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>
<%@ taglib prefix="sjt" uri="/struts-jquery-tree-tags"%>

<%
    if (session.getAttribute("ProgramSession") == null)
        response.sendRedirect("login");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title><%= BaseSession.loadProgramSession().getSetup().getWebTitle() %></title>

    <sj:head
            loadAtOnce="true"
            compressed="false"
            jqueryui="true"
            jquerytheme="cupertino"
            loadFromGoogle="false"
            debug="true" />
	
    <script type="text/javascript" src="<s:url value="/js/jquery.layout.js" />"></script>
    <script type="text/javascript" src="<s:url value="/js/jquery.cookie.js" />"></script>
    <script type="text/javascript" src="<s:url value="/js/jquery.treeview.js" />"></script>
    <script type="text/javascript" src="<s:url value="/js/jquery.treeview.async.js" />"></script>
    <script type="text/javascript" src="<s:url value="/js/autoNumeric.min.js" />"></script>
    <script type="text/javascript" src="<s:url value="/js/jquery_ready.js" />"></script>
    <script type="text/javascript" src="<s:url value="/js/jquery.block.ui.js" />"></script>
    <script type="text/javascript" src="<s:url value="/js/function.js" />"></script>
    <script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>

    <link href="css/mainstyle.css" rel="stylesheet" type="text/css" />
    <link href="css/jquery.treeview.css" rel="stylesheet" type="text/css" />
    <link rel="shortcut icon" href="<s:url value="/images/logo_trk.png" />"></link>
    <style>
        #browser li ul {
            display: none;
        }
        .ui-dialog-titlebar-close{
            visibility: hidden;
        }
        .my-error-class {
            color:#FF0000;  /* red */
        }
        .my-valid-class {
            color:#000000; /* black */
        }

        textarea.my-error-class {
            border: 1px solid red;
        }
        input.my-error-class {
            border: 1px solid red;
        }
    </style>
    
     <script type="text/javascript">
        var intervalId;
        var regexSpecialCharacter= /^[a-zA-Z0-9\n ,\._-]+$/g;
        var notAllowedCharacter="<br/><br/><br/><font style='color:red;font:icon'>Not Alowed Character:<br/>` ~ ! @ # $ % ^ & * ( ) + = {}[] | ' /\ : ? <><br/>Tab, Backslash, double quotation<font>";
        
        jQuery(document).ready(function(){ 
            
            // cek kalo usernamenya null
                var usrNameNow = '<%= BaseSession.loadProgramSession().getUserName()%>';
                if (usrNameNow === "null") {
                    var url = "session-expired-data";
                    var params = "";
                    $.post(url, params, function(data) {
                        //do nothing
                        alertExpired("Your Session has been Expired!");
                    });
                    return;
                }
                
                var IDLE_TIMEOUT = 3600; //seconds
//                var IDLE_TIMEOUT = 300; //seconds
                var _idleSecondsCounter = 0;
                document.onclick = function () {
                    _idleSecondsCounter = 0;
                };
                document.onmousemove = function () {
                    _idleSecondsCounter = 0;
                };
                document.onkeypress = function () {
                    _idleSecondsCounter = 0;
                };

                //cek idle
                intervalId = window.setInterval(CheckIdleTime, 1000);
                
                function CheckDoubleLogin() {
                    
                    var lgnUsername = '<%= BaseSession.loadProgramSession().getUserName()%>';
                    var url = "security/user-double-login";
                    var params = "username=" + lgnUsername;

                    $.post(url, params, function(data) {
                        if (data.error) {
                            alertMessage(data.errorMessage);

                            var url2 = "session-expired-data";
                            var params2 = "username=" + lgnUsername;
                            $.post(url2, params2, function(data) {
                                // do nothing
                                document.getElementById('btnSignOut').click();
                            });
                            return;
                        }
                    });
                }

                function CheckIdleTime() {
                    _idleSecondsCounter++;
                    var oPanel = document.getElementById("SecondsUntilExpire");
                    if (oPanel)
                        oPanel.innerHTML = (IDLE_TIMEOUT - _idleSecondsCounter) + "";
                    if (_idleSecondsCounter >= IDLE_TIMEOUT) {
                        window.clearInterval(intervalId);
                        
                        var url = "session-expired-data";
                        var params = "";
                        $.post(url, params, function(data) {
                            //do nothing
                            alertExpired("Your Session has been Expired!");
                        });
                        return;
                        
                    }else {
//                        CheckDoubleLogin();
                    }
                }
            
            $('body').layout({
                south__resizable: false
            });
            
            $(".hasDatepicker").datepicker({dateFormat:"yy-mm-dd"});
            
            $("#browser").treeview({
            	collapsed: true,
            	animated: "fast",
                persist: "location",
                url: "menu-json"
            });

            var maintab = jQuery('#tabs','#RightPane').tabs({
                add: function(e, ui) {
                    // append close thingy
                    $(ui.tab).parents('li:first')
                        .append('<span class="ui-tabs-close ui-icon ui-icon-close" title="Close Tab"></span>')
                        .find('span.ui-tabs-close')
                        .click(function() {
                            maintab.tabs('remove', $('li', maintab).index($(this).parents('li:first')[0]));
                        });
                    // select just added tab
                    maintab.tabs('select', '#' + ui.panel.id);
                }
            });

            
            $("span.file a", "#browser li").live('click', function(ev){
                ev.preventDefault();
				
                var st = "#tab"+ this.id;

                if($(st).html() != null ) {
                    maintab.tabs('select',st);
                } else {
                    showLoading();
                    maintab.tabs('add', st, this.innerHTML);
                    $(st,"#tabs").load(this.href, function(){
                        closeLoading();
                    });
                } 
//                if($(st).html() != null && this.id == $("#tabscontenttext").val()) {
//                    maintab.tabs('select',st);
//                } else {
//                    $("#tabscontenttext").val(this.id);
//                    maintab.tabs('remove', $('li', maintab).index($(this).parents('li:first')[0]));
//                    showLoading();
//                    maintab.tabs('add', st, this.innerHTML);
//                    $(st,"#tabs").load(this.href, function(){
//                        closeLoading();
//                    });
//                } 
            });
            
//            $("#dlgLoading").prev('.ui-dialog-titlebar').hide();
            
            
    	});
        
        function openHelp(url){
          //Open in new tab
          window.open(url, '_blank');
          //focus to thet window
          window.focus();
          //reload current page
          //location.reload();
        }

        function panel_periodMonth_OnChange(thisObject) {
            
            window.location = "panel-change-period?panel_periodMonth=" + $("#panel_periodMonth").val() + "&panel_periodYear=" + $("#panel_periodYear").val();
        }
        
        function panel_periodYear_OnChange(thisObject) {
            window.location = "panel-change-period?panel_periodMonth=" + $("#panel_periodMonth").val() + "&panel_periodYear=" + $("#panel_periodYear").val();
        }
        
        function closeLoading() {
            $.unblockUI();
        }
        
        //Penambahan tanggal berdasarkan jumlah hari
        function dateAdditionalNumber(id_field,id_target,sum_int,is_time){
            var val_int = parseFloat($("#"+sum_int).val())+0;
            if (isNaN(val_int) === true    ||val_int === "" || val_int === 0) {
                val_int = 0;
            }

            var date = new Date(formatDate($("#"+id_field).val(),is_time));
                date.setDate(date.getDate() + parseInt(val_int));
            var dd  = date.getDate();
            var mm  = date.getMonth()+1;
            var y   = date.getFullYear();
            var someFormattedDate = dd + '/' + mm + '/' + y;

            $("#"+id_target).val(someFormattedDate);
        }
        
        function showLoading() {
            $.blockUI({ 
                message: '<img src="images/busy.gif" />',
                css: { 
                    border: 'none', 
                    padding: '10px', 
                    backgroundColor: 'transparent', 
                    '-webkit-border-radius': '10px', 
                    '-moz-border-radius': '10px',
                    color: '#fff'
                },
                overlayCSS:  { 
                    backgroundColor: '#FFFFFF', 
                    opacity: 0.6
                }
            }); 
        }
        
        function alertMessage(alert_message,object){
            var dynamicDialog= $(
                    '<div id="conformBoxError">'+
                        '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                            '</span>'+alert_message+'<span style="float:left; margin:0 7px 20px 0;">'+
                        '</span>' +
                    '</div>');

            dynamicDialog.dialog({
                title        : "Attention!",
                closeOnEscape: false,
                modal        : true,
                width        : 400,
                resizable    : false,
                closeText    : "hide",
                buttons      : 
                            [{
                                text : "OK",
                                click : function() {
                                    $(this).dialog("close");
                                    object.focus();
                                }
                            }]
            });
        }
        function alertMessage(alert_message,width,object){
            var dynamicDialog= $(
                    '<div id="conformBoxError">'+
                        '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                            '</span>'+alert_message+'<span style="float:left; margin:0 7px 20px 0;">'+
                        '</span>' +
                    '</div>');

            dynamicDialog.dialog({
                title        : "Attention!",
                closeOnEscape: false,
                modal        : true,
                width        : width,
                resizable    : false,
                closeText    : "hide",
                buttons      : 
                            [{
                                text : "OK",
                                click : function() {
                                    $(this).dialog("close");
                                    object.focus();
                                }
                            }]
            });
        }
        
        function alertMessageConfirmationInfo(alert_message) {
                var status;
                var dynamicDialog = $('<div id="conformBox">' +
                        '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">' +
                        '</span>' + alert_message + '</div>');

                dynamicDialog.dialog({
                    title: "Confirmation:",
                    closeOnEscape: false,
                    modal: true,
                    width: 500,
                    resizable: false,

                    buttons:
                            [{
                                    text: "Yes",
                                    click: function () {
                                        $(this).dialog("close");
                                        status = false;
                                    }
                                },
                                {
                                    text: "No",
                                    click: function () {
                                        $(this).dialog("close");
                                        status = true;
                                    }
                                }]
                });
                return status;
            }
        
        function alertMessageDelete(module, urls, params, message, width) {
                //            var status;
                var dynamicDialog = $('<div id="conformBox">' +
                        '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">' +
                        '</span>' + message + '</div>');

                dynamicDialog.dialog({
                    title: "Confirmation Delete!",
                    closeOnEscape: false,
                    modal: true,
                    width: width,
                    resizable: false,
                    buttons:
                            [{
                                    text: "Yes",
                                    click: function () {
                                        $(this).dialog("close");
                                        $.post(urls, params, function (data) {
                                            if (data.error) {
                                                alertMessage(data.errorMessage);
                                            } else {
                                                $("#" + module + "_grid").trigger("reloadGrid");
                                                $("#" + module + "BranchList_grid").trigger("reloadGrid");
//                                                $("#" + module + "DivisionList_grid").trigger("reloadGrid");
//                                                $("#" + module + "DepartmentList_grid").trigger("reloadGrid");
//                                                $("#" + module + "WarehouseList_grid").trigger("reloadGrid");
                                            }
                                        });
                                    }
                                },
                                {
                                    text: "No",
                                    click: function () {
                                        $(this).dialog("close");
                                    }
                                }]
                });
                //            return status;
            }
            
        function alertExpired(alert_message) {
            var dynamicDialog = $(
                    '<div id="conformBoxError">' +
                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">' +
                    '</span>' + alert_message + '<span style="float:left; margin:0 7px 20px 0;">' +
                    '</span>' +
                    '</div>');

            dynamicDialog.dialog({
                title: "Attention!",
                closeOnEscape: false,
                modal: true,
                width: 400,
                resizable: false,
                closeText: "hide",
                buttons:
                    [{
                        text: "OK",
                        onfocus: true,
                        keypress: function ( e ) {
                            if (e.which === 13) {
                                $(this).dialog("close");
                                document.getElementById('btnSignOut').click();
                            }
                        },
                        click: function () {
                            $(this).dialog("close");
                            document.getElementById('btnSignOut').click();
                        }
                    }],
                open: function() {
                    $(this).parents('.ui-dialog-buttonpane button:eq(0)').focus(); 
                }
            });
        }
            
        function formatDateRemoveT(date, useTime) {
                var dateValues = date.split('T');
                var dateValuesTemp = dateValues[0].split('-');
                var dateValue = dateValuesTemp[2] + "/" + dateValuesTemp[1] + "/" + dateValuesTemp[0];
                var dateValuesTemps;

                if (useTime) {
                    dateValuesTemps = dateValue + ' ' + dateValues[1];
                } else {
                    dateValuesTemps = dateValue;
                }

                return dateValuesTemps;
            }
        
        function formatDate(date, useTime) {
                var dateValuesTemps;
                
                if (useTime) {
                    var dateValues = date.split(' ');
                    var dateValuesTemp = dateValues[0].split('/');
                    var dateValue = dateValuesTemp[1] + "/" + dateValuesTemp[0] + "/" + dateValuesTemp[2];
                    dateValuesTemps = dateValue + ' ' + dateValues[1];
                } else {
                    var dateValuesTemp = date.split('/');
                    var dateValue = dateValuesTemp[1] + "/" + dateValuesTemp[0] + "/" + dateValuesTemp[2];
                    dateValuesTemps = dateValue;
                }

                return dateValuesTemps;
            }
            
         
        
        function validDateLessThanNow(notif,dates, useTime) {
                var today       = getDateTimeIndonesianToday(false);
                var dateToday   = formatDate(today,false);
                var date;
                
                
                if(useTime){
                     date       = formatDate(dates,false);
                }else{
                    var dateTime    = formatDate(dates,false).split(" ");
                        date        = dateTime[0];
                    var todayTime   = dateToday.split(" ");
                        dateToday   = todayTime[0];
                }
                if(new Date(date) < new Date(dateToday)){
                    alertMessageNotif(notif+" Date Can't Less Than Date Server Today!");
                    return true;
                }

               return false;
            }
        
        function getDateTimeIndonesianToday(usedTime) {
                var today = new Date();
                var dd = today.getDate();
                var mm = today.getMonth() + 1; //January is 0!
                var yyyy = today.getFullYear();
                var hh = today.getHours();
                var mt = today.getMinutes();
                var ss = today.getSeconds();
                if (dd < 10) {
                    dd = '0' + dd;
                }
                if (mm < 10) {
                    mm = '0' + mm;
                }
                
                if(usedTime){
                    today = dd + '/' + mm + '/' + yyyy + " " + hh + ":" + mt + ":" + ss;
                }else{
                    today = dd + '/' + mm + '/' + yyyy;
                }
                
                return today;
            }

    </script>

</head>

<s:url id="remoteurlSignOut" action="signout" />
    
<body>
    <div style="background-color:#FDFDFC; height: 50px" id="TopPane" class="ui-layout-north ui-widget-content">
        <div>
            
            <div id="logo" style="display: inline-block">
                <img src="images/<%= BaseSession.loadProgramSession().getSetup().getLogoName() %>" style="height:<%= BaseSession.loadProgramSession().getSetup().getLogoHeight() %>px;width:<%= BaseSession.loadProgramSession().getSetup().getLogoWidth() %>px;margin-top: 10px;margin-left: 10px;"/>
            </div>
            
            <div id="header_right" style="display: inline-block;float: right;margin-top: 40px;">
                <%--<div align="right" cssClass="ikb-buttonset ikb-buttonset-single" style="width: 150px;margin-left: 30px;">
                    <a href="<%= BaseSession.loadProgramSession().getSetup().getLogoPath()%>" target="_blank"><img id="helpImage" src="images/help-icon.png" title="Help(Manual Book)"/></a>
                </div>--%>
                <div>
                    <%--<h style="width: 100px;font-size: 19px;"><%= BaseSession.loadProgramSession().getSetup().getCode() +" - "+BaseSession.loadProgramSession().getSetup().getCompanyName() %></h>&nbsp;&nbsp--%>
                </div>
                <br />
                <div style="font-size: 20px">
                    <img src="images/user_info.png"/>&nbsp;&nbsp;welcome,&nbsp;<b><%= BaseSession.loadProgramSession().getUserName()%></b> | <a id="btnSignOut" href="<s:property value="#remoteurlSignOut" />" > Sign Out </a>
                    <br />
                    <B>Period</B>&nbsp;&nbsp;
                    <s:select id="panel_periodMonth" name="panel_periodMonth" width="20" list="monthlyList" listKey="code" listValue="name" key="panel_periodMonth" onchange="panel_periodMonth_OnChange(this)" />
                    &nbsp;<s:select id="panel_periodYear" name="panel_periodYear" width="5" list="yearList" listKey="code" listValue="name" key="panel_periodYear" onchange="panel_periodYear_OnChange(this)" />
                </div>
            </div>
            
        </div>
    </div>
    <div id="LeftPane" class="ui-layout-west ui-widget ui-widget-content">
        <div class="menu_header">Modules</div>
        <ul id="browser" class="filetree"></ul>
    </div>
    <div id="RightPane" class="ui-layout-center ui-helper-reset ui-widget-content" >
        <div id="tabs" class="ui-layout-content">
            <ul>
                <li><a href="#tabs-1">HOME</a></li>
            </ul>
            <div id="tabs-1">
                <br /><br />
            </div>
        </div>
    </div>
    <div id="BottomPane" class="ui-layout-south ui-widget-content" style="text-align: center;">
        <b>2017 @ inkombizz</b>
        <%--<table width="100%">
            <tr>
                <td width="40%"/>
                <td>
                    
                </td>
                <td align="right">
                    <lable><%= BaseSession.loadProgramSession().getSetup().getLastProgramUpdated() %></lable>
                </td>
            </tr>
        </table>--%>
    </div>
    <sj:dialog 
        id="dlgLoading"
        autoOpen="false" 
        modal="true"
        height="140"
        width="auto"
        title="Please Wait..."
        resizable="false"
    >
    <img src="images/ajax-loader.gif"/>
    </sj:dialog>
</body>

</html>