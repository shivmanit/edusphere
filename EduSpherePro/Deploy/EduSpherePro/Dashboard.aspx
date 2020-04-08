<%@ Page Title="" Language="C#" MasterPageFile="~/EduSpherePro/EduSpherePro.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="EduSpherePro.EduSpherePro.Dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-xs-12">
            <div class="col-sm-4">  
                 <div class="hr hr-18 dotted hr-double"></div>
	               <h4 class="pink">
		              <i class="ace-icon fa fa-hand-o-right icon-animated-hand-pointer blue"></i>
			          <asp:Label ID="lblDashboardAction" Text="Dashboard" runat="server"></asp:Label>
	               </h4>
	              <div class="hr hr-18 dotted hr-double"></div>
               </div>
            <!--Page Button Menu Bar-->
         <div class="col-sm-4">
                    <div id="membersbar" class="navbar-buttons navbar-header pull-right" role="navigation">
					    <ul class="nav ace-nav">
						    <li class="light-blue dropdown-modal">
							    <a data-toggle="dropdown" href="#" class="dropdown-toggle">
                                    SJA Dashboard <i class="ace-icon fa fa-caret-down"></i> 
							    </a>
							    <ul class="user-menu dropdown-menu-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">
						            <li>
									     <asp:LinkButton ID="btnIndicators"   class="btn btn-sm btn-info" OnCommand="ManageDashboardPanels"  CommandName="pnlIndicatorsDashboard" CommandArgument="today" Text="Indicators" runat="server"  />
								    </li>
                                    <li>
                                         <asp:LinkButton ID="btnServiceRevenue"   class="btn btn-sm btn-info" OnCommand="ManageDashboardPanels"  CommandName="pnlServicesDashboard" Text="Services" runat="server"  />
								    </li>
								    <li>
                                        <asp:LinkButton ID="btnExpenses"   class="btn btn-sm btn-info" OnCommand="ManageDashboardPanels"  CommandName="pnlExpensesDashboard" Text="Expenses" runat="server"  />
                                    </li>
                                    <li>
                                         <asp:LinkButton ID="lnkBtnStaffAttendance"   class="btn btn-sm btn-info" OnCommand="ManageDashboardPanels"  CommandName="pnlAttendanceDashboard" Text='<i class="ace-icon fa fa-signal"></i> Staff Attendance' runat="server"  />      
                                    </li>
                                    <li>
									    <asp:LinkButton ID="lnkBtnStudentAcademic"  class="btn btn-sm btn-info"  OnCommand="ManageDashboardPanels" CommandName="pnlStudentAcademicsDashboard" Text='<i class="ace-icon fa fa-graduation-cap"></i> Student Academics' runat="server"></asp:LinkButton>
								    </li>
                                    <li>
									    <asp:LinkButton ID="lnkBtnStudentAttendance"  class="btn btn-sm btn-info"  OnCommand="ManageDashboardPanels" CommandName="pnlStudentAttendanceDashboard" Text='<i class="ace-icon fa fa-signal"></i> Student Attendance' runat="server"></asp:LinkButton>
								    </li>
                                    <li>
                                        <asp:LinkButton ID="lnkBtnPendingFee"    class="btn btn-sm btn-info" OnCommand="ManageDashboardPanels"  CommandName="pnlCustomerDashboard" Text='<i class="ace-icon fa fa-clock-o"></i> Student Outstandings' runat="server"  />
                                    </li>
							    </ul>
						    </li>
					    </ul>
				    </div>
              
          </div>
         <!---/Page Button Menu Bar--->
         </div>
   </div>
