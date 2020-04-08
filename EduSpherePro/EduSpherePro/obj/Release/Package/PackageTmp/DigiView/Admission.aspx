<%@ Page Title="" Language="C#" MasterPageFile="~/DigiView/DigiViewSite.Master" EnableEventValidation="false" AutoEventWireup="true" CodeBehind="Admission.aspx.cs" Inherits="EduSpherePro.DigiView.Admission" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<audio id="audio" src="http://www.soundjay.com/button/beep-07.wav" autostart="false" ></audio>
    <script type="text/javascript">
    function playSound() {
          var sound = document.getElementById("audio");
          sound.play();
      }
    </script>
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<!--Page Headers-->
    <div class="row">
        <div class="col-sm-3">
            <h4 class="pink">
                <i class="ace-icon fa fa-hand-o-right icon-animated-hand-pointer blue"></i>
                <asp:Label ID="lblStaffAction" Text="" runat="server"></asp:Label>
            </h4>
        </div>
        <div class="col-sm-3">
            <div class="input-group">
                <span class="input-group-addon">
                    <i class="ace-icon fa fa-check"></i>
                </span>
                <asp:TextBox class="form-control search-query" ID="txtBoxSearchStaff" Placeholder="Name or Phone" runat="server"></asp:TextBox>
                <span class="input-group-btn">
                    <asp:LinkButton ID="lnkBtnSerachEnquiry" class="btn btn-purple btn-sm" Text="<span class='ace-icon fa fa-search icon-on-right bigger-110'></span> Search" OnCommand="ManageStaffVisibility" CommandName="SearchEnquiry" runat="server"></asp:LinkButton>
                </span> 
            </div>
        </div>
        <!--Page Buttons-->
        <div class="col-sm-4">
                    <div id="membersbar" class="navbar-buttons navbar-header pull-right" role="navigation">
					    <ul class="nav ace-nav">
						    <li class="light-blue dropdown-modal">
							    <a data-toggle="dropdown" href="#" class="dropdown-toggle">
                                    Enrolments <i class="ace-icon fa fa-caret-down"></i> 
							    </a>
							    <ul class="user-menu dropdown-menu-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">
						           <%-- <li>
                                        <asp:LinkButton ID="lnkBtnEnroll" class="btn btn-xs btn-info" Text="<i class='ace-icon fa fa-plus bigger-120'></i> Enrol" ToolTip="Enrol" OnCommand="ManageStaffVisibility" CommandName="AddStaff" runat="server"></asp:LinkButton>
								    </li>
								    <li class="divider"></li>--%>
                                    <li>
                                        <asp:LinkButton ID="lbkBtnViewEnrolmentStatus" class="btn btn-xs btn-info" Text="<i class='ace-icon fa fa-eye bigger-120'></i> View Enrolment" ToolTip="View Leads" OnCommand="ManageStaffVisibility" CommandName="StatusFilter" CommandArgument="ALL" runat="server"></asp:LinkButton>
								    </li>
								    <li class="divider"></li>
                                      <li>
                                        <asp:LinkButton ID="lnkBtnHelp" class="btn btn-xs btn-warning" Text="<i class='ace-icon fa fa-question-circle bigger-120'></i> Help" ToolTip="Help" OnCommand="ManageStaffVisibility" CommandName="ViewHelp" CommandArgument="" runat="server"></asp:LinkButton>
								    </li>
								    <li class="divider"></li>
								    <%--<li>
									   <!-- Trigger the modal with a button -->
                                        <asp:LinkButton ID="lnkBtnFilterModal" data-toggle="modal" data-target="#filterModal" class="btn btn-xs btn-info" Text="<i class='ace-icon fa fa-filter bigger-120'></i> Apply Filters" ToolTip="Apply Filter" runat="server" ></asp:LinkButton>
                                       
								    </li>
                                    <li class="divider"></li>--%>
								    
							    </ul>
						    </li>
					    </ul>
				    </div>
              
          </div>
        <!--End Page Buttons-->
    </div>
    <div class="hr hr-18 dotted hr-double"></div>

