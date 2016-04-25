<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        .contText{padding:10px 0 0 10px;}
        .contButton{padding:15px 0 0 10px;}
        .rsApt{height:75px !important;}
        .rdfRow .rdfBlock {font-size:22px;display:block;margin:10px 0;}
        .rdfRow .rdfFieldValue{line-height:24px;}
        .rdfPager{height:30px;margin:10px 0;}
        .rdfPager .fl{float:left;}
        .rdfPager .fr{float:right;}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentCPH" Runat="Server">
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server">
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" EnableShadow="true">
    </telerik:RadWindowManager>
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="AttendanceRS">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="AttendanceRS"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="SubmitBtn">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="BankCardWindow" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="BankCardPanel" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="AttendanceRS">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="AttendanceRS" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>

    <telerik:RadWindow runat="server" ID="BankCardWindow" Modal="true"
        Height="220" Width="250" Behaviors="Close" Title="填写工资卡号">
        <ContentTemplate>
            <asp:Panel runat="server" ID="BankCardPanel">
                <p class="contText">
                    工资卡号(工商银行卡)
                </p>
                <div class="contButton">
                    <asp:TextBox ID="bankCardTB" runat="server" Width="180" MaxLength="19"></asp:TextBox>
                </div>
                <div class="contButton">
                    <asp:Button ID="SubmitBtn" Text="确定" runat="server" OnClick="SubmitBtn_Click" CssClass="btn btn-primary"></asp:Button>
                    <asp:Label ID="ErrorMsg" runat="server" ForeColor="Red"></asp:Label>
                </div>
            </asp:Panel>
        </ContentTemplate>
    </telerik:RadWindow>
    
    <div class="container-fluid">

        <!-- Page Heading -->
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">
                    <i class="fa fa-fw fa-dashboard"></i> 首页
                </h1>
            </div>
        </div>
        <!-- /.row -->

        <!--<div class="row">
            <div class="col-lg-12">
                <div class="alert alert-info alert-dismissable">
                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                    <i class="fa fa-info-circle"></i>  <strong>Like SB Admin?</strong> Try out <a href="http://startbootstrap.com/template-overviews/sb-admin-2" class="alert-link">SB Admin 2</a> for additional features!
                </div>
            </div>
        </div>-->
        <!-- /.row -->

        <div class="row">
            <%--<div class="col-lg-3 col-md-6">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-xs-3">
                                <i class="fa fa-comments fa-5x"></i>
                            </div>
                            <div class="col-xs-9 text-right">
                                <div class="huge">26</div>
                                <div>New Comments!</div>
                            </div>
                        </div>
                    </div>
                    <a href="#">
                        <div class="panel-footer">
                            <span class="pull-left">View Details</span>
                            <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                            <div class="clearfix"></div>
                        </div>
                    </a>
                </div>
            </div>--%>
            <div class="col-lg-6 col-md-6">
                <div class="panel panel-green">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-xs-3">
                                <i class="fa fa-tasks fa-5x"></i>
                            </div>
                            <div class="col-xs-9 text-right">
                                <div class="huge">任务列表</div>
                                <div>New Tasks!</div>
                            </div>
                        </div>
                    </div>
                    <a href="/task/list.aspx">
                        <div class="panel-footer">
                            <span class="pull-left">查看全部</span>
                            <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                            <div class="clearfix"></div>
                        </div>
                    </a>
                </div>
            </div>
            <div class="col-lg-6 col-md-6">
                <div class="panel panel-yellow">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-xs-3">
                                <i class="fa fa-support fa-5x"></i>
                            </div>
                            <div class="col-xs-9 text-right">
                                <div class="huge">审核列表</div>
                                <div>New Examines!</div>
                            </div>
                        </div>
                    </div>
                    <a href="/examine/list.aspx">
                        <div class="panel-footer">
                            <span class="pull-left">查看全部</span>
                            <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                            <div class="clearfix"></div>
                        </div>
                    </a>
                </div>
            </div>
            <%--<div class="col-lg-3 col-md-6">
                <div class="panel panel-red">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-xs-3">
                                <i class="fa fa-support fa-5x"></i>
                            </div>
                            <div class="col-xs-9 text-right">
                                <div class="huge">13</div>
                                <div>Support Tickets!</div>
                            </div>
                        </div>
                    </div>
                    <a href="#">
                        <div class="panel-footer">
                            <span class="pull-left">View Details</span>
                            <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                            <div class="clearfix"></div>
                        </div>
                    </a>
                </div>
            </div>--%>
        </div>
        <!-- /.row -->
        
        <div class="row" >
            
        
            <%--<div class="col-lg-4" runat="server" id="barDivChart" visible="false">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <i class="fa fa-bar-chart-o fa-fw"></i> 物品出入库
                    </div>
                    <div class="panel-body">
                        <telerik:RadHtmlChart runat="server" ID="BarChart" Height="250px" Width="100%" Transitions="true" Skin="Silk">
                            <PlotArea>
                                <Series>
                                    <telerik:BarSeries DataFieldY="Value1" Stacked="true">
                                        <LabelsAppearance Visible="false"></LabelsAppearance>
                                    </telerik:BarSeries>
                                    <telerik:BarSeries DataFieldY="Value2">
                                        <LabelsAppearance Visible="false"></LabelsAppearance>
                                    </telerik:BarSeries>
                                </Series>
                                <XAxis DataLabelsField="Item"></XAxis>
                            </PlotArea>
                            <ChartTitle Text="物品出入库对比"></ChartTitle>
                        </telerik:RadHtmlChart>
                    </div>
                </div>
            </div>--%>

            <div class="col-lg-4" runat="server" id="noticeDiv">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <i class="fa fa-bullhorn fa-fw"></i> 公告中心
                    </div>
                    <div class="panel-body">
                        <%--<asp:Literal ID="NoticeLiteral" runat="server"></asp:Literal>--%>
                        <%--<div class="timeline-panel">
                            <div class="timeline-heading">
                                <h4 class="timeline-title">Lorem ipsum dolor</h4>
                            </div>
                            <div class="timeline-body">
                                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Autem dolorem quibusdam, tenetur commodi provident cumque magni voluptatem libero, quis rerum. Fugiat esse debitis optio, tempore. Animi officiis alias, officia repellendus.</p>
                            </div>
                        </div>--%>
                        <asp:Panel ID="formPane" runat="server">
                            <telerik:RadAjaxPanel ID="RadAjaxPanel" runat="server">
                                <telerik:RadDataForm runat="server" ID="RadDataForm" DataKeyNames="Notice_ID" OnNeedDataSource="RadDataForm_NeedDataSource">
                                    <LayoutTemplate>
                                        <div>
                                            <div id="itemPlaceholder" runat="server">
                                            </div>
                                            <div class="rdfPager">
                                                <span>
                                                    <asp:LinkButton ID="btnPrev" runat="server" CommandArgument="Prev" CommandName="Page" CssClass="btn btn-circle btn-default fl" ToolTip="上一条">
                                                        <i class="fa fa-chevron-left"></i>
                                                    </asp:LinkButton>
                                                    <%--<asp:Button ID="btnPrev" runat="server" CommandArgument="Prev" CommandName="Page" CssClass="btn btn-circle btn-default" Text="上一条" ToolTip="Previous" />--%>
                                                </span>
                                                <span>
                                                    <asp:LinkButton ID="btnNext" runat="server" CommandArgument="Next" CommandName="Page" CssClass="btn btn-circle btn-default fr" ToolTip="下一条">
                                                        <i class="fa fa-chevron-right"></i>
                                                    </asp:LinkButton>
                                                    <%--<asp:Button ID="btnNext" runat="server" CommandArgument="Next" CommandName="Page" CssClass="rdfNext" Text="下一条" ToolTip="Next" />--%>
                                                    <%--<asp:Button ID="btnLast" runat="server" CommandArgument="Last" CommandName="Page" CssClass="rdfLast" Text="最后一条" ToolTip="Last" />--%>
                                                </span>
                                            </div>
                                        </div>
                                    </LayoutTemplate>
                                    <ItemTemplate>
                                        <div class="rdfFieldset rdfBorders">
                                            <div class="rdfRow">
                                                <asp:label id="contacttitlelabel2" runat="server" cssclass="rdfLabel rdfBlock" text='<%# Eval("Title") %>'></asp:label>
                                                <asp:label id="contacttitlelabel1" runat="server" cssclass="rdfFieldValue" text='<%# Eval("Substance") %>' />
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </telerik:RadDataForm>
                            </telerik:RadAjaxPanel>
                            <telerik:RadFormDecorator runat="server" ID="RadFormDecorator" DecoratedControls="Buttons, Textbox" />
                        </asp:Panel>
                        <a href="/notice/notice_list.aspx" class="btn btn-default btn-block">查看全部</a>
                    </div>
                </div>
            </div>

            <div class="col-lg-8" runat="server" id="taskLogDiv">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <i class="fa fa-bell fa-fw"></i> 任务通知
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        <div class="list-group" id="taskLog" runat="server">
                            <asp:Literal ID="TaskLogLiteral" runat="server"></asp:Literal>
                        </div>
                        <!-- /.list-group -->
                        <a href="/task/log_list.aspx" class="btn btn-default btn-block">查看全部</a>
                    </div>
                    <!-- /.panel-body -->
                </div>
            </div>
            
            <div class="col-lg-12" runat="server" id="attendanceDiv" visible="false">
                <div class="form-group">
                    <telerik:RadScheduler runat="server" ID="AttendanceRS" SelectedView="MonthView" Height="100%"
                        DataKeyField="ID" DataSubjectField="Subject" DataStartField="Start_Date" DataEndField="End_Date"
                        ReadOnly="true" FirstDayOfWeek="Monday" LastDayOfWeek="Sunday" OnDataBinding="AttendanceRS_DataBinding">
                        <WeekView UserSelectable="false" />
                        <DayView UserSelectable="false" />
                        <MultiDayView UserSelectable="false" />
                        <TimelineView UserSelectable="false" />
                        <MonthView UserSelectable="true" />
                        <AppointmentContextMenuSettings EnableDefault="false" />
                        <TimeSlotContextMenuSettings EnableDefault="false" />
                        <Localization HeaderToday="今天" HeaderMonth="月" />
                    </telerik:RadScheduler>
                </div>
            </div>

            <div class="col-lg-12" runat="server" id="pieChart" visible="false">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <i class="fa fa-bar-chart-o fa-fw"></i> 部门分配图
                    </div>
                    <div class="panel-body">
                        <telerik:RadHtmlChart runat="server" ID="PieChart1" Width="100%" Height="500" Transitions="true" Skin="Silk">
                            <ChartTitle Text="部门员工比例图">
                                <Appearance Align="Center" Position="Top">
                                </Appearance>
                            </ChartTitle>
                            <Legend>
                                <Appearance Position="Right" Visible="true">
                                </Appearance>
                            </Legend>
                            <PlotArea>
                                <Series>
                                    <telerik:PieSeries StartAngle="90">
                                        <LabelsAppearance Position="OutsideEnd" DataFormatString="{0}人">
                                        </LabelsAppearance>
                                        <TooltipsAppearance Color="White" DataFormatString="{0}人"></TooltipsAppearance>
                                        <SeriesItems>
                                            
                                        </SeriesItems>
                                    </telerik:PieSeries>
                                </Series>
                            </PlotArea>
                        </telerik:RadHtmlChart>
                    </div>
                </div>
            </div>
            
        </div>
        <!-- /.row -->
    </div>
    <!-- /.container-fluid -->
</asp:Content>

