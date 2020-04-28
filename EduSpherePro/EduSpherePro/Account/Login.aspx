<%@ Page Title="Log in" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="EduSpherePro.Account.Login" Async="true" %>

<%@ Register Src="~/Account/OpenAuthProviders.ascx" TagPrefix="uc" TagName="OpenAuthProviders" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    
    
    <div class="container">
        <h2><%: Title %>.</h2>
    <div class="row">
        <div class="col-md-12">
            <section id="loginForm">
                <div class="contact-one__form contact-form-validated">
                    <h1></h1>
                    <h1></h1>
                    <h1></h1>
                   <%-- <h3>Use  SJA account to log in.</h3>--%>
                    
                    <asp:PlaceHolder runat="server" ID="ErrorMessage" Visible="false">
                        <p class="text-danger">
                            <asp:Literal runat="server" ID="FailureText" />
                        </p>
                    </asp:PlaceHolder>
                    <div class="form-group">
                        <div class="row">
                            <asp:Label runat="server" Text='<i class="fa fa-envelope"></i>' AssociatedControlID="Email" class="col-sm-offset-2 col-sm-1"></asp:Label>
                            <div class="col-sm-8">
                                <asp:TextBox runat="server" ID="Email" CssClass="form-control" TextMode="Email" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="Email"
                                CssClass="text-danger" ErrorMessage="The email field is required." />
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                        <asp:Label runat="server" Text='<i class="fa fa-key"></i>' AssociatedControlID="Password" class="col-sm-offset-2 col-sm-1"></asp:Label>
                        <div class="col-sm-8">
                            <asp:TextBox runat="server" ID="Password" TextMode="Password" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="Password" CssClass="text-danger" ErrorMessage="The password field is required." />
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-6">
                            <div class="checkbox">
                                <asp:CheckBox runat="server" ID="RememberMe" />
                                <asp:Label runat="server" AssociatedControlID="RememberMe">Remember me?</asp:Label>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-6">
                            <asp:Button runat="server" OnClick="LogIn" Text="Log in" CssClass="thm-btn" />
                        </div>
                    </div>
                </div>
                <p>
                    <asp:HyperLink runat="server" ID="RegisterHyperLink" ViewStateMode="Disabled">Register as a new user</asp:HyperLink>
                </p>
                <p>
                    <%-- Enable this once you have account confirmation enabled for password reset functionality--%>
                    <asp:HyperLink runat="server" ID="ForgotPasswordHyperLink" ViewStateMode="Disabled">Forgot your password?</asp:HyperLink>
                    
                </p>
                    </div>
            </section>
        </div>

       <!-- <div class="col-md-4">
            <section id="socialLoginForm">
                <uc:OpenAuthProviders runat="server" ID="OpenAuthLogin" />
            </section>
        </div>-->
    </div>
    </div>
</asp:Content>
