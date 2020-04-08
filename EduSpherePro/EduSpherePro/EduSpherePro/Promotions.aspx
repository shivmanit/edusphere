<%@ Page Title="" Language="C#" MasterPageFile="~/EduSpherePro/EduSpherePro.Master" AutoEventWireup="true" CodeBehind="Promotions.aspx.cs" Inherits="EduSpherePro.EduSpherePro.Promotions" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-xs-12">
             <div class="col-sm-6">
                <div class="hr hr-18 dotted hr-double"></div>
	               <h4 class="pink">
		              <i class="ace-icon fa fa-hand-o-right icon-animated-hand-pointer blue"></i>
			          <asp:Label ID="lblPromotionsAction" Text="Promotions / SMS" runat="server"></asp:Label>
	               </h4>
	              <div class="hr hr-18 dotted hr-double"></div>
             </div>
            <div class="col-sm-6">
            
             </div>
            </div>
      </div>
    

    <div class="row">
        <div class="col-xs-12">
                <asp:Panel ID="pnlSendSMS" runat="server">
                    <div class="col-sm-12">
                        Message :<br />
                        <asp:TextBox ID="txtMessage" class="col-lg-10" TextMode="multiline" runat="server"></asp:TextBox>
                      </div>
                    <div class="col-sm-12">  
                            Phone Numbers :<br />
                            <asp:TextBox ID="txtRecepientNumber" class="col-lg-10" Height="200"  TextMode="MultiLine" runat="server"></asp:TextBox>
                        
                    </div>
                    <br /><br />
                    <div class="col-sm-12">
                        <asp:LinkButton ID="lnkBtnSendSMS" class="btn  btn-info" Text='<i class="fa  fa-mobile fa-2x"></i> SEND' OnCommand="btnSend_Click" runat="server"></asp:LinkButton>
                    </div>
                 </asp:Panel>
            
       </div>
     </div>
</asp:Content>
