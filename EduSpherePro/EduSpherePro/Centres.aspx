<%@ Page Title="Centres" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Centres.aspx.cs" Inherits="EduSpherePro.Centres" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <!-- List All Centres -->
    <asp:Panel ID="pnlViewCentres"  runat="server">
		<!--Page Headers-->
    <div class="row" style="margin-top:80px;margin-left:200px;">
        <div class="col-sm-4">
            <h4 class="pink">
                <i class="ace-icon fa fa-hand-o-right icon-animated-hand-pointer blue"></i>
                <asp:Label ID="lblCentreAction" Text="" runat="server"></asp:Label>
            </h4>
        </div>
        <div>
            <asp:LinkButton ID="lnkBtnTranslate" class="btn btn-purple btn-sm" Text="<span class='ace-icon fa fa-language icon-on-right bigger-110'></span> HINDI" OnCommand="Translate" CommandName="hi" runat="server"></asp:LinkButton>
        </div>
        <div class="col-sm-6">
            <div class="input-group">
                <span class="input-group-addon">
                    <i class="ace-icon fa fa-check"></i>
                </span>
                <asp:TextBox class="form-control search-query" ID="txtBoxSearchCentre" Placeholder="centre name or city" runat="server"></asp:TextBox>
                <span class="input-group-btn">
                    <asp:LinkButton ID="lnkBtnSerachCentre" class="btn btn-purple btn-sm" Text="<span class='ace-icon fa fa-search icon-on-right bigger-110'></span> Search" OnCommand="ManageCentreVisibility" CommandName="SearchCentre" runat="server"></asp:LinkButton>

                </span> 
            </div>
        </div>
        
    </div>
    <div class="hr hr-18 dotted hr-double"></div>

<!--Page Header-->
        <!--AlternatingItemStyle-BackColor="#666699" AlternatingItemStyle-ForeColor="White" -->
        <section id="feature">
			<div class="container">
                <asp:DataList ID="dlCentres" Cellpadding="3" CellSpacing="2"   RepeatColumns="2" 
                    RepeatDirection="horizontal" AlternatingItemStyle-BackColor="Silver" GridLines="none" runat="server">
                    <ItemTemplate>
                        <div class="row">                            
					        <div class="col-md-10 wow fadeInLeft col-sm-offset-1" data-wow-delay="0.6s">
						        <h3 class="text-uppercase"><%# Eval("OrganizationName") %></h3>
						        <h5><%# Eval("OfficeAddress") %></h5>
                                <p><%# Eval("Remarks") %></p>
                                <p></i><strong>HoD :</strong><%# Eval("ManagerName") %></p>
                                <p><strong>State :</strong><%# Eval("administrative_area_level_1") %></p>
                                <p><strong>City :</strong><%# Eval("locality") %></p>
                                <p><strong>Pin :</strong><%# Eval("postal_code") %></p>
						        <p><strong>Phone :</strong><%# Eval("PhoneOne") %></p>
						        <p><strong>Email :</strong><%# Eval("ManagerEmail") %></p>
                                
					            <!-- Trigger the modal with a button -->
                                
                                <p><asp:LinkButton ID="LinkButton1" class="btn btn-primary text-uppercase" Text="<i class='ace-icon fa fa-envelope'></i>" ToolTip="CONTACT" OnCommand="lnkBtnContact_Command" CommandArgument='<%# Eval("OrganizationID") %>' runat="server" >CONTACT</asp:LinkButton></p>       
                            </div>
					      <%--  <div class="col-md-5 wow fadeInRight" data-wow-delay="0.6s">
						        <img src="Content/TemplateSite/images/software-img.png" class="img-responsive" alt="feature img">
					        </div>--%>
                                                 
				        </div>
                         <hr />  
                    </ItemTemplate>
                </asp:DataList>				
			</div>
		</section>
		
    </asp:Panel>
    <!-- End List All Centres -->
    
</asp:Content>
