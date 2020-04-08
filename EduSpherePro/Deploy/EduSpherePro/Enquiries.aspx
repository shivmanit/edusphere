<%@ Page Title="" Language="C#" Async="true" MasterPageFile="~/EduSpherePro/EduSpherePro.Master" AutoEventWireup="true" EnableEventValidation="false" CodeBehind="Enquiries.aspx.cs" Inherits="EduSpherePro.EduSpherePro.Enquiries" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <audio id="audio" src="http://www.soundjay.com/button/beep-07.wav" autostart="false" ></audio>
    <script type="text/javascript">
    function playSound() {
          var sound = document.getElementById("audio");
          sound.play();
      }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  <!--Page Headers-->
    <div class="row">
        <div class="col-sm-3">
            <h4 class="pink">
                <i class="ace-icon fa fa-hand-o-right icon-animated-hand-pointer blue"></i>
                <asp:Label ID="lblEnquiryAction" Text="" runat="server"></asp:Label>
            </h4>
        </div>
        <div class="col-sm-3">
            <div class="input-group">
                <span class="input-group-addon">
                    <i class="ace-icon fa fa-check"></i>
                </span>
                <asp:TextBox class="form-control search-query" ID="txtBoxSearchEnquiry" Placeholder="Name or Phone" runat="server"></asp:TextBox>
                <span class="input-group-btn">
                    <asp:LinkButton ID="lnkBtnSerachEnquiry" class="btn btn-purple btn-sm" Text="<span class='ace-icon fa fa-search icon-on-right bigger-110'></span> Search" OnCommand="ManageEnquiryVisibility" CommandName="SearchEnquiry" runat="server"></asp:LinkButton>
                </span> 
            </div>
        </div>
        <!--Page Buttons-->
        <div class="col-sm-4">
                    <div id="membersbar" class="navbar-buttons navbar-header pull-right" role="navigation">
					    <ul class="nav ace-nav">
						    <li class="light-blue dropdown-modal">
							    <a data-toggle="dropdown" href="#" class="dropdown-toggle">
                                    Leads <i class="ace-icon fa fa-caret-down"></i> 
							    </a>
							    <ul class="user-menu dropdown-menu-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">
						            <li>
                                        <asp:LinkButton ID="lnkBtnAddEnquiry" class="btn btn-xs btn-info" Text="<i class='ace-icon fa fa-plus bigger-120'></i>Generate Lead" ToolTip="New Lead" OnCommand="ManageEnquiryVisibility" CommandName="AddEnquiry" runat="server"></asp:LinkButton>
								    </li>
								    <li class="divider"></li>
                                    <li>
                                        <asp:LinkButton ID="lbkBtnViewLeads" class="btn btn-xs btn-info" Text="<i class='ace-icon fa fa-eye bigger-120'></i> View Leads" ToolTip="View Leads" OnCommand="ManageEnquiryVisibility" CommandName="StatusFilter" CommandArgument="ALL" runat="server"></asp:LinkButton>
								    </li>
								    <li class="divider"></li>
								    <li>
									   <!-- Trigger the modal with a button -->
                                        <asp:LinkButton ID="lnkBtnFilterModal" data-toggle="modal" data-target="#filterModal" class="btn btn-xs btn-info" Text="<i class='ace-icon fa fa-filter bigger-120'></i> Apply Filters" ToolTip="Apply Filter" runat="server" ></asp:LinkButton>
                                       
								    </li>
                                    <li class="divider"></li>
								    
							    </ul>
						    </li>
					    </ul>
				    </div>
              
          </div>
        <!--End Page Buttons-->
    </div>
    <div class="hr hr-18 dotted hr-double"></div>


   
   

    <!--New Enquiry -->
    <div class="row">
        <div class="col-xs-12">
            <!-- PAGE CONTENT BEGINS -->
            <!--Add New Enquiry-->
            <asp:Panel ID="pnlAddEnquiry" ScrollBars="Auto" runat="server">
                <form class="form-horizontal" role="form">
                    <table id="simple-table" class="table  table-bordered table-hover">
                        <tbody>
                            <tr>
                                <th class="col-sm-1">Program  Group</th>
                                <td><asp:DropDownList ID="ddlProgramGroup"  DataTextField="ProgramGroup" DataValueField="ProgramGroupId" OnSelectedIndexChanged="ddlProgramGroup_SelectedIndexChanged" AutoPostBack="true" runat="server"></asp:DropDownList></td>
                                <th class="col-sm-1">Program</th>
                                <td><asp:DropDownList ID="ddlProgramId" DataTextField="ProgramTitle" DataValueField="ProgramId" runat="server"></asp:DropDownList></td>
                            </tr>
                            <tr>
                                <th class="col-sm-1">Preferred Centre</th>
                                <td><asp:DropDownList ID="ddlFranchiseeID" DataTextField="OrganizationName" DataValueField="OrganizationId" runat="server"></asp:DropDownList></td>
                                <th class="col-sm-1">Comments</th>
                                <td><asp:TextBox ID="txtBoxEnquiryMessage" TextMode="MultiLine" runat="server"></asp:TextBox></td> 
                            </tr>
                            <tr>
                                <th class="col-sm-1">Name</th>
                                <td><asp:TextBox ID="txtBoxStudentName" runat="server"></asp:TextBox></td>
                                <th class="col-sm-1">City</th>
                                <td><asp:TextBox ID="txtBoxCity" runat="server"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <th class="col-sm-1">Email</th>
                                <td><asp:TextBox ID="txtBoxEmail" runat="server"></asp:TextBox></td>
                                <th class="col-sm-1">Phone</th>
                                <td><asp:TextBox ID="txtBoxPhone" runat="server"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <th class="col-sm-1">Gender</th>
                                <td><asp:DropDownList ID="ddlGender" runat="server">
                                        <asp:ListItem>MALE</asp:ListItem>
                                        <asp:ListItem>FEMALE</asp:ListItem>
                                    </asp:DropDownList></td>
                                <th class="col-sm-1">Education</th>
                                <td><asp:TextBox ID="txtBoxEducation" placeholder="highest education" runat="server"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <th class="col-sm-1">School/College</th>
                                <td><asp:TextBox ID="txtBoxInstitute" runat="server"></asp:TextBox></td>
                                <th class="col-sm-1">Stream</th>
                                <td><asp:TextBox ID="txtBoxStream" placeholder="Science/Commenrce/Arts" runat="server"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <th class="col-sm-1">State</th>
                                <td><asp:TextBox ID="txtBoxState" runat="server"></asp:TextBox></td>
                                <th class="col-sm-1">PinCode</th>
                                <td><asp:TextBox ID="txtBoxPinCode" runat="server"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <th class="col-sm-1">Raised By Id</th>
                                <td><asp:Label ID="lblRaisedById"  runat="server"></asp:Label></td>
                                <th class="col-sm-1">Enquiry Source</th>
                                <td><asp:TextBox ID="txtBoxSource" placeholder="Enquiry Source"  runat="server"></asp:TextBox></td>
                            </tr>
                            
                        </tbody>
                    </table>


                    <div class="clearfix form-actions">
                        <div class="col-md-offset-3 col-md-9">
                            <asp:LinkButton ID="btnSubmit" class="btn btn-info" Text='<i class="ace-icon fa fa-check bigger-110"></i>Submit' OnCommand="AddNewEnquiry" runat="server"></asp:LinkButton>
                            &nbsp; &nbsp; &nbsp;
                             <asp:LinkButton ID="btnReturn" class="btn btn-purple" Text="<span class='ace-icon fa fa-undo icon-on-right bigger-110'></span> Return" OnCommand="ManageEnquiryVisibility" CommandName="ReturnToViewEnquiry" runat="server"></asp:LinkButton>
							
                        </div>
                    </div>
                    <br />
                    <br />
                </form>
            </asp:Panel>
        </div>
        <!-- /.col -->
    </div>
    <!-- /.row -->

    <!--View  Enquiries -->
    <div class="row">
        <div class="col-xs-12">

            <!-- Filter Modal -->
            <div id="filterModal" class="modal fade" role="dialog">
              <div class="modal-dialog modal-lg">

                <!-- Modal content-->
                <div class="modal-content">
                  <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Apply Filters</h4>
                  </div>
                  <div class="modal-body">
                     <table class="table table-hover table-bordered">
                        <tr>
                            <th>From</th>
                            <td><asp:TextBox ID="txtBoxFromDate" Text="dd/mm/yyyy" runat="server"></asp:TextBox></td>
                             <th>To</th>
                             <td><asp:TextBox  ID="txtBoxToDate" Text="dd/mm/yyyy" runat="server"></asp:TextBox></td>
                          </tr>
                         <tr>   
                       
                            <th class="col-sm-2">Centre</th>
                            <td class="col-sm-4">
                                <asp:DropDownList ID="ddlFilterOrganizationName" DataTextField="OrganizationName" DataValueField="OrganizationID" runat="server"></asp:DropDownList></td>
                            <th class="col-sm-2">Enquiry Status</th>
                            <td class="col-sm-2">
                                <asp:DropDownList ID="ddlFilterEnquiryStatus" runat="server">
                                    <asp:ListItem>Select</asp:ListItem>
                                    <asp:ListItem>NEW</asp:ListItem>
                                    <asp:ListItem>PROSPECTS</asp:ListItem>
                                    <asp:ListItem>TELECALL</asp:ListItem>
                                    <asp:ListItem>COUNSELLING</asp:ListItem>
                                    <asp:ListItem>FOLLOWUP</asp:ListItem>
                                    <asp:ListItem>CONVERTED</asp:ListItem>
                                    <asp:ListItem>COLD</asp:ListItem>
                                </asp:DropDownList></td>
                            <td class="col-sm-2">
                                <asp:LinkButton ID="btnFilterEnquiry" class="btn btn-xs btn-info" Text="<i class='ace-icon fa fa-filter bigger-120'> GO</i>" ToolTip="Filter Enquiry" OnCommand="ManageEnquiryVisibility" CommandName="FilterEnquiry" CommandArgument="" runat="server"></asp:LinkButton></td>
                        </tr>
                    </table>
                  </div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                  </div>
                </div>

              </div>
            </div>
            <!--End Filter Modal-->

            <!--History Modal-->
            <div id="historyModal" class="modal fade" role="dialog">
              <div class="modal-dialog modal-lg">

                <!-- Modal content-->
                <div class="modal-content">
                  <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Apply Filters</h4>
                  </div>
                  <div class="modal-body">
                    
                  </div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                  </div>
                </div>

              </div>
            </div>
            <!--End History Modal-->

            <!--View Enquiry-->
            <asp:Panel ID="pnlViewEnquiry"  ScrollBars="Auto" runat="server">
                <!--Enquiries-->
                <div class="col-xs-12">
                     <!--Tabbed-->
                <div class="col-sm-12 widget-container-col" id="widget-container-col-10">
                    <div class="widget-box" id="widget-box-10">
                       <div class="widget-header widget-header-small">
						    <h5 class="widget-title smaller">Leads Management </h5>
                           <div class="col-sm-2">
                                <a data-toggle="dropdown" class="dropdown-toggle" href="#">
				                    <i class="ace-icon fa fa-bell icon-animated-bell">New</i>
				                    <span class="badge badge-important"><asp:Label ID="lblCountEnquiries" runat="server"></asp:Label></span>
			                    </a>
                            </div>
						    <div class="widget-toolbar no-border">
							    <ul class="nav nav-tabs" id="myTab">
                                    <li>
									    <a data-toggle="" href="#"><asp:LinkButton ID="LinkButton9" class="btn btn-xs btn-info" Text="<i class='ace-icon fa fa-eye bigger-120'></i> All" ToolTip="View New" OnCommand="ManageEnquiryVisibility" CommandName="StatusFilter" CommandArgument="ALL" runat="server"></asp:LinkButton></a>
								    </li>
								    <li>
									    <a data-toggle="" href="#"> <asp:LinkButton ID="LinkButton2" class="btn btn-xs btn-warning" Text="<i class='ace-icon fa fa-eye bigger-120'></i> New" ToolTip="View New" OnCommand="ManageEnquiryVisibility" CommandName="StatusFilter" CommandArgument="NEW" runat="server"></asp:LinkButton></a>
								    </li>
								    <li>
									    <a data-toggle="" href="#"></a><asp:LinkButton ID="LinkButton3" class="btn btn-xs btn-info" Text="<i class='ace-icon fa fa-eye bigger-120'></i> Prospects" ToolTip="View Prospects" OnCommand="ManageEnquiryVisibility" CommandName="StatusFilter" CommandArgument="PROSPECTS" runat="server"></asp:LinkButton>
								    </li>
                                    <li>
									    <a data-toggle="" href="#telecalling"></a><asp:LinkButton ID="LinkButton4" class="btn btn-xs btn-warning" Text="<i class='ace-icon fa fa-eye bigger-120'></i> TeleCalling" ToolTip="View TeleCalling" OnCommand="ManageEnquiryVisibility" CommandName="StatusFilter" CommandArgument="TELECALL" runat="server"></asp:LinkButton>
								    </li>
                                    <li>
									    <a data-toggle="" href="#"></a><asp:LinkButton ID="LinkButton5" class="btn btn-xs btn-info" Text="<i class='ace-icon fa fa-eye bigger-120'></i> Walkins/Counselling" ToolTip="View Counselling" OnCommand="ManageEnquiryVisibility" CommandName="StatusFilter" CommandArgument="COUNSELLING" runat="server"></asp:LinkButton>
								    </li>
                                    <li>
									    <a data-toggle="" href="#"></a><asp:LinkButton ID="LinkButton8" class="btn btn-xs btn-warning" Text="<i class='ace-icon fa fa-eye bigger-120'></i> FollowUp" ToolTip="View Converted" OnCommand="ManageEnquiryVisibility" CommandName="StatusFilter" CommandArgument="FOLLOWUP" runat="server"></asp:LinkButton>
								    </li>
                                    <li>
									    <a data-toggle="" href="#"></a><asp:LinkButton ID="LinkButton6" class="btn btn-xs btn-info" Text="<i class='ace-icon fa fa-eye bigger-120'></i> Converted" ToolTip="View Converted" OnCommand="ManageEnquiryVisibility" CommandName="StatusFilter" CommandArgument="CONVERTED" runat="server"></asp:LinkButton>
								    </li>
                                    <li>
									    <a data-toggle="" href="#"></a><asp:LinkButton ID="LinkButton7" class="btn btn-xs btn-warning" Text="<i class='ace-icon fa fa-eye bigger-120'></i> Cold" ToolTip="View Counselling" OnCommand="ManageEnquiryVisibility" CommandName="StatusFilter" CommandArgument="COLD" runat="server"></asp:LinkButton>
								    </li>
							    </ul>
						    </div>
					    </div>

                       <!--Tab Body-->
					    <div class="widget-body">
                            <div class="widget-main padding-2">
								<div class="tab-content">
                                    <div id="all" class="tab-pane in active">
                                       <!--Tabs not used-->
                                        <div class="row">
                                        <asp:GridView ID="gvEnquiry" DataKeyNames="EnquiryId" OnRowDataBound="gvEnquiry_RowDataBound" OnRowCommand="gvEnquiry_RowCommand"  CssClass="table table-hover table-bordered" AlternatingRowStyle-BackColor="" HorizontalAlign="left" AutoGenerateColumns="false" BorderWidth="1" CellPadding="4" GridLines="both"
                                             
                                               BackColor="White" BorderColor="#3366CC" BorderStyle="None" AllowSorting="true"   AllowPaging="false"  PagerStyle-Mode="NumericPages" PageSize="100" RowStyle-HorizontalAlign="left" runat="server">
                           
                                                <RowStyle Font-Names="Arial" Font-Size="9pt" ForeColor="#003399" ></RowStyle>
                                                <Columns>
                                                    <asp:TemplateField HeaderText="E">
                                                        <ItemTemplate>
                                                         <asp:LinkButton ID="lnkBtnEdit" class="green bigger-120 show-details-btn" Text="<i class='ace-icon fa fa-edit bigger-120'></i>" ToolTip="ModifyEnquiryStatus"     CommandName="EditProfile" CommandArgument='<%# Eval("EnquiryId")%>'  runat="server"></asp:LinkButton>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="H">
                                                        <ItemTemplate>
                                                         <asp:LinkButton ID="lnkBtnHistory" class="orange bigger-120 show-details-btn" Text="<i class='ace-icon fa fa-history bigger-120'></i>" ToolTip="Status History"     CommandName="ViewEnquiryStatusModifications" CommandArgument='<%# Eval("EnquiryId")%>'  runat="server"></asp:LinkButton>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="RaisedOn" DataFormatString="{0:dd:MM:yyyy h:mmtt}" HeaderText="Date Received"></asp:BoundField>
                                                    <asp:BoundField DataField="EnquiryId"  HeaderText="Id"></asp:BoundField>
                                                    <asp:BoundField DataField="EnquiryStatus" HeaderText="Status"></asp:BoundField>
                                                    <asp:BoundField DataField="StudentName" HeaderText="Student"></asp:BoundField>
                                                    <asp:BoundField DataField="Email" HeaderText="Email"></asp:BoundField>
                                                    <asp:BoundField DataField="Phone" HeaderText="Phone"></asp:BoundField>                                 
                                                    <asp:BoundField DataField="Education" HeaderText="Education"></asp:BoundField>
                                                    <asp:TemplateField HeaderText="M">
                                                        <ItemTemplate>
                                                         <asp:LinkButton ID="lnkBtnDetails" class="orange bigger-120 show-details-btn" Text="<i class='ace-icon fa fa-angle-double-down bigger-120'></i>" ToolTip="Details"    CommandName="ViewProfile" CommandArgument='<%#Eval("EnquiryId")+";"+Eval("RaisedOn","{0:MMM/dd/yyyy}")  %>'  runat="server"></asp:LinkButton>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="Owner" HeaderText="Owner"></asp:BoundField>
                                                    <asp:BoundField DataField="Assigned" HeaderText="Assigned To"></asp:BoundField>
                                                    <asp:BoundField DataField="LastUpdated" DataFormatString="{0:dd:MM:yyyy h:mmtt}" HeaderText="Date Updated"></asp:BoundField>                                 
                                                    <asp:BoundField DataField="ProgramTitle" HeaderText="Enquiry For"></asp:BoundField>
                                                    <asp:BoundField DataField="Comments" HeaderText="Comments"></asp:BoundField>
                                                    <asp:BoundField DataField="OrganizationName" HeaderText="Centre"></asp:BoundField>
                                                </Columns>
                                                <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                                                <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                                                <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                                                <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />                           
                                        </asp:GridView>
                                        </div>
                                    </div>
                                    <div id="new" class="tab-pane in active">
                                      
                                    </div>
                                    <div id="telecalling" class="tab-pane">
                                    </div>
                                    <div id="counselling" class="tab-pane">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                </div>
                <!--End Tabbed-->
                </div>
                <!-- /.span -->
            </asp:Panel>
            <!-- PAGE CONTENT ENDS -->
        </div>
        <!-- /.col -->
    </div>
    <!-- /.row -->

    <!--View Selected Enquiry Profile-->
    <div class="row">
        <div class="col-xs-12">
            <!--View Enquiry Profile-->
            <asp:Panel ID="pnlViewEnquiryProfile" ScrollBars="Auto" runat="server">
                <div class="col-xs-12">
                    CSR Age :
                    <asp:Label ID="EnquiryAgeYears" runat="server"></asp:Label>&nbsp years
                       <asp:Label ID="EnquiryAgeMonths" runat="server"></asp:Label>&nbsp months
                    <asp:Label ID="EnquiryAgeDays" runat="server"></asp:Label>&nbsp days
                      
                    <asp:DataList ID="dlEnquiryDetails" DataKeyField="EnquiryId" HorizontalAlign="Justify" RepeatColumns="1" RepeatDirection="horizontal" GridLines="Vertical" runat="server">
                        <HeaderTemplate>
                        </HeaderTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                        <ItemTemplate>
                            <table id="simple-table" class="table  table-bordered table-hover">
                                <tbody>
                                    <tr style="background-color:orange;">
                                        <td colspan="4"></td>
                                    </tr>
                                    <tr>
                                        <th>Enquiry ID</th><td><%#Eval("EnquiryId")%></td>
                                        <th>Raised On</th><td><%#Eval("RaisedOn","{0:MMM/dd/yyyy}")%></td>
                                    </tr>
                                    <tr>
                                        <th>Program</th><td><%#Eval("ProgramTitle")%></td>
                                        <th>Message</th><td><%#Eval("EnquiryMessage")%></td>
                                    </tr>
                                    <tr>
                                        <th>Student Name</th><td><%#Eval("StudentName")%></td>
                                        <th>Email</th><td><%#Eval("Email")%></td>
                                    </tr>
                                    <tr>
                                        <th>Phone</th><td><%#Eval("Phone")%></td>
                                        <th>Education</th><td><%#Eval("Education")%></td>
                                    </tr>
                                     <tr>
                                        <th>State</th><td><%#Eval("State")%></td>
                                        <th>PinCode</th><td><%#Eval("PinCode")%></td>
                                    </tr>
                                    
                                    
                                  
                                   

                                    <tr>
                                        <td colspan="4">
                                            <div class="hidden-sm hidden-xs btn-group">

                                                <asp:LinkButton ID="lnkBtnEditEnquiryDetails" class="btn btn-xs btn-info" Text="<i class='ace-icon fa fa-pencil bigger-120'></i>" ToolTip="Edit Profile" OnCommand="ManageEnquiryVisibility" CommandName="EditProfile" CommandArgument='<%#Eval("EnquiryId")%>' runat="server"></asp:LinkButton>
                                                <asp:LinkButton ID="LinkButton1" class="btn btn-xs btn-info" Text="<i class='ace-icon fa fa-times bigger-120 white'></i>" ToolTip="Cancel" OnCommand="ManageEnquiryVisibility" CommandName="ReturnToViewEnquiry" runat="server"></asp:LinkButton>


                                            </div>

                                            <div class="hidden-md hidden-lg">
                                                <div class="inline pos-rel">
                                                    <button class="btn btn-minier btn-primary dropdown-toggle" data-toggle="dropdown" data-position="auto">
                                                        <i class="ace-icon fa fa-cog icon-only bigger-110"></i>
                                                    </button>

                                                    <ul class="dropdown-menu dropdown-only-icon dropdown-yellow dropdown-menu-right dropdown-caret dropdown-close">
                                                        <li>
                                                            <a href="#" class="tooltip-info" data-rel="tooltip" title="View">
                                                                <span class="blue">
                                                                    <i class="ace-icon fa fa-search-plus bigger-120"></i>
                                                                </span>
                                                            </a>
                                                        </li>

                                                        <li>
                                                            <a href="#" class="tooltip-success" data-rel="tooltip" title="Edit">
                                                                <span class="green">
                                                                    <i class="ace-icon fa fa-pencil-square-o bigger-120"></i>
                                                                </span>
                                                            </a>
                                                        </li>

                                                        <li>
                                                            <a href="#" class="tooltip-error" data-rel="tooltip" title="Delete">
                                                                <span class="red">
                                                                    <i class="ace-icon fa fa-trash-o bigger-120"></i>
                                                                </span>
                                                            </a>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>

                                </tbody>
                            </table>
                        </ItemTemplate>
                    </asp:DataList>

                </div>
                <!-- /.span -->
            </asp:Panel>
            <!-- PAGE CONTENT ENDS -->
        </div>
        <!-- /.col -->
    </div>
    <!-- /.row -->

    <!--Edit and Save Enquiry Profile-->
    <div class="row">
        <div class="col-xs-12">
            <!--View Enquiry -->
            <asp:Panel ID="pnlEditEnquiryProfile" ScrollBars="Auto" runat="server">
                <div class="col-xs-12">
                    <asp:DataList ID="dlEditEnquiryProfile" DataKeyField="EnquiryId" OnUpdateCommand="UpdateEnquiryProfile" HorizontalAlign="Justify" RepeatColumns="1" RepeatDirection="horizontal" GridLines="Vertical" runat="server">
                        <HeaderTemplate>
                        </HeaderTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                        <ItemTemplate>
                            <table id="simple-table" class="table  table-bordered table-hover">
                                <tbody>
                                    <tr>
                                        <th class="col-sm-2">Owner</th>
                                        <td><%# Eval("Owner") %><asp:Label id="lblCurrentOwnerId" Visible="false" Text=<%# Eval("OwnerEmployeeId") %> runat="server"></asp:Label>&nbsp <strong>Change:</strong> <asp:DropDownList ID="ddlEditOwnerEmployeeId"  DataTextField="FullName" DataValueField="EmployeeId" runat="server"></asp:DropDownList></td>
                                        <th class="col-sm-2">EnqId</th><td><%#Eval("EnquiryId") %></td>
                                    </tr>
                                    <tr>
                                        <th class="col-sm-2">Prefered Centre</th><td><%# Eval("Centre") %><asp:Label id="lblCurrentFranchiseeID" Visible="true" Text=<%# Eval("FranchiseeID") %> runat="server"></asp:Label> &nbsp <strong>Change:<asp:DropDownList ID="ddlEditFranchiseeId"  DataTextField="OrganizationName" DataValueField="OrganizationId" runat="server"></asp:DropDownList></td>
                                         <th class="col-sm-2">Counseller</th>
                                         <td><%# Eval("Assigned") %> <asp:Label id="lblCurrentAssignedId" Visible="false" Text=<%# Eval("AssignedEmployeeId") %> runat="server"></asp:Label>&nbsp <strong>Change:</strong><asp:DropDownList ID="ddlEditAssignedEmployeeId"  DataTextField="FullName" DataValueField="EmployeeId" runat="server"></asp:DropDownList></td>
                                    </tr>
                                    <tr>
                                        <th class="col-sm-2">Enquiry Status</th><td><asp:DropDownList  ID="ddlEditEnquiryStatus" OnSelectedIndexChanged="OnEnquiryStatus_Changed" AutoPostBack="true" runat="server">
                                                                                    <asp:ListItem>Select CSR Status</asp:ListItem>
                                                                                    <asp:ListItem>PROSPECTS</asp:ListItem>
                                                                                    <asp:ListItem>TELECALL</asp:ListItem>
                                                                                    <asp:ListItem>COUNSELLING</asp:ListItem>
                                                                                    <asp:ListItem>FOLLOWUP</asp:ListItem>
                                                                                    <asp:ListItem>CONVERTED</asp:ListItem>
                                                                                    <asp:ListItem>COLD</asp:ListItem>
                                                                                </asp:DropDownList></td>

                                        <th class="col-sm-2">Name</th><td><asp:TextBox ID="txtBoxEditStudentNames"  Text=<%#Eval("StudentName") %>    runat="server"></asp:TextBox></td>
                                    </tr>
                                    
                                    <tr>
                                        <th class="col-sm-2">Final Status</th><td></td>
                                         <th class="col-sm-2">Modified By</th>
                                        <td><asp:DropDownList ID="ddlEditModifiedByEmployeeId" DataTextField="FullName" DataValueField="EmployeeId" runat="server"></asp:DropDownList></td>
                                        
                                    </tr>
                                    <tr>
                                        <th class="col-sm-2">Modification Comments</th><td><asp:TextBox ID="txtBoxEditMoficationComments" CssClass="col-lg-12" TextMode="MultiLine" runat="server"></asp:TextBox></td>
                                        <th class="col-sm-2">Attachment Title</th><td><asp:TextBox ID="txtBoxEditAttachmentTitle" runat="server"></asp:TextBox></td>
                                    </tr>
                                     
                                    <tr>
                                        <th class="col-sm-2">Attachment</th>
                                        <td><asp:FileUpload ID="flEnquiryModification" CssClass="" runat="server"></asp:FileUpload><asp:Label ID="lblCloseWarning" class="label label-sm label-warning" runat="server"></asp:Label></td>
                                        <th class="col-sm-2"><asp:LinkButton ID="btnFileUpload_EnquiryModification" class="btn btn-app btn-purple btn-sm" Text='<i class="ace-icon fa fa-cloud-upload bigger-200"></i>' OnCommand="btnFileUpload_EnquiryModification_Command" CommandName="flEnquiryModification" runat="server"></asp:LinkButton></th>
                                        <td><asp:Label ID="lblModificationAttachment" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td colspan="4">
                                            <div class="hidden-sm hidden-xs btn-group">
                                                <asp:LinkButton ID="lnkBtnUpdateEnquiryProfile" class="btn btn-white btn-info btn-bold" Text="<i class='ace-icon fa fa-floppy-o bigger-120 blue'> Save</i>" ToolTip="Save" CommandName="Update" runat="server"></asp:LinkButton>
                                                <asp:LinkButton ID="lnkBtnReturnToViewCusatomers" class="btn btn-white btn-default btn-round" Text="<i class='ace-icon fa fa-times red2'> Cancel</i>" ToolTip="Cancel" OnCommand="ManageEnquiryVisibility" CommandName="ReturnToViewEnquiry" runat="server"></asp:LinkButton>
                                            </div>

                                            <div class="hidden-md hidden-lg">
                                                <div class="inline pos-rel">
                                                    <button class="btn btn-minier btn-primary dropdown-toggle" data-toggle="dropdown" data-position="auto">
                                                        <i class="ace-icon fa fa-cog icon-only bigger-110"></i>
                                                    </button>
                                                    <ul class="dropdown-menu dropdown-only-icon dropdown-yellow dropdown-menu-right dropdown-caret dropdown-close">
                                                        <li>
                                                            <asp:LinkButton ID="lnklBtnSave" class="btn btn-white btn-info btn-bold" Text="<i class='ace-icon fa fa-floppy-o bigger-120 blue'></i>" ToolTip="Save" CommandName="Update" runat="server"></asp:LinkButton>
                                                        </li>
                                                        <li>
                                                            <asp:LinkButton ID="lnkBtnCancel" class="btn btn-white btn-default btn-round" Text="<i class='ace-icon fa fa-times red2'></i>" ToolTip="Cancel" OnCommand="ManageEnquiryVisibility" CommandName="ReturnToViewEnquiry" runat="server"></asp:LinkButton>
                                                        </li>
                                                        
                                                    </ul>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>

                                </tbody>
                            </table>
                        </ItemTemplate>
                    </asp:DataList>
                </div>
                <!-- /.span -->
            </asp:Panel>


            <!-- PAGE CONTENT ENDS -->
        </div>
        <!-- /.col -->
    </div>
    <!-- /.row -->

    <!--CSR Status Modifications History-->
    <div class="row">
        <div class="col-xs-12">
            <!--View EnquiryStatusModifications History -->
            <asp:Panel ID="pnlEnquiryStatusModifications" ScrollBars="Auto" runat="server">
                <div class="col-xs-12">
                    <!--View CSR History-->
                    <asp:GridView ID="gvEnquiryStatusModifications" CssClass="table table-hover table-bordered"  DataKeyNames="ModificationId" AlternatingItemStyle-BackColor="Silver" AutoGenerateColumns="false" CellPadding="4" 
                            GridLines="both" AllowSorting="true" AllowPaging="false" PagerStyle-Mode="NumericPages" PageSize="30" ItemStyle-HorizontalAlign="left" runat="server">
                            <HeaderStyle Font-Names="Arial"   Font-Size="10pt" Font-Bold="false" BackColor="#333333" ForeColor="#FFFFFF" />
                            <RowStyle Font-Names="Arial" Font-Size="8pt" ForeColor="#000000" ></RowStyle>
                        <Columns>
                            <asp:BoundField DataField="Owner" HeaderText="Owner" />
                            <asp:BoundField DataField="Assigned" HeaderText="Consellor" />
                            <asp:BoundField DataField="OrganizationName" HeaderText="Centre" />
                            <asp:BoundField DataField="EnquiryStatus" HeaderText="Status" />
                            <asp:BoundField DataField="ModificationComments" HeaderText="Comments" />
                            <asp:BoundField DataField="ModificationDate" HeaderText="Date" />
                            <asp:BoundField DataField="ModifiedById" HeaderText="Modified by Id" />
                            <asp:BoundField DataField="ModifiedByEmployeeId" HeaderText="Modified Proxy" Visible="false" />
                      
                            <asp:HyperLinkField DataTextField="ModificationArtifactTitle" HeaderText="Attachment" DataNavigateUrlFields="ModificationAttachment" />
                        </Columns>
                        <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                        <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                        <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                        <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
                    </asp:GridView>

                </div>
                <!-- /.span -->
            </asp:Panel>


            <!-- PAGE CONTENT ENDS -->
        </div>
        <!-- /.col -->
    </div>
    <!-- /.row -->
</asp:Content>
