<%@page import="com.inkombizz.action.BaseSession"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>==<%= BaseSession.loadProgramSession().getSetup().getWebTitle() %>==</title>

    <link href="css/innerstyle.css" rel="stylesheet" type="text/css" />

    <sj:head
    	loadAtOnce="true"
    	compressed="false"
    	jqueryui="true"
        jquerytheme="cupertino"
    	loadFromGoogle="false"
    	debug="true" />

    <script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
    <script type="text/javascript" src="<s:url value="/js/jquery_ready.js" />"></script>

    <script type="text/javascript">

        $(function() {
            $("#accordion").accordion({
                autoHeight: false
            });
        });

        $(document).ready(function() {

            $(".ui-accordion-content ul li a").click(function(ev) {
                $('.ui-dialog').remove();
                $('.ui-jqdialog').remove();
                $('.ikb-dialog').remove();

                pageLoad(this.href);

                ev.preventDefault();
            });

            $("#submitForm").click(function() {
                var url = "pph21/login-json";
                var params = $("#frmInput").serialize();
                var pathSuccess = "index";
                $.post(url, params, function(result) {
                    var res = (result);
                    //alert(res.login);
                    if (res.login) {
                        window.location="panel";
                    }
                    else {
                        alert("username and password is not valid");
                    }
                });
                return false;
            });

        });

    </script>

</head>

<body>
<!--topMain end -->
<!--blackMain start -->
<div id="blackMain">
    <!--black start -->
        <div id="black">
            <table>
                <tr>    
                    <td><p><h1>==<%= BaseSession.loadProgramSession().getSetup().getWebTitle() %>==</h1></p></td>
                </tr>
                <tr>
                    <td><p><span class="yellow"><h2>==<%= BaseSession.loadProgramSession().getSetup().getWebTitle() %>==</h2></span></p></td>
                </tr>
            </table>
        <a href="#" class="whatNew"></a></div>
    <!--black end -->
</div>

<!--blackMain end -->
<!--grey start -->
<!--grey end -->
<!--botMain start -->
<div id="botMain">
<!--bot start -->
    <div id="bot">
        <!--left panel start -->
        <!--left panel end -->
        <!--mid panel start -->
        <div id="mid">
        <br class="spacer" />
        </div>
        <!--mid panel end -->
        <!--right panel start -->
        <div id="right">
            <s:actionerror />
                <s:fielderror />
                    <s:form id="frmInput" action="%{urlLoginJson}" method="POST">
                        <table cellpadding="2" cellspacing="2" width="50%" align="right">
                            <tr>
                                <td>User Name</td>
                                <td><s:textfield label="User Name" name="username" id="username" value=""></s:textfield></td>
                            </tr>
                            <tr>
                                <td>Password</td>
                                <td><s:password label="Password" name="password" id="password" value=""></s:password></td>
                            </tr>
                            <tr>
                                <td></td>
                                <td>
                                    <a href="#" id="submitForm" class="ikb-button ui-state-default ikb-button-icon-center ui-corner-all"><span class=""></span>LOGIN</a>
                                </td>
                            </tr>
                        </table>
                    </s:form>
        </div>
    <!--right panel end -->
    </div>
<!--bot end -->
<br class="spacer" />
</div>
<!--botMain end -->

<!--footer start -->
<!-- <div id="footerMain"> -->
<!--footer start -->
<!--
  <div id="footer">
    <p class="copyright">Copyright © INKOMBIZZ 2010. All Rights Reserved.</p>
    <a href="http://validator.w3.org/check?uri=referer" class="xhtml">Xhtml</a>
    <a href="http://jigsaw.w3.org/css-validator/check/referer" class="css">css</a>
    <p class="design">Designed by : N1ckho</p>
  </div>
-->
<!--footer end -->
<!-- </div> -->
<!--footer end -->
</body>
</html>