<%@ Page Title="" Language="C#" MasterPageFile="~/EduSpherePro/EduSpherePro.Master" AutoEventWireup="true" CodeBehind="Expenses.aspx.cs" Inherits="EduSpherePro.EduSpherePro.Expenses" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <!--Page Buttons-->
    <div class="row">
        <div class="col-xs-12">
            <div class="col-sm-4">  
                 <div class="hr hr-18 dotted hr-double"></div>
	               <h4 class="pink">
		              <i class="ace-icon fa fa-hand-o-right icon-animated-hand-pointer blue"></i>
			          <asp:Label ID="lblDashboardAction" Text="Accounts" runat="server"></asp:Label>
	               </h4>
	              <div class="hr hr-18 dotted hr-double"></div>
               </div>
            <!--Page Button Menu Bar-->
         <div class="col-sm-4">
                    <div id="membersbar" class="navbar-buttons navbar-header pull-right" role="navigation">
					    <ul class="nav ace-nav">
						    <li class="light-blue dropdown-modal">
							    <a data-toggle="dropdown" href="#" class="dropdown-toggle">
                                    Account Transactions <i class="ace-icon fa fa-caret-down"></i> 
							    </a>
							    <ul class="user-menu dropdown-menu-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">						            
                                    <li>
                                        <asp:LinkButton ID="btnAccountTxs"   class="btn btn-sm btn-info" OnCommand="ManageDashboardPanels"  CommandName="pnlAccountTxsDashboard" Text="Transaction Statement" runat="server"  />
                                    </li>
                                    <li>
                                        <asp:LinkButton ID="btnAddAccountTxs"   class="btn btn-sm btn-info" OnCommand="ManageDashboardPanels"  CommandName="pnlAddAccountTxs" Text="New Transaction" runat="server"  />
                                    </li>
                                    <li>
                                         <asp:LinkButton ID="btnNewExpesneTitle"   class="btn btn-sm btn-info" OnCommand="ManageDashboardPanels"  CommandName="pnlManageAccountTxTitles" Text="Add Transaction Head" runat="server"  />
                                    </li>
							    </ul>
						    </li>
					    </ul>
				    </div>
              
          </div>
         <!---/Page Button Menu Bar--->
            <div class="col-sm-8">
                 
            </div>
         </div>
   </div>

     <!--Page Buttons-->

     <!--AccountTxs Report-->
    <div class="row">
            <div class="col-xs-12">
                <!--Pannel To display AccountTxs -->
                <asp:Panel ID="pnlAccountTxsDashboard"  ScrollBars="Vertical" runat="server">
                    <asp:Panel ID="pnlFilterAccountTxs"   runat="server">
                            <table  class="table  table-bordered table-hover">
                                <tr>
                                <td><strong>From:</strong></td>
                                <td><asp:TextBox ID="txtBoxExpFrom" Type="Date"   runat="server"></asp:TextBox></td>
                                <td><strong>To:</strong></td>
                                <td><asp:TextBox ID="txtBoxExpTo" Type="Date"   runat="server"></asp:TextBox></td>
                            </tr>
                                <tr>                     
                                    <th><strong>Org:</strong></th>
                                    <td><asp:DropDownList ID="ddlSite" DataTextField="OrganizationName" DataValueField="OrganizationID" runat="server">
                                        </asp:DropDownList></td> 
                                    <th>Pay Mode</th>
                                     <td><asp:DropDownList ID="ddlPayMode" runat="server">
                                        <asp:ListItem>All</asp:ListItem>    
                                        <asp:ListItem>Cash</asp:ListItem>
                                        <asp:ListItem>Paytm</asp:ListItem>
                                        <asp:ListItem>Card</asp:ListItem>
                                        <asp:ListItem>Cheque</asp:ListItem>
                                        <asp:ListItem>NEFT</asp:ListItem>
                                        <asp:ListItem>Others</asp:ListItem>
                                        </asp:DropDownList>
                                    </td> 
                                                                 
                                 </tr>
                                 <tr>
                                     <th>Spent By:</th>
                                    <td><asp:DropDownList ID="ddlSpender" DataTextField="FullName" DataValueField="EmployeeID" runat="server"></asp:DropDownList></td>
                                     
                                 </tr>
                            
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td><asp:Button ID="btnAllExp" class="btn-sm btn-info"  Text="All" OnCommand="GetAccountTxsReport" CommandName="AllAccountTxsByDate" runat="server" />
                                        <asp:ImageButton ImageUrl="~/Images/excelExport.png" Height="30px" Width="30px" ToolTip="ExportToExcel" OnCommand="GetAccountTxsReport" CommandName="AllAccountTxsByDate" CommandArgument="exportToExcel" runat="server" /></td>
                                
                                    <td><asp:Button ID="btnSepcificExp" class="btn-sm btn-info"  Text="Specific" OnCommand="GetAccountTxsReport" CommandName="AccountTxsByDateByGroupByStore" runat="server" />
                                        <asp:ImageButton ImageUrl="~/Images/excelExport.png" Height="30px" Width="30px" ToolTip="ExportToExcel" OnCommand="GetAccountTxsReport" CommandName="AccountTxsByDateByGroupByStore" CommandArgument="exportToExcel" runat="server" /></td>
                                
                            </tr>
                                <tr>
                                    <td><strong>Total Outflow:</strong></td>
                                    <td><asp:Label class="name" ID="lblTotalAccountTxs" runat="server"></asp:Label></td>
                                    <td><strong>Total Inflow:</strong></td>
                                    <td><asp:Label class="name" ID="lblTotalInflow" runat="server"></asp:Label></td>
                                </tr>
                          </table>                   
                        </asp:Panel>
                                          
                        <asp:GridView ID="gvAccountTxsDashboard" CssClass="table table-hover table-bordered" AlternatingRowStyle-BackColor="Silver" AutoGenerateColumns="false" CellPadding="10" CellSpacing="4" GridLines="both" 
                            AllowSorting="true" AllowPaging="false" OnPageIndexChanging="OnAccountTxsPageIndexChanging" PagerStyle-Mode="NumericPages" PageSize="20" RowStyle-HorizontalAlign="center" runat="server">
                            <HeaderStyle Font-Names="Arial" Font-Size="10pt" Font-Bold="false" BackColor="#333333" ForeColor="#FFFFFF" />
                            <RowStyle Font-Names="Arial" Font-Size="8pt" ForeColor="#000000" ></RowStyle>
                            <Columns>
                                <asp:BoundField DataField="OrganizationID" HeaderText="Site"></asp:BoundField>
                                <asp:BoundField DataField="FullName" HeaderText="Spender"></asp:BoundField>
                                <asp:BoundField DataField="AccountTxTitle" HeaderText="Transaction Head"></asp:BoundField>
                                <asp:BoundField DataField="AccountTxDetails" HeaderText="Details"></asp:BoundField>
                                <asp:BoundField DataField="DebitAmount" HeaderText="Debit"></asp:BoundField>
                                <asp:BoundField DataField="CreditAmount" HeaderText="Credit"></asp:BoundField> 
                                <asp:BoundField DataField="AccountTxDate" HeaderText="Date"></asp:BoundField>
                                <asp:BoundField DataField="PaymentMode" HeaderText="Payment Mode"></asp:BoundField>
                                <asp:BoundField DataField="ConfirmationString" HeaderText="Pay Code"></asp:BoundField>
                                <asp:HyperLinkField DataTextField="DocPath" HeaderText="Attachment" DataNavigateUrlFields="DocPath" />
                            </Columns> 
                            <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                                                <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                                                <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                                                <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />                                                     
                        </asp:GridView><br />
                        &nbsp<asp:ImageButton ImageUrl="~/Images/Return.png" Height="30px" Width="30px" ToolTip="Return" OnCommand="ManageDashboardPanels"  CommandName="FromPnlServicesRevenueToNoPanel" runat="server" />&nbsp &nbsp &nbsp 
                    
                </asp:Panel>
            </div>
    </div>
     <!--/AccountTxs Report-->

     <!--Add AccountTx-->
    <div class="row">
            <div class="col-xs-12">
                 <!---Add New AccountTx----->
                <asp:Panel ID="pnlAddAccountTxs" runat="server">
                    <fieldset class="login">
                        <legend>Add New Transaction</legend>                   
                        <table class="table  table-bordered table-hover">           
                        <tr>
                            <td>Transaction Group:</td>
                            <td><asp:DropDownList ID="ddlAccountTxType"  runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlAccountTxType_SelectedIndexChanged">
                                                            <asp:ListItem>CustomerReceipts</asp:ListItem>
                                                            <asp:ListItem>Salary</asp:ListItem>
                                                            <asp:ListItem>Incentive</asp:ListItem>
                                                            <asp:ListItem>Reward</asp:ListItem>
                                                            <asp:ListItem>EmployeeWelfare</asp:ListItem>
                                                            <asp:ListItem>Material</asp:ListItem>
                                                            <asp:ListItem>VendorPayments</asp:ListItem>
                                                            <asp:ListItem>Operations</asp:ListItem>
                                                            <asp:ListItem>Capital</asp:ListItem>
                                                            <asp:ListItem>Sundry</asp:ListItem>
                                                            <asp:ListItem>Others</asp:ListItem>
                                                        </asp:DropDownList></td>    
                            <td>Transaction Head:</td>
                            <td><asp:DropDownList ID="ddlAccountTxTitle" DataTextField="AccountTxTitle" DataValueField="AccountTxTitleID" runat="server"></asp:DropDownList> </td>
                        </tr>
                        <tr>
                            <td>Cost Centre:</td>
                            <td><asp:DropDownList ID="ddlCostSite" DataTextField="OrganizationName" DataValueField="OrganizationID" runat="server">
                                                           
                                </asp:DropDownList></td>    
                            <td>Approved By:</td>
                            <td><asp:DropDownList ID="ddlApprovedBy" DataTextField="FullName" DataValueField="EmployeeID" runat="server"></asp:DropDownList> </td>
                         </tr>
                         <tr>
                                <td>Amount</td>
                                <td><asp:TextBox ID="txtBoxAccountTxAmount" runat="server"></asp:TextBox> </td>
                                <td>Transaction Details</td>
                                <td><asp:TextBox ID="txtBoxAccountTxDetails" runat="server"></asp:TextBox></td>
                         </tr>
                         <tr>
                             <td>Mode of Transaction</td>
                            <td><asp:DropDownList ID="ddlAccountTxMode" runat="server">
                                    <asp:ListItem>All</asp:ListItem>    
                                    <asp:ListItem>Cash</asp:ListItem>
                                    <asp:ListItem>Paytm</asp:ListItem>
                                    <asp:ListItem>Card</asp:ListItem>
                                    <asp:ListItem>Cheque</asp:ListItem>
                                    <asp:ListItem>NEFT</asp:ListItem>
                                    <asp:ListItem>Others</asp:ListItem>
                                    </asp:DropDownList>
                             </td>
                             <td>Confirmation Code:</td> 
                             <td><asp:TextBox ID="txtBoxExpConfirmationString" runat="server"></asp:TextBox></td> 

                         </tr>
                         <tr>
                                <th class="col-sm-1">Attachment</th>
                                <td>
                                    <asp:FileUpload ID="flUploadTxDoc" runat="server"></asp:FileUpload></td>
                                <th class="col-sm-1">Attachment Title</th>
                                <td>
                                    <asp:TextBox ID="txtBoxAttachmentTitle" runat="server"></asp:TextBox></td>

                            </tr>
                            <tr>
                                <th class="col-sm-1">Click Upload after choosing file</th>
                                <td>
                                    <asp:LinkButton ID="btnFileUpload" class="btn btn-app btn-purple btn-xs" Text='<i class="ace-icon fa fa-cloud-upload"></i> Upload' OnCommand="btnFileUpload_TxDoc" CommandName="flUploadTxDoc" CommandArgument="" runat="server"></asp:LinkButton>
                                </td>
                                    <td>
                                    <asp:Label ID="lblDocAttachment" runat="server"></asp:Label></td>
                                <th></th>
                                <td></td>
                            </tr>
                         <tr>
                            <td><asp:Button ID="btnSubmit" class="btn btn-sm btn-info" OnCommand="SubmitAccountTx" CommandName="InsertAccountTx" Text="Submit"  runat="server" /></td>                             
                            <td><asp:ImageButton ID="imgBtnReturn"  ImageUrl="~/Images/Return.png" Width="30px" Height="30px"  ToolTip="Return" OnCommand="ManageDashboardPanels" CommandName="FromPnlServicesRevenueToNoPanel" runat="server" /></td>
                            <td></td>
                            <td></td>
                         </tr>
                        </table>
                        </fieldset>
                </asp:Panel> 
            </div>
       </div>
     <!--/Add AccountTx-->

     <!--Add AccountTx Title-->
    <div class="row">
            <div class="col-xs-12">
                <!--Panel to Filter,View and Edit exisitng AccountTxTitles. Add New Titles from next panel-->
                <asp:Panel ID="pnlManageAccountTxTitles" ScrollBars="Both"   runat="server">
                      <!--Filter Panel-->
                      <asp:Panel  ID="pnlFilterAccountTxTitles"  runat="server">
                             <div class="col-sm-12" >
                                
                                    <asp:Label ID="lblRole" Visible="false"  runat="server"></asp:Label>
                                    <strong>Transaction Group :</strong>

                                    <asp:DropDownList ID="ddlAccountTxGroupFilter" runat="server">
                                                           <asp:ListItem>CustomerReceipts</asp:ListItem>
                                                           <asp:ListItem>Salary</asp:ListItem>
                                                            <asp:ListItem>Incentive</asp:ListItem>
                                                            <asp:ListItem>Reward</asp:ListItem>
                                                            <asp:ListItem>EmployeeWelfare</asp:ListItem>
                                                            <asp:ListItem>Material</asp:ListItem>
                                                            <asp:ListItem>VendorPayments</asp:ListItem>
                                                            <asp:ListItem>Operations</asp:ListItem>
                                                            <asp:ListItem>Capital</asp:ListItem>
                                                            <asp:ListItem>Sundry</asp:ListItem>
                                                            <asp:ListItem>Others</asp:ListItem>
                                                       </asp:DropDownList>
                                    <asp:Button class="btn btn-sm btn-info" ID="btnFilter" Text="GO" OnCommand="FilterAccountTxTitles" CommandArgument="" runat="server" />
                                
                                </div>
                            </asp:Panel><hr />
                      <!--dg to edit,update and delete exisitng AccountTx Titles--->
                      <asp:DataGrid ID="dgExistingAccountTxTitles"  AutoGenerateColumns="false" CellPadding="2" 
			                                              GridLines="both" OnEditCommand="dgEditAccountTxTitle" AlternatingItemStyle-BackColor="Silver" OnCancelCommand="dgCancelAccountTxTitle"
			                                              OnUpdateCommand="dgUpdateAccountTxTitle" OnDeleteCommand="dgDeleteAccountTxTitle" DataKeyField="AccountTxTitleID" width="600px"
			                                              AllowSorting="true"  AllowPaging="false"  PagerStyle-Mode="NumericPages" PageSize="50" 
                                                           ItemStyle-HorizontalAlign="left" runat="server">
                        <HeaderStyle Font-Names="Arial" Font-Italic="true" Font-Size="12pt" Font-Bold="false"  BackColor="#465c71" ForeColor="#FFFFFF"  />
                        <ItemStyle  Font-Names="Arial" Font-Size="10pt" ForeColor="Black" HorizontalAlign="left" Width="100px" Wrap="true" />
                        <Columns>   
                            <asp:EditCommandColumn EditText="Edit" Visible="true" CancelText="Cancel" UpdateText="Update" />
                            <asp:BoundColumn DataField="AccountTxTitleID" HeaderText="AccountTxTitleID" Visible="false"  ></asp:BoundColumn>
                            <asp:BoundColumn DataField="AccountTxTitle" HeaderText="Title" ></asp:BoundColumn>
                            <asp:BoundColumn DataField="AccountTxTitleGroup" ReadOnly="true" Visible="false" HeaderText="Group" ></asp:BoundColumn>
                            <asp:BoundColumn DataField="AccountTxTitleDescription" HeaderText="Description" ></asp:BoundColumn>
                            <asp:ButtonColumn CommandName="delete" Text="Delete"></asp:ButtonColumn>
                        </Columns>
                        </asp:DataGrid>
                     <!--Only to view AccountTx Titles-->
                      <asp:DataGrid ID="dgExistingAccountTxTitlesView"  AutoGenerateColumns="false" CellPadding="2" AlternatingItemStyle-BackColor="Silver" 
			                                              GridLines="both" Width="680px" AllowSorting="true" AllowPaging="false" PagerStyle-Mode="NumericPages" PageSize="30" 
                                                           ItemStyle-HorizontalAlign="left" runat="server">
                        <HeaderStyle Font-Names="Arial" Font-Size="12pt" Font-Italic="true" Font-Bold="false"  BackColor="#465c71" ForeColor="#FFFFFF"  />
                        <FooterStyle Font-Names="Arial" Font-Size="12pt" Font-Italic="true" Font-Bold="false"  BackColor="#465c71" ForeColor="#FFFFFF"  />
                       <ItemStyle  Font-Names="Arial" Font-Size="10pt" ForeColor="#000000" HorizontalAlign="left" Width="100px" />
                        <Columns> 
                            <asp:BoundColumn DataField="AccountTxTitleID" HeaderText="AccountTxTitleID" Visible="false"  ></asp:BoundColumn>
                            <asp:BoundColumn DataField="AccountTxTitle" HeaderText="AccountTx Title" ></asp:BoundColumn>
                            <asp:BoundColumn DataField="AccountTxTitleGroup" HeaderText="AccountTx Group" ></asp:BoundColumn>
                            <asp:BoundColumn DataField="AccountTxTitleDescription" HeaderText="Description for Title" ></asp:BoundColumn>                                           
                        </Columns>
                            
                        </asp:DataGrid>
                        
                      <!--Add New AccountTx Title---To edit and update use dg-->
                      <asp:Panel ID="pnlNewAccountTxTitle" runat="server">
                                <fieldset class="login">
                                <legend>Create New Head for Transaction</legend>                   
                                <table class="table  table-bordered table-hover">           
                                <tr>
                                    <td>Transaction Group:</td>
                                    <td><asp:DropDownList ID="ddlAccountTxGroup" runat="server">
                                                            <asp:ListItem>CustomerReceipts</asp:ListItem>                                                          
                                                            <asp:ListItem>Salary</asp:ListItem>
                                                            <asp:ListItem>Incentive</asp:ListItem>
                                                            <asp:ListItem>Reward</asp:ListItem>
                                                            <asp:ListItem>EmployeeWelfare</asp:ListItem>
                                                            <asp:ListItem>Material</asp:ListItem>
                                                            <asp:ListItem>VendorPayments</asp:ListItem>
                                                            <asp:ListItem>Operations</asp:ListItem>
                                                            <asp:ListItem>Capital</asp:ListItem>
                                                            <asp:ListItem>Sundry</asp:ListItem>
                                                            <asp:ListItem>Others</asp:ListItem>
                                                        </asp:DropDownList></td>    
                                    <td>Transaction Head Title:</td><td><asp:TextBox ID="txtBoxAccountTxTitle" runat="server"></asp:TextBox> </td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td>Description:</td>
                                    <td><asp:TextBox ID="txtBoxAccountTxTitleDescription" runat="server"></asp:TextBox></td>
                                    
                                    <td><asp:Button ID="btnNewAccountTxTitle" class="btn btn-sm btn-info" Text="Submit" OnClick="InsertNewAccountTxTitle" runat="server" /></td> 
                                    <td><asp:ImageButton ID="imgBtnBack"  ImageUrl="~/Images/Return.png" Width="30px" Height="30px"  ToolTip="Return" OnCommand="ManageDashboardPanels" CommandName="FromPnlAddAccountTxToPnlAccountTxs" runat="server" /></td>
                                </tr>
                                </table>
                            </fieldset>
                        </asp:Panel>
                            
                </asp:Panel>
            </div>
    </div>
    <!--/Add AccountTx Title-->

</asp:Content>