<!--/Page Header-->
 <!--Enroll For Neurotherapist Membership-->
 <!--New Staff-->
    <div class="row">
		<div class="col-xs-12">
			<!-- PAGE CONTENT BEGINS -->
                <!--Add New Staff-->
                <asp:Panel ID="pnlAddStaff" ScrollBars="Auto"  runat="server">
                  
                    <table id="simple-table" class="table  table-bordered table-hover">
                        <tbody>
							<tr>
                                <th class="col-sm-1">Full Name</th><td class="col-sm-2"><asp:TextBox ID="txtBoxFullName"  runat="server"></asp:TextBox></td>
                                <th class="col-sm-1">Function</th><td class="col-sm-4"><asp:DropDownList ID="ddlOrgId" DataTextField="OrganizationName" DataValueField="OrganizationID" runat="server"></asp:DropDownList></td>
                            </tr>
                            <tr>
                                <th class="col-sm-1"></th><td class="col-sm-2"></td>
                                <th class="col-sm-1">Gender</th><td class="col-sm-4"><asp:DropDownList ID="ddlGender" runat="server">
                                                                                          <asp:ListItem>FEMALE</asp:ListItem>
                                                                                           <asp:ListItem>MALE</asp:ListItem>                                                     
                                                                                        </asp:DropDownList></td>
                            </tr>
                            <tr>
                                <th>Phone</th><td><asp:TextBox ID="txtBoxPhoneOne" runat="server"></asp:TextBox></td>
								<th>Phone(whatsup)</th><td><asp:TextBox ID="txtBoxPhoneTwo" runat="server"></asp:TextBox></td>
						    </tr>
                            <tr>
                                <th>Email</th><td><asp:TextBox ID="txtBoxEmail"  runat="server"></asp:TextBox></td>
								<th></th><td></td>
                           </tr>
                            <tr>
                                <th>Contact Address</th>
                                <td colspan="3"><asp:TextBox id="autoaddress" class="col-sm-10" ClientIDMode="static" clientID="autoaddress" placeholder="Enter your address"
             onFocus="geolocate()" type="text" runat="server"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <th>Road</th>
                                <td><asp:TextBox class="field" id="street_number1" ClientIDMode="static" clientID="street_number1"
              disabled="true" runat="server"></asp:TextBox></td>
                                 <th></th>
                                 <td><asp:TextBox class="field" id="route1" ClientIDMode="static" clientID="route1" 
              disabled="true"  runat="server"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <th>City/District</th>
                                <td><asp:TextBox class="field" id="locality1" ClientIDMode="static" clientID="locality1"
                                                          disabled="true" type="text"  runat="server"></asp:TextBox></td>
								<th>State</th>
                                <td><asp:TextBox class="field" id="administrative_area_level_11" ClientIDMode="static" clientID="administrative_area_level_11"
                                                 disabled="true" type="text"  runat="server"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <th>PinCode</th>
                                <td><asp:TextBox class="field" id="postal_code1" ClientIDMode="static" clientID="postal_code1"
                                                disabled="true" type="text"  runat="server"></asp:TextBox></td>
                                <th>Country :</th>
                                <td><asp:TextBox class="field" id="country1" ClientIDMode="static" clientID="country1"
                                 disabled="true" type="text"  runat="server"></asp:TextBox></td>
						    </tr>
                            <tr>
                                <th></th><td></td>
                                <th>Designation</th><td><asp:TextBox ID="txtBoxDesignation" runat="server"></asp:TextBox></td>
							</tr>
                            <tr>
                                <th>Date of Birth</th><td><asp:TextBox ID="txtBoxDateOfBirth" TextMode="Date" runat="server"></asp:TextBox></td>
                                <th>Mentor</th><td><asp:DropDownList ID="ddlManagerId" DataTextField="FullName" DataValueField="MemberID" runat="server"></asp:DropDownList></td>
                            </tr>
                            <tr>
                                <th>Date Of Joining</th><td><asp:TextBox ID="txtBoxDateOfJoining" TextMode="Date" runat="server"></asp:TextBox></td>
                                <th>Membership Type</th><td><asp:DropDownList ID="ddlEmploymentType" runat="server">
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
                  
                </asp:Panel>
            	</div><!-- /.col -->
    </div><!-- /.row -->
 <!--End Enroll for Certificate-->

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
                                <th>Document Type</th>
                                <th>Selected Document</th>
                                <th>Click Upload</th>
                                <th>Click Save after Upload</th>
                            </tr>
                        </thead>
                        <tbody>
							<tr>
                                <td><asp:FileUpload ID="flStaffDocumentOne" runat="server"></asp:FileUpload></td>
                                <td><asp:TextBox ID="txtBoxStaffDocumentTitleOne" runat="server"></asp:TextBox></td>
                                <td><asp:Label ID="lblDocTypeOne" Text="PAN" runat="server"></asp:Label></td>
                                 <td><asp:Label ID="lblStaffDocumentPathOne" runat="server"></asp:Label></td>
                                <td><asp:LinkButton ID="btnFileUploadOne" class="btn btn-app btn-purple btn-xs" Text='<i class="ace-icon fa fa-cloud-upload"></i>' OnCommand="btnFileUpload_StaffDocument" CommandName="flOne" CommandArgument="" runat="server"></asp:LinkButton>
                                </td>
                                <td><asp:LinkButton ID="lnkBtnSaveDocumentDetailsOne" class="btn btn-app btn-purple btn-xs" Text='<i class="ace-icon fa fa-save"></i>' OnCommand="SaveStaffDocument" CommandName="docOne" CommandArgument="" runat="server"></asp:LinkButton>
                                </td>
                            </tr>
                            <tr>
                                <td><asp:FileUpload ID="flStaffDocumentTwo" runat="server"></asp:FileUpload></td>
                                <td><asp:TextBox ID="txtBoxStaffDocumentTitleTwo" runat="server"></asp:TextBox></td>
                                 <td><asp:Label ID="lblDocTypeTwo" Text="AADHAAR" runat="server"></asp:Label></td>
                                <td><asp:Label ID="lblStaffDocumentPathTwo" runat="server"></asp:Label></td>
                                <td><asp:LinkButton ID="btnFileUploadTwo" class="btn btn-app btn-purple btn-xs" Text='<i class="ace-icon fa fa-cloud-upload"></i>' OnCommand="btnFileUpload_StaffDocument" CommandName="flTwo" CommandArgument="" runat="server"></asp:LinkButton>
                                </td>
                                <td><asp:LinkButton ID="lnkBtnSaveDocumentDetailsTwo" class="btn btn-app btn-purple btn-xs" Text='<i class="ace-icon fa fa-save"></i>' OnCommand="SaveStaffDocument" CommandName="docTwo" CommandArgument="" runat="server"></asp:LinkButton>
                                </td>
                            </tr>	
                            <tr>
                                <td><asp:FileUpload ID="flStaffDocumentThree" runat="server"></asp:FileUpload></td>
                                <td><asp:TextBox ID="txtBoxStaffDocumentTitleThree" runat="server"></asp:TextBox></td>
                                <td><asp:Label ID="lblDocTypeThree" Text="NEUROTHERAPY-CERT" runat="server"></asp:Label></td>
                                 <td><asp:Label ID="lblStaffDocumentPathThree" runat="server"></asp:Label></td>
                                <td><asp:LinkButton ID="btnFileUploadThree" class="btn btn-app btn-purple btn-xs" Text='<i class="ace-icon fa fa-cloud-upload"></i>' OnCommand="btnFileUpload_StaffDocument" CommandName="flThree" CommandArgument="" runat="server"></asp:LinkButton>
                                </td>
                                <td><asp:LinkButton ID="lnkBtnSaveDocumentDetailThree" class="btn btn-app btn-purple btn-xs" Text='<i class="ace-icon fa fa-save"></i>' OnCommand="SaveStaffDocument" CommandName="docThree" CommandArgument="" runat="server"></asp:LinkButton>
                                </td>
                            </tr>	
                            <tr>
                                <td><asp:FileUpload ID="flStaffDocumentFour" runat="server"></asp:FileUpload></td>
                                <td><asp:TextBox ID="txtBoxStaffDocumentTitleFour" runat="server"></asp:TextBox></td>
                                <td><asp:Label ID="lblDocTypeFour" Text="SCHOOL-CERT" runat="server"></asp:Label></td>
                                 <td><asp:Label ID="lblStaffDocumentPathFour" runat="server"></asp:Label></td>
                                <td><asp:LinkButton ID="btnFileUploadFour" class="btn btn-app btn-purple btn-xs" Text='<i class="ace-icon fa fa-cloud-upload"></i>' OnCommand="btnFileUpload_StaffDocument" CommandName="flFour" CommandArgument="" runat="server"></asp:LinkButton>
                                </td>
                                <td><asp:LinkButton ID="lnkBtnSaveDocumentDetailsFour" class="btn btn-app btn-purple btn-xs" Text='<i class="ace-icon fa fa-save"></i>' OnCommand="SaveStaffDocument" CommandName="docFour" CommandArgument="" runat="server"></asp:LinkButton>
                                </td>
                            </tr>	
                            <tr>
                                <td><asp:FileUpload ID="flStaffDocumentFive" runat="server"></asp:FileUpload></td>
                                <td><asp:TextBox ID="txtBoxStaffDocumentTitleFive" runat="server"></asp:TextBox></td>
                                <td><asp:Label ID="lblDocTypeFive" Text="GRAD-CERT" runat="server"></asp:Label></td>
                                 <td><asp:Label ID="lblStaffDocumentPathFive" runat="server"></asp:Label></td>
                                <td><asp:LinkButton ID="btnFileUploadFive" class="btn btn-app btn-purple btn-xs" Text='<i class="ace-icon fa fa-cloud-upload"></i>' OnCommand="btnFileUpload_StaffDocument" CommandName="flFive" CommandArgument="" runat="server"></asp:LinkButton>
                                </td>
                                <td><asp:LinkButton ID="lnkBtnSaveDocumentDetailsFive" class="btn btn-app btn-purple btn-xs" Text='<i class="ace-icon fa fa-save"></i>' OnCommand="SaveStaffDocument" CommandName="docFive" CommandArgument="" runat="server"></asp:LinkButton>
                                </td>
                            </tr>	
                            <tr>
                                <td><asp:FileUpload ID="flStaffDocumentSix" runat="server"></asp:FileUpload></td>
                                <td><asp:TextBox ID="txtBoxStaffDocumentTitleSix" runat="server"></asp:TextBox></td>
                                <td><asp:Label ID="lblDocTypeSix" Text="OTHERS" runat="server"></asp:Label></td>
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
                            <asp:LinkButton ID="lnkBtnReturn"  class="btn  btn-warning" Text="<i class='ace-icon fa fa-times bigger-110'></i> Cancel" ToolTip="Cancel" OnCommand="ManageStaffVisibility" CommandName="ReturnToViewStaff" runat="server" ></asp:LinkButton>
						    <asp:LinkButton ID="lnkBtnEditStaffDetails"  class="btn btn-info" Text="<i class='ace-icon fa fa-pencil bigger-120'></i> Continue Edit" ToolTip="Edit Profile" OnCommand="ManageStaffVisibility" CommandName="TopnlProfileEditFrompnlUploadStaffDocument" CommandArgument="" runat="server" ></asp:LinkButton>
                        </div>
					</div> <br /><br /> 
                  </form>
                </asp:Panel>
            	</div><!-- /.col -->
    </div><!-- /.row -->

    <!--View Staff Documents-->
    <div class="row">
       <!--View Staff Profile-->
                <!--ViewStaff Documents -->
            <asp:Panel ID="pnlHelp" ScrollBars="Auto" runat="server">
                <div class="col-xs-12">
                    <!--View Staff Documents-->
                    <asp:GridView ID="gvHelpDocuments" CssClass="table table-hover table-bordered"  DataKeyNames="DocumentId" runat="server" AutoGenerateColumns="False" BackColor="White"
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
        
    </div>
    <!-- /.row -->
       
    <!--View All Staff -->
    <div class="row">
		    <div class="col-xs-12">
                 <!--View Staff-->
                <asp:Panel ID="pnlViewStaff" ScrollBars="Auto"  runat="server">
                    <!--Filter Staff-->
                      <div class="col-xs-12">
                    <table>
                        <tr>
                            <th class="col-sm-1">Enrolment Status</th>
                            <td class="col-sm-2">
                                <asp:DropDownList ID="ddlFilterEmploymentStatus" Visible="true" runat="server">
                                    <asp:ListItem>ACTIVE</asp:ListItem>
                                    <asp:ListItem>NOTACTIVE</asp:ListItem>
                                </asp:DropDownList></td>
                            <td class="col-sm-1">
                                <asp:LinkButton ID="btnFilterEmploymentStatus" Visible="true" class="btn btn-xs btn-info" Text="<i class='ace-icon fa fa-filter bigger-120'> GO</i>" ToolTip="Filter" OnCommand="ManageStaffVisibility" CommandName="FilterStaff" CommandArgument="" runat="server"></asp:LinkButton></td>
                        </tr>
                    </table>
                </div>
                    <hr />
                    <!--End Filter Staff-->
                <div class="col-xs-12">
                    <asp:DataList ID="dlStaff" DataKeyField="MemberID" HorizontalAlign="Justify"   RepeatColumns="1" RepeatDirection="horizontal" GridLines="Vertical" runat="server">
                        <HeaderTemplate>
                            <table id="simple-table" class="table  table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th><asp:Label Width="50px" Text="Id" runat="server"></asp:Label></th>
										<th><asp:Label Width="50px" Text="Details" runat="server"></asp:Label></th>
										<%--<th colspan="1"><asp:Label Width="100px" Text="Function" runat="server"></asp:Label></th>--%>
										<th><asp:Label Width="200px" Text="FullName" runat="server"></asp:Label></th>
										<th><asp:Label Width="200px" Text="Email" runat="server"></asp:Label></th>
                                        <th><asp:Label Width="100px" Text="Phone" runat="server"></asp:Label></th>
                                        
                                        <th><asp:Label Width="300px" class="ace-icon fa fa-clock-o bigger-110 hidden-480" Text="" runat="server"></asp:Label></th>				
										
									</tr>
								</thead>
                            </table>
                        </HeaderTemplate>
                        <ItemStyle HorizontalAlign="Center"   />
                        <ItemTemplate>
                             <table id="simple-table" class="table  table-bordered table-hover">
								<tbody>
									<tr>
                                        <td colspan="1"><asp:Label Width="50px" class="label label-sm label-warning" Text='<%#Eval("MemberID") %>' runat="server"></asp:Label></span></td>
                                        <td><asp:LinkButton Width="50px" ID="btnViewStaffDetails"  class="green bigger-140 show-details-btn" Text="<i class='ace-icon fa fa-angle-double-down bigger-120'></i>" ToolTip="Profile" OnCommand="ManageStaffVisibility" CommandName="ViewProfile" CommandArgument='<%#Eval("MemberID") %>' runat="server" ></asp:LinkButton></td>
										<%--<td colspan="1"><asp:Label Width="100px" Text='<%#Eval("OrganizationName")%>' runat="server"></asp:Label></td>--%>
										<td><asp:Label Width="200px" Text='<%#Eval("FullName")%>' runat="server"></asp:Label></td>
										<td><asp:Label Width="200px" Text='<%#Eval("Email")%>' runat="server"></asp:Label> </td>
                                        <td><asp:Label Width="100px" Text='<%#Eval("PhoneOne")%>' runat="server"></asp:Label></td>
                                        
										<td>
											<div class="hidden-sm hidden-xs btn-group" style="width:300px;">
												<div>
                                                    <asp:LinkButton ID="lnkBtnAcademic" class="btn btn-xs btn-warning" Visible="false" ToolTip="Skills" Text="<i class='ace-icon fa fa-graduation-cap bigger-120'></i>Acad" OnCommand="ManageStaffVisibility"  CommandName="AcademicDetails" CommandArgument='<%#Eval("MemberID") %>' runat="server"></asp:LinkButton>
                                                </div>
                                                <%--<div>                                        
                                                    <asp:LinkButton ID="lnkBtnPublication" class="btn btn-xs btn-warning" ToolTip="Publications" Text="<i class='ace-icon fa fa-book bigger-120'></i> Pub" OnCommand="ManageStaffVisibility"  CommandName="PublicationDetails" CommandArgument='<%#Eval("MemberID") %>'  runat="server"></asp:LinkButton>
                                                </div>--%>
                                                <!--<button class="btn btn-xs btn-info">
													<i class="ace-icon fa fa-book bigger-120"> Accounts</i>
												</button>-->
                                                <asp:LinkButton ID="lnkUploadBtnStaffDoc"  class="btn btn-xs btn-info" Visible="false" Text="<i class='ace-icon fa fa-files-o bigger-120'></i> Upload" ToolTip="Upload Documents" OnCommand="ManageStaffVisibility" CommandName="UploadStaffDocument" CommandArgument='<%#Eval("MemberID") %>' runat="server" ></asp:LinkButton>
												
                                                <!--<button class="btn btn-xs btn-danger">
													<i class="ace-icon fa fa-trash-o bigger-120"></i>
												</button>-->
                                                <asp:LinkButton ID="lnkBtnViewStaffDocs"  class="btn btn-xs btn-warning"  Text="<i class='ace-icon fa fa-list bigger-120'></i> View Doc" ToolTip="View Doc" OnCommand="ManageStaffVisibility" CommandName="ViewStaffDocument" CommandArgument='<%#Eval("MemberID") %>' runat="server" ></asp:LinkButton>

												<!--<button class="btn btn-xs btn-warning">
													<i class="ace-icon fa fa-flag bigger-120"> CSR</i>
												</button>-->
                                                <asp:LinkButton ID="lnkBtnCert" Visible='<%#Eval("MembershipStatus").ToString().Trim()=="ACTIVE" %>' class="btn btn-xs btn-warning" Text="<i class='ace-icon fa fa-download bigger-120'></i>Cert" ToolTip="Download Membership" OnCommand="ManageStaffVisibility" CommandName="ViewEnrolmentCertificate" CommandArgument='<%#Eval("MemberID") %>' runat="server" ></asp:LinkButton>
                                               
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
                                                             <asp:LinkButton ID="LinkButton4" class="btn btn-xs btn-warning" ToolTip="Skills" Text="<i class='ace-icon fa fa-graduation-cap bigger-120'></i>A" OnCommand="ManageStaffVisibility"  CommandName="AcademicDetails" CommandArgument='<%#Eval("MemberID") %>' runat="server"></asp:LinkButton>
														</li>
														<li>
															<%--<a href="#" class="tooltip-success" data-rel="tooltip" title="Edit">
																<span class="green">
																	<i class="ace-icon fa fa-pencil-square-o bigger-120"></i>
																</span>
															</a>--%>
                                                            <%-- <asp:LinkButton ID="LinkButton5" class="btn btn-xs btn-warning" ToolTip="Publications" Text="<i class='ace-icon fa fa-book bigger-120'></i>P" OnCommand="ManageStaffVisibility"  CommandName="PublicationDetails" CommandArgument='<%#Eval("MemberID") %>'  runat="server"></asp:LinkButton>--%>
														</li>
														<li>
															<%--<a href="#" class="tooltip-error" data-rel="tooltip" title="Delete">
																<span class="red">
																	<i class="ace-icon fa fa-trash-o bigger-120"></i>
																</span>
															</a>--%>
                                                            <asp:LinkButton ID="LinkButton6"  class="btn btn-xs btn-info" Text="<i class='ace-icon fa fa-files-o bigger-120'></i> U" ToolTip="Upload Documents" OnCommand="ManageStaffVisibility" CommandName="UploadStaffDocument" CommandArgument='<%#Eval("MemberID") %>' runat="server" ></asp:LinkButton>
														</li>
                                                        <li>
                                                            <asp:LinkButton ID="LinkButton7"  class="btn btn-xs btn-warning" Text="<i class='ace-icon fa fa-list bigger-120'></i> D" ToolTip="View Documents" OnCommand="ManageStaffVisibility" CommandName="ViewStaffDocument" CommandArgument='<%#Eval("MemberID") %>' runat="server" ></asp:LinkButton>
                                                        </li>
                                                        <li>
                                                            <asp:LinkButton ID="LinkButton8" Visible='<%#Eval("MembershipStatus").ToString().Trim()=="ACTIVE" %>'  class="btn btn-xs btn-warning" Text="<i class='ace-icon fa fa-download bigger-120'></i>C" ToolTip="Download Membership" OnCommand="ManageStaffVisibility" CommandName="ViewEnrolmentCertificate" CommandArgument='<%#Eval("MemberID") %>' runat="server" ></asp:LinkButton>
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
		    <div class="col-sm-12">
                 <!--View Staff Profile-->
                <asp:Panel ID="pnlViewStaffProfile" ScrollBars="Auto"  runat="server">
                  <div class="col-sm-6">
                    <asp:DataList ID="dlStaffDetails" DataKeyField="MemberID" HorizontalAlign="Justify"   RepeatColumns="1" RepeatDirection="horizontal" GridLines="Vertical" runat="server">
                        <HeaderTemplate>
                        </HeaderTemplate>
                        <ItemStyle HorizontalAlign="Center"   />
                        <ItemTemplate>
                             <table id="simple-table" class="table  table-bordered table-hover">
								<tbody>
                                    <tr>
                                        <td colspan="1" rowspan="4"><asp:Image ImageUrl='<%# Eval("PhotoPath") %>' style="border:6px solid black;border-bottom-left-radius:30px;"  class="editable img-responsive" AlternateText="ProfilePhoto" runat="server" /></td>
                                    </tr>
							        <tr>
                                        <th>Full Name</th><td colspan="3"><%#Eval("FullName")%></td>
                                    </tr>
                                    <tr>
                                        <th>Centre </th><td colspan="3"><%#Eval("OrganizationName")%></td>
                                    </tr>
                                    <tr>
                                        <th>Phone One</th><td colspan="3"><%#Eval("PhoneOne")%></td>
                                    </tr>
                                    <tr>
								        <th>Phone Two</th><td><%#Eval("PhoneTwo")%></td>
                                        <th>Email</th><td><%#Eval("Email")%></td>
                                    </tr>
                                    <tr>
                                        <th>Program </th><td><asp:Label ID="lblStudentProgram" Visible='<%#Eval("MembershipType").ToString().Trim()=="STUDENT" %>' Text='<%# Eval("ProgramTitle")%>' runat="server"></asp:Label></td>
                                        <th>Designation</th><td><%#Eval("Designation")%></td>
							        </tr>
                                    <tr>
                                         <th>Date Of Birth</th><td><asp:Label ID="lblDob" Text='<%#Eval("DateOfBirth","{0:MMM/dd/yyyy}")%>'  runat="server"></asp:Label> </td>
                                         <th>Mentor/Coach</th><td><%#Eval("MentorName")%></td>
                                     </tr>
                                     <tr>
                                        <th>Fathers Name</th><td><asp:Label ID="txtBoxEditFathersName" Text='<%#Eval("FathersName") %>' runat="server"></asp:Label></td>
                                        <th>Mothers Name</th><td><asp:Label ID="txtBoxEditMothersName" Text='<%#Eval("MothersName") %>' runat="server"></asp:Label></td>
							        </tr>
                                    <tr>
                                        <th>PAN Number</th><td><asp:Label ID="txtBoxEditPan" Text='<%#Eval("PanNumber") %>' runat="server"></asp:Label></td>
                                        <th>Aadhaar Number</th><td><asp:Label ID="txtBoxEditAadhaar" Text='<%#Eval("AadhaarNumber") %>' runat="server"></asp:Label></td>
							        </tr>
                                    <tr>
                                        <th>Bank Name</th><td><asp:Label ID="txtBoxEditBankName" Text='<%#Eval("BankName") %>' runat="server"></asp:Label></td>
                                        <th>Bank Account Number</th><td><asp:Label ID="txtBoxEditBankAccount" Text='<%#Eval("BankAccountNumber") %>' runat="server"></asp:Label></td>
							        </tr>
                                    <tr>
                                        <th>Bank IFSC</th><td><asp:Label ID="txtBoxEditBankIFSC" Text='<%#Eval("BankIFSC") %>' runat="server"></asp:Label></td>
                                        <th>Neurotherapy Exam Status</th><td><asp:Label ID="lblExamStatus" Text='<%#Eval("AcademicExamStatus") %>' runat="server"></asp:Label></td>
							        </tr>
                                    <tr>
                                        <th>Date Of Joining</th><td><%#Eval("DateOfJoining", "{0:MMM/dd/yyyy}")%></td>
                                        <th>Membership Type</th><td><%#Eval("MembershipType")%>
                                            </td>
							        </tr>
                                     <tr>
                                        <th>Membership Status</th><td><%#Eval("MembershipStatus")%></td>
                                        <th>Date Of Leaving</th><td><asp:Label ID="lblViewDateOfLeaving" Visible='<%# string.Equals(Eval("MembershipStatus"),"NOTACTIVE") %>' Text='<%#Eval("DateOfLeaving","{0:MMM/dd/yyyy}")%>'  runat="server"></asp:Label></td>
						            </tr>
                                    <tr>
                                        <th>Membership Valid for Years</th><td><%#Eval("MembershipValidForYears")%></td>
                                        <th>Membership Expiry Date</th><td><asp:Label ID="lblMembershipExpiryDate" Visible='<%# string.Equals(Eval("MembershipStatus"),"ACTIVE") %>' Text='<%#Eval("MembershipExpiryDate","{0:MMM/dd/yyyy}")%>'  runat="server"></asp:Label></td>
						            </tr>

                                    <tr>
										<td colspan="4">
											<div class="hidden-sm hidden-xs btn-group">
                                                <asp:LinkButton ID="lnkBtnEditStaffDetails" Visible='<%#Eval("MembershipStatus").ToString().Trim()=="NOTACTIVE" %>'  class="btn btn-xs btn-info" Text="<i class='ace-icon fa fa-pencil bigger-120'></i>" ToolTip="Edit Profile" OnCommand="ManageStaffVisibility" CommandName="EditProfile" CommandArgument='<%#Eval("MemberID")%>' runat="server" ></asp:LinkButton>
												<asp:LinkButton ID="lnkBtnReturn"  class="btn btn-xs btn-info" Text="<i class='ace-icon fa fa-times bigger-120 white'></i>" ToolTip="Cancel" OnCommand="ManageStaffVisibility" CommandName="ReturnToViewStaff" runat="server" ></asp:LinkButton>
                                            </div>
											<div class="hidden-md hidden-lg">
												<div class="inline pos-rel">
													<button class="btn btn-minier btn-primary dropdown-toggle" data-toggle="dropdown" data-position="auto">
														<i class="ace-icon fa fa-cog icon-only bigger-110"></i>
													</button>

													<ul class="dropdown-menu dropdown-only-icon dropdown-yellow dropdown-menu-right dropdown-caret dropdown-close">
														<li>
															<%--<a href="#" class="tooltip-info" data-rel="tooltip" title="View">
																<span class="blue">
																	<i class="ace-icon fa fa-search-plus bigger-120"></i>
																</span>
															</a>--%>
                                                            <asp:LinkButton ID="lnkBtnE" Visible='<%#Eval("MembershipStatus").ToString().Trim()=="NOTACTIVE" %>'  class="btn btn-xs btn-info" Text="<i class='ace-icon fa fa-pencil bigger-120'></i>" ToolTip="E" OnCommand="ManageStaffVisibility" CommandName="EditProfile" CommandArgument='<%#Eval("MemberID")%>' runat="server" ></asp:LinkButton>
														</li>

														<li>
															<%--<a href="#" class="tooltip-success" data-rel="tooltip" title="Edit">
																<span class="green">
																	<i class="ace-icon fa fa-pencil-square-o bigger-120"></i>
																</span>
															</a>--%>
                                                            <asp:LinkButton ID="lnkBtnR"  class="btn btn-xs btn-info" Text="<i class='ace-icon fa fa-times bigger-120 white'></i>" ToolTip="C" OnCommand="ManageStaffVisibility" CommandName="ReturnToViewStaff" runat="server" ></asp:LinkButton>
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
                  
          <!--Documents-->
          <div class="col-sm-6">
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
         </div>          
          <!--End Documents-->       
        <!--View Only--Acdemics-->
        <div class="col-sm-6">
              <asp:GridView ID="gvViewAcademics" CssClass="table table-hover table-bordered" runat="server" AutoGenerateColumns="False" BackColor="White"
                        BorderColor="#3366CC" BorderStyle="None"
                        BorderWidth="1px" CellPadding="4">
                        <RowStyle BackColor="White" ForeColor="#003399" />
                        <Columns>
                            <asp:BoundField DataField="Degree" HeaderText="Qualification Title" />
                            <asp:BoundField DataField="Institute" HeaderText="Institute" />
                            <asp:BoundField DataField="University" HeaderText="University" />
                            <asp:BoundField DataField="StartDate" DataFormatString="{0:dd/MM/yyyy}" HeaderText="From" /> 
                            <asp:BoundField DataField="CompletionYear" DataFormatString="{0:dd/MM/yyyy}" HeaderText="To" />
                            <asp:BoundField DataField="Grade" HeaderText="Grade" />                             
                            
                        </Columns>
                        <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                        <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                        <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                        <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
                    </asp:GridView>                       
         </div>
        <!--End Academics-->
        <!--Addresses-->
        <div class="col-sm-6">
                    <asp:GridView ID="gvPostalAddresses" CssClass="table table-hover table-bordered"  DataKeyNames="MemberID" runat="server" AutoGenerateColumns="False" BackColor="White"
                        BorderColor="#3366CC" BorderStyle="None"
                        BorderWidth="1px" CellPadding="4">
                        <RowStyle BackColor="White" ForeColor="#003399" />
                        <Columns>
                            <asp:BoundField DataField="AddressType" HeaderText="Type" />
                            <asp:BoundField DataField="PostalAddress" HeaderText="Address" />
                            
                            <asp:HyperLinkField DataTextField="City" HeaderText="City/District" />
                            <asp:BoundField DataField="PinCode" HeaderText="Pin" />
                            <asp:BoundField DataField="State" HeaderText="State" />
                            
                            <asp:HyperLinkField DataTextField="country" HeaderText="country" />
                        </Columns>
                        <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                        <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                        <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                        <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
                    </asp:GridView>
                  </div>
        <!--End Address-->
            </asp:Panel>
		  </div>
    </div><!-- /.row -->

    <!--Edit and Save Staff Profile-->
	<div class="row">
                 <!--View Staff-->
                <asp:Panel ID="pnlEditStaffProfile" ScrollBars="Auto"  runat="server">
                    ID:<asp:Label ID="lblNeutherapistID" runat="server"></asp:Label>
                <div class="col-xs-12">
                    <asp:DataList ID="dlEditStaffProfile" OnItemDataBound="dlEditProfile_OnItemDataBound" DataKeyField="MemberID" OnUpdateCommand="UpdateStaffProfile"  HorizontalAlign="Justify"   RepeatColumns="1" RepeatDirection="horizontal" GridLines="Vertical" runat="server">
                        <HeaderTemplate>

                        </HeaderTemplate>
                        <ItemStyle HorizontalAlign="Center"   />
                        <ItemTemplate>
                             <asp:Label ID="lblMembershipType" Text='<%#Eval("MembershipType") %>' runat="server"></asp:Label>
                             <table id="simple-table" class="table  table-bordered table-hover">
								<tbody>
                                    <tr>
                                        <td colspan="2" rowspan="3"><asp:ImageButton  ImageUrl='<%#Eval("PhotoPath") %>'  style="border:2px solid silver;"  class="editable img-responsive" AlternateText="Profile Photo" runat="server" />
                                            <asp:FileUpload ID="flUploadStaffPhoto" runat="server" />
                                            <asp:LinkButton ID="btnFileUpload" class="btn btn-app btn-purple btn-xs" Text='<i class="ace-icon fa fa-cloud-upload"></i> Upload' OnCommand="btnFileUpload_StaffPhoto" CommandName="" CommandArgument="" runat="server"></asp:LinkButton>
                                            <asp:Label ID="lblEmpPhotoPath" Text='<%# Eval("PhotoPath") %>' runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>Full Name</th><td colspan="3"><asp:TextBox ID="txtBoxEditFullName" ReadOnly="true" Text='<%#Eval("FullName") %>' runat="server"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <th>Organization</th><td colspan="3"><asp:DropDownList ID="ddlEditOrgId"  DataTextField="OrganizationName" DataValueField="OrganizationID" runat="server"></asp:DropDownList></td>
                                    </tr>
                                    <tr>
                                        <th>Program</th><td><asp:DropDownList ID="ddlEditProgram"  DataTextField="ProgramTitle" DataValueField="ProgramID" runat="server"></asp:DropDownList></td>
                                  
                                        <th>Phone One</th><td><asp:TextBox ID="txtBoxEditPhoneOne" Text='<%#Eval("PhoneOne") %>' runat="server"></asp:TextBox></td>
								    </tr>
                                    <tr>
                                        <th>Phone Two</th><td><asp:TextBox ID="txtBoxEditPhoneTwo" Text='<%#Eval("PhoneTwo") %>' runat="server"></asp:TextBox></td>
						            
                                        <th>Email</th><td><asp:Label ID="lblEmail"  Text='<%#Eval("Email") %>' runat="server"></asp:Label></td>
								    </tr>
                                    <tr>
                                        <th>Date Of Birth</th><td><asp:TextBox ID="txtBoxEditDateOfBirth" Text='<%#Eval("DateOfBirth","{0:dd/MM/yyyy}") %>'  runat="server"></asp:TextBox></td>
                                        <th>Designation</th><td><asp:TextBox ID="txtBoxEditDesignation" Visible="false" Text='<%#Eval("Designation") %>' ReadOnly="true" runat="server"></asp:TextBox></td>
							        </tr>
                                     <%--<tr>
                                         
                                         <th>Mentor/Coach</th><td><asp:DropDownList ID="ddlEditManagerId" DataTextField="FullName" DataValueField="MemberID" runat="server"></asp:DropDownList></td>
                                     </tr>--%>
                                    <tr>
                                         <th>Marital Status</th><td><asp:DropDownList ID="ddlEditMaritalStatus" runat="server">
                                                                     <asp:ListItem>Select</asp:ListItem>
                                                                    <asp:ListItem>SINGLE</asp:ListItem>
                                                                    <asp:ListItem>MARRIED</asp:ListItem>
                                                                    <asp:ListItem>SEPERATED</asp:ListItem>
                                                                    <asp:ListItem>DIVORCED</asp:ListItem>
                                                                    <asp:ListItem>WIDOWED</asp:ListItem>
                                                                    </asp:DropDownList></td>
                                     </tr> 
                                    <tr>
                                        <th>Fathers Name</th><td><asp:TextBox ID="txtBoxEditFathersName" Visible="false" Text='<%#Eval("FathersName") %>' runat="server"></asp:TextBox></td>
                                        <th>Mothers Name</th><td><asp:TextBox ID="txtBoxEditMothersName" Visible="false" Text='<%#Eval("MothersName") %>' runat="server"></asp:TextBox></td>
							        </tr>
                                    <tr>
                                        <th>PAN Number</th>
                                        <td><asp:TextBox ID="txtBoxEditPan" Text='<%#Eval("PanNumber") %>' runat="server"></asp:TextBox>
                                          <asp:LinkButton ID="lnkBtnUploadPan"  class="btn btn-xs btn-info" Text="<i class='ace-icon fa fa-files-o bigger-120'></i> Upload PAN" ToolTip="Upload pan here" OnCommand="ManageStaffVisibility" CommandName="UploadStaffDocument" CommandArgument='<%#Eval("MemberID") %>' runat="server" ></asp:LinkButton>  
                                        </td>
                                        <th>Aadhaar Number</th>
                                        <td><asp:TextBox ID="txtBoxEditAadhaar" Text='<%#Eval("AadhaarNumber") %>' runat="server"></asp:TextBox>
                                          <asp:LinkButton ID="lnkBtnUploadAadhaar"  class="btn btn-xs btn-info" Text="<i class='ace-icon fa fa-files-o bigger-120'></i> Upload aadhaar here" ToolTip="Upload Aadhaar" OnCommand="ManageStaffVisibility" CommandName="UploadStaffDocument" CommandArgument='<%#Eval("MemberID") %>' runat="server" ></asp:LinkButton>  
                                        </td>
							        </tr>
                                    <tr>
                                        <th>Bank Name (optional)</th><td><asp:TextBox Visible="false" ID="txtBoxEditBankName" Text='<%#Eval("BankName") %>' runat="server"></asp:TextBox></td>
                                        <th>Bank Account Number (optional)</th><td><asp:TextBox Visible="false" ID="txtBoxEditBankAccount" Text='<%#Eval("BankAccountNumber") %>' runat="server"></asp:TextBox></td>
							        </tr>
                                    <tr>
                                        <th>Bank IFSC (optional)</th><td><asp:TextBox Visible="false" ID="txtBoxEditBankIFSC" Text='<%#Eval("BankIFSC") %>' runat="server"></asp:TextBox></td>
                                        <th>Academic Exam Status</th>
                                        <td><asp:DropDownList ID="ddlNeurotherapyExamStatus" runat="server">
                                            <asp:ListItem>SSC</asp:ListItem>
                                            <asp:ListItem>HSC</asp:ListItem>
                                            <asp:ListItem>GRADUATE</asp:ListItem>
                                            <asp:ListItem>POSTGRADUATE</asp:ListItem>
                                            </asp:DropDownList>
                                       <asp:LinkButton ID="lnkBtnAcademic" class="btn btn-xs btn-warning" ToolTip="Skills" Text="<i class='ace-icon fa fa-graduation-cap bigger-120'></i>Mention Institute Details here" OnCommand="ManageStaffVisibility"  CommandName="AcademicDetails" CommandArgument='<%#Eval("MemberID") %>' runat="server"></asp:LinkButton>
                                        </td>
							        </tr>
                                    <tr>
                                        <th>Date Of Joining</th><td><asp:Label ID="lblDateOfJoining"  Text='<%#Eval("DateOfJoining","{0:dd/MM/yyyy}") %>'  runat="server"></asp:Label></td>
                                        <th>Membership Type</th><td><asp:DropDownList ID="ddlEditEmploymentType"  runat="server">
                                                                                        <asp:ListItem>NONE</asp:ListItem>
                                                                                        <asp:ListItem>STUDENT</asp:ListItem>
                                                                                        <asp:ListItem>ALUMANI</asp:ListItem>
                                                                                        
                                                                                        </asp:DropDownList></td>
							        </tr>
                                    <tr>
                                        <th><asp:Label id="lblMembershipYears" Visible='<%#Eval("MembershipType").ToString().Trim()!="STUDENT" %>' Text="Membership for Years" runat="server"></asp:Label></th>
                                         <td><asp:TextBox ID="txtBoxMembershipValidForYears" Visible='<%#Eval("MembershipType").ToString().Trim()!="STUDENT" %>' Placeholder="Number of years you want to remain Member, e.g.1" runat="server"></asp:TextBox></td>
                                        <th></th><td></td>
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
                   <!--Atucomplete address form-->
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="col-sm-12">
                                 <h3>Address.</h3>
                    <table id="permanentaddress-table" class="table  table-bordered table-hover">
                        <tr>
                            <td colspan="4"><asp:Label style="background-color:silver;color:red;font-size:18px;" ID="lblIbstruction" Text="Use Auto Pouplate Address Box below to fetch your City,Pin,State, Countery. Moment you type your Area, City it will propose addresses. Click on one, nearest to you and other boxes (City/District,State,Pin,Country will get filled automatically.In case some data like Pin is not correct, you can change it manually. If you want your correspendece address to be same as PERAMANET then tick the box below before save. For different correspondence address, refresh the page (click F5) and repeat the same process with address type COREESPONDENCE." runat="server"></asp:Label></td>
                        </tr>
                        <tr>
                            <th>Address Line One</th>
                            <td colspan="3"><asp:TextBox ID="txtBoxAddressLineOne" class="col-sm-10" TextMode="MultiLine" Placeholder="Flat, Bldg, Society, Area" runat="server"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <th>Auto Populate Address</th>
                            <td colspan="3"><asp:TextBox id="autopermanent" class="col-sm-10" ClientIDMode="static" clientID="autopermanent" placeholder="Main Areas, City to get fields below autopopulated" onFocus="geolocate()" type="text" runat="server"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <%--<th>Landmark (optional)</th>
                            <td colspan="1"><asp:TextBox ID="txtBoxEditContactAddress" TextMode="MultiLine" runat="server"></asp:TextBox></td>--%>
                            <th>Select AddressType</th>
                            <td><asp:DropDownList ID="ddlAddressType" runat="server">
                                <asp:ListItem>PERMANENT</asp:ListItem>
                                <asp:ListItem>CORRESPONDENCE</asp:ListItem>
                                
                                </asp:DropDownList></td>
                        </tr>
                            <tr>
                                <th>Road</th>
                                <td><asp:TextBox class="field" id="street_number" ClientIDMode="static" clientID="street_number"
              disabled="true" runat="server"></asp:TextBox></td>
                                 <th></th>
                                 <td><asp:TextBox class="field" id="route" ClientIDMode="static" clientID="route" 
              disabled="true"  runat="server"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <th>City/District</th>
                                <td><asp:TextBox class="field"  id="locality" ClientIDMode="static" clientID="locality"
                                                          disabled="true" type="text"  runat="server"></asp:TextBox></td>
								<th>State</th>
                                <td><asp:TextBox class="field" id="administrative_area_level_1" ClientIDMode="static" clientID="administrative_area_level_1"
                                                 disabled="true" type="text"  runat="server"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <th>PinCode</th>
                                <td><asp:TextBox class="field" id="postal_code" ClientIDMode="static" clientID="postal_code"
                                                disabled="true" type="text"  runat="server"></asp:TextBox></td>
                                <th>Country :</th>
                                <td><asp:TextBox class="field" id="country" ClientIDMode="static" clientID="country"
                                 disabled="true" type="text"  runat="server"></asp:TextBox></td>
						    </tr>
                        <tr>
                            <th>Correspondence Address (same)</th>
                            <td><asp:CheckBox ID="chkBoxCorresAdrSameAsPermaAdr" Checked="false" runat="server" /></td>
                            <td colspan="4">
                                <asp:LinkButton ID="lnkBtnUSaveContactAddress"  class="btn btn-white btn-info btn-bold" Text="<i class='ace-icon fa fa-floppy-o bigger-120 blue'>Save</i>" ToolTip="Save" OnCommand="UpdatePostalAddress" CommandName="PERMANENT" CommandArgument='<%#Eval("NuerotherapistID") %>' runat="server" ></asp:LinkButton>
						       
                                <asp:LinkButton ID="lnkBtnReturnToViewCustomers"  class="btn btn-white btn-default btn-round" Text="<i class='ace-icon fa fa-times red2'>Cancel</i>" ToolTip="Cancel" OnCommand="ManageStaffVisibility"  CommandName="ReturnToViewStaff" runat="server" ></asp:LinkButton>
                            </td>
                        </tr>
                    </table>

                            </div>
                            <%--<div class="col-sm-6">
                                 <h3>Update Correspondence Address</h3>
                    <table id="address-table" class="table  table-bordered table-hover">
                        <tr>
                                <th>Correspondence Address</th>
                                <td colspan="3"><asp:TextBox id="autocorrespondence" class="col-sm-6" ClientIDMode="static" clientID="autocorrespondence" placeholder="Enter your correspondence address"
             onFocus="geolocate()" type="text" runat="server"></asp:TextBox></td>
                            </tr>
                        <tr>
                            <th>Landmark (optional)</th>
                            <td colspan="3"><asp:TextBox ID="TextBox2" class="col-sm-6" runat="server"></asp:TextBox></td>
                        </tr>
                            <tr>
                                <th>Road</th>
                                <td><asp:TextBox class="field" id="street_number2" ClientIDMode="static" clientID="street_number2"
              disabled="true" runat="server"></asp:TextBox></td>
                                 <th></th>
                                 <td><asp:TextBox class="field" id="route2" ClientIDMode="static" clientID="route2" 
              disabled="true"  runat="server"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <th>City/District</th>
                                <td><asp:TextBox class="field"  id="locality2" ClientIDMode="static" clientID="locality2"
                                                          disabled="true" type="text"  runat="server"></asp:TextBox></td>
								<th>State</th>
                                <td><asp:TextBox class="field" id="administrative_area_level_12" ClientIDMode="static" clientID="administrative_area_level_12"
                                                 disabled="true" type="text"  runat="server"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <th>PinCode</th>
                                <td><asp:TextBox class="field" id="postal_code2" ClientIDMode="static" clientID="postal_code2"
                                                disabled="true" type="text"  runat="server"></asp:TextBox></td>
                                <th>Country :</th>
                                <td><asp:TextBox class="field" id="country2" ClientIDMode="static" clientID="country2"
                                 disabled="true" type="text"  runat="server"></asp:TextBox></td>
						    </tr>
                        <tr>
                            <td colspan="4">
                                <asp:LinkButton ID="LinkButton4"  class="btn btn-white btn-info btn-bold" Text="<i class='ace-icon fa fa-floppy-o bigger-120 blue'>Save</i>" ToolTip="Save" CommandName="Update" runat="server" ></asp:LinkButton>
						      
                                <asp:LinkButton ID="LinkButton5"  class="btn btn-white btn-default btn-round" Text="<i class='ace-icon fa fa-times red2'>Cancel</i>" ToolTip="Cancel" OnCommand="ManageStaffVisibility"  CommandName="ReturnToViewStaff" runat="server" ></asp:LinkButton>
                            </td>
                        </tr>
                    </table>

                            </div>
                            <div class="col-sm-6">
                                 <h3>Update Treatment Facility Address</h3>
                    <table id="address-table" class="table  table-bordered table-hover">
                        <tr>
                                <th>Permanent Address</th>
                                <td colspan="3"><asp:TextBox id="autotreatment" class="col-sm-10" ClientIDMode="static" clientID="utotreatment" placeholder="Enter your treatment facility address"
             onFocus="geolocate()" type="text" runat="server"></asp:TextBox></td>
                            </tr>
                        <tr>
                            <th>Landmark (optional)</th>
                            <td colspan="4"><asp:TextBox ID="TextBox3" class="col-sm-10" runat="server"></asp:TextBox></td>
                        </tr>
                            <tr>
                                <th>Road</th>
                                <td><asp:TextBox class="field" id="street_number3" ClientIDMode="static" clientID="street_number3"
              disabled="true" runat="server"></asp:TextBox></td>
                                 <th></th>
                                 <td><asp:TextBox class="field" id="route3" ClientIDMode="static" clientID="route3" 
              disabled="true"  runat="server"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <th>City/District</th>
                                <td><asp:TextBox class="field"  id="locality3" ClientIDMode="static" clientID="locality3"
                                                          disabled="true" type="text"  runat="server"></asp:TextBox></td>
								<th>State</th>
                                <td><asp:TextBox class="field" id="administrative_area_level_13" ClientIDMode="static" clientID="administrative_area_level_13"
                                                 disabled="true" type="text"  runat="server"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <th>PinCode</th>
                                <td><asp:TextBox class="field" id="postal_code3" ClientIDMode="static" clientID="postal_code3"
                                                disabled="true" type="text"  runat="server"></asp:TextBox></td>
                                <th>Country :</th>
                                <td><asp:TextBox class="field" id="country3" ClientIDMode="static" clientID="country3"
                                 disabled="true" type="text"  runat="server"></asp:TextBox></td>
						    </tr>
                        <tr>
                            <td colspan="4">
                                <asp:LinkButton ID="LinkButton6"  class="btn btn-white btn-info btn-bold" Text="<i class='ace-icon fa fa-floppy-o bigger-120 blue'>Save</i>" ToolTip="Save" CommandName="Update" runat="server" ></asp:LinkButton>
						     
                                   <asp:LinkButton ID="LinkButton7"  class="btn btn-white btn-default btn-round" Text="<i class='ace-icon fa fa-times red2'>Cancel</i>" ToolTip="Cancel" OnCommand="ManageStaffVisibility"  CommandName="ReturnToViewStaff" runat="server" ></asp:LinkButton>
                            </td>
                        </tr>
                    </table>

                            </div>
                            <div class="col-sm-6">
                                 <h3>Update Training Facility Address</h3>
                    <table id="address-table" class="table  table-bordered table-hover">
                        <tr>
                                <th>Permanent Address</th>
                                <td colspan="3"><asp:TextBox id="autotraining" class="col-sm-10" ClientIDMode="static" clientID="autotraining" placeholder="Enter your correspondence address"
             onFocus="geolocate()" type="text" runat="server"></asp:TextBox></td>
                            </tr>
                        <tr>
                            <th>Landmark (optional)</th>
                            <td colspan="3"><asp:TextBox ID="TextBox11" class="col-sm-10" runat="server"></asp:TextBox></td>
                        </tr>
                            <tr>
                                <th>Road</th>
                                <td><asp:TextBox class="field" id="street_number4" ClientIDMode="static" clientID="street_number4"
              disabled="true" runat="server"></asp:TextBox></td>
                                 <th></th>
                                 <td><asp:TextBox class="field" id="route4" ClientIDMode="static" clientID="route4" 
              disabled="true"  runat="server"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <th>City/District</th>
                                <td><asp:TextBox class="field"  id="locality4" ClientIDMode="static" clientID="locality4"
                                                          disabled="true" type="text"  runat="server"></asp:TextBox></td>
								<th>State</th>
                                <td><asp:TextBox class="field" id="administrative_area_level_14" ClientIDMode="static" clientID="administrative_area_level_14"
                                                 disabled="true" type="text"  runat="server"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <th>PinCode</th>
                                <td><asp:TextBox class="field" id="postal_code4" ClientIDMode="static" clientID="postal_code4"
                                                disabled="true" type="text"  runat="server"></asp:TextBox></td>
                                <th>Country :</th>
                                <td><asp:TextBox class="field" id="country4" ClientIDMode="static" clientID="country4"
                                 disabled="true" type="text"  runat="server"></asp:TextBox></td>
						    </tr>
                        <tr>
                            <td colspan="4">
                                <asp:LinkButton ID="LinkButton8"  class="btn btn-white btn-info btn-bold" Text="<i class='ace-icon fa fa-floppy-o bigger-120 blue'>Save</i>" ToolTip="Save" CommandName="Update" runat="server" ></asp:LinkButton>
						      
                                <asp:LinkButton ID="LinkButton9"  class="btn btn-white btn-default btn-round" Text="<i class='ace-icon fa fa-times red2'>Cancel</i>" ToolTip="Cancel" OnCommand="ManageStaffVisibility"  CommandName="ReturnToViewStaff" runat="server" ></asp:LinkButton>
                            </td>
                        </tr>
                    </table>

                            </div>--%>
                        </div>
                    </div>
                    
                 
             
                </div><!-- /.span -->
            </asp:Panel>
		   <!-- PAGE CONTENT ENDS -->
		  
    </div><!-- /.row -->

     <!--Staff Academics-->
       <div class="row">
         <div class="col-sm-6">
                <!--Panel to display/Add/Edit Academic Details of an Employee-->
                <asp:Panel ID="pnlNeuroAcademics" Visible="false" runat="server">
                        <h3> Qualifications Acquired </h3>
                        <asp:Label ID="lblEID" Text="Emp" runat="server"></asp:Label>
                        <%--<asp:ImageButton ImageUrl="~/Images/add.png" ToolTip="Add Degree" ID="btnAddQual" Height="40px" Width="40px" Style="float: right;" OnCommand="AddNewQualification" CommandArgument='<%Eval("EmployeesID" %>' runat="server" />--%>
                        <asp:LinkButton ID="lnkBtnAcademic" class="btn btn-xs btn-warning"  ToolTip="Add Qualifications" Text="<i class='ace-icon fa fa-graduation-cap bigger-120'></i>Click to Add Qualification" OnCommand="AddNewQualification"  CommandName="" CommandArgument='<%#Eval("MemberID") %>' runat="server"></asp:LinkButton>
                   <hr />
                    <asp:DataList ID="dlAcademicDetails" DataKeyField="AcadID" OnEditCommand="dlAcademicDetailsEditHandler"
                        OnUpdateCommand="dlAcademicDetailsUpdateHandler" OnCancelCommand="dlAcademicDetailsCancelHandler" runat="server">
                        <HeaderTemplate>
                            <table  class="table  table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <td>Exam/Diplom/Degree Name</td>
                                        <td>Institute</td>
                                        <td>Address/City/State/Pin</td>
                                        <td>Start Date</td>
                                        <td>Completion Date</td>
                                        <td>Grade</td>
                                        <td>Edit</td>
                                    </tr>
                                </thead>
                            </table>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <table  class="table  table-bordered table-hover">
                                <tbody>
                                <tr>
                                    <td>
                                        <asp:Label   ID="lblEmpDegree" Text='<%#DataBinder.Eval(Container.DataItem,"Degree")%>' runat="server"></asp:Label></td>
                                    <td>
                                        <asp:Label  ID="lblEmpInstitute" Text='<%#DataBinder.Eval(Container.DataItem,"Institute")%>' runat="server"></asp:Label></td>
                                    <td>
                                        <asp:Label  ID="lblEmpUniversity" Text='<%#DataBinder.Eval(Container.DataItem,"University")%>' runat="server"></asp:Label></td>
                                    <td>
                                        <asp:Label ID="lblStartDate" Text='<%#Eval("StartDate","{0:dd/MM/yyyy}") %>' runat="server"></asp:Label></td>
                                    
                                    <td>
                                        <asp:Label  ID="lblCompletionYear" Text='<%#Eval("CompletionYear","{0:dd/MM/yyyy}") %>' runat="server"></asp:Label></td>
                                    <td>
                                        <asp:Label  ID="lblGrade" Text='<%#Eval("Grade") %>' runat="server"></asp:Label></td>
                                    <td>
                                        <asp:LinkButton ID="lnkBtnEditAcademicDetails" class="btn btn-xs btn-info" Text="<i class='ace-icon fa fa-edit bigger-120'></i> Edit" CommandName="edit" runat="server" />
                                       
                                     </td>
                                </tr>
                                </tbody>
                            </table>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <table  class="table  table-bordered table-hover">
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtBoxEmpDegree" TextMode="MultiLine"  Text='<%#Eval("Degree") %>' runat="server"></asp:TextBox></td>
                                    <td>
                                        <asp:TextBox ID="txtBoxEmpInstitute" TextMode="MultiLine"  Text='<%#Eval("Institute") %>' runat="server"></asp:TextBox></td>
                                    <td>
                                        <asp:TextBox ID="txtBoxEmpUniversity" TextMode="MultiLine"  Text='<%#Eval("University") %>' runat="server"></asp:TextBox></td>
                                    <td>
                                        <asp:TextBox ID="txtBoxStartDate" TextMode="Date"  Text='<%#Eval("StartDate") %>' runat="server"></asp:TextBox></td>
                                    <td>
                                        <asp:TextBox ID="txtBoxCompletionYear" TextMode="Date"  Text='<%#Eval("CompletionYear") %>' runat="server"></asp:TextBox></td>
                                    <td>
                                        <asp:TextBox ID="txtBoxGrade"  Text='<%#Eval("Grade") %>' runat="server"></asp:TextBox></td>

                                </tr>
                                <tr>
                                    <td colspan="7">
                                        <asp:Button ID="btnUpdate" Text="Update" CommandName="update" runat="server" />
                                        <asp:Button ID="btnCancel" Text="Cancel" CommandName="cancel" runat="server" /></td>
                                </tr>
                            </table>
                        </EditItemTemplate>
                    </asp:DataList>
                     <asp:LinkButton ID="lnkBtnBack" class="btn btn-xs btn-warning" Text="<i class='ace-icon fa fa-times bigger-120'></i> Cancel" OnCommand="ManageStaffVisibility" CommandName="ReturnToViewStaff" runat="server" />
                      <asp:LinkButton ID="lnkBtnContinueEditing"  class="btn btn-xs btn-info" Text="<i class='ace-icon fa fa-pencil bigger-120'></i> Continue Edit" ToolTip="Edit Profile" OnCommand="ManageStaffVisibility" CommandName="TopnlProfileEditFrompnlNeuroAcademics" CommandArgument="" runat="server" ></asp:LinkButton>
                </asp:Panel>
         </div>   
       </div>
    <!--End Staff Academics-->

    <!--Staff Publications-->
       <div class="row">
            <div class="col-xs-12">
                <!--Panel to view/add/edit research work/publications of the employees-->
                <asp:Panel ID="pnlNeuroPublications" Style="margin-top: 20px;" Visible="false" runat="server">
                    <asp:ImageButton ID="imgBtnBackToEmp" ImageUrl="~/Images/return.png" Height="30px" Width="30px" ImageAlign="left" Text="Return" OnCommand="ManageStaffVisibility" CommandName="ReturnToViewStaff" runat="server" />
                    <asp:ImageButton ImageUrl="~/Images/add.png" ToolTip="Add Research" ID="btnAddPublication" Height="30px" Width="30px" Style="float: right;" OnCommand="AddNewPublication" runat="server" />
                    <br />
                    <fieldset class="login">
                        <legend>Publications</legend>
                        <asp:Label ID="lblPubEID" Visible="false" Text="Emp" runat="server"></asp:Label>
                        <asp:DataList ID="dlNeuroPublications" DataKeyField="NeuroPublicationID" OnEditCommand="dlNeuroPublicationEditHandler"
                            OnUpdateCommand="dlNeuroPublicationUpdateHandler" OnCancelCommand="dlNeuroPublicationCancelHandler" runat="server">
                            <HeaderTemplate>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <strong>Type:</strong><asp:Label ID="lblPublicationType" Text='<%#DataBinder.Eval(Container.DataItem,"PublicationType")%>' runat="server"></asp:Label><br />
                                <strong>Title:</strong><asp:Label ID="lblPublicationTitle" Text='<%#DataBinder.Eval(Container.DataItem,"PublicationTitle")%>' runat="server"></asp:Label><br />
                                <strong>Overview:</strong><asp:Label ID="lblPublicationDescription" Text='<%#Eval("PublicationDescription") %>' runat="server"></asp:Label><br />
                                <strong>Publish Date:</strong><asp:Label ID="lblPublishDate" Text='<%#Eval("PublishDate","{0:MMM, dd, yyyy}")%>' runat="server"></asp:Label><br />
                                <strong>Publisher:</strong><asp:Label ID="lblPublisherDetails" Text='<%#Eval("PublisherDetails") %>' runat="server"></asp:Label>
                                <asp:ImageButton ImageAlign="Right" ImageUrl="~/Images/edit.png" wodht="40px" Height="40px" ID="imgBtnEditResearchDetails" ToolTip="Edit" CommandName="edit" runat="server" />

                            </ItemTemplate>
                            <EditItemTemplate>
                                <fieldset class="login">
                                    <legend>Edit Publication</legend>
                                    <asp:Label Width="100px" runat="server">Type:</asp:Label><asp:DropDownList ID="ddlPublicationType" Width="100px" Text='<%#Eval("PublicationType") %>' runat="server">
                                        <asp:ListItem>Paper</asp:ListItem>
                                        <asp:ListItem>Book</asp:ListItem>
                                        <asp:ListItem></asp:ListItem>
                                    </asp:DropDownList>&nbsp &nbsp &nbsp 
           <asp:Label ID="Label8" Width="100px" runat="server">Publish Date:</asp:Label><asp:TextBox ID="txtBoxPublishDate" Width="100px" TextMode="Date" Text='<%#Eval("PublishDate","{0:MMM, dd, yyyy}") %>' runat="server"></asp:TextBox>&nbsp &nbsp &nbsp 
           <asp:Label ID="Label5" Width="150px" runat="server">Publication Code:</asp:Label>
                                    <asp:TextBox ID="txtBoxPublicationCode" Width="100px" Text='<%#Eval("PublicationCode") %>' runat="server"></asp:TextBox><br />
                                    <br />
                                    <asp:Label ID="Label6" Width="100px" runat="server">Title</asp:Label>
                                    <asp:TextBox ID="txtBoxPublicationTitle" Width="600px" Text='<%#Eval("PublicationTitle") %>' runat="server"></asp:TextBox>
                                    <br />
                                    <br />
                                    <asp:Label ID="Label7" Width="100px" runat="server">Brief Description:</asp:Label><asp:TextBox ID="txtBoxPublicationDescription" Height="100px" Width="600px" TextMode="MultiLine" Text='<%#Eval("PublicationDescription") %>' runat="server"></asp:TextBox><br />
                                    <br />
                                    <asp:Label ID="Label9" Width="100px" runat="server">Publisher Details:</asp:Label><asp:TextBox ID="txtBoxPublisherDetails" Height="50px" Width="600px" TextMode="MultiLine" Text='<%#Eval("PublisherDetails") %>' runat="server"></asp:TextBox><br />
                                    <br />
                                    <asp:Label ID="Label10" Width="100px" runat="server">Remarks</asp:Label><asp:TextBox ID="txtBoxRemarks" Height="50px" Width="600px" Text='<%#Eval("Remarks") %>' runat="server"></asp:TextBox>
                                    <br />
                                    <br />
                                    <asp:Button class="btn" ID="btnUpdateResearch" Text="Update" CommandName="update" runat="server" />
                                    <asp:Button class="btn" ID="btnCancelResearch" Text="Cancel" CommandName="cancel" runat="server" />
                                </fieldset>
                            </EditItemTemplate>
                        </asp:DataList>
                    </fieldset>
                </asp:Panel>
             </div>
       </div>
    <!--End Staff Publications-->
    
      <!--AutoAddressComplete GoogleAPI-->
     <script>
      // This example displays an address form, using the autocomplete feature
      // of the Google Places API to help users fill in the information.

      // This example requires the Places library. Include the libraries=places
      // parameter when you first load the API. For example:
        // <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDIu5ljLPVCQa0mfkp2Fb7-hmGgIiAfo3U&libraries=places">

         var placeSearch, autocomplete1, autocomplete2, autocomplete3, autocomplete4;
      var componentForm = {
        street_number: 'short_name',
        route: 'long_name',
        locality: 'long_name',
        administrative_area_level_1: 'short_name',
        country: 'long_name',
        postal_code: 'short_name'
      };

    

      function initAutocomplete() {
        // Create the autocomplete object, restricting the search to geographical
        // location types.
        autocomplete = new google.maps.places.Autocomplete(
            /** @type {!HTMLInputElement} */(document.getElementById('autopermanent')),
            { types: ['geocode'] });
        // When the user selects an address from the dropdown, populate the address
        // fields in the form.
        autocomplete.addListener('place_changed', function () {
            fillInAddress(autocomplete, "");
        });

        autocomplete2 = new google.maps.places.Autocomplete(
        /** @type {!HTMLInputElement} */(document.getElementById('autocorrespondence')),
        { types: ['geocode'] });
        autocomplete2.addListener('place_changed', function () {
            fillInAddress(autocomplete2, "2");
        });

        autocomplete3 = new google.maps.places.Autocomplete(
      /** @type {!HTMLInputElement} */(document.getElementById('autotreatment')),
      { types: ['geocode'] });
        autocomplete3.addListener('place_changed', function () {
            fillInAddress(autocomplete3, "3");
        });

        autocomplete4 = new google.maps.places.Autocomplete(
        /** @type {!HTMLInputElement} */(document.getElementById('autotraining')),
        { types: ['geocode'] });
        autocomplete4.addListener('place_changed', function () {
            fillInAddress(autocomplete4, "4");
        });

      }

      

      

      function fillInAddress(autocomplete,unique) {
        // Get the place details from the autocomplete object.
        var place = autocomplete.getPlace();         
        for (var component in componentForm) {
          document.getElementById(component + unique).value = '';
          document.getElementById(component + unique).disabled = false;
        }

        // Get each component of the address from the place details
        // and fill the corresponding field on the form.
        for (var i = 0; i < place.address_components.length; i++) {
          var addressType = place.address_components[i].types[0];
          if (componentForm[addressType] && document.getElementById(addressType + unique)) {
            var val = place.address_components[i][componentForm[addressType]];
            document.getElementById(addressType + unique).value = val;
            //document.getElementsById('locality').innerHTML.value = val;
          }
        }
      }

      //    function fillInAddress2() {
      //  // Get the place details from the autocomplete object.
      //  var place = autocomplete2.getPlace();
        
      //  for (var component in componentForm) {
      //    document.getElementById(component+"2").value = '';
      //    document.getElementById(component+"2").disabled = false;
      //  }

      //  // Get each component of the address from the place details
      //  // and fill the corresponding field on the form.
      //  for (var i = 0; i < place.address_components.length; i++) {
      //    var addressType = place.address_components[i].types[0];
      //    if (componentForm[addressType] && document.getElementById(addressType + "2")) {
      //      var val = place.address_components[i][componentForm[addressType]];
      //      document.getElementById(addressType+"2").value = val;
      //      //document.getElementsById('locality').innerHTML.value = val;
      //    }
      //  }
      //}

      // Bias the autocomplete object to the user's geographical location,
      // as supplied by the browser's 'navigator.geolocation' object.
      function geolocate() {
        if (navigator.geolocation) {
          navigator.geolocation.getCurrentPosition(function(position) {
            var geolocation = {
              lat: position.coords.latitude,
              lng: position.coords.longitude
            };
            var circle = new google.maps.Circle({
              center: geolocation,
              radius: position.coords.accuracy
            });
            autocomplete.setBounds(circle.getBounds());
          });
        }
      }
    </script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDIu5ljLPVCQa0mfkp2Fb7-hmGgIiAfo3U&libraries=places&callback=initAutocomplete"
        async defer></script>
     
    <!--End AutoAddressComplete GoogleAPI-->

</asp:Content>
