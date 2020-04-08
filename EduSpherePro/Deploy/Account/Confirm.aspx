<%@ Page Title="Account Confirmation" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Confirm.aspx.cs" Inherits="EduSpherePro.Account.Confirm" Async="true" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <h2><%: Title %>.</h2>
    <div class="container">
    <div class="row">
    <div>
        <asp:PlaceHolder runat="server" ID="successPanel" ViewStateMode="Disabled" Visible="true">
            <h1></h1>
            <h1></h1>
            <h1></h1>
            <p>
                Thank you for confirming your account. Click <asp:HyperLink ID="login" runat="server" NavigateUrl="~/Account/Login">here</asp:HyperLink>  to login             
            </p>
        </asp:PlaceHolder>
        <asp:PlaceHolder runat="server" ID="errorPanel" ViewStateMode="Disabled" Visible="false">
            <h1></h1>
            <h1></h1>
            <h1></h1>

            <p class="text-danger">
                An error has occurred.
            </p>
        </asp:PlaceHolder>
    </div>
        </div>
        </div>
</asp:Content>
