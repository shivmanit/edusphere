<%@ Page Title="" Language="C#" MasterPageFile="~/EduSpherePro/EduSpherePro.Master" AutoEventWireup="true" CodeBehind="Placements.aspx.cs" Inherits="EduSpherePro.EduSpherePro.Placements" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--Page Command Buttons-->   
        <div class="row">
            <div class="col-xs-12">
               <div class="col-sm-6">  
                 <div class="hr hr-18 dotted hr-double"></div>
	               <h4 class="pink">
		              <i class="ace-icon fa fa-hand-o-right icon-animated-hand-pointer blue"></i>
			          <asp:Label ID="lblPlacementAction" Text="Placements / Courses" runat="server"></asp:Label>
	               </h4>
	              <div class="hr hr-18 dotted hr-double"></div>
               </div>
               <div class="col-sm-4">
                    <div id="membersbar" class="navbar-buttons navbar-header pull-right" role="navigation">
					    <ul class="nav ace-nav">
						    <li class="light-blue dropdown-modal">
							    <a data-toggle="dropdown" href="#" class="dropdown-toggle">
                                    Placements <i class="ace-icon fa fa-caret-down"></i> 
							    </a>
							    <ul class="user-menu dropdown-menu-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">
						            <li>
                                        <asp:LinkButton ID="lnkBtnViewPlacements"   OnCommand="ManageVisibility" CommandName="ViewPlacementDrives" CommandArgument="" Text='<i class="ace-icon fa fa-eye fa-fw"></i>Placement Drives' runat="server"></asp:LinkButton>
								    </li>
								    <li class="divider"></li>
								    
                                    
							    </ul>
						    </li>
					    </ul>
				    </div>
              
          </div>
            </div>
         </div>
    <!--end Page Command Buttons-->
    
    <!--View /Create New Drive-->
     <div class="row">
            <div class="col-xs-12">  
              <asp:Panel ID="pnlPlacementDrives"  ScrollBars="Auto"   runat="server">
                 <!--Tabbed-->
                <div class="col-sm-7 widget-container-col" id="widget-container-col-10">
                    <div class="widget-box" id="widget-box-10">
                       <div class="widget-header widget-header-small">
						    <h5 class="widget-title smaller">Placement Drives</h5>
						    <div class="widget-toolbar no-border">
							    <ul class="nav nav-tabs" id="myTab">
								    <li class="active">
									    <a data-toggle="tab" href="#drives">Drives</a>
								    </li>
								    <li>
									    <a data-toggle="tab" href="#createdrive">Create Drive</a>
								    </li>
							    </ul>
						    </div>
					    </div>

                       <!--Tab Body-->
					    <div class="widget-body">
                            <div class="widget-main padding-6">
								<div class="tab-content">
                                    <div id="drives" class="tab-pane in active">
                                        <asp:GridView ID="gvPlacementDrives" OnRowCommand="gvPlacementDrives_RowCommand" CssClass="table table-hover table-bordered" AlternatingRowStyle-BackColor="Silver" HorizontalAlign="left" AutoGenerateColumns="false" BorderWidth="1" CellPadding="4" GridLines="both" 
                                               BackColor="White" BorderColor="#3366CC" BorderStyle="None" AllowSorting="true"   AllowPaging="false"  PagerStyle-Mode="NumericPages" PageSize="100" RowStyle-HorizontalAlign="left" runat="server">
                           
                                                <RowStyle Font-Names="Arial" Font-Size="10pt" ForeColor="#003399" ></RowStyle>
                                                <Columns>
                                                    <asp:BoundField DataField="DriveID" HeaderText="ID"></asp:BoundField>
                                                    <asp:BoundField DataField="DriveTitle" HeaderText="Job Title"></asp:BoundField>
                                                    <asp:BoundField DataField="OrganizationName" HeaderText="HiringCompany"></asp:BoundField>
                                                    <asp:BoundField DataField="DriveDate" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Drive Date"></asp:BoundField>                                 
                                                    <asp:BoundField DataField="FullName"  HeaderText="Coordinator"></asp:BoundField>
                                                    <asp:TemplateField HeaderText="AddStudents">
                                                        <ItemTemplate>
                                                         <asp:LinkButton ID="lnkBtnViewStudents"    CommandName="AddStudentsToDrive" CommandArgument='<%#Eval("DriveID") %>' Text="<i class='ace-icon fa fa-plus bigger-120'></i>" runat="server"></asp:LinkButton>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="ViewDriveStatus">
                                                        <ItemTemplate>
                                                         <asp:LinkButton ID="lnkBtnViewDriveStatus"    CommandName="ViewDriveStatus" CommandArgument='<%#Eval("DriveID") %>' Text="<i class='ace-icon fa fa-eye bigger-120'></i>" runat="server"></asp:LinkButton>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                                <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                                                <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                                                <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                                                <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />                           
                                        </asp:GridView>
                                    </div>
                                    <div id="createdrive" class="tab-pane">
                                         <!--Create new Drive-->
                                        <h3 class="pink">Create Placement Drive</h3>
                                          <table class="table  table-bordered table-hover">
                                            <tr>
                                                <th>Employer</th>
                                                <td><asp:DropDownList ID="ddlEmployerID" DataTextField="OrganizationName" DataValueField="OrganizationID" runat="server"></asp:DropDownList></td>
                                                <th>Drive Title</th> 
                                                <td><asp:TextBox ID="txtBoxDriveTitle" runat="server"></asp:TextBox> </td>
                                            </tr>
                                            <tr>
                                                <th>DriveDate</th>
                                                <td><asp:TextBox ID="txtBoxDriveDate" TextMode="Date" runat="server"></asp:TextBox></td>
                                                <th>Coordinator</th> 
                                                <td><asp:DropDownList ID="ddlCoordinatorID" DataTextField="FullName" DataValueField="EmployeeID" runat="server"></asp:DropDownList></td>
                                            </tr>
                                            <tr>
                                                <th>Job Description</th>
                                                <td colspan="3"><asp:TextBox ID="txtBoxJobDescription" TextMode="MultiLine" runat="server"></asp:TextBox></td>
                                            </tr>
                                            <tr>
                                                <td><asp:ImageButton ID="ImageButton4"  ImageUrl="~/Images/Return.png" Width="20px" Height="20px"  ToolTip="Return" OnCommand="ManageVisibility" CommandName="ReturnToPlacements" runat="server" /></td>
                                                <td><asp:LinkButton ID="lnkBtnCreateDrive" class="btn btn-xs btn-info"  Text="Submit" OnClick="CreateNewDrive" runat="server" /></td>
                                            </tr>
                                          </table>
                                    </div>
                                </div>
                            </div>
                        </div>

                      
                  </div>
                    
                </div>
                <!--End Tabbed-->
                  <!--Extended View- DriveStatus-->
                 <div class="col-sm-4">
                     <h3 class="pink">DID:<asp:Label ID="lblDriveID" Visible="true" runat="server"></asp:Label></h3>
                      <asp:GridView ID="gvDriveStatus"  DataKeyNames="StudentsPlacementDriveID" OnRowCommand="gvDriveStatus_RowCommand"  CssClass="table table-hover table-bordered" AlternatingRowStyle-BackColor="Silver" HorizontalAlign="left" AutoGenerateColumns="false" BorderWidth="1px" CellPadding="4" GridLines="both" 
                           OnRowEditing="gvEditDriveStatus" OnRowCancelingEdit="gvCancelDriveStatus" OnRowUpdating="gvUpdateDriveStatus"
                          onrowdatabound="gvDriveStatus_RowDataBound"
                          BackColor="White" BorderColor="#3366CC" BorderStyle="None" AllowSorting="true"   AllowPaging="false"  PagerStyle-Mode="NumericPages" PageSize="100" RowStyle-HorizontalAlign="left" runat="server">
                           <RowStyle Font-Names="Arial" Font-Size="10pt" ForeColor="#003399" ></RowStyle>
                            <Columns>
                                <asp:CommandField ShowEditButton="true" />
                                <asp:BoundField DataField="FullName" HeaderText="Name" ReadOnly="true"></asp:BoundField>
                              
                                 <asp:TemplateField HeaderText="Student Status">
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="ddlEditStudentStatus" runat="server">
                                            <asp:ListItem>APPEARED</asp:ListItem>
                                            <asp:ListItem>OPTEDOUT</asp:ListItem>
                                            <asp:ListItem>SELECTED</asp:ListItem>
                                            <asp:ListItem>NOTSELECTED</asp:ListItem>
                                        </asp:DropDownList>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblStudentStatus" runat="server" Text='<%# Bind("StudentsDriveStatus") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                               
                            </Columns>
                            <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                            <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                            <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                            <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />                           
                    </asp:GridView>
                     <!--Drive Students-->
                     
                     <!--End Drive Students-->
                   </div>
                  <!--End Extended View- DriveStatus-->
                </asp:Panel>
           </div>
   </div>
    <!--End View/Create New Drive-->  


</asp:Content>
