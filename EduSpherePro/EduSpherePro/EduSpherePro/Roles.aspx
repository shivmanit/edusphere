<%@ Page Title="" Language="C#" MasterPageFile="~/EduSpherePro/EduSpherePro.Master" AutoEventWireup="true" CodeBehind="Roles.aspx.cs" Inherits="EduSpherePro.EduSpherePro.Roles" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  <!--Page Headers-->
    <div class="row">
        <div class="col-sm-3">
            <h4 class="pink">
                <i class="ace-icon fa fa-hand-o-right icon-animated-hand-pointer blue"></i>
                <asp:Label ID="lblRoleRequestsAction" Text="" runat="server"></asp:Label>
            </h4>
        </div>
        <div class="col-sm-3">
            <div class="input-group">
                <span class="input-group-addon">
                    <i class="ace-icon fa fa-check"></i>
                </span>
                <asp:TextBox class="form-control search-query" ID="txtBoxSearchRoleRequests" Placeholder="Name or Phone" runat="server"></asp:TextBox>
                <span class="input-group-btn">
                    <asp:LinkButton ID="lnkBtnSearchRoleRequests" class="btn btn-purple btn-sm" Text="<span class='ace-icon fa fa-search icon-on-right bigger-110'></span> Search" OnCommand="ManageRoleRequestsVisibility" CommandName="SearchRoleRequests" runat="server"></asp:LinkButton>
                </span> 
            </div>
        </div>
        <!--Page Buttons-->
        <div class="col-sm-4">
                    <div id="membersbar" class="navbar-buttons navbar-header pull-right" role="navigation">
					    <ul class="nav ace-nav">
						    <li class="light-blue dropdown-modal">
							    <a data-toggle="dropdown" href="#" class="dropdown-toggle">
                                    Access <i class="ace-icon fa fa-caret-down"></i> 
							    </a>
							    <ul class="user-menu dropdown-menu-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">
						            <li>
                                        <asp:LinkButton ID="lnkBtnAddRoleRequests" class="btn btn-xs btn-info" Text="<i class='ace-icon fa fa-plus bigger-120'></i>Generate Lead" ToolTip="New Lead" OnCommand="ManageRoleRequestsVisibility" CommandName="AddRoleRequests" runat="server"></asp:LinkButton>
								    </li>
								    <li class="divider"></li>
                                    <li>
                                        <asp:LinkButton ID="lbkBtnViewLeads" class="btn btn-xs btn-info" Text="<i class='ace-icon fa fa-eye bigger-120'></i> View Access" ToolTip="View Access" OnCommand="ManageRoleRequestsVisibility" CommandName="StatusFilter" CommandArgument="ALL" runat="server"></asp:LinkButton>
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


    <!--Add New RoleRequests -->
    <div class="row">
        <div class="col-xs-12">
            <!-- PAGE CONTENT BEGINS -->
            <!--Add New RoleRequests-->
            <asp:Panel ID="pnlAddRoleRequests" ScrollBars="Auto" runat="server">
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
                                <td><asp:TextBox ID="txtBoxRoleRequestsMessage" TextMode="MultiLine" runat="server"></asp:TextBox></td> 
                            </tr>
                            <tr>
                                <th class="col-sm-1">Name</th>
                                <td><asp:TextBox ID="txtBoxStudentName" runat="server"></asp:TextBox></td>
                                <th class="col-sm-1">RequesterState</th>
                                <td><asp:TextBox ID="txtBoxCity" runat="server"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <th class="col-sm-1">RequesterEmail</th>
                                <td><asp:TextBox ID="txtBoxEmail" runat="server"></asp:TextBox></td>
                                <th class="col-sm-1">RequesterPhone</th>
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
                                <th class="col-sm-1">RoleRequests Source</th>
                                <td><asp:TextBox ID="txtBoxSource" placeholder="RoleRequests Source"  runat="server"></asp:TextBox></td>
                            </tr>
                            
                        </tbody>
                    </table>


                    <div class="clearfix form-actions">
                        <div class="col-md-offset-3 col-md-9">
                            <asp:LinkButton ID="btnSubmit" class="btn btn-info" Text='<i class="ace-icon fa fa-check bigger-110"></i>Submit' OnCommand="AddNewRoleRequests" runat="server"></asp:LinkButton>
                            &nbsp; &nbsp; &nbsp;
                             <asp:LinkButton ID="btnReturn" class="btn btn-purple" Text="<span class='ace-icon fa fa-undo icon-on-right bigger-110'></span> Return" OnCommand="ManageRoleRequestsVisibility" CommandName="ReturnToViewRoleRequests" runat="server"></asp:LinkButton>
							
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

    <!--View  Requests -->
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
                       
                            <th class="col-sm-2"></th>
                            <td class="col-sm-4">
                                <asp:DropDownList ID="ddlFilterOrganizationName" Visible="false" DataTextField="OrganizationName" DataValueField="OrganizationID" runat="server"></asp:DropDownList></td>
                            <th class="col-sm-2">Status</th>
                            <td class="col-sm-2">
                                <asp:DropDownList ID="ddlFilterRoleRequestsStatus" runat="server">
                                    <asp:ListItem>Select</asp:ListItem>
                                    <asp:ListItem>NEW</asp:ListItem>
                                    <asp:ListItem>APPROVED</asp:ListItem>
                                    <asp:ListItem>BLOCKED</asp:ListItem>
                                    
                                </asp:DropDownList></td>
                            <td class="col-sm-2">
                                <asp:LinkButton ID="btnFilterRoleRequests" class="btn btn-xs btn-info" Text="<i class='ace-icon fa fa-filter bigger-120'> GO</i>" ToolTip="Filter RoleRequests" OnCommand="ManageRoleRequestsVisibility" CommandName="FilterRoleRequests" CommandArgument="" runat="server"></asp:LinkButton></td>
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

            <!--View RoleRequests-->
            <asp:Panel ID="pnlViewRoleRequests"  ScrollBars="Auto" runat="server">
                <!--Requests-->
                <div class="col-xs-12">
                     <!--Tabbed-->
                <div class="col-sm-12 widget-container-col" id="widget-container-col-10">
                    <div class="widget-box" id="widget-box-10">
                       <div class="widget-header widget-header-small">
						    <h5 class="widget-title smaller">Access Management </h5>
                           <div class="col-sm-4">
                                <a data-toggle="dropdown" class="dropdown-toggle" href="#">
				                    <i class="ace-icon fa fa-bell icon-animated-bell pink">New</i>
				                    <span class="badge badge-important"><asp:Label ID="lblCountRequests" runat="server"></asp:Label></span>
			                    </a>
                               <a data-toggle="dropdown" class="dropdown-toggle" href="#">
				                   <i class="ace-icon fa fa-hand-o-right icon-animated-hand-pointer blue">Approved</i>
				                    <span class="badge badge-important"><asp:Label ID="lblCountRequestsApproved" runat="server"></asp:Label></span>
			                    </a>
                            </div>
						    <div class="widget-toolbar no-border">
							    <ul class="nav nav-tabs" id="myTab">
                                    <li>
									    <a data-toggle="" href="#"><asp:LinkButton ID="lnkBtnViewAllReqs" class="btn btn-xs btn-info" Text="<i class='ace-icon fa fa-eye bigger-120'></i> All" ToolTip="View New" OnCommand="ManageRoleRequestsVisibility" CommandName="StatusFilter" CommandArgument="ALL" runat="server"></asp:LinkButton></a>
								    </li>
								    <li>
									    <a data-toggle="" href="#"> <asp:LinkButton ID="lnkBtnViewNeurotherapistReqs" class="btn btn-xs btn-warning" Text="<i class='ace-icon fa fa-eye bigger-120'></i> Members" ToolTip="Members" OnCommand="ManageRoleRequestsVisibility" CommandName="StatusFilter" CommandArgument="Member" runat="server"></asp:LinkButton></a>
								    </li>
								    <li>
									    <a data-toggle="" href="#"></a><asp:LinkButton ID="lnkBtnViewStudentReqs" class="btn btn-xs btn-info" Text="<i class='ace-icon fa fa-eye bigger-120'></i> Students" ToolTip=" Students" OnCommand="ManageRoleRequestsVisibility" CommandName="StatusFilter" CommandArgument="Student" runat="server"></asp:LinkButton>
								    </li>
                                    <li>
									    <a data-toggle="" href="#telecalling"></a><asp:LinkButton ID="LinkButton4" class="btn btn-xs btn-warning" Text="<i class='ace-icon fa fa-eye bigger-120'></i> Blocked" ToolTip="View Blocked" OnCommand="ManageRoleRequestsVisibility" CommandName="StatusFilter" CommandArgument="BLOCKED" runat="server"></asp:LinkButton>
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
                                        <asp:GridView ID="gvRoleRequests" DataKeyNames="RequestId" OnRowDataBound="gvRoleRequests_RowDataBound" OnRowCommand="gvRoleRequests_RowCommand"  CssClass="table table-hover table-bordered" AlternatingRowStyle-BackColor="" HorizontalAlign="left" AutoGenerateColumns="false" BorderWidth="1" CellPadding="4" GridLines="both"
                                             
                                               BackColor="White" BorderColor="#3366CC" BorderStyle="None" AllowSorting="true"   AllowPaging="false"  PagerStyle-Mode="NumericPages" PageSize="100" RowStyle-HorizontalAlign="left" runat="server">
                           
                                                <RowStyle Font-Names="Arial" Font-Size="9pt" ForeColor="#003399" ></RowStyle>
                                                <Columns>
                                                    <asp:TemplateField HeaderText="E">
                                                        <ItemTemplate>
                                                         <asp:LinkButton ID="lnkBtnEdit" class="green bigger-120 show-details-btn" Text="<i class='ace-icon fa fa-edit bigger-120'></i>" ToolTip="ModifyRoleRequestsStatus"     CommandName="EditProfile" CommandArgument='<%# Eval("RequestId")%>'  runat="server"></asp:LinkButton>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="H" Visible="false">
                                                        <ItemTemplate>
                                                         <asp:LinkButton ID="lnkBtnHistory" Visible="false" class="orange bigger-120 show-details-btn" Text="<i class='ace-icon fa fa-history bigger-120'></i>" ToolTip="Status History"     CommandName="ViewRoleRequestsStatusModifications" CommandArgument='<%# Eval("RequestId")%>'  runat="server"></asp:LinkButton>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="RaisedOn" DataFormatString="{0:dd:MM:yyyy h:mmtt}" HeaderText="Date Received"></asp:BoundField>
                                                    <asp:BoundField DataField="RequestId"  HeaderText="Id"></asp:BoundField>
                                                    <asp:BoundField DataField="RequestApprovalStatus" HeaderText="Status"></asp:BoundField>
                                                    <asp:BoundField DataField="RequesterFullName" HeaderText="Name"></asp:BoundField>
                                                    <asp:BoundField DataField="OrganizationName" HeaderText="MentoringOrg"></asp:BoundField>
                                                    <asp:BoundField DataField="RequestedRoleName"  HeaderText="ReqType"></asp:BoundField>
                                                    <asp:BoundField DataField="RequesterEmail" HeaderText="Email"></asp:BoundField>
                                                    <asp:BoundField DataField="RequesterPhone" HeaderText="Phone"></asp:BoundField>                                 
                                                    <asp:BoundField DataField="StateName" HeaderText="State"></asp:BoundField>
                                                    <asp:BoundField DataField="City" HeaderText="City/Taluka"></asp:BoundField>
                                                   <%-- <asp:BoundField DataField="Comments" HeaderText="Message"></asp:BoundField>--%>
                                                    <asp:TemplateField HeaderText="Del">
                                                        <ItemTemplate>
                                                         <asp:LinkButton ID="lnkBtnDetails" class="orange bigger-120 show-details-btn" Text="<i class='ace-icon fa fa-trash bigger-120'></i>" ToolTip="Remove " Visible='<%#Eval("RequestApprovalStatus").ToString().Trim()=="NEW" %>'    CommandName="DeleteRequest" CommandArgument='<%#Eval("RequestId")+";"+Eval("RaisedOn","{0:MMM/dd/yyyy}")  %>'  runat="server"></asp:LinkButton>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <%--<asp:BoundField DataField="Owner" HeaderText="Owner"></asp:BoundField>--%>
                                                    <%--<asp:BoundField DataField="Assigned" HeaderText="Assigned To"></asp:BoundField>
                                                    <asp:BoundField DataField="LastUpdated" DataFormatString="{0:dd:MM:yyyy h:mmtt}" HeaderText="Date Updated"></asp:BoundField>                                 
                                                    <asp:BoundField DataField="ProgramTitle" HeaderText="RoleRequests For"></asp:BoundField>
                                                    <asp:BoundField DataField="Comments" HeaderText="Comments"></asp:BoundField>
                                                    <asp:BoundField DataField="OrganizationName" HeaderText="Centre"></asp:BoundField>--%>
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

    <!--View Selected RoleRequests Profile-->
    <div class="row">
        <div class="col-xs-12">
            <!--View RoleRequests Profile-->
            <asp:Panel ID="pnlViewRoleRequestsProfile" ScrollBars="Auto" runat="server">
                <div class="col-xs-12">
                    CSR Age :
                    <asp:Label ID="RoleRequestsAgeYears" runat="server"></asp:Label>&nbsp years
                       <asp:Label ID="RoleRequestsAgeMonths" runat="server"></asp:Label>&nbsp months
                    <asp:Label ID="RoleRequestsAgeDays" runat="server"></asp:Label>&nbsp days
                      
                    <asp:DataList ID="dlRoleRequestsDetails" DataKeyField="RequestId" HorizontalAlign="Justify" RepeatColumns="1" RepeatDirection="horizontal" GridLines="Vertical" runat="server">
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
                                        <th>RoleRequests ID</th><td><%#Eval("RequestId")%></td>
                                        <th>Raised On</th><td><%#Eval("RequesterFullName")%></td>
                                    </tr>
                                    <tr>
                                        <th>Program</th><td><%#Eval("RequesterEmail")%></td>
                                        <th>Message</th><td><%#Eval("Comments")%></td>
                                    </tr>
                                    <tr>
                                        <th>Student Name</th><td><%#Eval("RequesterPhone")%></td>
                                        <th>ChooseRole</th><td><asp:DropDownList ID="ddlGrantedRole" runat="server">
                                                                <asp:ListItem>Therapist</asp:ListItem>
                                                                <asp:ListItem>Student</asp:ListItem>
                                                              </asp:DropDownList></td>
                                    </tr>
                                    <tr>
                                        <th>MentoringOrg</th><td><%#Eval("OrgName")%></td>
                                    </tr>
                                    <tr>
                                        <td colspan="4">
                                            <div class="hidden-sm hidden-xs btn-group">
                                                <asp:LinkButton ID="lnkBtnGrantAccess" class="btn btn-xs btn-info" Text="<i class='ace-icon fa fa-thumbs-up bigger-120'></i>" ToolTip="Grant Access"  CommandName="ManageRoleRequestsVisibility" CommandArgument='<%#Eval("RequestId")%>' runat="server"></asp:LinkButton>
                                                <asp:LinkButton ID="lnkBtnDenyAccess" class="btn btn-xs btn-info" Text="<i class='ace-icon fa fa-thumbs-down bigger-120 white'></i>" ToolTip="Deny Access" OnCommand="ManageRoleRequestsVisibility" CommandName="DenyAccess" CommandArgument='<%#Eval("RequestId")%>' runat="server"></asp:LinkButton>

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
                                                            <a href="#" class="tooltip-success" data-rel="tooltip" title="Allow">
                                                                <span class="green">
                                                                    <i class="ace-icon fa fa-pencil-square-o bigger-120"></i>
                                                                </span>
                                                            </a>
                                                        </li>

                                                        <li>
                                                            <a href="#" class="tooltip-error" data-rel="tooltip" title="Deny">
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

    <!--Edit and Save RoleRequests Profile-->
    <div class="row">
        <div class="col-xs-12">
            <!--View RoleRequests -->
            <asp:Panel ID="pnlEditRoleRequestsProfile" ScrollBars="Auto" runat="server">
                <h4>Create a new account</h4>
                <div class="col-xs-12">
                    <p class="text-danger">
                    <asp:Literal runat="server" ID="ErrorMessage" />
                    <asp:ValidationSummary runat="server" CssClass="text-danger" />
                    <asp:DataList ID="dlEditRoleRequestsProfile" DataKeyField="RequestId" OnUpdateCommand="UpdateRoleRequestsProfile" HorizontalAlign="Justify" RepeatColumns="1" RepeatDirection="horizontal" GridLines="Vertical" runat="server">
                        <HeaderTemplate>
                        </HeaderTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                        <ItemTemplate>
                            <table id="simple-table" class="table  table-bordered table-hover">
                                <tbody>
                                    <tr>
                                        <th>Name</th>
                                        <td><asp:TextBox ID="FullName" Text='<%# Eval("RequesterFullName") %>' runat="server"></asp:TextBox>
                                            <asp:RequiredFieldValidator runat="server" ControlToValidate="FullName"
                                            CssClass="text-danger" ErrorMessage="The Name field is required." />
                                        </td>
                                        <th>RequestID</th><td><asp:Label ID="RequestID" Text='<%#Eval("RequestID") %>' runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <th>Mentoring Org</th><td><asp:Label ID="lblOrgName" Text='<%#Eval("OrganizationName") %>' runat="server"></asp:Label></td>
                                        <th>Mentoring Org Id</th><td><asp:Label ID="lblOrgID" Text='<%#Eval("OrganizationId") %>' runat="server"></asp:Label></td>
                                    </tr>
                                    
                                    <tr>
                                    <th>RoleRequests Status</th><td><asp:DropDownList  ID="ddlRequestApprovalStatus" runat="server">
                                                                                    <asp:ListItem>Select Approval Status</asp:ListItem>
                                                                                    <asp:ListItem>APPROVED</asp:ListItem>
                                                                                    <asp:ListItem>BLOCKED</asp:ListItem>
                                                                                    
                                                                                </asp:DropDownList></td>

                                     <th>RequesterState: </th><td><%#Eval("StateName") %><asp:TextBox ID="State" Visible="false"  Text=<%#Eval("StateID") %>    runat="server"></asp:TextBox></td>                                   
                                    </tr>
                                    <tr>
                                        <th>Email</th><td><asp:TextBox ID="Email" Text='<%#Eval("RequesterEmail") %>' CssClass="col-lg-12"  runat="server"></asp:TextBox>
                                            <asp:RequiredFieldValidator runat="server" ControlToValidate="Email"
                                                      CssClass="text-danger" ErrorMessage="The email field is required." />
                                        </td>
                                        <th>GrantedRole</th>
                                        <td><asp:DropDownList ID="ddlRole" runat="server">
                                             <asp:ListItem>STUDENT</asp:ListItem>
                                             <asp:ListItem>ALUMANI</asp:ListItem>
                                             
                                            </asp:DropDownList></td>
                                        
                                    </tr>
                                    <tr>
                                        <th>Phone</th><td><asp:TextBox ID="Phone" Text='<%#Eval("RequesterPhone") %>' CssClass="col-lg-12"  runat="server"></asp:TextBox>
                                            <asp:RequiredFieldValidator runat="server" ControlToValidate="Phone"
                                                      CssClass="text-danger" ErrorMessage="The phone field is required." />
                                        </td>
                                        <th class="col-sm-1">RequesterCity/Taluka</th>
                                        <td><asp:TextBox ID="txtBoxRequesterCity" Text='<%#Eval("City") %>'  runat="server"></asp:TextBox></td>

                                    </tr>
                                     
                                   
                                    <tr>
                                        <td colspan="4">
                                            <div class="hidden-sm hidden-xs btn-group">
                                                <asp:LinkButton ID="lnkBtnUpdateRoleRequestsProfile" class="btn btn-white btn-info btn-bold" Text="<i class='ace-icon fa fa-floppy-o bigger-120 blue'> Save</i>" ToolTip="Save" CommandName="Update" runat="server"></asp:LinkButton>
                                                <asp:LinkButton ID="lnkBtnReturnToViewCustomers" class="btn btn-white btn-default btn-round" Text="<i class='ace-icon fa fa-times red2'> Cancel</i>" ToolTip="Cancel" OnCommand="ManageRoleRequestsVisibility" CommandName="ReturnToViewRoleRequests" runat="server"></asp:LinkButton>
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
                                                            <asp:LinkButton ID="lnkBtnCancel" class="btn btn-white btn-default btn-round" Text="<i class='ace-icon fa fa-times red2'></i>" ToolTip="Cancel" OnCommand="ManageRoleRequestsVisibility" CommandName="ReturnToViewRoleRequests" runat="server"></asp:LinkButton>
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
            <!--View RoleRequestsStatusModifications History -->
            <asp:Panel ID="pnlRoleRequestsStatusModifications" ScrollBars="Auto" runat="server">
                <div class="col-xs-12">
                    <!--View CSR History-->
                    <asp:GridView ID="gvRoleRequestsStatusModifications" CssClass="table table-hover table-bordered"  DataKeyNames="ModificationId" AlternatingItemStyle-BackColor="Silver" AutoGenerateColumns="false" CellPadding="4" 
                            GridLines="both" AllowSorting="true" AllowPaging="false" PagerStyle-Mode="NumericPages" PageSize="30" ItemStyle-HorizontalAlign="left" runat="server">
                            <HeaderStyle Font-Names="Arial"   Font-Size="10pt" Font-Bold="false" BackColor="#333333" ForeColor="#FFFFFF" />
                            <RowStyle Font-Names="Arial" Font-Size="8pt" ForeColor="#000000" ></RowStyle>
                        <Columns>
                            <asp:BoundField DataField="Owner" HeaderText="Owner" />
                            <asp:BoundField DataField="Assigned" HeaderText="Consellor" />
                            <asp:BoundField DataField="OrganizationName" HeaderText="Centre" />
                            <asp:BoundField DataField="RequestApprovalStatus" HeaderText="Status" />
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