<!--End Page Buttons-->

    <!--Service Revenue-->
       <div class="row">
            <div class="col-xs-12">
                <!--Pannel To display Services Revenue-->
                <asp:Panel ID="pnlServicesDashboard"  ScrollBars="Both" runat="server">
                   
                            <table class="table  table-bordered table-hover">
                            <tr>
                                <td><strong>From:</strong></td>
                                <td><asp:TextBox ID="txtBoxFromDate" Type="Date"   runat="server"></asp:TextBox></td>
                                <td><strong>To:</strong></td>
                                <td><asp:TextBox ID="txtBoxToDate" Type="Date"   runat="server"></asp:TextBox></td>
                                                      
                            </tr>
                            <tr>   
                                <td><strong>Location:</strong></td>
                                <td><asp:DropDownList ID="ddlSalon" DataTextField="OrganizationName" DataValueField="OrganizationID"  runat="server">
                                        
                                    </asp:DropDownList></td>
                                <td><strong>Pay Mode</strong></td>
                                <td><asp:DropDownList ID="ddlPaymentMode" runat="server">
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
                                <td><strong>Consultant:</strong></td>
                                <td><asp:DropDownList ID="ddlConsultant" DataTextField="FullName" DataValueField="EmployeeID" runat="server"></asp:DropDownList></td>
                                
                                <td><asp:LinkButton ID="lnkBtnServiceAll" class="btn btn-sm btn-info"  Text='<i class="ace-icon fa fa-users"></i> All' OnCommand="GetServicesRevenueReport" CommandName="AllByDate" runat="server"></asp:LinkButton></td>
                                <td><asp:ImageButton ImageUrl="~/Images/excelExport.png" Height="30px" Width="30px" ToolTip="ExportToExcel" OnCommand="GetServicesRevenueReport" CommandName="AllByDate" CommandArgument="exportToExcel" runat="server" /></td>
                               
                            </tr>
                            <tr>
                                <td><strong>Bill:</strong></td>
                                <td><asp:Label class="name" ID="lblTotalBill" runat="server"></asp:Label></td>
                                   
                                <td><asp:LinkButton ID="btnServiceFilter" class="btn btn-sm btn-info"  Text='<i class="ace-icon fa fa-user"></i>Specific' OnCommand="GetServicesRevenueReport" CommandName="ByDateByGroupByConsultant" runat="server"></asp:LinkButton></td>
                                <td><asp:ImageButton ImageUrl="~/Images/excelExport.png" Height="30px" Width="30px" ToolTip="ExportToExcel" OnCommand="GetServicesRevenueReport" CommandName="ByDateByGroupByConsultant" CommandArgument="exportToExcel" runat="server" /></td>                               
                                
                            </tr>
                            <tr>
                                <td><strong>Received:</strong></td>
                                <td><asp:Label class="name" ID="lblTotalReceipt" runat="server"></asp:Label></td>  
                               
                            </tr>
                          </table>                                           
                        

                   
                        <asp:GridView ID="gvServicesDashboard" AlternatingRowStyle-BackColor="Silver" HorizontalAlign="left" AutoGenerateColumns="false" CellPadding="10" GridLines="both" 
                            AllowSorting="true"   AllowPaging="false"  PagerStyle-Mode="NumericPages" PageSize="100" RowStyle-HorizontalAlign="center" runat="server">
                            <HeaderStyle Font-Names="Arial"   Font-Size="10pt" Font-Bold="false" BackColor="#333333" ForeColor="#FFFFFF" />
                            <RowStyle Font-Names="Arial" Font-Size="8pt" ForeColor="#000000" ></RowStyle>
                            <Columns>
                                <asp:BoundField DataField="ServiceDate" HeaderText="Date"></asp:BoundField>
                                <asp:BoundField DataField="MemberName" HeaderText="Customer"></asp:BoundField>
                                <asp:BoundField DataField="PhoneOne" HeaderText="Contact"></asp:BoundField>
                                <asp:BoundField DataField="ServiceGroup" HeaderText="Type"></asp:BoundField> 
                                <asp:BoundField DataField="ServiceTitle" HeaderText="ServiceTitle"></asp:BoundField>
                                <asp:BoundField DataField="ConsultantName" HeaderText="Consultant"></asp:BoundField>
                                <asp:BoundField DataField="DebitAmount" HeaderText="Bill"></asp:BoundField>
                                <asp:BoundField DataField="CreditAmount" HeaderText="Received"></asp:BoundField>
                                <asp:BoundField DataField="PaymentMode" HeaderText="PayMode"></asp:BoundField>
                                <asp:BoundField DataField="DigitalPaymentRefCode" HeaderText="ConfString"></asp:BoundField>                                                                       
                            
                            </Columns>                           
                        </asp:GridView><br />
                        
                   
                    &nbsp
                        <asp:ImageButton ImageUrl="~/Images/Return.png" Height="30px" Width="30px" ToolTip="Return" OnCommand="ManageDashboardPanels"  CommandName="FromPnlServicesRevenueToNoPanel" runat="server" />
                </asp:Panel>
            </div>
    </div>
     <!--End Service Revenue-->

    <!--Business Indicators-->
    <div class="row">
            <div class="col-xs-12">
                <!----Display business Indicators----->
                <asp:Panel ID="pnlIndicatorsDashboard" ScrollBars="auto" runat="server">
                       <div class="row">
                            <div class="col-xs-12">
                                <!--Select Date and Salon Site-->
                                <table id="simple-table" class="table  table-bordered table-hover">
                                      <tr>
                                        <th colspan="2">Select Date</th>
                                        <td colspan="2"><asp:TextBox ID="txtBoxIndicatorDate" Text="dd/mm/yyyy"  runat="server"></asp:TextBox></td>
                                        <td colspan="2"><asp:DropDownList ID="ddlSalonSite" DataTextField="OrganizationName" DataValueField="OrganizationID" runat="server">
                                                            
                                                          </asp:DropDownList></td>
                                        <td colspan="2"><asp:Button CssClass="btn btn-1" ID="getSpecificDateIndicator" Text="GO" OnCommand="ManageDashboardPanels" CommandName="pnlIndicatorsDashboard" CommandArgument="specificDate" runat="server" /></td>
                                      </tr>
                                      <tr>
                                        <td colspan="8" style="background-color:gray"></td>
                                      </tr>
                                  </table>
                               <!--Total Business--->
                                 <div class="col-xs-6">
                                   <table id="simple-table" class="table  table-bordered table-hover">
                          <tbody>
                              
                              <tr>
                                <th colspan="8" style="background-color:orange;">Todays Business Indicators</th>
                              </tr>
                            <tr>
                                <th colspan="2">Service Bills</th>
                                <td colspan="2"><asp:Label ID="lblTodaysServiceBills" runat="server"></asp:Label></td>
                                <th colspan="2">Service Receipts</th>
                                <td colspan="2"><asp:Label ID="lblTodaysServiceReceipts" runat="server"></asp:Label></td>
                            </tr>
                            
                            <tr>
                                <th colspan="2">Expense Bills </th>
                                <td colspan="2"><asp:Label ID="lblTodaysExpenseBills" runat="server"></asp:Label></td>
                                <th colspan="2"></th>
                                <td colspan="2"></td>
                            </tr>
                              <tr>
                                <th colspan="8" style="background-color:orange;">Monthly Business Indicators</th>
                                  
                              </tr>
                               <tr>
                                <th colspan="2">Service Bills</th>
                                <td colspan="2"><asp:Label ID="lblMonthlyServiceBills" runat="server"></asp:Label></td>
                                <th colspan="2">Service Receipts</th>
                                <td colspan="2"><asp:Label ID="lblMonthlyServiceReceipts" runat="server"></asp:Label></td>
                            </tr>
                            <tr>
                                <th colspan="2">Expense Bills </th>
                                <td colspan="2"><asp:Label ID="lblMonthlyExpenseBills" runat="server"></asp:Label></td>
                                <th colspan="2"></th>
                                <td colspan="2"></td>
                            </tr>
                        </tbody>
                    </table>
                                 </div>
                                <!---Payment Modes ---->
                                <div class="col-xs-6">
                                    <asp:GridView ID="gvServicePaymentMode" CssClass="table table-hover table-bordered"  DataKeyNames="" AlternatingItemStyle-BackColor="Silver" AutoGenerateColumns="false" CellPadding="4" 
                                        GridLines="both" AllowSorting="true" AllowPaging="false" PagerStyle-Mode="NumericPages" PageSize="30" ItemStyle-HorizontalAlign="left" runat="server">
                                        <HeaderStyle Font-Names="Arial"   Font-Size="10pt" Font-Bold="false" BackColor="#333333" ForeColor="#FFFFFF" />
                                        <RowStyle Font-Names="Arial" Font-Size="8pt" ForeColor="#000000" ></RowStyle>
                                    <Columns>
                                        <asp:BoundField DataField="ModeOfReceipt" HeaderText="ModeOfReceipt" />
                                        <asp:BoundField DataField="ReceivedAmount" HeaderText="Received-Services" />
                                    </Columns>
                                    <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                                    <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                                    <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                                    <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
                                </asp:GridView>

                                     <asp:GridView ID="gvProductPaymentMode" CssClass="table table-hover table-bordered"  DataKeyNames="" AlternatingItemStyle-BackColor="Silver" AutoGenerateColumns="false" CellPadding="4" 
                                        GridLines="both" AllowSorting="true" AllowPaging="false" PagerStyle-Mode="NumericPages" PageSize="30" ItemStyle-HorizontalAlign="left" runat="server">
                                        <HeaderStyle Font-Names="Arial"   Font-Size="10pt" Font-Bold="false" BackColor="#333333" ForeColor="#FFFFFF" />
                                        <RowStyle Font-Names="Arial" Font-Size="8pt" ForeColor="#000000" ></RowStyle>
                                    <Columns>
                                        <asp:BoundField DataField="ModeOfReceipt" HeaderText="Mode Of Receipt" />
                                        <asp:BoundField DataField="ReceivedAmount" HeaderText="Received-Products" />
                                    </Columns>
                                    <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                                    <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                                    <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                                    <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
                                </asp:GridView>
                                </div>
                            </div>
                        </div>
                        <!--Display Staff Level Business Indicators-->
                     
                         <div class="row">
                            <!--Staff level Day Indicators-->
                             <div class="col-xs-12">
                               <div class="col-xs-6">
                                <!--Service Bills-->
                                    <asp:GridView ID="gvStaffDayServiceIndicators" CssClass="table table-hover table-bordered"  DataKeyNames="EmployeeID" AlternatingItemStyle-BackColor="Silver" AutoGenerateColumns="false" CellPadding="4" 
                                        GridLines="both" AllowSorting="true" AllowPaging="false" PagerStyle-Mode="NumericPages" PageSize="30" ItemStyle-HorizontalAlign="left" runat="server">
                                        <HeaderStyle Font-Names="Arial"   Font-Size="10pt" Font-Bold="false" BackColor="#333333" ForeColor="#FFFFFF" />
                                        <RowStyle Font-Names="Arial" Font-Size="8pt" ForeColor="#000000" ></RowStyle>
                                    <Columns>
                                        <asp:BoundField DataField="BillAmount" HeaderText="Day Service Bills" />
                                        <asp:BoundField DataField="Name" HeaderText="Name" />
                                    </Columns>
                                    <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                                    <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                                    <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                                    <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
                                </asp:GridView>
                            </div>
                               <div class="col-xs-6">
                                <!--Product Bills-->
                                    <asp:GridView ID="gvStaffDayProductsIndicators" CssClass="table table-hover table-bordered"  DataKeyNames="EmployeeID" AlternatingItemStyle-BackColor="Silver" AutoGenerateColumns="false" CellPadding="4" 
                                        GridLines="both" AllowSorting="true" AllowPaging="false" PagerStyle-Mode="NumericPages" PageSize="30" ItemStyle-HorizontalAlign="left" runat="server">
                                        <HeaderStyle Font-Names="Arial"   Font-Size="10pt" Font-Bold="false" BackColor="#333333" ForeColor="#FFFFFF" />
                                        <RowStyle Font-Names="Arial" Font-Size="8pt" ForeColor="#000000" ></RowStyle>
                                    <Columns>
                                        <asp:BoundField DataField="BillAmount" HeaderText="Day Product Bills" />
                                        <asp:BoundField DataField="Name" HeaderText="Name" />
                                    </Columns>
                                    <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                                    <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                                    <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                                    <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
                                </asp:GridView>
                            </div>
                             </div>
                         </div>
                         <div class="row">
                             <div class="col-xs-12">
                               <!--Staff level Month Indicators-->
                               <div class="col-xs-6">
                                   <asp:GridView ID="gvStaffMonthServiceIndicators" CssClass="table table-hover table-bordered"  DataKeyNames="EmployeeID" AlternatingItemStyle-BackColor="Silver" AutoGenerateColumns="false" CellPadding="4" 
                                        GridLines="both" AllowSorting="true" AllowPaging="false" PagerStyle-Mode="NumericPages" PageSize="30" ItemStyle-HorizontalAlign="left" runat="server">
                                        <HeaderStyle Font-Names="Arial"   Font-Size="10pt" Font-Bold="false" BackColor="#333333" ForeColor="#FFFFFF" />
                                        <RowStyle Font-Names="Arial" Font-Size="8pt" ForeColor="#000000" ></RowStyle>
                                    <Columns>
                                        <asp:BoundField DataField="BillAmount" HeaderText="Month ServiceBills" />
                                        <asp:BoundField DataField="Name" HeaderText="Name" />
                                    </Columns>
                                    <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                                    <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                                    <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                                    <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
                                </asp:GridView> 
                            </div>
                               <div class="col-xs-6">
                                    <asp:GridView ID="gvStaffMonthProductsIndicators" CssClass="table table-hover table-bordered"  DataKeyNames="EmployeeID" AlternatingItemStyle-BackColor="Silver" AutoGenerateColumns="false" CellPadding="4" 
                                        GridLines="both" AllowSorting="true" AllowPaging="false" PagerStyle-Mode="NumericPages" PageSize="30" ItemStyle-HorizontalAlign="left" runat="server">
                                        <HeaderStyle Font-Names="Arial"   Font-Size="10pt" Font-Bold="false" BackColor="#333333" ForeColor="#FFFFFF" />
                                        <RowStyle Font-Names="Arial" Font-Size="8pt" ForeColor="#000000" ></RowStyle>
                                    <Columns>
                                        <asp:BoundField DataField="BillAmount" HeaderText="Month ProductBills" />
                                        <asp:BoundField DataField="Name" HeaderText="Name" />
                                    </Columns>
                                    <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                                    <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                                    <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                                    <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
                                </asp:GridView>
                            </div>
                            </div>
                         </div>
                      
             </asp:Panel>
             </div>
     </div>
    <!--End Business Indicators-->
   

    <!--Staff Attendance Dashboard-->
       <div class="row">
        <div class="col-xs-12">
            <!--Attendance Count for the month -->
            <asp:Label ID="lblAttendanceError" runat="server"></asp:Label>
            <asp:Panel ID="pnlAttendanceDashboard" ScrollBars="Auto" runat="server">              
                <div class="col-xs-6">
                    <h4 class="pink2">Attendance Count :<asp:Label ID="lblDate" Text="" runat="server"></asp:Label></h4>
                     <asp:GridView ID="gvAttendanceDashboard" CssClass="table table-hover table-bordered"  DataKeyNames="" runat="server" AutoGenerateColumns="False" BackColor="White"
                        BorderColor="#3366CC" BorderStyle="None"
                        BorderWidth="1px" CellPadding="4">
                        <RowStyle BackColor="White" ForeColor="#003399" />
                        <Columns>                        
                                <asp:BoundField DataField="Name" HeaderText="Name"></asp:BoundField>
                                <asp:BoundField DataField="Number" HeaderText="Count"></asp:BoundField>
                        </Columns> 
                        <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                        <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                        <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                        <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
                    </asp:GridView>

                </div> 
                <!--Filter Staff-->
                <div class="col-xs-6">
                    <h4 class="pink2">Choose Date/Staff, <strong>Select</strong> for all</h4>
                    <table>
                        <tr>
                            <th class="col-sm-1">Staff</th>
                            <td class="col-sm-5">
                                <asp:DropDownList ID="ddlStaff" DataTextField="FullName" DataValueField="EmployeeID" runat="server"></asp:DropDownList></td>
                           
                        </tr>
                        <tr>
                             <td class="col-sm-5">
                                <asp:Label ID="lblSelectedDate" runat="server"></asp:Label>
                                <asp:Calendar ID="staffAttendanceCalendar" SelectionMode="DayWeekMonth" BorderWidth="2" WeekendDayStyle-BackColor="silver" DayStyle-Width="10"  ShowGridLines="true" OnSelectionChanged="staffAttendaceCalendar_SelectionChanged" runat="server">

                                </asp:Calendar>
                            </td>
                            

                        </tr>

                    </table>
                </div>
                <!--End Filter Staff-->
                <hr />

                <!--PIVOT Attendace Report for month-->
                <!---->
                <div class="row">
                    <div class="col-xs-12">
                        <h4>Day Attendance Report
                             <asp:LinkButton ID="lnkBtnExportAttendance" class="btn btn-xs btn-warning" Text="<i class='ace-icon fa fa-file-excel-o bigger-120'> download</i>" ToolTip="Download" OnCommand="ManageFileExport" CommandName="gvMonthlyAttendancePvt" CommandArgument="ToExcel" runat="server"></asp:LinkButton>
                        </h4>
                        <asp:Panel ID="pnlAttendancePvt" ScrollBars="Both" height="400px" runat="server">
                           <asp:GridView ID="gvMonthlyAttendancePvt" SelectedRowStyle-BackColor="Silver" CssClass="table table-hover table-bordered"  DataKeyNames="" runat="server" AutoGenerateColumns="true" BackColor="White"
                                BorderColor="#3366CC" BorderStyle="None"
                                BorderWidth="1px" CellPadding="4">
                                <RowStyle BackColor="White" ForeColor="#003399" />
                                <Columns>
                                
                                </Columns> 
                                <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                                <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                                <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                                <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
                            </asp:GridView>
                     </asp:Panel>
                    </div>
                </div>
                 <!--End Details attendance for selected staff-->

                <hr />

                <!--Detailed attendance for selected staff-->
                <div class="row">
                    <div class="col-xs-12">
                        <h4>Detailed Report for selected staff</h4>
                       <asp:GridView ID="gvStaffAttendanceDetails" CssClass="table table-hover table-bordered"  DataKeyNames="" runat="server" AutoGenerateColumns="False" BackColor="White"
                        BorderColor="#3366CC" BorderStyle="None"
                        BorderWidth="1px" CellPadding="4">
                        <RowStyle BackColor="White" ForeColor="#003399" />
                        <Columns>
                                <asp:BoundField DataField="AttendanceDate" HeaderText="Date"></asp:BoundField>                        
                                <asp:BoundField DataField="Name" HeaderText="Name"></asp:BoundField>
                                <asp:BoundField DataField="SwipeInDateTime" HeaderText="InTime"></asp:BoundField>
                                <asp:BoundField DataField="SwipeOutDateTime" HeaderText="OutTime"></asp:BoundField>
                                <asp:BoundField DataField="HoursPresentFor" HeaderText="Hours"></asp:BoundField>
                                <asp:BoundField DataField="DayStatus" HeaderText="DayStatus"></asp:BoundField> 
                        </Columns> 
                        <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                        <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                        <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                        <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
                    </asp:GridView>

                    </div>
                </div>
                 <!--End Details attendance for selected staff-->

                <hr />

                <!--Day attendance for each staff-->
               
                <!--End Day attendance for each staff-->
                
            </asp:Panel>


            <!-- PAGE CONTENT ENDS -->
        </div>
        <!-- /.col -->
    </div>
    <!-- End Staff Attendance Dashboard -->

    <!--Student Attendance Dashboard-->
       <div class="row">
        <div class="col-xs-12">
            <!--Attendance for the Batch -->
            <asp:Panel ID="pnlStudentAttendanceDashboard" ScrollBars="Auto" runat="server">
                <!--Filter Batch  -->
                <div class="col-xs-12">
                    <div class="col-sm-5">
                        <strong>Batch: </strong><asp:Label ID="lblSelectedAttendanceBatch" runat="server"></asp:Label>
                            <asp:DropDownList ID="ddlAttendanceBatchFilter" DataTextField="BatchCode" DataValueField="BatchID" OnSelectedIndexChanged="ddlAttendanceBatchFilter_IndexChanged" AutoPostBack="true" runat="server"></asp:DropDownList>
                            <asp:Label ID="lblStudentAttendanceError" runat="server"></asp:Label>
                            <strong>Batch Attendance</strong>
                              <asp:LinkButton ID="lnkBtnStudentAttendanceExport" class="btn btn-xs btn-warning" Text="<i class='ace-icon fa fa-file-excel-o bigger-120'> download</i>" ToolTip="Download" OnCommand="ManageFileExport" CommandName="gvBatchAttendance" CommandArgument="ToExcel" runat="server"></asp:LinkButton>
                            
                    </div>
                    <div class="col-sm-5">
                        <strong>Student: </strong><asp:DropDownList ID="ddlAttendanceStudentFilter" DataTextField="FullName" DataValueField="StudentID"  runat="server"></asp:DropDownList>
                        <asp:LinkButton ID="lnkBtnViewStudentAttendanceDetail"  class="btn btn-sm btn-info"  OnCommand="ddlAttendanceFilter_Changed" CommandName="" Text='<i class="ace-icon fa fa-filter"></i> GO' runat="server"></asp:LinkButton>
                    </div>
                </div>
                <!--End Filter Student-->
                

                <!--PIVOT Attendace Report for month-->
                <div class="row">
                    <div class="col-xs-12">
                        <asp:Panel ID="pnlBatchAttendance" ScrollBars="auto" height="300px" runat="server">
                           <asp:GridView ID="gvBatchAttendance" SelectedRowStyle-BackColor="Silver" CssClass="table table-hover table-bordered"  DataKeyNames="" runat="server" AutoGenerateColumns="true" BackColor="White"
                                BorderColor="#3366CC" BorderStyle="None"
                                BorderWidth="1px" CellPadding="4">
                                <RowStyle BackColor="White" ForeColor="#003399" />
                                <Columns>
                                
                                </Columns> 
                                <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                                <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                                <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                                <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
                            </asp:GridView>
                     </asp:Panel>
                    </div>
                </div>

                <hr />

                <!--Detailed attendance for selected student-->
                <div class="row">
                    <div class="col-xs-12">
                       <strong>Selected Student Attendance</strong>
                       <asp:GridView ID="gvStudentAttendanceDetails" CssClass="table table-hover table-bordered"  DataKeyNames="" runat="server" AutoGenerateColumns="False" BackColor="White"
                        BorderColor="#3366CC" BorderStyle="None"
                        BorderWidth="1px" CellPadding="4">
                        <RowStyle BackColor="White" ForeColor="#003399" />
                        <Columns>
                                <asp:BoundField DataField="AttendanceDate" HeaderText="Date"></asp:BoundField>                        
                                <asp:BoundField DataField="CourseTitle" HeaderText="Name"></asp:BoundField>
                                <asp:BoundField DataField="AttendanceStatus" HeaderText="P/A"></asp:BoundField>
                        </Columns> 
                        <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                        <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                        <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                        <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
                    </asp:GridView>

                    </div>
                </div>
                 <!--End Details attendance for selected student-->

                <hr />
            </asp:Panel>


            <!-- PAGE CONTENT ENDS -->
        </div>
        <!-- /.col -->
    </div>
    <!-- End Student Attendance Dashboard -->

    <!--Student Academics Dashboard-->
       <div class="row">
        <div class="col-xs-12">
            <!--Academics for the Batch -->
            <asp:Panel ID="pnlStudentAcademicsDashboard" ScrollBars="Auto" runat="server">
                <!--Filter Batch  -->
                <div class="col-xs-12">
                    <h4 class="pink2">Batch:<asp:Label ID="lblSelectedAcademicsBatch" runat="server"></asp:Label></h4>
                    <asp:DropDownList ID="ddlAcademicsBatchFilter" DataTextField="BatchCode" DataValueField="BatchID" OnSelectedIndexChanged="ddlAcademicsBatchFilter_IndexChanged" AutoPostBack="true" runat="server"></asp:DropDownList>
                      <asp:Label ID="lblBatchAcdemicsError" runat="server"></asp:Label>

                    <strong>Batch Academics</strong>
                    <asp:LinkButton ID="lnkBtnAcademicsBatch" class="btn btn-xs btn-warning" Text="<i class='ace-icon fa fa-file-excel-o bigger-120'> download</i>" ToolTip="Download" OnCommand="ManageFileExport" CommandName="gvBatchAssessments" CommandArgument="ToExcel" runat="server"></asp:LinkButton>
                </div>
                <!--End Filter Student-->
                <hr />

                <!--PIVOT Attendace Report for month-->
                <!---->
                <div class="row">
                    <div class="col-xs-12">
                        <h4>Batch Academic Report
                             <!--<asp:LinkButton ID="lnkBtnGvBatchAssessmentsToExcel" class="btn btn-xs btn-warning" Text="<i class='ace-icon fa fa-file-excel-o bigger-120'> download</i>" ToolTip="Download" OnCommand="ManageFileExport" CommandName="gvBatchAssessments" CommandArgument="ToExcel" runat="server"></asp:LinkButton>-->
                        </h4>
                        <asp:Panel ID="pnlBatchAssessments" ScrollBars="Both" height="400px" runat="server">
                           <asp:GridView ID="gvBatchAssessments" SelectedRowStyle-BackColor="Silver" CssClass="table table-hover table-bordered"  DataKeyNames="" runat="server" AutoGenerateColumns="true" BackColor="White"
                                BorderColor="#3366CC" BorderStyle="None"
                                BorderWidth="1px" CellPadding="4">
                                <RowStyle BackColor="White" ForeColor="#003399" />
                                <Columns>
                                
                                </Columns> 
                                <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                                <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                                <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                                <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
                            </asp:GridView>
                     </asp:Panel>
                    </div>
                </div>
                
            </asp:Panel>


            <!-- PAGE CONTENT ENDS -->
        </div>
        <!-- /.col -->
    </div>
    <!-- End Student Attendance Dashboard -->

    <!--Outstandings from Students-->
    <div class="row">
            <div class="col-xs-12">
                <!--Pannel To display Customer Receivables/Payables-->
                <asp:Panel ID="pnlCustomerDashoard" Class="span10" ScrollBars="Vertical" runat="server">
                    <asp:Panel ID="pnlCustomerFilter"  runat="server">
                            <div class="col-xs-12">
                                <div class="col-sm-5">
                                <strong>Centre :</strong>
                                <asp:DropDownList ID="ddlLocation" DataTextField="OrganizationName" DataValueField="OrganizationID" runat="server">
                                   </asp:DropDownList>
                                <asp:Button ID="btnService" class="btn btn-sm btn-info"  Text="GO" OnCommand="GetCustomerBalanceReport" CommandName="Services" runat="server" />
                                </div>
                                <div class="col-sm-5">
                                <asp:ImageButton ImageUrl="~/Images/excelExport.png" Visible="true" Height="30px" Width="30px" ToolTip="ExportToExcel" OnCommand="GetCustomerBalanceReport" CommandName="Services" CommandArgument="exportToExcel"   runat="server" />                             
                          
                               <strong>Total Outstandings:</strong>
                                <asp:Label class="name" ID="lblBalanceTotal" runat="server"></asp:Label> 
                                </div>
                          </div>                   
                        </asp:Panel>
                                           
                        <asp:GridView ID="gvCustomerServiceBalance" CssClass="table table-hover table-bordered"  AlternatingRowStyle-BackColor="Silver" AutoGenerateColumns="false" CellPadding="4" GridLines="both" 
                            AllowSorting="true" AllowPaging="false" OnPageIndexChanging="OnServiceRevenuePageIndexChanging" PagerStyle-Mode="NumericPages" PageSize="20" RowStyle-HorizontalAlign="center" runat="server">
                            <HeaderStyle Font-Names="Arial" Font-Size="10pt" Font-Bold="false" BackColor="#333333" ForeColor="#FFFFFF" />
                            <RowStyle Font-Names="Arial" Font-Size="8pt" ForeColor="#000000" ></RowStyle>
                            <Columns>
                                <asp:BoundField DataField="StudentID" HeaderText="ID"></asp:BoundField>
                                <asp:BoundField DataField="Name" HeaderText="Name" Visible="true"></asp:BoundField>
                                <asp:BoundField DataField="PhoneOne" HeaderText="Contact"></asp:BoundField>
                                <asp:BoundField DataField="ServiceDate" HeaderText="Service Date"></asp:BoundField> 
                                <asp:BoundField DataField="BalanceAmount" HeaderText="Balance"></asp:BoundField>
                           
                            </Columns>
                            <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                                <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                                <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                                <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />                           
                        </asp:GridView><br />

                         <%--<asp:GridView ID="gvCustomerProductBalance" AlternatingRowStyle-BackColor="Silver" AutoGenerateColumns="false" CellPadding="4" GridLines="both" 
                            AllowSorting="true" AllowPaging="false" OnPageIndexChanging="OnServiceRevenuePageIndexChanging" PagerStyle-Mode="NumericPages" PageSize="20" RowStyle-HorizontalAlign="center" runat="server">
                            <HeaderStyle Font-Names="Arial" Font-Size="10pt" Font-Bold="false" BackColor="#333333" ForeColor="#FFFFFF" />
                            <RowStyle Font-Names="Arial" Font-Size="8pt" ForeColor="#000000" ></RowStyle>
                            <Columns>
                                <asp:BoundField DataField="StudentID" HeaderText="ID"></asp:BoundField>
                                <asp:BoundField DataField="Name" HeaderText="Name" Visible="true"></asp:BoundField>
                                <asp:BoundField DataField="PhoneOne" HeaderText="Contact"></asp:BoundField>
                                <asp:BoundField DataField="dtOfPurchase" HeaderText="PurchaseDate"></asp:BoundField> 
                                <asp:BoundField DataField="BalanceAmount" HeaderText="Balance"></asp:BoundField>
                           
                            </Columns>                      
                        </asp:GridView><br />--%>


                        &nbsp &nbsp &nbsp &nbsp &nbsp
                        <asp:ImageButton ImageUrl="~/Images/Return.png" Height="30px" Width="30px" ToolTip="Return" OnCommand="ManageDashboardPanels"  CommandName="FromPnlServicesRevenueToNoPanel" runat="server" />&nbsp &nbsp &nbsp 
                   
                </asp:Panel>
            </div>
     </div>
     <!--End Outstandings from Students-->

    <!--Expenses-->
    <div class="row">
            <div class="col-xs-12">
                <!--Pannel To display Expenses -->
                <asp:Panel ID="pnlExpensesDashboard"  ScrollBars="Vertical" runat="server">
                    <asp:Panel ID="pnlFilterExpenses"   runat="server">
                            <table  class="table  table-bordered table-hover">
                                <tr>
                                <td><strong>From:</strong></td>
                                <td><asp:TextBox ID="txtBoxExpFrom" Type="Date"   runat="server"></asp:TextBox></td>
                                <td><strong>To:</strong></td>
                                <td><asp:TextBox ID="txtBoxExpTo" Type="Date"   runat="server"></asp:TextBox></td>
                            </tr>
                                <tr>                     
                                    <th><strong>Store:</strong></th>
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
                                    <td><asp:Button ID="btnAllExp" class="btn-sm btn-info"  Text="All" OnCommand="GetExpensesReport" CommandName="AllExpensesByDate" runat="server" />
                                        <asp:ImageButton ImageUrl="~/Images/excelExport.png" Height="30px" Width="30px" ToolTip="ExportToExcel" OnCommand="GetExpensesReport" CommandName="AllExpensesByDate" CommandArgument="exportToExcel" runat="server" /></td>
                                
                                    <td><asp:Button ID="btnSepcificExp" class="btn-sm btn-info"  Text="Specific" OnCommand="GetExpensesReport" CommandName="ExpensesByDateByGroupByStore" runat="server" />
                                        <asp:ImageButton ImageUrl="~/Images/excelExport.png" Height="30px" Width="30px" ToolTip="ExportToExcel" OnCommand="GetExpensesReport" CommandName="ExpensesByDateByGroupByStore" CommandArgument="exportToExcel" runat="server" /></td>
                                
                            </tr>
                                <tr>
                                    <td><strong>Total:</strong></td>
                                    <td><asp:Label class="name" ID="lblTotalExpenses" runat="server"></asp:Label></td>

                                </tr>
                          </table>                   
                        </asp:Panel>
                                          
                        <asp:GridView ID="gvExpensesDashboard" CssClass="table table-hover table-bordered" AlternatingRowStyle-BackColor="Silver" AutoGenerateColumns="false" CellPadding="10" CellSpacing="4" GridLines="both" 
                            AllowSorting="true" AllowPaging="false" OnPageIndexChanging="OnExpensesPageIndexChanging" PagerStyle-Mode="NumericPages" PageSize="20" RowStyle-HorizontalAlign="center" runat="server">
                            <HeaderStyle Font-Names="Arial" Font-Size="10pt" Font-Bold="false" BackColor="#333333" ForeColor="#FFFFFF" />
                            <RowStyle Font-Names="Arial" Font-Size="8pt" ForeColor="#000000" ></RowStyle>
                            <Columns>
                                <asp:BoundField DataField="SalonID" HeaderText="Site"></asp:BoundField>
                                <asp:BoundField DataField="FullName" HeaderText="Spender"></asp:BoundField>
                                <asp:BoundField DataField="ExpenseTitle" HeaderText="Expense"></asp:BoundField>
                                <asp:BoundField DataField="ExpenseDetails" HeaderText="Details"></asp:BoundField>
                                <asp:BoundField DataField="DebitAmount" HeaderText="Amount"></asp:BoundField> 
                                <asp:BoundField DataField="ExpenseDate" HeaderText="Date"></asp:BoundField>
                                <asp:BoundField DataField="PaymentMode" HeaderText="Payment Mode"></asp:BoundField>
                                <asp:BoundField DataField="ConfirmationString" HeaderText="Pay Code"></asp:BoundField>
                            </Columns>                           
                        </asp:GridView><br />
                        &nbsp<asp:ImageButton ImageUrl="~/Images/Return.png" Height="30px" Width="30px" ToolTip="Return" OnCommand="ManageDashboardPanels"  CommandName="FromPnlServicesRevenueToNoPanel" runat="server" />&nbsp &nbsp &nbsp 
                    
                </asp:Panel>
            </div>
    </div>
     <!--End Expenses-->

</asp:Content>
