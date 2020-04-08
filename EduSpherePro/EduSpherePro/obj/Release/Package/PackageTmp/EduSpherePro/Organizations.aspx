<%@ Page Title="" Language="C#" MasterPageFile="~/EduSpherePro/EduSpherePro.Master" EnableEventValidation="false" AutoEventWireup="true" CodeBehind="Organizations.aspx.cs" Inherits="EduSpherePro.EduSpherePro.Organizations" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<link type="text/css" rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500">
    <style>
      #locationField, #controls {
        position: relative;
        width: 480px;
      }
      #autocomplete {
        position: absolute;
        top: 0px;
        left: 0px;
        width: 99%;
      }
      .label {
        text-align: right;
        font-weight: bold;
        width: 100px;
        color: #303030;
      }
      #address {
        border: 1px solid #000090;
        background-color: #f0f0ff;
        width: 680px;
        padding-right: 2px;
      }
      #address td {
        font-size: 10pt;
      }
      .field {
        width: 99%;
      }
      .slimField {
        width: 80px;
      }
      .wideField {
        width: 200px;
      }
      #locationField {
        height: 20px;
        margin-bottom: 2px;
      }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="row">
        <div class="col-sm-2">
            <div class="action-buttons">
                <asp:LinkButton ID="lnkBtnAddOrganization"  class="btn btn-xs btn-success" Text="<i class='ace-icon fa fa-plus bigger-120'></i>New Organization" ToolTip="Profile" OnCommand="ManageOrganizationVisibility" CommandName="AddOrganization" runat="server" ></asp:LinkButton>              
            </div>
        </div>
        <div class="col-sm-4">
            <div class="input-group">
				<span class="input-group-addon">
					<i class="ace-icon fa fa-check"></i>
				</span>
                <asp:TextBox  class="form-control search-query" ID="txtBoxSearchOrganization" runat="server"></asp:TextBox>
				<span class="input-group-btn">
                    <asp:LinkButton ID="lnkBrnSerachOrganization" class="btn btn-purple btn-sm" Text="<span class='ace-icon fa fa-search icon-on-right bigger-110'></span> Search" OnCommand="ManageOrganizationVisibility" CommandName="SearchOrganization" runat="server"></asp:LinkButton>
					
				</span>
			</div>
        </div>

        <div class="col=sm-6">
            <div class="navbar-buttons navbar-header pull-right" role="navigation">
					<ul class="nav ace-nav">
						<li class="grey dropdown-modal">
							<a data-toggle="dropdown" class="dropdown-toggle" href="#">
								<i class="ace-icon fa fa-tasks"></i>
								<span class="badge badge-grey"><asp:Label ID="lblCountCustomers" runat="server"></asp:Label></span>
							</a>

							<ul class="dropdown-menu-right dropdown-navbar dropdown-menu dropdown-caret dropdown-close">
								<li class="dropdown-header">
									<i class="ace-icon fa fa-check"></i>
									<asp:Label ID="lblCountCustomersHelp" runat="server"></asp:Label> Customer Organizations
								</li>
								<li class="dropdown-footer">
									<a href="#">
										See Organization details
										<i class="ace-icon fa fa-arrow-right"></i>
									</a>
								</li>
							</ul>
						</li>

						<li class="purple dropdown-modal">
							<a data-toggle="dropdown" class="dropdown-toggle" href="#">
								<i class="ace-icon fa fa-bell icon-animated-bell"></i>
								<span class="badge badge-important"><asp:Label ID="lblCountPrinciples" runat="server"></asp:Label></span>
							</a>

							<ul class="dropdown-menu-right dropdown-navbar navbar-pink dropdown-menu dropdown-caret dropdown-close">
								<li class="dropdown-header">
									<i class="ace-icon fa fa-exclamation-triangle"></i>
									<asp:Label ID="lblCountPrinciplesHelp" runat="server"></asp:Label>Principle Organizations
								</li>
								<li class="dropdown-footer">
									<a href="#">
										See Principle Details
										<i class="ace-icon fa fa-arrow-right"></i>
									</a>
								</li>
							</ul>
						</li>

						<li class="green dropdown-modal">
							<a data-toggle="dropdown" class="dropdown-toggle" href="#">
								<i class="ace-icon fa fa-envelope icon-animated-vertical"></i>
								<span class="badge badge-success"><asp:Label ID="lblCountVendors" runat="server"></asp:Label></span>
							</a>

							<ul class="dropdown-menu-right dropdown-navbar dropdown-menu dropdown-caret dropdown-close">
								<li class="dropdown-header">
									<i class="ace-icon fa fa-envelope-o"></i>
									<asp:Label ID="lblCountVendorsHelp" runat="server"></asp:Label> Vendor Organizations
								</li>

							
								<li class="dropdown-footer">
									<a href="#l">
										See Vendor Details
										<i class="ace-icon fa fa-arrow-right"></i>
									</a>
								</li>
							</ul>
						</li>
					</ul>
				</div>
        </div>
   </div>
   <div class="hr hr-18 dotted hr-double"></div>
	    <h4 class="pink">
		    <i class="ace-icon fa fa-hand-o-right icon-animated-hand-pointer blue"></i>
			<asp:Label ID="lblOrganizationAction" Text="" runat="server"></asp:Label>
	    </h4>
	<div class="hr hr-18 dotted hr-double"></div>
    
    <!--Add New Organization-->
    <div class="row">
		<div class="col-xs-12">
			<!-- PAGE CONTENT BEGINS -->
                <!--Add New Organization-->
                <asp:Panel ID="pnlAddOrganization" ScrollBars="Auto"  runat="server">
                      <form>
                                <div class="form-group col-sm-6">
                                    <label for="txtBoxOrganizationName">OrganizationName:</label>
                                    <asp:TextBox ID="txtBoxOrganizationName" class="form-control"   runat="server"></asp:TextBox>
								 </div>
                                <div class="form-group col-sm-6"> 
                                     <label for="ddlOrganizationType">OrganizationType</label>
                                     <asp:DropDownList ID="ddlOrganizationType" class="form-control" runat="server">
                                        <asp:ListItem></asp:ListItem>
                                            <%--<asp:ListItem>TREATMENT-CENTRE</asp:ListItem>--%>
                                            <asp:ListItem>EDUCATION-CENTRE</asp:ListItem>
                                            <asp:ListItem>EMPLOYER</asp:ListItem>
                                            <asp:ListItem>VENDOR</asp:ListItem>
								        </asp:DropDownList>
						        </div>
                               <div class="form-group col-sm-6">
                                    <label for="txtBoxManagerName">HOD Name :</label>
                                    <asp:TextBox ID="txtBoxManagerName" class="form-control"  runat="server"></asp:TextBox>
								  </div>
                               <div class="form-group col-sm-6">
                                    <label for="txtBoxManagerEmail">HOD Email :</label>
                                   <asp:TextBox ID="txtBoxManagerEmail" class="form-control" runat="server"></asp:TextBox>
                                </div>
                                <div class="form-group col-sm-6">
                                    <label for="txtBoxManagerPhone">HOD Phone :</label>
                                    <asp:TextBox ID="txtBoxManagerPhone" class="form-control" runat="server"></asp:TextBox>
								 </div>
                                <div class="form-group col-sm-6">
                                    <label for="txtBoxContactPerson">ContactPerson :</label>
                                    <asp:TextBox ID="txtBoxContactPerson" class="form-control" runat="server"></asp:TextBox>
                                </div>
                               <div class="form-group col-sm-6">
                                    <label for="txtBoxPhoneOne">Contact Phone One</label>
                                    <asp:TextBox ID="txtBoxPhoneOne" class="form-control" runat="server"></asp:TextBox>
							   </div>
                               <div class="form-group col-sm-6">
                                    <label for="txtBoxPhoneTwo ">Contact Phone Two</label>
                                   <asp:TextBox ID="txtBoxPhoneTwo" class="form-control" runat="server"></asp:TextBox>
                                </div>
                               <div class="form-group col-sm-6">
                                     <label for="txtBoxEmail">Contact Email</label>
                                     <asp:TextBox ID="txtBoxEmail" class="form-control" runat="server"></asp:TextBox></td>
                                </div>
                                
                                
                                <div class="form-group col-sm-6">
                                    <label for="txtBoxEnrolmentDate">Date of Establishment</label>
                                    <asp:TextBox ID="txtBoxEnrolmentDate" class="form-control" TextMode="Date" runat="server"></asp:TextBox>
								  </div>
                                <div class="form-group col-sm-12">
                                        <label for="txtBoxRemarks">Brief Description :</label>
                                        <asp:TextBox ID="txtBoxRemarks" class="form-control" TextMode="MultiLine" runat="server"></asp:TextBox>
							        </div>
                                <div class="form-group col-sm-12"> 
                                    <label for="txtBoxOfficeAddress">Full Address</label>
                                    <asp:TextBox ID="txtBoxOfficeAddress" class="form-control" TextMode="MultiLine" runat="server"></asp:TextBox>
							    </div>
                               <div class="form-group col-sm-12 ">
                                    <asp:Label style="color:blue;font-size:16px;"  ID="lblIbstruction" Text="Use Auto Pouplate Address Box below to fetch your City,Pin,State, Countery. As you type your Area, City it will propose addresses. Click on one, nearest to you and other boxes (City/District,State,Pin,Country will get filled automatically.In case some data like Pin is not correct, you can change it manually." runat="server"></asp:Label>
                                </div>
                               <div class="form-group col-sm-6">
                                   <label for="autocomplete">Auto Populate Address :</label>
                                   <asp:TextBox id="autopermanent" class="col-sm-12" ClientIDMode="static" clientID="autopermanent" placeholder="Type address here" onFocus="geolocate()" type="text" runat="server"></asp:TextBox>
                                </div>
                                <div class="form-group col-sm-6">
                                    <label for="street_number">Road :</label>
                                    <asp:TextBox class="field" id="street_number" ClientIDMode="static" clientID="street_number" disabled="true" runat="server"></asp:TextBox>
                                     <asp:TextBox class="field" id="route" ClientIDMode="static" clientID="route" disabled="true"  runat="server"></asp:TextBox> 
								 </div>
                                 <div class="form-group col-sm-6">
                                    <label for="locality">City/District :</label>
                                   <asp:TextBox class="field"  id="locality" ClientIDMode="static" clientID="locality"
                                        disabled="true" type="text"  runat="server"></asp:TextBox>
								   
                                 </div>
                                  <div class="form-group col-sm-6">
                                        <label for="administrative_area_level_1">State :</label>
                                        <asp:TextBox class="field" id="administrative_area_level_1" ClientIDMode="static" clientID="administrative_area_level_1"
                                                disabled="true" type="text"  runat="server"></asp:TextBox>
								        </div>
                                  <div class="form-group col-sm-6">
                                    <label for="postal_code">PinCode :</label>
                                    <asp:TextBox class="field" id="postal_code" ClientIDMode="static" clientID="postal_code"
                                        disabled="true" type="text"  runat="server"></asp:TextBox>
								    </div>
                               <div class="form-group col-sm-6">  
                                    <label for="country">Country :</label>
                                     <asp:TextBox class="field" id="country" ClientIDMode="static" clientID="country"
                                 disabled="true" type="text"  runat="server"></asp:TextBox>
                                </div>
                              
                    <div class="clearfix form-actions">
						<div class="col-md-offset-3 col-md-9">
                             <asp:LinkButton ID="LinkButton2" class="btn btn-info" Text='<i class="ace-icon fa fa-check bigger-110"></i>Submit' OnCommand="AddNewOrganization" runat="server"></asp:LinkButton>							
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
       
    <!--View All Organizations -->
    <div class="row">
                 <!--View Organizations-->
                <asp:Panel ID="pnlViewOrganizations" ScrollBars="Auto"  runat="server">
                    <!--Filter Organizations-->
                     <div class="col-sm-12">
                        <div>
                            <div>
                                <div class="col-sm-2">Organization Type</div><div class="col-sm-2"><asp:DropDownList ID="ddlFilterOrganizationType" runat="server">
                                                                                                           <%-- <asp:ListItem>TREATMENT-CENTRE</asp:ListItem>--%>
                                                                                                            <asp:ListItem>EDUCATION-CENTRE</asp:ListItem>
                                                                                                            <asp:ListItem>EMPLOYER</asp:ListItem>
                                                                                                            <asp:ListItem>VENDOR</asp:ListItem>
                                                                                                </asp:DropDownList></div>
                            
                                <div class="col-sm-2"><asp:LinkButton ID="btnFilterOrganizationType"  class="btn btn-xs btn-info" Text="<i class='ace-icon fa fa-filter bigger-120'> GO</i>" ToolTip="Filter Org Type" OnCommand="ManageOrganizationVisibility" CommandName="FilterOrganizationType" CommandArgument="" runat="server" ></asp:LinkButton></div>
                            </div>
                        </div>
                    </div><hr />
               
                    <asp:DataList ID="dlOrganizations" DataKeyField="OrganizationId"    runat="server">
                        <HeaderTemplate>
                                <%--<div class="col-md-12">
                                        <div class="col-sm-1"><asp:Label Text=Id runat="server"></asp:Label></div>
                                        <th colspan="1"><asp:Label Width="80px" Text=OrgType runat="server"></asp:Label></th>
                                        <div class="col-sm-1"><asp:Label  Text="Details"  runat="server" ></asp:Label></div>
                                        <div class="col-sm-2"><asp:Label  Text=Organization runat="server"></asp:Label></div>
                                        <div class="col-sm-2"><asp:Label  Text="Manager" runat="server"></asp:Label></div>
										<div class="col-sm-2"><asp:Label  Text="ContactPerson" runat="server"></asp:Label></div>
										<div class="col-sm-2"><asp:Label  Text="Phone" runat="server"></asp:Label> </div>
										<div class="col-sm-2"><asp:Label  Text="Email" runat="server"></asp:Label></div>
										<div class="col-sm-1"><asp:Label  Text="Bank" runat="server"></asp:Label></div>
									</div>--%>
                                    
                              
                        </HeaderTemplate>
                        <ItemStyle HorizontalAlign="Center"   />
                        <ItemTemplate>
                             <div id="simple-table" class="table  table-bordered table-hover">
									<div>
                                        <div><asp:Label class="label label-sm label-warning" Text=<%#Eval("OrganizationId") %> runat="server"></asp:Label></div>
                                        <div><asp:Label Text=<%# DataBinder.Eval(Container.DataItem,"OrganizationType")%> runat="server"></asp:Label></div>
                                        <div><asp:LinkButton   ID="btnViewOrganizationDetails"  class="green bigger-140 show-details-btn" Text="<i class='ace-icon fa fa-angle-double-down bigger-120'></i>" ToolTip="Profile" OnCommand="ManageOrganizationVisibility" CommandName="ViewProfile" CommandArgument='<%#Eval("OrganizationId") %>' runat="server" ></asp:LinkButton></div>
                                        <div><asp:Label  Text=<%# DataBinder.Eval(Container.DataItem,"OrganizationName")%> runat="server"></asp:Label></div>
                                        <div>MGR: <asp:Label  Text=<%# DataBinder.Eval(Container.DataItem,"ManagerName")%> runat="server"></asp:Label></div>
										<div><asp:Label  Text=<%# DataBinder.Eval(Container.DataItem,"ContactPerson")%> runat="server"></asp:Label></div>
										<div><asp:Label  Text=<%# DataBinder.Eval(Container.DataItem,"PhoneOne")%> runat="server"></asp:Label> </div>
										<div><asp:Label  Text=<%#DataBinder.Eval(Container.DataItem,"Email") %> runat="server"></asp:Label></div>
										<div>
											<div class="hidden-sm hidden-xs btn-group" style="width:50px;">
                                                <!--<button class="btn btn-xs btn-warning">
													<i class="ace-icon fa fa-flag bigger-120"> CSR</i>
												</button>-->
                                                <!--<asp:LinkButton ID="btnViewOrganizationCSR"  class="btn btn-xs btn-warning" Text="<i class='ace-icon fa fa-flag bigger-120'> CSR</i>" ToolTip="ModifyCsrStatus" OnCommand="ManageOrganizationVisibility" CommandName="ViewOrganizationCsr" CommandArgument='<%# Eval("OrganizationId")%>' runat="server" ></asp:LinkButton>-->

												<!--<button class="btn btn-xs btn-info">
													<i class="ace-icon fa fa-inr bigger-120"> Accounts</i>
												</button>-->
												
                                                <!--<button class="btn btn-xs btn-danger">
													<i class="ace-icon fa fa-bank bigger-120"></i>
												</button>-->
                                                <asp:LinkButton ID="lnkBtnOrgBankDetails"  class="btn btn-xs btn-info" Text="<i class='ace-icon fa fa-bank bigger-120'> B</i>" ToolTip="Bank Details" OnCommand="ManageOrganizationVisibility" CommandName="OrganizationBankDetails" CommandArgument='<%# Eval("OrganizationId")%>' runat="server" ></asp:LinkButton>
												<!--<asp:LinkButton ID="lnkBtnCreateStudentList"  class="btn btn-xs btn-warning" Text='<i class="ace-icon fa fa-group bigger-120"> SL</i>' ToolTip="Create Interview" OnCommand="ManageOrganizationVisibility" CommandName="GoToStudentGallery" CommandArgument='<%# Eval("OrganizationId")%>' runat="server" ></asp:LinkButton>-->
											</div>

											<div class="hidden-md hidden-lg">
												<div class="inline pos-rel">
													<button class="btn btn-minier btn-primary dropdown-toggle" data-toggle="dropdown" data-position="auto">
														<i class="ace-icon fa fa-cog icon-only bigger-110"></i>
													</button>

													<ul class="dropdown-menu dropdown-only-icon dropdown-yellow dropdown-menu-right dropdown-caret dropdown-close">
														<!--<li>
															<a href="#" class="tooltip-info" data-rel="tooltip" title="View">
																<span class="blue">
																	<i class="ace-icon fa fa-search-plus bigger-120"></i>
																</span>
															</a>
														</li>-->

														<li>
															<!--<a href="#" class="tooltip-success" data-rel="tooltip" title="Edit">
																<span class="green">
																	<i class="ace-icon fa fa-pencil-square-o bigger-120"></i>
																</span>
															</a>-->
                                                            <!--<asp:LinkButton ID="lnkBtnCSL"  class="btn btn-xs btn-warning" Text='<i class="ace-icon fa fa-group bigger-120"> SL</i>' ToolTip="Create Interview" OnCommand="ManageOrganizationVisibility" CommandName="GoToStudentGallery" CommandArgument='<%# Eval("OrganizationId")%>' runat="server" ></asp:LinkButton>-->
														</li>

														<li>
															<!--<a href="#" class="tooltip-error" data-rel="tooltip" title="Delete">
																<span class="red">
																	<i class="ace-icon fa fa-trash-o bigger-120"></i>
																</span>
															</a>-->
                                                            <asp:LinkButton ID="LinkButton3"  class="btn btn-warning" Text="<i class='ace-icon fa fa-bank bigger-120'></i> B" ToolTip="Bank Details" OnCommand="ManageOrganizationVisibility" CommandName="OrganizationBankDetails" CommandArgument='<%# Eval("OrganizationId")%>' runat="server" ></asp:LinkButton>
														</li>
													</ul>
												</div>
											</div>
										</div>
									</div>
                              </div>
                        </ItemTemplate>
                    </asp:DataList>
                   
                
            </asp:Panel>
		   <!-- PAGE CONTENT ENDS -->
		   
    </div><!-- /.row -->

    <!--View Selected Organization Profile-->
    <div class="row">
		    <div class="col-xs-12">
                 <!--View Organization Profile-->
                <asp:Panel ID="pnlViewOrganizationProfile" ScrollBars="Auto"  runat="server">
                <div class="col-xs-12">
                    <asp:DataList ID="dlOrganizationDetails" DataKeyField="OrganizationId" HorizontalAlign="Justify"   RepeatColumns="1" RepeatDirection="horizontal" GridLines="Vertical" runat="server">
                        <HeaderTemplate>
                        </HeaderTemplate>
                        <ItemStyle HorizontalAlign="Center"   />
                        <ItemTemplate>
                             <table id="simple-table" class="table  table-bordered table-hover">
								<tbody>
									<tr>
										<th>Organization Name:</th><td><%# Eval("OrganizationName")%></td>
                                        <th>Organization ID:</th><td class="hidden-480"><span class="label label-sm label-warning"><%#Eval("OrganizationId") %></span></td>
                                    </tr>
                                    <tr>
                                        <th>HOD Name:</th><td><%# Eval("ManagerName")%></td>
                                        <th>HOD Email:</th><td><%# Eval("ManagerEmail")%></td>
                                    </tr>
                                    <tr>
                                        <th>HOD Phone:</th><td><%# Eval("ManagerPhone")%></td>
                                       <th>Contact Person:</th><td><%# Eval("ContactPerson")%></td>
                                    </tr>
                                     <tr>
										<th>Phone One</th><td><%# Eval("PhoneOne")%> </td>
										<th>Phone Two</th><td><%# Eval("PhoneTwo") %></td>
                                    </tr>
                                    <tr>
                                        <th>Email</th><td><%# Eval("Email")%> </td>
                                        <th>Office Address:</th><td colspan="3"><%# Eval("OfficeAddress")%></td>
                                    </tr>
                                    <tr>
									  <th>EnrolmentDate</th><td><%# Eval("EnrolmentDate")%> </td>
									  <th>MemberPhoto</th><td><%# Eval("MemberPhoto") %></td>
                                    </tr>
                                     <tr>
									  <th>Remarks</th><td><%# Eval("Remarks")%> </td>
									  <th>Notify</th><td><%# Eval("Notify") %></td>
                                    </tr>
                                   
                                    <tr>
										<td colspan="4">
											<div class="hidden-sm hidden-xs btn-group">
															
                                                <asp:LinkButton ID="lnkBtnEditOrganizationDetails"  class="btn btn-xs btn-info" Text="<i class='ace-icon fa fa-pencil bigger-120'></i>" ToolTip="Edit Profile" OnCommand="ManageOrganizationVisibility" CommandName="EditProfile" CommandArgument='<%#Eval("OrganizationId")%>' runat="server" ></asp:LinkButton>
												<asp:LinkButton ID="LinkButton1"  class="btn btn-xs btn-info" Text="<i class='ace-icon fa fa-times bigger-120 white'></i>" ToolTip="Cancel" OnCommand="ManageOrganizationVisibility" CommandName="ReturnToViewOrganizations" runat="server" ></asp:LinkButton>

												
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

    <!--View Selected Organization Bank Details-->
    <div class="row">
		    <div class="col-xs-12">
                 <!--View Organization Bank Details-->
                <asp:Panel ID="pnlOrganizationBankDetails" ScrollBars="Auto"  runat="server">
                <div class="col-xs-12">
                    <asp:DataList ID="dlOrganizationBankDetails" DataKeyField="OrganizationId"  OnEditCommand="dlOrganizationBankDetailsEditHandler" OnUpdateCommand="dlOrganizationBankDetailsUpdateHandler" 
                                  OnCancelCommand="dlOrganizationBankDetailsCancelHandler" HorizontalAlign="Justify" GridLines="Vertical" runat="server">
                        <HeaderTemplate>
                        </HeaderTemplate>
                        <ItemStyle HorizontalAlign="Center"   />
                        <ItemTemplate>
                             <table id="simple-table" class="table  table-bordered table-hover">
								<tbody>
									<tr>
										<th>Organization Name:</th><td><%# Eval("OrganizationName")%></td>
                                        <th>Organization ID:</th><td class="hidden-480"><span class="label label-sm label-warning"><%#Eval("OrganizationId") %></span></td>
                                    </tr>
                                    <tr>
                                        <th>GST Code:</th><td><%# Eval("GoodsAndServicesTaxCode")%></td>
                                        <th>Service Tax Number:</th><td><%# Eval("ServiceTaxCode")%></td>
                                    </tr>
                                    <tr>
                                        <th>VAT:</th><td><%# Eval("ValueAddedTaxCode")%></td>
                                       <th>PAN:</th><td><%# Eval("PermanentAccountNumber")%></td>
                                    </tr>
                                     <tr>
										<th>Bank Name</th><td><%# Eval("BankName")%> </td>
										<th>Bank Account Number</th><td><%# Eval("BankAccountNumber") %></td>
                                    </tr>
                                    <tr>
                                        <th>IFCSC Code</th><td><%# Eval("BankIFSCCode")%> </td>
                                        <th></th><td></td>
                                    </tr>
                                    <tr>
										<td colspan="4">
											<div class="hidden-sm hidden-xs btn-group">
															
                                                <asp:LinkButton ID="lnkBtnEditOrganizationBankDetails"  class="btn btn-xs btn-info" Text="<i class='ace-icon fa fa-pencil bigger-120'></i>" ToolTip="Edit Bank Details" CommandName="edit" runat="server" ></asp:LinkButton>
												<asp:LinkButton ID="LinkButton1"  class="btn btn-xs btn-info" Text="<i class='ace-icon fa fa-times bigger-120 white'></i>" ToolTip="Cancel" OnCommand="ManageOrganizationVisibility" CommandName="ReturnToViewOrganizations" runat="server" ></asp:LinkButton>

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

                        <EditItemTemplate>
                             <table id="simple-table" class="table  table-bordered table-hover">
								<tbody>
									<tr>
										<th>Organization Name:</th><td><%# Eval("OrganizationName")%></td>
                                        <th>Organization ID:</th><td class="hidden-480"><span class="label label-sm label-warning"><%#Eval("OrganizationId") %></span></td>
                                    </tr>
                                    <tr>
                                        <th>GST Code:</th><td><asp:TextBox ID="txtBoxEditGSTCode" Text=<%# Eval("GoodsAndServicesTaxCode")%> runat="server"></asp:TextBox></td>
                                        <th>Service Tax Number:</th><td><asp:TextBox ID="txtBoxEditServiceTaxCode" Text=<%# Eval("ServiceTaxCode")%> runat="server"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <th>VAT:</th><td><asp:TextBox ID="txtBoxEditVATCode" Text=<%# Eval("ValueAddedTaxCode")%> runat="server"></asp:TextBox></td>
                                       <th>PAN:</th><td><asp:TextBox ID="txtBoxEditPANNumber" Text=<%# Eval("PermanentAccountNumber")%> runat="server"></asp:TextBox></td>
                                    </tr>
                                     <tr>
										<th>Bank Name</th><td><asp:TextBox ID="txtBoxEditBnkName" Text=<%# Eval("BankName")%> runat="server"></asp:TextBox></td>
										<th>Bank Account Number</th><td><asp:TextBox ID="txtBoxEditBankAccountNumber" Text=<%# Eval("BankAccountNumber") %> runat="server"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <th>IFCSC Code</th><td><asp:TextBox ID="txtBoxEditBankIFSCCode" Text=<%# Eval("BankIFSCCode")%> runat="server"></asp:TextBox> </td>
                                        <th></th><td></td>
                                    </tr>
                                    <tr>
										<td colspan="4">
											<div class="hidden-sm hidden-xs btn-group">
															
                                                <asp:LinkButton ID="lnkBtnEditOrganizationBankDetails"  class="btn btn-xs btn-info" Text="<i class='ace-icon fa fa-refresh bigger-120'></i>" ToolTip="Edit Bank Details" CommandName="update" runat="server" ></asp:LinkButton>
												<asp:LinkButton ID="LinkButton1"  class="btn btn-xs btn-info" Text="<i class='ace-icon fa fa-times bigger-120 white'></i>" ToolTip="Cancel" OnCommand="ManageOrganizationVisibility" CommandName="cancel" runat="server" ></asp:LinkButton>

												
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

                        </EditItemTemplate>
                    </asp:DataList>
                   
                 </div><!-- /.span -->
            </asp:Panel>
		   <!-- PAGE CONTENT ENDS -->
		    </div><!-- /.col -->
    </div><!-- /.row -->

    <!--Edit and Save Organization Profile-->
	<div class="row">
		    <div class="col-xs-12">
                 <!--View Organization-->
                <asp:Panel ID="pnlEditOrganizationProfile" ScrollBars="Auto"  runat="server">
                <div class="col-xs-12">
                    <asp:DataList ID="dlEditOrganizationProfile" DataKeyField="OrganizationId" OnUpdateCommand="UpdateOrganizationProfile"  HorizontalAlign="Justify"   RepeatColumns="1" RepeatDirection="horizontal" GridLines="Vertical" runat="server">
                        <HeaderTemplate>
                        </HeaderTemplate>
                        <ItemStyle HorizontalAlign="Center"   />
                        <ItemTemplate>
                             <table id="simple-table" class="table  table-bordered table-hover">
								<tbody>
									<tr>
										<th>Organization Name:</th><td><asp:TextBox ID="txtBoxEditOrgName" Text='<%# Eval("OrganizationName")%>' runat="server"></asp:TextBox></td>
                                        <th>Organization ID:</th><td class="hidden-480"><span class="label label-sm label-warning"><%#Eval("OrganizationId") %></span></td>
                                    </tr>
                                     <tr>
                                        <th class="col-sm-1">HOD Name</th><td><asp:TextBox ID="txtBoxEditManagerName" Text=<%# Eval("ManagerName")%>  runat="server"></asp:TextBox></td>
								        <th class="col-sm-1">HOD Email</th><td><asp:TextBox ID="txtBoxEditManagerEmail" Text=<%# Eval("ManagerEmail")%> runat="server"></asp:TextBox></td>
                                    </tr
                                    <tr>
                                        <th class="col-sm-1">HOD Phone</th><td><asp:TextBox ID="txtBoxEditManagerPhone" Text=<%# Eval("ManagerPhone")%> runat="server"></asp:TextBox></td>
                                        <th class="col-sm-1">Office Address:</th><td><asp:TextBox class="col-sm-12" ID="txtBoxEditOfficeAddress" TextMode="MultiLine"   Text=<%# Eval("OfficeAddress")%> runat="server"></asp:TextBox></td>
                                    </tr>
                                    <tr>
									  <th>Contact Person:</th><td><asp:TextBox ID="txtBoxEditContactPerson" Text='<%# Eval("ContactPerson")%>' runat="server"></asp:TextBox></td>
									  <th>Email</th><td><asp:TextBox ID="txtBoxEditEmail" Text='<%# Eval("Email")%>' runat="server"></asp:TextBox> </td>
                                    </tr>
                                    <tr>
										<th>Phone One</th><td><asp:TextBox ID="txtBoxEditPhoneOne" Text='<%# Eval("PhoneOne")%>' runat="server"></asp:TextBox> </td>
										<th>Phone Two</th><td><asp:TextBox ID="txtBoxEditPhoneTwo" Text='<%# Eval("PhoneTwo") %>' runat="server"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <th class="col-sm-1">EnrolmentDate</th><td><asp:TextBox ID="txtBoxEditEnrolmentDate" Text='<%# Eval("EnrolmentDate")%>'  runat="server"></asp:TextBox></td>
								         <th class="col-sm-1">Notify</th><td><asp:TextBox ID="txtBoxEditNotify" Text='<%# Eval("Notify")%>' runat="server" />
                                    </tr>
                                    <tr>
                                        <th class="col-sm-1">Remarks</th><td><asp:TextBox ID="txtBoxEditRemarks" Text=<%# Eval("Remarks")%>  TextMode="MultiLine" runat="server"></asp:TextBox></td>
								        <th class="col-sm-1">MemberPhoto</th><td><asp:TextBox ID="txtBoxEditMemberPhoto" Text=<%# Eval("MemberPhoto") %> runat="server"></asp:TextBox></td>
                                    </tr>	
                                    <tr>
										<td colspan="4">
											<div class="hidden-sm hidden-xs btn-group">
                                                <asp:LinkButton ID="lnkBtnUpdateOrganizationProfile"  class="btn btn-white btn-info btn-bold" Text="<i class='ace-icon fa fa-floppy-o bigger-120 blue'>Save</i>" ToolTip="Save" CommandName="Update" runat="server" ></asp:LinkButton>
												<asp:LinkButton ID="lnkBtnReturnToViewCusatomers"  class="btn btn-white btn-default btn-round" Text="<i class='ace-icon fa fa-times red2'>Cancel</i>" ToolTip="Cancel" OnCommand="ManageOrganizationVisibility"  CommandName="ReturnToViewOrganizations" runat="server" ></asp:LinkButton>			
                                               
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
