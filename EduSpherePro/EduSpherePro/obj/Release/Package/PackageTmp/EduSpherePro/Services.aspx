<%@ Page Title="" Language="C#" MasterPageFile="~/EduSpherePro/EduSpherePro.Master" AutoEventWireup="true" CodeBehind="Services.aspx.cs" Inherits="EduSpherePro.EduSpherePro.Services" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  <div class="row">         
            <div class="col-xs-12">
                <div class="col-sm-6">  
                 <div class="hr hr-18 dotted hr-double"></div>
	               <h4 class="pink">
		              <i class="ace-icon fa fa-hand-o-right icon-animated-hand-pointer blue"></i>
			          <asp:Label ID="lblMembersAction" Text=" Services" runat="server"></asp:Label>
	               </h4>
	              <div class="hr hr-18 dotted hr-double"></div>
               </div>
                <div class="col-sm-4">
                   <div id="membersbar" class="navbar-buttons navbar-header pull-right" role="navigation">
					    <ul class="nav ace-nav">
						    <li class="light-blue dropdown-modal">
							    <a data-toggle="dropdown" href="#" class="dropdown-toggle">
                                    Services <i class="ace-icon fa fa-caret-down"></i> 
							    </a>
							    <ul class="user-menu dropdown-menu-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">
						            
                                    <li>
									   <asp:LinkButton ID="btnAddCustomer" class="btn btn-xs btn-info"    OnCommand="DisplayPnlAddService" CommandName="AddService" Text='<i class="ace-icon fa fa-plus"></i> Add Service' runat="server"></asp:LinkButton> 
								    </li>
                                    <li class="divider"></li>
							    </ul>
						    </li>
					    </ul>
				    </div>
                    
                   
                    
               
              </div>
            </div>
        </div>

 <!--Add New Service--> 
    <div class="section">          
        <div class="row">
            <div class="col-xs-12">
             <asp:Panel ID="pnlAddService" runat="server">                             
                        <div class="col-xs-12" style="margin-top:5px;">
                             <div class="col-xs-4">SkuGroup:</div>
                             <div class="col-xs-8"><asp:DropDownList ID="ddlServiceGroup" DataTextField="SkuGroup" DataValueField="SkuGroupID" OnSelectedIndexChanged="ddlServiceGroup_SelectedIndexChanged" AutoPostBack="true" runat="server"></asp:DropDownList></div>
                        </div>
                        
                        <div class="col-xs-12" style="margin-top:5px;">                              
                             <div class="col-xs-4">SubGroup:</div>
                             <div class="col-xs-8"><asp:DropDownList  ID="ddlServiceSubGroup" DataTextField="SkuSubGroup" DataValueField="SkuSubGroupID" runat="server"></asp:DropDownList></div>                                
                        </div>
                              
                         <div class="col-xs-12"style="margin-top:5px;">
                             <div class="col-xs-4">Title:</div>
                             <div class="col-xs-8"><asp:TextBox TextMode="MultiLine"  ID="txtBoxServiceTitle" runat="server"></asp:TextBox> </div>
                        </div>
                         
                        <div class="col-xs-12" style="margin-top:5px;">
                            <div class="col-xs-4">TimeUnits:</div>
                            <div class="col-xs-8"><asp:TextBox ID="txtBoxServiceDuration" runat="server"></asp:TextBox></div>
                         </div>
                         <div class="col-xs-12" style="margin-top:5px;">  
                            <div class="col-xs-4">Desc:</div><div class="col-xs-8"><asp:TextBox ID="txtBoxServiceDescription" TextMode="MultiLine"  runat="server"></asp:TextBox></div>
                         </div>
                         
                        <div class="col-xs-12" style="margin-top:5px;">
                            <div class="col-xs-4">Unit Rate:</div><div class="col-xs-8"><asp:TextBox class="col-xs-8" ID="txtBoxUnitRate" runat="server"></asp:TextBox></div>
                         </div>
                        <div class="col-xs-12" style="margin-top:5px;">   
                            <div class="col-xs-4">TaxCode:</div><div class="col-xs-8"><asp:DropDownList  ID="ddlTaxCode" DataTextField="TaxCodeDescription" DataValueField="TaxCode" runat="server"></asp:DropDownList></div>    
                        </div>
                           
                         <div class="col-xs-12" style="margin-top:5px;">
                             <div class="col-xs-12"><asp:Button ID="btnInsertNewService" class="btn btn-1" Text="Submit" OnClick="InsertNewService" runat="server" />&nbsp&nbsp&nbsp&nbsp 
                             <asp:ImageButton ID="imgBtnBack"  ImageUrl="~/Images/Return.png" Width="30px" Height="30px"  ToolTip="Return" OnCommand="ReturnToPanel" CommandName="FromPnlAddServiceToPnlServices" runat="server" /></div>
                        </div>
             </asp:Panel>
           </div>
     </div>
    </div>
        <!--End Add New Service-->

    <!--View/Edit Services-->
        <div class="row">
                <div class="col-xs-12">
                    <!--Panel to display Service list for selected SkuGroup. Contains panel to filter the Services -->
                    <asp:Panel ID="pnlServices" ScrollBars="auto"  runat="server">
                        <!--Filter Panel-->
                        <asp:Panel  ID="pnlFilterService"  runat="server">
                             <table >
                                <tr>
                                    <th>SkuGroup :</th>
                                    <td> <asp:DropDownList ID="ddlServiceGroupFilter" DataTextField="SkuGroup" DataValueField="SkuGroupID" OnSelectedIndexChanged="ddlServiceGroupFilter_SelectedIndexChanged" AutoPostBack="true" runat="server"></asp:DropDownList></td>
                                    <td><asp:Label ID="lblRole" Visible="false"  runat="server"></asp:Label></td>
                                    
                                </tr>
                                
                                </table>
                        </asp:Panel>
                        <hr />
                        <asp:GridView ID="dgServices"  class="table  table-bordered table-hover"  AutoGenerateColumns="false" CellPadding="2" 
			                                              GridLines="both"  OnRowEditing="dgEditService" AlternatingItemStyle-BackColor="Silver" OnRowCancelingEdit="dgCancelService"
			                                              OnRowUpdating="dgUpdateService" OnRowDeleting="dgDeleteService" DataKeyNames="SkuID"
			                                              AllowSorting="true"  AllowPaging="false" PagerStyle-Mode="NumericPages" PageSize="12" 
                                                           ItemStyle-HorizontalAlign="left" runat="server">
                        <HeaderStyle Font-Names="Arial" Font-Italic="true" HorizontalAlign="center"   Font-Size="10pt" Font-Bold="false"  BackColor="#465c71" ForeColor="#FFFFFF"  />
                        <RowStyle  Font-Names="Arial" Font-Size="9pt"  ForeColor="Black" HorizontalAlign="center" Wrap="true" />
                        <Columns>   
                            <asp:CommandField  ShowEditButton="true" />
                            <asp:BoundField DataField="SkuID" HeaderText="SkuID" Visible="false"  ></asp:BoundField>
                            <asp:BoundField DataField="SkuTitle" HeaderText="Service Title" ></asp:BoundField>
                            <asp:BoundField DataField="SkuDescription" HeaderText="Description" ></asp:BoundField>
                            <asp:BoundField DataField="SkuDuration" HeaderText="Duration"  ></asp:BoundField>
                            <asp:BoundField  DataField="UnitRate" HeaderText="UnitRate"   ></asp:BoundField>      
                            <asp:CommandField ShowDeleteButton="true" />
                        </Columns>
                            <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                            <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                            <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                            <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" /> 
                        </asp:GridView>
                        <%--<asp:ButtonColumn ButtonType="LinkButton" Text="Delete" CommandName="Delete"  />--%>
                        <asp:GridView ID="dgServicesView"  AutoGenerateColumns="false" CellPadding="2" AlternatingItemStyle-BackColor="Silver" 
			                                              GridLines="both" AllowSorting="true" PagerStyle-Mode="NumericPages" PageSize="30" 
                                                           ItemStyle-HorizontalAlign="left" runat="server">
                        <HeaderStyle Font-Names="Arial" Font-Size="12pt" Font-Italic="true" Font-Bold="false"  BackColor="#465c71" ForeColor="#FFFFFF"  />
                        <FooterStyle Font-Names="Arial" Font-Size="12pt" Font-Italic="true" Font-Bold="false"  BackColor="#465c71" ForeColor="#FFFFFF"  />
                       <RowStyle  Font-Names="Arial" Font-Size="10pt" ForeColor="#000000" HorizontalAlign="left" Width="100px" />
                        <Columns> 
                            <asp:BoundField DataField="SkuID" HeaderText="SkuID" Visible="false"  ></asp:BoundField>
                            <asp:BoundField DataField="SkuTitle" HeaderText="Service" FooterText="Description"  ></asp:BoundField>
                            <asp:BoundField DataField="SkuDescription" HeaderText="Description" ></asp:BoundField>
                            <asp:BoundField  DataField="SkuDuration" HeaderText="Duration"  ></asp:BoundField>
                            <asp:BoundField  DataField="UnitRate" HeaderText="UnitRate"  ></asp:BoundField>
                           
                                         
                        </Columns>
                            
                        </asp:GridView>
                    </asp:Panel>

            </div>
        </div>
    <!--End View Edit Services-->
</asp:Content>
