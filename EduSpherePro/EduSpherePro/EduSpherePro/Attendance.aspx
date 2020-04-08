<%@ Page Title="Attendance" Language="C#" MasterPageFile="~/EduSpherePro/EduSpherePro.Master" AutoEventWireup="true" CodeBehind="Attendance.aspx.cs" Inherits="EduSpherePro.EduSpherePro.Attendance" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="row">
        <div class="col-sm-2">
            <div class="action-buttons">
                <!--<asp:LinkButton ID="lnkBtnAddStaff"  class="btn btn-xs btn-success" Text="<i class='ace-icon fa fa-plus bigger-120'></i>AddNewStaff" ToolTip="Profile" OnCommand="ManageStaffAttendance" CommandName="AddStaff" runat="server" ></asp:LinkButton> -->             
            </div>
        </div>
        <div class="col-sm-6">
            <div class="input-group">
				<span class="input-group-addon">
					<i class="ace-icon fa fa-check"></i>
				</span>
                <asp:TextBox  class="form-control search-query" ID="txtBoxSearchStaff" runat="server"></asp:TextBox>
				
				<span class="input-group-btn">
                    <asp:LinkButton ID="lnkBrnSerachStaff" class="btn btn-purple btn-sm" Text="<span class='ace-icon fa fa-search icon-on-right bigger-110'></span> Search" OnCommand="ManageStaffAttendance" CommandName="SearchStaff" runat="server"></asp:LinkButton>
					
				</span>
			</div>
        </div>
   </div>
   <div class="hr hr-18 dotted hr-double"></div>
	    <h4 class="pink">
		    <i class="ace-icon fa fa-hand-o-right icon-animated-hand-pointer blue"></i>
			<asp:Label ID="lblStaffAction" Text="" runat="server"></asp:Label>
	    </h4>
	<div class="hr hr-18 dotted hr-double"></div>
    
    
       
    <!--View All Staff Timesheet -->
    <div class="row">
		    <div class="col-xs-12">
                 <!--View Staff Timesheet-->
                <asp:Panel ID="pnlViewStaff" ScrollBars="Auto"  runat="server">
                <div class="col-xs-12">
                    <asp:DataList ID="dlStaff" DataKeyField="EmployeeId" OnUpdateCommand="UpdateStaffAttendance" HorizontalAlign="Justify"   RepeatColumns="1" RepeatDirection="horizontal" GridLines="Vertical" runat="server">
                        <HeaderTemplate>
                            <table id="simple-table" class="table  table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th colspan="1"><asp:Label Width="80px" Text="SwipeId" runat="server"></asp:Label></th>
                                        <th colspan="1"><asp:Label Width="80px" Text="Id" runat="server"></asp:Label></th>
										<th colspan="1"><asp:Label Width="20px" Text="" runat="server"></asp:Label></th>
										<th colspan="1"><asp:Label Width="100px" Text="Name" runat="server"></asp:Label></th>
										<!--<th colspan="2"><asp:Label Width="100px" Text="Phone" runat="server"></asp:Label></th>-->
										<!--<th colspan="1"><asp:Label Width="200px" Text="Email" runat="server"></asp:Label></th>-->
                                        <th colspan="1"><asp:Label Width="100px" Text="IN" runat="server"></asp:Label></th>
                                        <th colspan="1"><asp:Label Width="100px" Text="OUT" runat="server"></asp:Label></th>
                                        <th colspan="1"><asp:Label Width="100px" Text="Remarks" runat="server"></asp:Label></th>
                                        <th colspan="1"><asp:Label Width="100px" class="ace-icon fa fa-clock-o bigger-110 hidden-480" Text="Click the Attendance" runat="server"></asp:Label></th>				
										
									</tr>
								</thead>
                            </table>
                        </HeaderTemplate>
                        <ItemStyle HorizontalAlign="Center"   />
                        <ItemTemplate>
                             <table id="simple-table" class="table  table-bordered table-hover">
								<tbody>
									<tr>
                                        <td colspan="1"><asp:Label ID="lblSwipeId" Width="80px" class="label label-sm label-warning" Text=<%#Eval("SwipeId") %> runat="server"></asp:Label></span></td>
                                        <td colspan="1"><asp:Label Width="80px" class="label label-sm label-warning" Text=<%#Eval("EmployeeId") %> runat="server"></asp:Label></span></td>
                                        <td colspan="1"><asp:LinkButton Width="20px" ID="LinkButton2"  class="green bigger-140 show-details-btn" Text="<i class='ace-icon fa fa-angle-double-down bigger-120'></i>" ToolTip="Profile" OnCommand="ManageStaffAttendance" CommandName="ViewProfile" CommandArgument='<%#Eval("EmployeeId") %>' runat="server" ></asp:LinkButton></td>
										<td colspan="1"><asp:Label Width="100px" Text=<%#Eval("FullName")%> runat="server"></asp:Label></td>
										<!--<td colspan="1"><asp:Label Width="100px" Text=<%#Eval("PhoneOne")%> runat="server"></asp:Label></td>-->
										<!--<td colspan="1"><asp:Label Width="200px" Text=<%#Eval("Email")%> runat="server"></asp:Label> </td>-->
                                        <td colspan="1"><asp:Label Width="100px" Text=<%#Eval("SwipeInDateTime")%> runat="server"></asp:Label></td>
                                        <td colspan="1"><asp:Label Width="100px" Text=<%#Eval("SwipeOutDateTime")%> runat="server"></asp:Label></td>
										<td colspan="1"><asp:TextBox Width="100px" ID="txtBoxAttendanceRemarks" TextMode="SingleLine"  runat="server"></asp:TextBox></td>
                                        <td colspan="1">
											<div class="hidden-sm hidden-xs btn-group" style="width:100px;">
												<!--<button class="btn btn-xs btn-info">
													<i class="ace-icon fa fa-sign-in bigger-120"> IN</i>
												</button>-->
                                                <asp:LinkButton ID="lnkBtnInTime" class="btn btn-xs btn-info" Text="<i class='ace-icon fa fa-sign-in bigger-120'> IN</i>" ToolTip="In Time" Visible='<%# string.IsNullOrEmpty(Eval("SwipeInDateTime").ToString()) %>'  CommandName="Update" CommandArgument='<%#Eval("SwipeInDateTime")+";"+"IN" %>' runat="server"></asp:LinkButton>
												<!--<button class="btn btn-xs btn-danger">
													<i class="ace-icon fa fa-sign-out bigger-120"> OUT</i>
												</button>-->
                                                <asp:LinkButton ID="lnkBtnOutTime" class="btn btn-xs btn-danger" Text="<i class='ace-icon fa fa-sign-out bigger-120'>OUT</i>" ToolTip="Out Time"  Visible='<%# string.Equals(Eval("SwipeInStatus"),"DISABLED") %>' CommandName="Update" CommandArgument='<%#Eval("SwipeInDateTime")+";"+"OUT" %>' runat="server"></asp:LinkButton>
												
											</div>

											<div class="hidden-md hidden-lg" style="width:100px;">
												<div class="inline pos-rel">
													<button class="btn btn-minier btn-primary dropdown-toggle" data-toggle="dropdown" data-position="auto">
														<i class="ace-icon fa fa-cog icon-only bigger-110"></i>
													</button>

													<ul class="dropdown-menu dropdown-only-icon dropdown-yellow dropdown-menu-right dropdown-caret dropdown-close">
														<li>
															<!--<a href="#" class="tooltip-info" data-rel="tooltip" title="View">
																<span class="blue">
																	<i class="ace-icon fa fa-search-plus bigger-120"></i>
																</span>
															</a>-->
                                                            <asp:LinkButton ID="lnkBtnIn" class="btn btn-xs btn-info" Text="<i class='ace-icon fa fa-sign-in bigger-120'></i>" ToolTip="In" Visible='<%# string.IsNullOrEmpty(Eval("SwipeInDateTime").ToString()) %>'  CommandName="Update" CommandArgument='<%#Eval("SwipeInDateTime")+";"+"IN" %>' runat="server"></asp:LinkButton>
														</li>

														<li>
															<!--<a href="#" class="tooltip-success" data-rel="tooltip" title="Edit">
																<span class="green">
																	<i class="ace-icon fa fa-pencil-square-o bigger-120"></i>
																</span>
															</a>-->
                                                            <asp:LinkButton ID="lnkBtnOut" class="btn btn-xs btn-danger" Text="<i class='ace-icon fa fa-sign-out bigger-120'></i>" ToolTip="Out"  Visible='<%# string.Equals(Eval("SwipeInStatus"),"DISABLED") %>' CommandName="Update" CommandArgument='<%#Eval("SwipeInDateTime")+";"+"OUT" %>' runat="server"></asp:LinkButton>
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
                   
                 </div><!-- /.span -->
            </asp:Panel>
		   <!-- PAGE CONTENT ENDS -->
		    </div><!-- /.col -->
    </div><!-- /.row -->

    <!--View Selected Staff Profile-->
    <div class="row">
		    <div class="col-xs-12">
                 <!--View Staff Profile-->
                <asp:Panel ID="pnlViewStaffProfile" ScrollBars="Auto"  runat="server">
                <div class="col-xs-12">
                    <asp:DataList ID="dlStaffDetails" DataKeyField="EmployeeId" HorizontalAlign="Justify"   RepeatColumns="1" RepeatDirection="horizontal" GridLines="Vertical" runat="server">
                        <HeaderTemplate>
                        </HeaderTemplate>
                        <ItemStyle HorizontalAlign="Center"   />
                        <ItemTemplate>
                             <table id="simple-table" class="table  table-bordered table-hover">
								<tbody>
							        <tr>
                                    <th>Full Name</th><td><%#Eval("FullName")%></td>
                                    <th>Organization</th><td><%#Eval("OrganizationId")%></td>
                            </tr>
                            <tr>
                                <th>Phone One</th><td><%#Eval("PhoneOne")%></td>
								<th>Phone Two</th><td><%#Eval("PhoneTwo")%></td>
						    </tr>
                            <tr>
                                <th>Email</th><td><%#Eval("Email")%></td>
								<th>Address</th><td><%#Eval("ContactAddress")%></td>
                            </tr>
                            <tr>
                                <th>City</th><td><%#Eval("City")%></td>
								<th>District</th><td><%#Eval("District")%></td>
                            </tr>
                            <tr>
                                <th>Pin Code</th><td><%#Eval("PinCode")%></td>
                                <th>State</th><td><%#Eval("State")%></td>
						    </tr>
                            <tr>
                                <th>Country</th><td><%#Eval("Country")%></td>
                                <th>Designation</th><td><%#Eval("Designation")%></td>
							</tr>
                             <tr>
                                 <th>Date Of Birth</th><td><asp:Label ID="lblDob" Text=<%#Eval("DateOfBirth","{0:MMM/dd/yyyy}")%>  runat="server"></asp:Label> </td>
                                  <th></th><td></td>
                             </tr>
                             <tr>
                                <th>Manager</th><td><%#Eval("ManagerId")%></td>
                                <th>Employment Status</th><td><%#Eval("EmploymentStatus")%>
                                    </td>
						    </tr>
                            <tr>
                                <th>Date Of Joining</th><td><%#Eval("DateOfJoining", "{0:MMM/dd/yyyy}")%></td>
                                <th>Employment Type</th><td><%#Eval("EmploymentType")%>
                                    </td>
							</tr>
                             <tr>
                                <th>Date Of Leaving</th><td><%#Eval("DateOfLeaving","{0:MMM/dd/yyyy}")%></td>
                                <th></th><td><asp:TextBox ID="TextBox17" runat="server"></asp:TextBox></td>
						    </tr>

                                    <tr>
										<td colspan="4">
											<div class="hidden-sm hidden-xs btn-group">
															
                                                <!--<asp:LinkButton ID="lnkBtnEditStaffDetails"  class="btn btn-xs btn-info" Text="<i class='ace-icon fa fa-pencil bigger-120'></i>" ToolTip="Edit Profile" OnCommand="ManageStaffAttendance" CommandName="EditProfile" CommandArgument='<%#Eval("EmployeeId")%>' runat="server" ></asp:LinkButton>-->
												<asp:LinkButton ID="lnkBtnReturn"  class="btn btn-xs btn-info" Text="<i class='ace-icon fa fa-times bigger-120 white'></i>" ToolTip="Cancel" OnCommand="ManageStaffAttendance" CommandName="ReturnToViewStaff" runat="server" ></asp:LinkButton>

												
											</div>

											
										</td>
									</tr>
												
								</tbody>
                              </table>
                        </ItemTemplate>
                    </asp:DataList>
                   
                 </div><!-- /.span -->
            </asp:Panel>
		   <!-- PAGE CONTENT ENDS -->
		    </div><!-- /.col -->
    </div><!-- /.row -->
</asp:Content>
