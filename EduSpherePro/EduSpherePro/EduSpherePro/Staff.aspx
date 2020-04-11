<%@ Page Title="" Language="C#" MasterPageFile="~/EduSpherePro/EduSpherePro.Master" AutoEventWireup="true" CodeBehind="Staff.aspx.cs" Inherits="EduSpherePro.EduSpherePro.Staff" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  <div class="row">
        <div class="col-sm-2">
            <div class="action-buttons">
                <asp:LinkButton ID="lnkBtnAddStaff"  class="btn btn-xs btn-success" Text="<i class='ace-icon fa fa-plus bigger-120'></i>AddNewStaff" ToolTip="Profile" OnCommand="ManageStaffVisibility" CommandName="AddStaff" runat="server" ></asp:LinkButton>              
            </div>
        </div>
        <div class="col-sm-6">
            <div class="input-group">
				<span class="input-group-addon">
					<i class="ace-icon fa fa-check"></i>
				</span>
                <asp:TextBox  class="form-control search-query" ID="txtBoxSearchStaff" runat="server"></asp:TextBox>
				
				<span class="input-group-btn">
                    <asp:LinkButton ID="lnkBrnSerachStaff" class="btn btn-purple btn-sm" Text="<span class='ace-icon fa fa-search icon-on-right bigger-110'></span> Search" OnCommand="ManageStaffVisibility" CommandName="SearchStaff" runat="server"></asp:LinkButton>
					
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
    
    <!--New Staff-->
    <div class="row">
		<div class="col-xs-12">
			<!-- PAGE CONTENT BEGINS -->
                <!--Add New Staff-->
                <asp:Panel ID="pnlAddStaff" ScrollBars="Auto"  runat="server">
                  <form class="form-horizontal" role="form">
                    <table id="simple-table" class="table  table-bordered table-hover">
                        <tbody>
							<tr>
                                <th class="col-sm-1">Full Name</th><td class="col-sm-2"><asp:TextBox ID="txtBoxFullName"  runat="server"></asp:TextBox></td>
                                <th class="col-sm-1">Organization</th><td class="col-sm-4"><asp:DropDownList ID="ddlOrgId" DataTextField="OrganizationName" DataValueField="OrganizationID" runat="server"></asp:DropDownList></td>
                            </tr>
                            <tr>
                                <th class="col-sm-1"></th><td class="col-sm-2"></td>
                                <th class="col-sm-1">Gender</th><td class="col-sm-4"><asp:DropDownList ID="ddlGender" runat="server">
                                                                                           <asp:ListItem>FEMALE</asp:ListItem>
                                                                                           <asp:ListItem>MALE</asp:ListItem>                                                     
                                                                                        </asp:DropDownList></td>
                            </tr>
                            <tr>
                                <th>Phone One</th><td><asp:TextBox ID="txtBoxPhoneOne" runat="server"></asp:TextBox></td>
								<th>Phone Two</th><td><asp:TextBox ID="txtBoxPhoneTwo" runat="server"></asp:TextBox></td>
						    </tr>
                            <tr>
                                <th>Email</th><td><asp:TextBox ID="txtBoxEmail" runat="server"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtBoxEmail"
                                    ForeColor="Red" ValidationExpression="^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$"
                                    Display = "Dynamic" ErrorMessage = "Invalid email address"/>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtBoxEmail"
                                    ForeColor="Red" Display = "Dynamic" ErrorMessage = "Required" />
                                              </td>
								<th>Address</th><td><asp:TextBox ID="txtBoxContactAddress" class="col-sm-10" TextMode="MultiLine" runat="server"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <th>City</th><td><asp:TextBox ID="txtBoxCity" runat="server"></asp:TextBox></td>
								<th>District</th><td><asp:TextBox ID="txtBoxDistrict" runat="server"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <th>Pin Code</th><td><asp:TextBox ID="txtBoxPinCode" runat="server"></asp:TextBox></td>
                                <th>State</th><td><asp:TextBox ID="txtBoxState" runat="server"></asp:TextBox></td>
						    </tr>
                            <tr>
                                <th>Country</th><td><asp:TextBox ID="txtBoxCountry" runat="server"></asp:TextBox></td>
                                <th>Designation</th><td><asp:TextBox ID="txtBoxDesignation" runat="server"></asp:TextBox></td>
							</tr>
                            <tr>
                                <th>Date of Birth</th><td><asp:TextBox ID="txtBoxDateOfBirth" TextMode="Date" runat="server"></asp:TextBox></td>
                                <th>Manager</th><td><asp:DropDownList ID="ddlManagerId" DataTextField="FullName" DataValueField="EmployeeId" runat="server"></asp:DropDownList></td>
                            </tr>
                            <tr>
                                <th>Date Of Joining</th><td><asp:TextBox ID="txtBoxDateOfJoining" TextMode="Date" runat="server"></asp:TextBox></td>
                                <th>Employment Type</th><td><asp:DropDownList ID="ddlEmploymentType" runat="server">
                                    <asp:ListItem>EMPLOYEE</asp:ListItem>
                                    <asp:ListItem>CONTRACT</asp:ListItem>
                                    </asp:DropDownList></td>
							</tr>
                            <tr>
                                <th>Fathers Name</th><td><asp:TextBox ID="txtBoxFathersName" runat="server"></asp:TextBox></td>
                                <th>Mothers Name</th><td><asp:TextBox ID="txtBoxMothersName" runat="server"></asp:TextBox></td>
							</tr>
                            <tr>
                                <th>PAN Number</th><td><asp:TextBox ID="txtBoxPan" runat="server"></asp:TextBox></td>
                                <th>Aadhaar Number</th><td><asp:TextBox ID="txtBoxAadhaar" runat="server"></asp:TextBox></td>
							</tr>
                            <tr>
                                <th>Bank Name</th><td><asp:TextBox ID="txtBoxBankName" runat="server"></asp:TextBox></td>
                                <th>Bank Account Number</th><td><asp:TextBox ID="txtBoxBankAccount" runat="server"></asp:TextBox></td>
							</tr>
                            <tr>
                                <th>Bank IFSC</th><td><asp:TextBox ID="txtBoxBankIFSC" runat="server"></asp:TextBox></td>
                                <th></th><td></td>
							</tr>
                             <tr>
                                 <th>Employment Status</th><td><asp:DropDownList ID="ddlEmploymentStatus" AutoPostBack="true" OnSelectedIndexChanged="ddlEmploymentStatus_SelectedIndexChanged"  runat="server">
                                    <asp:ListItem>ACTIVE</asp:ListItem>
                                    <asp:ListItem>NOTAVTIVE</asp:ListItem>
                                    </asp:DropDownList></td>
                                <th><asp:Label ID="lblDtOfLeaving" Text="Date of Leaving" Visible="false" runat="server"></asp:Label></th><td><asp:TextBox ID="txtBoxDateOfLeaving" Visible="false" TextMode="Date" runat="server"></asp:TextBox></td>
                                
						    </tr>							
						</tbody>
                    </table>

				        
                    <div class="clearfix form-actions">
						<div class="col-md-offset-3 col-md-9">
                            <asp:LinkButton ID="btnSubmit" class="btn btn-info" Text='<i class="ace-icon fa fa-check bigger-110"></i>Submit' OnCommand="AddNewStaff" runat="server"></asp:LinkButton>							
							&nbsp; &nbsp; &nbsp;
							<button class="btn" type="reset">
								<i class="ace-icon fa fa-undo bigger-110"></i>
								Reset
							</button>
						</div>
					</div> <br /><br /> 
                  </form>
                </asp:Panel>
            	</div><!-- /.col -->
    </div><!-- /.row -->

    <!--Add Staff Doument-->
    <div class="row">
		<div class="col-xs-12">
			<!-- PAGE CONTENT BEGINS -->
                <!--Add New Staff Document-->
                <asp:Panel ID="pnlUploadStaffDocument" ScrollBars="Auto"  runat="server">
                  <form class="form-horizontal" role="form">
                    <h3>Employee Id :&nbsp<asp:Label ID="lblEmployeeId" runat="server"></asp:Label></h3>
                    <table id="docupload-table" class="table  table-bordered table-hover">
                        <thead>
                            <tr>
                                <th>Choose Document</th>
                                <th>Document Title</th>
                                <th>Selected Document</th>
                                <th>Click Upload</th>
                                <th>Click Save after Upload</th>
                            </tr>
                        </thead>
                        <tbody>
							<tr>
                                <td><asp:FileUpload ID="flStaffDocumentOne" runat="server"></asp:FileUpload></td>
                                <td><asp:TextBox ID="txtBoxStaffDocumentTitleOne" runat="server"></asp:TextBox></td>
                                 <td><asp:Label ID="lblStaffDocumentPathOne" runat="server"></asp:Label></td>
                                <td><asp:LinkButton ID="btnFileUploadOne" class="btn btn-app btn-purple btn-xs" Text='<i class="ace-icon fa fa-cloud-upload"></i>' OnCommand="btnFileUpload_StaffDocument" CommandName="flOne" CommandArgument="" runat="server"></asp:LinkButton>
                                </td>
                                <td><asp:LinkButton ID="lnkBtnSaveDocumentDetailsOne" class="btn btn-app btn-purple btn-xs" Text='<i class="ace-icon fa fa-save"></i>' OnCommand="SaveStaffDocument" CommandName="docOne" CommandArgument="" runat="server"></asp:LinkButton>
                                </td>
                            </tr>
                            <tr>
                                <td><asp:FileUpload ID="flStaffDocumentTwo" runat="server"></asp:FileUpload></td>
                                <td><asp:TextBox ID="txtBoxStaffDocumentTitleTwo" runat="server"></asp:TextBox></td>
                                 <td><asp:Label ID="lblStaffDocumentPathTwo" runat="server"></asp:Label></td>
                                <td><asp:LinkButton ID="btnFileUploadTwo" class="btn btn-app btn-purple btn-xs" Text='<i class="ace-icon fa fa-cloud-upload"></i>' OnCommand="btnFileUpload_StaffDocument" CommandName="flTwo" CommandArgument="" runat="server"></asp:LinkButton>
                                </td>
                                <td><asp:LinkButton ID="lnkBtnSaveDocumentDetailsTwo" class="btn btn-app btn-purple btn-xs" Text='<i class="ace-icon fa fa-save"></i>' OnCommand="SaveStaffDocument" CommandName="docTwo" CommandArgument="" runat="server"></asp:LinkButton>
                                </td>
                            </tr>	
                            <tr>
                                <td><asp:FileUpload ID="flStaffDocumentThree" runat="server"></asp:FileUpload></td>
                                <td><asp:TextBox ID="txtBoxStaffDocumentTitleThree" runat="server"></asp:TextBox></td>
                                 <td><asp:Label ID="lblStaffDocumentPathThree" runat="server"></asp:Label></td>
                                <td><asp:LinkButton ID="btnFileUploadThree" class="btn btn-app btn-purple btn-xs" Text='<i class="ace-icon fa fa-cloud-upload"></i>' OnCommand="btnFileUpload_StaffDocument" CommandName="flThree" CommandArgument="" runat="server"></asp:LinkButton>
                                </td>
                                <td><asp:LinkButton ID="lnkBtnSaveDocumentDetailThree" class="btn btn-app btn-purple btn-xs" Text='<i class="ace-icon fa fa-save"></i>' OnCommand="SaveStaffDocument" CommandName="docThree" CommandArgument="" runat="server"></asp:LinkButton>
                                </td>
                            </tr>	
                            <tr>
                                <td><asp:FileUpload ID="flStaffDocumentFour" runat="server"></asp:FileUpload></td>
                                <td><asp:TextBox ID="txtBoxStaffDocumentTitleFour" runat="server"></asp:TextBox></td>
                                 <td><asp:Label ID="lblStaffDocumentPathFour" runat="server"></asp:Label></td>
                                <td><asp:LinkButton ID="btnFileUploadFour" class="btn btn-app btn-purple btn-xs" Text='<i class="ace-icon fa fa-cloud-upload"></i>' OnCommand="btnFileUpload_StaffDocument" CommandName="flFour" CommandArgument="" runat="server"></asp:LinkButton>
                                </td>
                                <td><asp:LinkButton ID="lnkBtnSaveDocumentDetailsFour" class="btn btn-app btn-purple btn-xs" Text='<i class="ace-icon fa fa-save"></i>' OnCommand="SaveStaffDocument" CommandName="docFour" CommandArgument="" runat="server"></asp:LinkButton>
                                </td>
                            </tr>	
                            <tr>
                                <td><asp:FileUpload ID="flStaffDocumentFive" runat="server"></asp:FileUpload></td>
                                <td><asp:TextBox ID="txtBoxStaffDocumentTitleFive" runat="server"></asp:TextBox></td>
                                 <td><asp:Label ID="lblStaffDocumentPathFive" runat="server"></asp:Label></td>
                                <td><asp:LinkButton ID="btnFileUploadFive" class="btn btn-app btn-purple btn-xs" Text='<i class="ace-icon fa fa-cloud-upload"></i>' OnCommand="btnFileUpload_StaffDocument" CommandName="flFive" CommandArgument="" runat="server"></asp:LinkButton>
                                </td>
                                <td><asp:LinkButton ID="lnkBtnSaveDocumentDetailsFive" class="btn btn-app btn-purple btn-xs" Text='<i class="ace-icon fa fa-save"></i>' OnCommand="SaveStaffDocument" CommandName="docFive" CommandArgument="" runat="server"></asp:LinkButton>
                                </td>
                            </tr>	
                            <tr>
                                <td><asp:FileUpload ID="flStaffDocumentSix" runat="server"></asp:FileUpload></td>
                                <td><asp:TextBox ID="txtBoxStaffDocumentTitleSix" runat="server"></asp:TextBox></td>
                                 <td><asp:Label ID="lblStaffDocumentPathSix" runat="server"></asp:Label></td>
                                <td><asp:LinkButton ID="btnFileUploadSix" class="btn btn-app btn-purple btn-xs" Text='<i class="ace-icon fa fa-cloud-upload"></i>' OnCommand="btnFileUpload_StaffDocument" CommandName="flSix" CommandArgument="" runat="server"></asp:LinkButton>
                                </td>
                                <td><asp:LinkButton ID="lnkBtnSaveDocumentDetailsSix" class="btn btn-app btn-purple btn-xs" Text='<i class="ace-icon fa fa-save"></i>' OnCommand="SaveStaffDocument" CommandName="docSix" CommandArgument="" runat="server"></asp:LinkButton>
                                </td>
                            </tr>						
						</tbody>
                    </table>

                    <div class="clearfix form-actions">
						<div class="col-md-offset-3 col-md-9">
                            <!--<asp:LinkButton ID="lnkBtnSaveDocumentDetails" class="btn btn-info" Text='<i class="ace-icon fa fa-check bigger-110"></i>Submit' OnCommand="SaveStaffDocument" runat="server"></asp:LinkButton>							
							&nbsp; &nbsp; &nbsp;-->
                           
							<!--<button class="btn" type="reset">
								<i class="ace-icon fa fa-undo bigger-110"></i>
								Reset
							</button>-->
                            <asp:LinkButton ID="LinkButton2"  class="btn  btn-info" Text="<i class='ace-icon fa fa-undo bigger-110'></i> Return" ToolTip="Cancel" OnCommand="ManageStaffVisibility" CommandName="ReturnToViewStaff" runat="server" ></asp:LinkButton>
						</div>
					</div> <br /><br /> 
                  </form>
                </asp:Panel>
            	</div><!-- /.col -->
    </div><!-- /.row -->

    <!--View Staff Documents-->
    <div class="row">
        <div class="col-xs-12">
            <!--ViewStaff Documents -->
            <asp:Panel ID="pnlViewStaffDocuments" ScrollBars="Auto" runat="server">
                <div class="col-xs-12">
                    <!--View Staff Documents-->
                    <asp:GridView ID="gvStaffDocuments" CssClass="table table-hover table-bordered"  DataKeyNames="DocumentId" runat="server" AutoGenerateColumns="False" BackColor="White"
                        BorderColor="#3366CC" BorderStyle="None"
                        BorderWidth="1px" CellPadding="4">
                        <RowStyle BackColor="White" ForeColor="#003399" />
                        <Columns>
                            <asp:BoundField DataField="UploadDate" HeaderText="Date" />
                            <asp:BoundField DataField="DocumentTitle" HeaderText="Title" />
                            
                            <asp:HyperLinkField DataTextField="DocumentPath" HeaderText="Document" DataNavigateUrlFields="DocumentPath" />
                        </Columns>
                        <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                        <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                        <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                        <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
                    </asp:GridView>
                </div>
            </asp:Panel>
             <!-- /.span -->

            <!-- PAGE CONTENT ENDS -->
        </div>
        <!-- /.col -->
    </div>
    <!-- /.row -->
       
    <!--View All Staff -->
    <div class="row">
		    <div class="col-md-12">
                 <!--View Staff-->
                <asp:Panel ID="pnlViewStaff" ScrollBars="Auto"  runat="server">
                    <!--Filter Staff-->
                      <div class="col-sm-12">
                    <table>
                        <tr>
                            <th class="col-sm-1">Status</th>
                            <td class="col-sm-2">
                                <asp:DropDownList ID="ddlFilterEmploymentStatus" runat="server">
                                    <asp:ListItem>ACTIVE</asp:ListItem>
                                    <asp:ListItem>NOTACTIVE</asp:ListItem>
                                </asp:DropDownList></td>
                            <td class="col-sm-1">
                                <asp:LinkButton ID="btnFilterEmploymentStatus" class="btn btn-xs btn-info" Text="<i class='ace-icon fa fa-filter bigger-120'> GO</i>" ToolTip="Filter Staff" OnCommand="ManageStaffVisibility" CommandName="FilterStaff" CommandArgument="" runat="server"></asp:LinkButton></td>
                        </tr>
                    </table>
                </div>
                    <hr />
                    <!--End Filter Staff-->
                <div class="col-sm-12">
                    <asp:DataList ID="dlStaff" DataKeyField="EmployeeId" HorizontalAlign="Justify"   GridLines="Vertical" runat="server">
                        <HeaderTemplate>
                            <table id="simple-table" class="table  table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th colspan="1"><asp:Label Width="50px" Text="EmpId" runat="server"></asp:Label></th>
										<th colspan="1"><asp:Label Width="20px" Text="" runat="server"></asp:Label></th>
										<th colspan="1"><asp:Label Width="100px" Text="Function" runat="server"></asp:Label></th>
										<th colspan="2"><asp:Label Width="200px" Text="FullName" runat="server"></asp:Label></th>
										<th colspan="2"><asp:Label Width="300px" Text="Email" runat="server"></asp:Label></th>
                                        <th colspan="1"><asp:Label Width="150px" Text="Phone" runat="server"></asp:Label></th>
                                        
                                        <th colspan="2"><asp:Label Width="100px" class="ace-icon fa fa-clock-o bigger-110 hidden-480" Text="" runat="server"></asp:Label></th>				
										
									</tr>
								</thead>
                            </table>
                        </HeaderTemplate>
                        <ItemStyle HorizontalAlign="Center"   />
                        <ItemTemplate>
                             <table id="" class="table  table-bordered table-hover">
								<tbody>
									<tr>
                                        <td colspan="1"><asp:Label Width="50px" class="label label-sm label-warning" Text=<%#Eval("EmployeeId") %> runat="server"></asp:Label></span></td>
                                        <td><asp:LinkButton Width="20px" ID="btnViewStaffDetails"  class="green bigger-140 show-details-btn" Text="<i class='ace-icon fa fa-angle-double-down bigger-120'></i>" ToolTip="Profile" OnCommand="ManageStaffVisibility" CommandName="ViewProfile" CommandArgument='<%#Eval("EmployeeId") %>' runat="server" ></asp:LinkButton></td>
										<td colspan="1"><asp:Label Width="100px" Text=<%#Eval("OrganizationName")%> runat="server"></asp:Label></td>
										<td colspan="2"><asp:Label Width="200px" Text=<%#Eval("FullName")%> runat="server"></asp:Label></td>
										<td colspan="2"><asp:Label Width="300px" Text=<%#Eval("Email")%> runat="server"></asp:Label> </td>
                                        <td colspan="1"><asp:Label Width="150px" Text=<%#Eval("PhoneOne")%> runat="server"></asp:Label></td>
                                        
										<td colspan="2">
											<div class="hidden-sm hidden-xs btn-group" style="width:100px;">
                                                 
												<!--<button class="btn btn-xs btn-info">
													<i class="ace-icon fa fa-book bigger-120"> Accounts</i>
												</button>-->
                                                <asp:LinkButton ID="lnkBtnStaffDoc"  class="btn btn-xs btn-info" Text="<i class='ace-icon fa fa-files-o bigger-120'></i> Doc" ToolTip="Upload Staff Doc" OnCommand="ManageStaffVisibility" CommandName="UploadStaffDocument" CommandArgument='<%#Eval("EmployeeId") %>' runat="server" ></asp:LinkButton>
												
                                                <!--<button class="btn btn-xs btn-danger">
													<i class="ace-icon fa fa-trash-o bigger-120"></i>
												</button>-->
                                                <asp:LinkButton ID="lnkBtnViewStaffDocs"  class="btn btn-xs btn-warning" Text="<i class='ace-icon fa fa-list bigger-120'></i>View" ToolTip="View Staff Doc" OnCommand="ManageStaffVisibility" CommandName="ViewStaffDocument" CommandArgument='<%#Eval("EmployeeId") %>' runat="server" ></asp:LinkButton>

												<!--<button class="btn btn-xs btn-warning">
													<i class="ace-icon fa fa-flag bigger-120"> CSR</i>
												</button>-->
											</div>

											<div class="hidden-md hidden-lg">
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
                                        <td colspan="1" rowspan="4"><asp:Image ImageUrl='<%# Eval("EmpPhotoPath") %>' style="border:6px solid black;border-bottom-left-radius:30px;"  class="editable img-responsive" AlternateText="StaffPhoto" runat="server" /></td>
                                    </tr>
							        <tr>
                                        <th>Full Name</th><td colspan="3"><%#Eval("FullName")%></td>
                                    </tr>
                                    <tr>
                                        <th>Organization</th><td colspan="3"><%#Eval("OrganizationID")%></td>
                                    </tr>
                                    <tr>
                                        <th>Phone One</th><td colspan="3"><%#Eval("PhoneOne")%></td>
                                    </tr>
                                    <tr>
								        <th>Phone Two</th><td><%#Eval("PhoneTwo")%></td>
						            
                                        <th>Email</th><td><%#Eval("Email")%></td>
                                    </tr>
                                    <tr>
								        <th>Address</th><td colspan="3"><%#Eval("ContactAddress")%></td>
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
                                         <th>Manager</th><td><%#Eval("ManagerName")%></td>
                                     </tr>
                                     <tr>
                                        <th>Fathers Name</th><td><asp:Label ID="txtBoxEditFathersName" Text=<%#Eval("FathersName") %> runat="server"></asp:Label></td>
                                        <th>Mothers Name</th><td><asp:Label ID="txtBoxEditMothersName" Text=<%#Eval("MothersName") %> runat="server"></asp:Label></td>
							        </tr>
                                    <tr>
                                        <th>PAN Number</th><td><asp:Label ID="txtBoxEditPan" Text=<%#Eval("PanNumber") %> runat="server"></asp:Label></td>
                                        <th>Aadhaar Number</th><td><asp:Label ID="txtBoxEditAadhaar" Text=<%#Eval("AadhaarNumber") %> runat="server"></asp:Label></td>
							        </tr>
                                    <tr>
                                        <th>Bank Name</th><td><asp:Label ID="txtBoxEditBankName" Text=<%#Eval("BankName") %> runat="server"></asp:Label></td>
                                        <th>Bank Account Number</th><td><asp:Label ID="txtBoxEditBankAccount" Text=<%#Eval("BankAccountNumber") %> runat="server"></asp:Label></td>
							        </tr>
                                    <tr>
                                        <th>Bank IFSC</th><td><asp:Label ID="txtBoxEditBankIFSC" Text=<%#Eval("BankIFSC") %> runat="server"></asp:Label></td>
                                        <th></th><td></td>
							        </tr>
                                    <tr>
                                        <th>Date Of Joining</th><td><%#Eval("DateOfJoining", "{0:MMM/dd/yyyy}")%></td>
                                        <th>Employment Type</th><td><%#Eval("EmploymentType")%>
                                            </td>
							        </tr>
                                     <tr>
                                        <th>Employment Status</th><td><%#Eval("EmploymentStatus")%>
                                        <th>Date Of Leaving</th><td><asp:Label ID="lblViewDateOfLeaving" Visible='<%# string.Equals(Eval("EmploymentStatus"),"NotActive") %>' Text=<%#Eval("DateOfLeaving","{0:MMM/dd/yyyy}")%> runat="server"></asp:Label></td>
						            </tr>

                                    <tr>
										<td colspan="4">
											<div class="hidden-sm hidden-xs btn-group">
															
                                                <asp:LinkButton ID="lnkBtnEditStaffDetails"  class="btn btn-xs btn-info" Text="<i class='ace-icon fa fa-pencil bigger-120'></i>" ToolTip="Edit Profile" OnCommand="ManageStaffVisibility" CommandName="EditProfile" CommandArgument='<%#Eval("EmployeeId")%>' runat="server" ></asp:LinkButton>
												<asp:LinkButton ID="LinkButton1"  class="btn btn-xs btn-info" Text="<i class='ace-icon fa fa-times bigger-120 white'></i>" ToolTip="Cancel" OnCommand="ManageStaffVisibility" CommandName="ReturnToViewStaff" runat="server" ></asp:LinkButton>

												
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
                   
                 </div><!-- /.span -->
            </asp:Panel>
		   <!-- PAGE CONTENT ENDS -->
		    </div><!-- /.col -->
    </div><!-- /.row -->

    <!--Edit and Save Staff Profile-->
	<div class="row">
		    <div class="col-xs-12">
                 <!--View Staff-->
                <asp:Panel ID="pnlEditStaffProfile" ScrollBars="Auto"  runat="server">
                <div class="col-xs-12">
                    <asp:DataList ID="dlEditStaffProfile" DataKeyField="EmployeeId" OnUpdateCommand="UpdateStaffProfile"  HorizontalAlign="Justify"   RepeatColumns="1" RepeatDirection="horizontal" GridLines="Vertical" runat="server">
                        <HeaderTemplate>

                        </HeaderTemplate>
                        <ItemStyle HorizontalAlign="Center"   />
                        <ItemTemplate>
                             <table id="simple-table" class="table  table-bordered table-hover">
								<tbody>
                                    <tr>
                                        <td colspan="1" rowspan="4"><asp:ImageButton  ImageUrl='<%#Eval("EmpPhotoPath") %>'  style="border:2px solid silver;"  class="editable img-responsive" AlternateText="StaffPhoto" runat="server" />
                                            <asp:FileUpload ID="flUploadStaffPhoto" runat="server" />
                                            <asp:LinkButton ID="btnFileUpload" class="btn btn-app btn-purple btn-xs" Text='<i class="ace-icon fa fa-cloud-upload"></i> Upload' OnCommand="btnFileUpload_StaffPhoto" CommandName="" CommandArgument="" runat="server"></asp:LinkButton>
                                            <asp:Label ID="lblEmpPhotoPath" Text='<%# Eval("EmpPhotoPath") %>' runat="server"></asp:Label>
                                        </td>
                                        
                                    </tr>
                                    <tr>
                                        <th>Full Name</th><td colspan="3"><asp:TextBox ID="txtBoxEditFullName" Text=<%#Eval("FullName") %> runat="server"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <th>Organization</th><td colspan="3"><asp:DropDownList ID="ddlEditOrgId" DataTextField="OrganizationName" DataValueField="OrganizationID" runat="server"></asp:DropDownList></td>
                                    </tr>
                                    <tr>
                                        <th>Phone One</th><td colspan="3"><asp:TextBox ID="txtBoxEditPhoneOne" Text=<%#Eval("PhoneOne") %> runat="server"></asp:TextBox></td>
								    </tr>
                                    <tr>
                                        <th>Phone Two</th><td><asp:TextBox ID="txtBoxEditPhoneTwo" Text=<%#Eval("PhoneTwo") %> runat="server"></asp:TextBox></td>
						            
                                        <th>Email</th><td><asp:TextBox ID="txtBoxEditEmail" Text=<%#Eval("Email") %> runat="server"></asp:TextBox>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtBoxEditEmail"
                                                ForeColor="Red" ValidationExpression="^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$"
                                                Display = "Dynamic" ErrorMessage = "Invalid email address"/>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtBoxEditEmail"
                                                ForeColor="Red" Display = "Dynamic" ErrorMessage = "Required" />
                                                      </td>
								    </tr>
                                    <tr>
                                        <th>Address</th><td colspan="3"><asp:TextBox ID="txtBoxEditContactAddress" CssClass="col-xs-12" Text=<%#Eval("ContactAddress") %> TextMode="MultiLine" runat="server"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <th>City</th><td><asp:TextBox ID="txtBoxEditCity" Text=<%#Eval("City") %> runat="server"></asp:TextBox></td>
								        <th>District</th><td><asp:TextBox ID="txtBoxEditDistrict" Text=<%#Eval("District") %> runat="server"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <th>Pin Code</th><td><asp:TextBox ID="txtBoxEditPinCode" Text=<%#Eval("PinCode") %> runat="server"></asp:TextBox></td>
                                        <th>State</th><td><asp:TextBox ID="txtBoxEditState" Text=<%#Eval("State") %> runat="server"></asp:TextBox></td>
						            </tr>
                                    <tr>
                                        <th>Country</th><td><asp:TextBox ID="txtBoxEditCountry" Text=<%#Eval("Country") %> runat="server"></asp:TextBox></td>
                                        <th>Designation</th><td><asp:TextBox ID="txtBoxEditDesignation" Text=<%#Eval("Designation") %> runat="server"></asp:TextBox></td>
							        </tr>
                                     <tr>
                                         <th>Date Of Birth</th><td><asp:TextBox ID="txtBoxEditDateOfBirth" Text=<%#Eval("DateOfBirth","{0:dd/MM/yyyy}") %>  runat="server"></asp:TextBox></td>
                                         <th>Manager</th><td><asp:DropDownList ID="ddlEditManagerId" DataTextField="FullName" DataValueField="EmployeeId" runat="server"></asp:DropDownList></td>
                                     </tr>
                                     <tr>
                                        <th>Fathers Name</th><td><asp:TextBox ID="txtBoxEditFathersName" Text=<%#Eval("FathersName") %> runat="server"></asp:TextBox></td>
                                        <th>Mothers Name</th><td><asp:TextBox ID="txtBoxEditMothersName" Text=<%#Eval("MothersName") %> runat="server"></asp:TextBox></td>
							        </tr>
                                    <tr>
                                        <th>PAN Number</th><td><asp:TextBox ID="txtBoxEditPan" Text=<%#Eval("PanNumber") %> runat="server"></asp:TextBox></td>
                                        <th>Aadhaar Number</th><td><asp:TextBox ID="txtBoxEditAadhaar" Text=<%#Eval("AadhaarNumber") %> runat="server"></asp:TextBox></td>
							        </tr>
                                    <tr>
                                        <th>Bank Name</th><td><asp:TextBox ID="txtBoxEditBankName" Text=<%#Eval("BankName") %> runat="server"></asp:TextBox></td>
                                        <th>Bank Account Number</th><td><asp:TextBox ID="txtBoxEditBankAccount" Text=<%#Eval("BankAccountNumber") %> runat="server"></asp:TextBox></td>
							        </tr>
                                    <tr>
                                        <th>Bank IFSC</th><td><asp:TextBox ID="txtBoxEditBankIFSC" Text=<%#Eval("BankIFSC") %> runat="server"></asp:TextBox></td>
                                        <th></th><td></td>
							        </tr>
                                    <tr>
                                        <th>Date Of Joining</th><td><asp:TextBox ID="txtBoxEditDateOfJoining" Text=<%#Eval("DateOfJoining","{0:dd/MM/yyyy}") %>  runat="server"></asp:TextBox></td>
                                        <th>Employment Type</th><td><asp:DropDownList ID="ddlEditEmploymentType" runat="server">
                                                                                        <asp:ListItem>EMPLOYEE</asp:ListItem>
                                                                                        <asp:ListItem>CONTRACT</asp:ListItem>
                                                                                        </asp:DropDownList></td>
							        </tr>
                                     <tr>
                                        <th>Employment Status</th><td><asp:DropDownList ID="ddlEditEmploymentStatus" Text=<%#Eval("EmploymentStatus") %> AutoPostBack="true" OnSelectedIndexChanged="ddlEditEmploymentStatus_SelectedIndexChanged" runat="server">
                                                                                        <asp:ListItem>ACTIVE</asp:ListItem>
                                                                                        <asp:ListItem>NOTACTIVE</asp:ListItem>
                                                                                        </asp:DropDownList></td>
                                        <th><asp:Label ID="lblEditDateOfLeaving" Text="Date of Leaving" Visible="false" runat="server"></asp:Label></th><td><asp:TextBox ID="txtBoxEditDateOfLeaving" Visible="false" Text='<%#Eval("DateOfLeaving") %>'  runat="server"></asp:TextBox></td>
                                        
						            </tr>
                                            <tr>
										        <td colspan="4">
											        <div class="hidden-sm hidden-xs btn-group">
                                                        <asp:LinkButton ID="lnkBtnUpdateStaffProfile"  class="btn btn-white btn-info btn-bold" Text="<i class='ace-icon fa fa-floppy-o bigger-120 blue'>Save</i>" ToolTip="Save" CommandName="Update" runat="server" ></asp:LinkButton>
												        <asp:LinkButton ID="lnkBtnReturnToViewCusatomers"  class="btn btn-white btn-default btn-round" Text="<i class='ace-icon fa fa-times red2'>Cancel</i>" ToolTip="Cancel" OnCommand="ManageStaffVisibility"  CommandName="ReturnToViewStaff" runat="server" ></asp:LinkButton>			
                                               
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
                   
                 </div><!-- /.span -->
            </asp:Panel>
		   <!-- PAGE CONTENT ENDS -->
		    </div><!-- /.col -->
    </div><!-- /.row -->
    	  

</asp:Content>
