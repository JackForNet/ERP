<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="error.aspx.cs" Inherits="error" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentCPH" Runat="Server">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header"><i class="fa fa-fw fa-ban"></i> 系统异常</h1>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-12">
            <div class="alert alert-danger">
                系统发生异常，<a href="/index.aspx" class="alert-link">点击返回首页</a>
            </div>
        </div>
    </div>
</asp:Content>

