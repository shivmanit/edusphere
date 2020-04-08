<%@ Page Title="" Language="C#" MasterPageFile="~/EduSpherePro/EduSpherePro.Master" AutoEventWireup="true" CodeBehind="Students.aspx.cs" Inherits="EduSpherePro.EduSpherePro.Students" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <script type = "text/javascript">
                    var ddlText, ddlValue, ddl, lblMesg;
                    function CacheItems() {
                        ddlText = new Array();
                        ddlValue = new Array();
                        ddl = document.getElementById("<%=ddlSku.ClientID %>");
                        lblMesg = document.getElementById("<%=lblMessage.ClientID%>");
                        for (var i = 0; i < ddl.options.length; i++) {
                            ddlText[ddlText.length] = ddl.options[i].text;
                            ddlValue[ddlValue.length] = ddl.options[i].value;
                        }
                    }
                    window.onload = CacheItems;
   
                    function FilterItems(value) {
                        ddl.options.length = 0;
                        for (var i = 0; i < ddlText.length; i++) {
                            if ((ddlText[i].toLowerCase().indexOf(value) != -1) ||(ddlText[i].toUpperCase().indexOf(value) != -1)) {
                                AddItem(ddlText[i], ddlValue[i]);
                            }
                        }
                        lblMesg.innerHTML = ddl.options.length + " items found.";
                        if (ddl.options.length == 0) {
                            AddItem("No items found.", "");
                        }
                    }
   
                    function AddItem(text, value) {
                        var opt = document.createElement("option");
                        opt.text = text;
                        opt.value = value;
                        ddl.options.add(opt);
                    }
                </script> 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <!--Page Command Buttons-->   
        <div class="row">
            <div class="col-xs-12">
               <div class="col-sm-6">  
                 <div class="hr hr-18 dotted hr-double"></div>
	               <h4 class="pink">
		              <i class="ace-icon fa fa-hand-o-right icon-animated-hand-pointer blue"></i>
			          <asp:Label ID="lblMembersAction" Text="Operations / Students" runat="server"></asp:Label>
	               </h4>
	              <div class="hr hr-18 dotted hr-double"></div>
               </div>
               <div class="col-sm-4">
                    <div id="membersbar" class="navbar-buttons navbar-header pull-right" role="navigation">
					    <ul class="nav ace-nav">
						    <li class="light-blue dropdown-modal">
							    <a data-toggle="dropdown" href="#" class="dropdown-toggle">
                                    Students <i class="ace-icon fa fa-caret-down"></i> 
							    </a>
							    <ul class="user-menu dropdown-menu-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">
						            <li>
                                        <asp:LinkButton ID="lnkBtnViewStudents"   OnCommand="FilterStudent" CommandArgument="ALL" Text='<i class="ace-icon fa fa-eye fa-fw"></i>View Students' runat="server"></asp:LinkButton>
								    </li>
								    <li class="divider"></li>
								    <li>
									    <asp:LinkButton ID="btnAddStudent"    OnCommand="EnrolNewStudent" CommandArgument="Enroll" Text='<i class="ace-icon fa fa-plus"></i> Enrol Student' runat="server"></asp:LinkButton>
								    </li>
                                    <%--<li class="divider"></li>
								    <li>
									    <asp:LinkButton ID="btnViewEnquiries"  OnCommand="DisplayStudentsReport" CommandArgument="ENQ" Visible="false" Text="Enquiries" runat="server"></asp:LinkButton>
								    </li>
                                    <li class="divider"></li>
								    <li>
									    <asp:LinkButton ID="btnViewFees"   OnCommand="DisplayStudentsReport" CommandArgument="SERV" Text="My Fees"  Visible="false" runat="server" />
								    </li>--%>
                                    <%--<li class="divider"></li>
								    <li>
									    <asp:LinkButton ID="btnViewSmsTrail"   OnCommand="DisplayStudentsReport" CommandArgument="SMS" Visible="true" Text="SMS Trail" runat="server" />
								    </li>
                                    <li class="divider"></li>
								    <li>
									    <asp:LinkButton ID="btnViewMailTrail"   OnCommand="DisplayStudentsReport" CommandArgument="MAIL"  Visible="true" Text="Mail Trail" runat="server" />
								    </li>--%>
                                    <li class="divider"></li>
								    <li>
									     <asp:LinkButton ID="btnGreetings"   OnCommand="DisplayStudentsReport" CommandArgument="GREETINGS" Text="Greetings" runat="server" />
								    </li>
                                    <li class="divider"></li>
								    <li>
									    <asp:LinkButton ID="btnReminders"   OnCommand="DisplayStudentsReport" CommandArgument="SERVICEREMINDERS" Text="Reminders" runat="server" />
								    </li>
							    </ul>
						    </li>
					    </ul>
				    </div>
              
          </div>
            </div>
         </div>
  <!--end Page Command Buttons-->

    <!--Add New Student-->
          <div class="row">
              <div class="col-xs-12">
                <asp:Panel ID="pnlEnroll" BorderWidth="0px" ScrollBars="none" runat="server">
                    <fieldset class="login">
                        <legend>Student Registration</legend>                      
                        <table class="table  table-bordered table-hover">            
                            <tr>
                                <th>Name:</th>
                                <td><asp:TextBox ID="txtBoxFirstName" runat="server"></asp:TextBox></td>
                                <th>Gender :</th>
                                <td><asp:TextBox ID="txtBoxLastName" runat="server"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <th>Program</th>
                                <td><asp:DropDownList ID="ddlMembershipType" DataTextField="ProgramTitle" DataValueField="ProgramID" runat="server"></asp:DropDownList></td>
                                <th>Academic Status</th>
                                <td><asp:DropDownList ID="ddlAcadStatus" runat="server">
                                     <asp:ListItem>FIRST</asp:ListItem>
                                     <asp:ListItem>SECOND</asp:ListItem>
                                     <asp:ListItem>THIRD</asp:ListItem>
                                     <asp:ListItem>FOURTH</asp:ListItem>
                                     </asp:DropDownList>
                                 </td>
                            </tr>
                            <tr>
                                <th>Phone One:<asp:Label ID="lblCountryCode1" Text="+91" runat="server"></asp:Label></th>
                                <td><asp:TextBox ID="txtBoxPhoneOne" runat="server"></asp:TextBox></td>
                                <th>Phone Two:<asp:Label ID="Label9" Text="+91" runat="server"></asp:Label></th>
                                <td><asp:TextBox ID="txtBoxPhoneTwo" runat="server"></asp:TextBox></td>
                            </tr>  
                            <tr>
                                <th>Email:</th>
                                <td><asp:TextBox ID="txtBoxEmail" runat="server"></asp:TextBox></td>
                                <th>Address:</th>
                                <td><asp:TextBox ID="txtBoxAddress" runat="server"></asp:TextBox></td>
                            </tr>                       
                            <tr>
                                <th>Date of Birth:</th>
                                <td><asp:TextBox ID="txtBoxDateOfBirth"      Font-Italic="true" runat="server"></asp:TextBox>
                                    <asp:CheckBox ID="chkBoxDateOfBirth" Text="SKIP" runat="server" /> 
                                </td>
                                <th>Section</th>
                                <td><asp:DropDownList ID="ddlSection" runat="server">
                                    <asp:ListItem>A</asp:ListItem>
                                    <asp:ListItem>B</asp:ListItem>
                                    <asp:ListItem>C</asp:ListItem>
                                    <asp:ListItem>D</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <th>Anniversary:</th>
                                <td><asp:TextBox ID="txtBoxAnniversary"    runat="server"></asp:TextBox>
                                    <asp:CheckBox ID="chkBoxAnnivarsaryDate" Text="SKIP" runat="server" />
                                </td>
                                <th>ExpectedCompletionDate</th>
                                <td><asp:TextBox ID="txtBoxMemExpDate" Text="dd/mm/yyyy" runat="server"></asp:TextBox> </td>
                            </tr>
                            
                            <tr> 
                                <td><asp:CheckBox ID="chkBoxNotify"  runat="Server" /></td>
                                <th>Notify me through SMS.</th>                               
                                <th>Educational Details:</th>
                                <td><asp:TextBox ID="txtBoxRemarks" TextMode="multiline" Font-Italic="true" runat="server"></asp:TextBox></td>            
                            </tr>
                            <tr>
                                <td><asp:Button class="btn btn-sm btn-info" ID="btnSubmit" OnCommand="InsertStudentDetails" Text="Submit" runat="server" /></td>
                                <td><asp:ImageButton ImageUrl="~/Images/Return.png" Height="30px" Width="30px" ToolTip="Return" OnCommand="ManagePnlVisibility"  CommandName="FromPnlEnrollToPnlStudents" runat="server" /></td>   
                            </tr>
                        </table>
                    </fieldset>                   
                </asp:Panel>
              </div>
          </div>
    <!--/Add New Student-->

    <!--Student Search-->
           <div class="row">
               <div class="col-xs-12">
                   <asp:Panel ID="pnlMemberSummary" runat="server">
                       <div class="col-xs-12">
                          <div class="col-sm-2">
                                <strong>Count : </strong><i class="ace-icon fa fa-bell icon-animated-bell"></i>
                                <span class="badge badge-important">
                                    <asp:Label  ID="lblCount" runat="server"></asp:Label>
                                 </span>
                            </div>   
                           
                            <div  class="col-sm-4">
                                <div class="input-group">
                                  <span class="input-group-addon">
					                   <i class="ace-icon fa fa-check"></i>
				                  </span>
                                  <asp:TextBox ID="txtBoxSearch" class="form-control search-query" runat="server"></asp:TextBox>
                                  <span class="input-group-btn">
                                      <asp:LinkButton ID="btnFilter" class="btn btn-purple btn-sm"   Text="<span class='ace-icon fa fa-search icon-on-right bigger-110'> </span> Search" OnCommand="FilterStudent" runat="server"></asp:LinkButton>
                                  </span>
                                </div>
                          </div>
                           <div class="col-sm-2">
                               <asp:Label ID="lblRole" Visible="false"  runat="server"></asp:Label>
                               <asp:Label ID="lblDriveID" Visible="true" runat="server"></asp:Label>
                           </div>
                          
                       </div>
                </asp:Panel>
               </div>
           </div>
     <!--/Student Search-->  
    
    <!--View Students List-->                
           <div class="row">
               <div class="col-xs-12">
                <!--Panel displaying list of  Students-->
                  <asp:Panel  Style="margin-top: 20px;" ID="pnlMembers" ScrollBars="Auto"  runat="server">
                    <asp:DataList ID="dlStudents" DataKeyField="MemberID" 
                        Cellpadding="3" CellSpacing="2"   RepeatColumns="3" RepeatDirection="horizontal" GridLines="both" runat="server">
                        <HeaderTemplate>
                        </HeaderTemplate>
                        <ItemStyle BackColor="White" ForeColor="Black" BorderWidth="2px" />
                        <ItemTemplate>
                            <div class="col-xs-12">
                                
                                    <div class="col-sm-2"><asp:Label class="label label-sm label-warning" Text='<%# DataBinder.Eval(Container.DataItem,"MemberID")%>' runat="server"></asp:Label></div>
                                    <div class="col-sm-4"><%# DataBinder.Eval(Container.DataItem,"FullName")%>
                                        <br />
                                        <i class="fa fa-certificate"></i><%#Eval("ProgramTitle") %>
                                    </div>
                                                        
                                    <div class="col-sm-1"><asp:ImageButton class="green bigger-140 show-details-btn"  ID="imgBtnProfile"  ImageUrl='<%# Eval("Gender").Equals("MALE") ? "~/Images/male.png" :"~/Images/female.png" %>' Width="25px" Height="25px" CommandName ="PersonalDetails" CommandArgument='<%#Eval("MemberID") %>' OnCommand="DisplayStudentData" runat="server"></asp:ImageButton> </div>
                                    <%--<div class="col-sm-1"><asp:ImageButton class="green bigger-140 show-details-btn" ID="imgBtnKart" ToolTip="AddToPlacementDrive" ImageUrl="~/Images/kart.png" Width="25px" Height="25px" CommandName="AddToPlacementDrive" CommandArgument='<%#Eval("MemberID") %>' OnCommand="DisplayStudentData" runat="server" /> </div>--%>                                       
                                    <div class="col-sm-1"><asp:ImageButton class="green bigger-140 show-details-btn" ID="imgBtnAccount" ToolTip="BookFee Update Payment " ImageUrl="~/Images/fee.png" Width="25px" Height="25px" CommandName="StudentAccount" CommandArgument='<%#Eval("MemberID") %>' OnCommand="DisplayStudentData" runat="server" /></div>
                                    
                                    <div class="col-sm-1"><asp:ImageButton class="green bigger-140 show-details-btn" ID="btnDeleteStudent" ToolTip="Delete" ImageUrl="~/Images/del.png" Width="25px" Height="25px" Visible="false" Text="Delete" CommandName="DeleteStudent" CommandArgument='<%#Eval("MemberID") %>' OnCommand="DisplayStudentData" runat="server" /></div>
                                    
                               
                            </div>
                            <hr />
                           
                        </ItemTemplate>
                    </asp:DataList>
                </asp:Panel>
                </div>
           </div>
     <!--/View Students List-->
     
    <!--View Student Profile-->                
           <div class="row">
               <div class="col-xs-12">
                <!--Panel to display personal details-->
                  <asp:Panel BorderWidth="0px" Style="margin-top: 50px;" ID="pnlPersonalDetails" ScrollBars="none" runat="server">
                    <asp:DataList ID="dlPersonalDetails" DataKeyField="MemberID" OnEditCommand="dlPersonalDetailsEditHandler"
                        OnUpdateCommand="dlPersonalDetailsUpdateHandler" OnCancelCommand="dlPersonalDetailsCancelHandler" runat="server">
                        <ItemTemplate>
                            <table class="table  table-bordered table-hover">
                                <tr>
                                    <td class="span2"><asp:ImageButton ID="Image1" AlternateText="Upload Photo" Style="border:2px solid red;border-radius:250px;" width="100px" height="100px" ToolTip="Edit Photo" OnCommand="Edit_PersonalDetails" CommandArgument='<%#DataBinder.Eval(Container.DataItem,"MemberID")%>' CommandName="Student" ImageUrl='<%#DataBinder.Eval(Container.DataItem,"PhotoPath") %>' runat="server" /></td>
                                    <th>Batch ID: <asp:Label ID="lblBatchID" Text='<%# Eval("BatchID") %>' runat="server"></asp:Label></th>                                  
                                </tr>
                                <tr>
                                    <th class="span2">Name :</th>
                                    <td class="span2"><asp:Label ID="lblFullName" Text='<%#DataBinder.Eval(Container.DataItem,"FullName")%>' runat="server"></asp:Label></td>
                                    <th class="span2"><strong>Education Centre</strong></th>
                                    <td class="span2"><asp:Label ID="lblCentre" Text='<%#DataBinder.Eval(Container.DataItem,"OrganizationName")%>' runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <th>Program</th>
                                    <td class="span2"><asp:Label ID="Label15" Text='<%#Eval("ProgramTitle")%>' runat="server"></asp:Label></td>
                                    <th>Membership Type</th>
                                    <td class="span2"><asp:Label ID="Label16" Text='<%#Eval("MembershipType")%>' runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td class="span2"><strong>Phone One :</strong></td>
                                    <td class="span2"><asp:Label ID="Label3" Text='<%#DataBinder.Eval(Container.DataItem,"PhoneOne")%>' runat="server"></asp:Label></td>
                                    <td class="span2"><strong>Phone Two :</strong></td>
                                    <td class="span2"><asp:Label ID="Label4" Text='<%#DataBinder.Eval(Container.DataItem,"PhoneTwo")%>' runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td class="span2"><strong>Email :</strong></td>
                                    <td class="span2"><asp:Label ID="Label5" Text='<%#DataBinder.Eval(Container.DataItem,"Email")%>' runat="server"></asp:Label></td>
                                    <td class="span2"><strong>Marital Status :</strong></td>
                                    <td class="span2"><asp:Label ID="Label6" Text='<%#DataBinder.Eval(Container.DataItem,"MaritalStatus")%>' runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td class="span2"><strong>Date of Birth :</strong></td>
                                    <td class="span2"><%# DataBinder.Eval(Container.DataItem,"DateOfBirth","{0:dd/MM/yyyy}")%> </td>
                                    <td class="span2"><strong>Anniversary :</strong></td>
                                    <td class="span2"><%#DataBinder.Eval(Container.DataItem, "Anniversary","{0:dd/MM/yyyy}")%></td>
                                </tr>
                                <tr>
                                    <td class="span2"><strong>Enrolment Date :</strong></td>
                                    <td class="span2"><%#DataBinder.Eval(Container.DataItem, "DateOfJoining","{0:dd/MM/yyyy}")%></td>
                                    <td class="span2"><strong>Remarks :</strong></td>
                                    <td class="span2"><%#DataBinder.Eval(Container.DataItem, "Remarks")%></td>
                                </tr>
                               <%-- <tr>
                                    <td><asp:CheckBox ID="chkBoxNotify"  runat="Server" /></td>
                                    <td><strong>Notify me through SMS</strong></td>
                                    <td class="span2"><strong>Section</strong></td>
                                    <td class="span2"><%#DataBinder.Eval(Container.DataItem, "Section")%></td>
                                </tr>--%>
                                
                                <tr>
                                    <td class="span2"><asp:Button ID="btnEditPersonalDetails" class="btn btn-sm btn-info" Text="Edit" CommandName="Edit" runat="server" /></td>
                                    <td class="span2"> <asp:Button ID="btnReturn" class="btn btn-sm btn-info" Text="Return" OnCommand="ManagePnlVisibility" CommandName="FromPnlPersonalDetailsToPnlStudents" CommandArgument="ToPnlStudents" runat="server" /></td>
                                    <td class="span2"><asp:ImageButton ImageUrl="~/Images/email_icon.png" width="30px" Height="30px" ID="btnSendMsg" Text="SendCircular" ToolTip="SendEmail" AlternateText="SendEmail" OnCommand="SendEmailToStudent" CommandArgument='<%#Eval("Email") + ";" + Eval("FullName") %>' CommandName="UnicastStudentEmail" runat="server" /></td>
                                    <td class="span2"><asp:ImageButton ImageUrl="~/Images/sms_icon.png"  Width ="30px" Height="30px" ID="btnSendSMS" Text="SendSMS" ToolTip="SendSMS" AlternateText="SendSMS" OnCommand="SendSmsToStudent" CommandArgument='<%#Eval("PhoneOne") + ";" + Eval("FullName") %>' CommandName="UnicastStudentSms" runat="server" /></td>
                                </tr>
                            </table>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <fieldset class="login">
                                <legend>Member ID : <%#Eval("MemberID") %></legend>
                               <%-- Notify:<asp:Label ID="lblNotify" Text='<%#Eval("Notify") %>' runat="server"></asp:Label>--%>
                                <table class="table  table-bordered table-hover">
                                    <tr>
                                        <th>Name: </th><td><asp:TextBox ID="txtBoxFullName"  Text='<%#Eval("FullName") %>' runat="server"></asp:TextBox></td>
                                        <th>Gender: </th><td><asp:TextBox ID="txtBoxGender"  Text='<%#Eval("Gender") %>' runat="server"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <th>Program:</th><td><asp:DropDownList ID="ddlEditProgram"  DataTextField="ProgramTitle" DataValueField="ProgramID" runat="server">
                                        </asp:DropDownList></td><th>MembershipType:</th><td><asp:DropDownList ID="ddlEditMembershipType" DataTextField='<%#Eval("MembershipType")%>'  runat="server">
                                                <asp:ListItem>Select</asp:ListItem>    
                                                <asp:ListItem>STUDENT</asp:ListItem>
                                                <asp:ListItem>ALUMANI</asp:ListItem>
                                                <asp:ListItem>NONE</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>Phone One:</th><td><asp:TextBox ID="txtBoxPhoneOne" Text='<%#Eval("PhoneOne")%>' runat="server"></asp:TextBox></td>
                                        <th>Phone Two:</th><td><asp:TextBox ID="txtBoxPhoneTwo" Text='<%#Eval("PhoneTwo")%>' runat="server"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <th>Email:</th>
                                        <td><asp:TextBox ID="txtBoxEmail" Text='<%#Eval("Email")%>' runat="server"></asp:TextBox></td>
                                        <th>Education Centre:</th>
                                        <td><asp:DropDownList ID="ddlEditEducationCentre" DataTextField="OrganizationName" DataValueField="OrganizationID"  runat="server"></asp:DropDownList></td>
                                    </tr>
                                    <tr>
                                        <th>DateOfBirth:</th><td><asp:TextBox ID="txtBoxDateOfBirth" Text='<%#Eval("DateOfBirth","{0:dd/MM/yyyy}")%>' runat="server"></asp:TextBox></td>
                                        <th>Anniversary:</th><td><asp:TextBox ID="txtBoxAnniversary" Text='<%#Eval("Anniversary","{0:dd/MM/yyyy}")%>' runat="server"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <th>BatchCode</th>
                                        <td><asp:DropDownList ID="ddlEditBatchCode" DataTextField="BatchCode" DataValueField="BatchID" runat="server"></asp:DropDownList></td>
                                        <th>Remarks:</th>
                                        <td><asp:TextBox ID="txtBoxRemarks" Text='<%#Eval("Remarks")%>' runat="server"></asp:TextBox></td>
                                    </tr>
                                   <tr>
                                        <th>Marital Status:</th>
                                        <td><asp:DropDownList ID="ddlEditMaritalStatus" DataTextField='<%#Eval("MaritalStatus")%>'  runat="server">
                                                <asp:ListItem>Select</asp:ListItem>
                                                <asp:ListItem>SINGLE</asp:ListItem>
                                                <asp:ListItem>MARRIED</asp:ListItem>
                                                <asp:ListItem>SEPERATED</asp:ListItem>
                                                <asp:ListItem>DIVORCED</asp:ListItem>
                                               <asp:ListItem>WIDOWED</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <th>Expected Completion</th>
                                        <td><asp:TextBox ID="txtBoxEditExpCompletion" Text='<%#Eval("MembershipExpiryDate","{0:dd/MM/yyyy}") %>' runat="server"></asp:TextBox></td>
                                    </tr>
                                    
                                    <tr>
                                        <td>
                                            <asp:Button ID="btnUpdate" class="btn btn-sm btn-info" Text="Update" CommandName="update" runat="server" /></td>
                                        <td>
                                            <asp:Button ID="btnCancel" class="btn btn-sm btn-info" Text="Cancel" CommandName="cancel" runat="server" /></td>
                                    </tr>
                                </table>
                            </fieldset>
                        </EditItemTemplate>
                    </asp:DataList>
                    <asp:Panel ID="pnlSendMsg" style="padding-top:30px;" runat="server">
                        <fieldset class="login">
                            <legend>Send SMS Email</legend>
                            <div>
                                <strong>Sub:</strong> <asp:TextBox ID="txtBoxSubject" Text="Type Subject here" runat="server"></asp:TextBox><br />
                                <strong>Msg:</strong><asp:TextBox ID="txtBoxBody" Text="Type Message here" runat="server"></asp:TextBox>
                                <asp:Label ID ="lblSentStatus" runat="server"></asp:Label>
                            </div>
                                </fieldset>
                   </asp:Panel>
                </asp:Panel>
                </div>
           </div>
     
    <!--Edit Student Photo-->                  
           <div class="row">
               <div class="col-xs-12">
                <!--Edit Photo/Upload new Photo-->
                  <asp:Panel Style="margin-top: 50px;" ID="pnlEditPhoto" runat="server">
                    <fieldset class="login">
                        <legend>Edit photo for MemberID:<asp:Label ID="lblStudentId" runat="server"></asp:Label></legend>
                        <asp:Label ID="lblPhotoName" runat="server"></asp:Label>
                        <asp:TextBox ID="txtBoxPhotoPath" runat="server"></asp:TextBox>
                        <asp:FileUpload ID="fileUpload" runat="server" />
                        <asp:Button ID="btnSubmittPhoto" class="btn-sm btn-info" Text="Upload" OnCommand="UploadPhoto" runat="server" /><br />
                        <br />
                        <asp:Button ID="btnSumit" class="btn-sm btn-info" Text="Save" OnCommand="DoneEditing" runat="server" />&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
                        <asp:ImageButton ImageUrl="~/Images/Return.png" Height="5%" Width="5%" ToolTip="Return" OnCommand="ManagePnlVisibility" CommandName="FromPnlEditPhotoToPnlPersonalDetails" runat="server" />
                    </fieldset>
                </asp:Panel>
               </div>
           </div>
    <!--End Edit Student Photo-->
    
     <!--View Assessments and Print-->
      
    <!--End View Assessments and Print-->
           
    <!--Billing-->            
          <div class="row"> 
                <!--Pannel To display Customer Account Statement-->
                  <asp:Panel ID="pnlMemberSkuStatement"   ScrollBars="Vertical" Visible="false"   runat="server">
                      
                    <!--Tab Bill/Payment/Voucher-->
                    <div class="col-sm-12">
                        <!--Tabbed-->
                        <div class="col-sm-6 widget-container-col" id="widget-container-col-10">
						<div class="widget-box" id="widget-box-10">
							<div class="widget-header widget-header-small">
                                <h5 class="widget-title smaller">Transactions</h5>
								<div class="widget-toolbar no-border">
									<ul class="nav nav-tabs" id="myTab">
										<li class="active">
											<a data-toggle="tab" href="#bill">Make Bill</a>
										</li>
										<li>
											<a data-toggle="tab" href="#payment">Take Payment</a>
										</li>
										<li>
											<a data-toggle="tab" href="#voucher">Vouchers</a>
										</li>
                                        <li>
											<a data-toggle="tab" href="#tokens">LearningTokens</a>
										</li>
									</ul>
								</div>
							</div>
							<!--Bill/Payment/Voucher Body-->
									<div class="widget-body">
										<div class="widget-main padding-2">
											<div class="tab-content">
												<div id="bill" class="tab-pane in active">
                                                        <asp:DataList ID="dlTax" Visible="false" runat="server">
                                                            <ItemTemplate>
                                                                <strong>TaxCode :</strong><asp:Label ID="lblTaxCode" runat="server" Text='<%#Eval("TaxCode") %>'></asp:Label>
                                                                <strong>CGST % :</strong><asp:Label  ID="lblCGSTPercentage" runat="server" Text='<%#Eval("CGSTPercentage") %>'></asp:Label>
                                                                <strong>SGST % :</strong><asp:Label  ID="lblSGSTPercentage" runat="server" Text='<%#Eval("SGSTPercentage") %>'></asp:Label>
                                                                <strong>UnitRate :</strong><asp:Label  ID="lblUnitRate" runat="server" Text='<%#Eval("UnitRate") %>'></asp:Label>            
                                                            </ItemTemplate>
                                                        </asp:DataList>
                                                       
                                                        <div class="row">
                                                            <div class="col-sm-12">
                                                                <div class="col-xs-12">
                                                                    <div class="col-xs-6"><strong>SKU :</strong><br />
                                                                        <asp:TextBox class="form-control input-sm" ID="txtSearch" PlaceHolder="Type title to search"   runat="server" onkeyup = "FilterItems(this.value)"></asp:TextBox>
                                                                        <asp:DropDownList class="form-control input-sm"  ID="ddlSku" DataTextField="DisplayText" DataValueField="SkuId" OnSelectedIndexChanged="SelectedSkuChanged" AutoPostBack="true" runat="server">
                                                                            
                                                                        </asp:DropDownList><br />
                                                                        <asp:Label class="form-control input-sm" ID="lblMessage" runat="server" Text=""></asp:Label>
                                                                   </div>
                                                                    <div class="col-xs-4"><strong>CENTRE :</strong><asp:DropDownList   class="form-control input-sm" ID="ddlTxLocation" Visible="true" DataTextField="OrganizationName" DataValueField="OrganizationID"   runat="server">
                                                                        </asp:DropDownList>
                                                                        <%--<asp:RequiredFieldValidator runat="server" ControlToValidate="ddlServiceLocation"
                                                                                            CssClass="text-danger" InitialValue="Select" ErrorMessage="* Please select salon branch" /><br />--%>
                                                                        <strong>AMOUNT :</strong> <asp:TextBox class="form-control input-sm"  ID="txtBoxDebitAmount" runat="server"></asp:TextBox>
                                                                           <asp:Label ID="lblMembershipDiscount" Visible="false" runat="server"></asp:Label>
                                                                           <strong>Discount. % OR</strong><asp:TextBox class="form-control input-sm" ID="txtBoxDiscountPercentage" Text="0" runat="server"></asp:TextBox>
                                                                       
                                                                    </div>
                                                                    <div class="col-xs-2">
                                                                        <strong>Qty:</strong><asp:TextBox class="form-control input-sm"  ID="txtBoxSkuQuantity" Text="0" OnTextChanged="txtBoxSkuQuantity_TextChanged" AutoPostBack="true" runat="server"></asp:TextBox>
                                                                        <%--<asp:RequiredFieldValidator runat="server" ControlToValidate="txtBoxServiceQuantity"
                                                                                            CssClass="text-danger" InitialValue="1" ErrorMessage="* Enter Service Quantity" />--%>
                                                                        <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator1"
                                                                                        ControlToValidate="txtBoxServiceQuantity" runat="server"
                                                                                        ErrorMessage="Only Numbers allowed"
                                                                                        ValidationExpression="\d+">
                                                                                    </asp:RegularExpressionValidator>--%>
                                                                    </div>
                                                                    
                                                                </div>
                                                                <div class="col-xs-12">

                                                                    <div class="col-xs-4"><strong>Discount Amt:</strong><asp:TextBox class="form-control input-sm"  ID="txtBoxDiscountAmount" Text="0" runat="server"></asp:TextBox></div>
                                                                    
                                                                    <div class="col-xs-4"><strong>Discount Reason:</strong><asp:DropDownList class="form-control input-sm"  ID="ddlDiscountReason" runat="server">
                                                                                                                        <asp:ListItem>PrivilegeCard</asp:ListItem>
                                                                                                                        <asp:ListItem>RoyalMGMT</asp:ListItem>
                                                                                                                        <asp:ListItem>RoyalFamily</asp:ListItem>
                                                                                                                      </asp:DropDownList></div>
                                                                    <div class="col-xs-4"><strong>Discount Comments:</strong><asp:TextBox class="form-control input-sm"  ID="txtBoxDiscountDetails" Placeholder="PrvgCardNumber" runat="server"></asp:TextBox></div>
                                                                </div>
                                                                <div class="col-xs-12">
                                                                    <div class="col-xs-6"> <strong>FOLLOW UP :</strong> After <br /><asp:TextBox class="form-control input-sm" Text="0"   ID="txtBoxNextFollowup" runat="server"></asp:TextBox>Days</div>
                                                                    <div class="col-xs-6"><strong>CONSULTANT :</strong><asp:DropDownList class="form-control input-sm"   ID="ddlConsultantOneID" DataTextField="FullName" DataValueField="EmployeeID" runat="server"></asp:DropDownList>
                                                                       <%-- <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlConsultantOneID"
                                                                                            CssClass="text-danger" InitialValue="Select" ErrorMessage="* Please select consultant name" /><br />--%>
                                                                        <strong>Effort % :</strong><asp:TextBox class="form-control input-sm" ID="txtBoxConsultantOneEffort" Text="100" runat="server"></asp:TextBox>    
                                                                    </div>
                                                                </div>
                                                                <div class="col-xs-12">
                                                                    <div class="col-xs-6"><%--<strong>CONS-TWO :</strong>--%><asp:DropDownList class="form-control input-sm" Visible="false"   ID="ddlConsultantTwoID" DataTextField="FullName" DataValueField="EmployeeID" runat="server"></asp:DropDownList>
                                                                        <%--<strong>Effort % :</strong>--%><asp:TextBox class="form-control input-sm" Visible="false" ID="txtBoxConsultantTwoEffort" Text="0" runat="server"></asp:TextBox>
                                                                    </div>
                                                                    <div class="col-xs-6"><%--<strong>CONS-THREE :</strong>--%><asp:DropDownList class="form-control input-sm" Visible="false"   ID="ddlConsultantThreeID" DataTextField="FullName" DataValueField="EmployeeID" runat="server"></asp:DropDownList>
                                                                        <%--<strong>Effort % :</strong>--%><asp:TextBox class="form-control input-sm" ID="txtBoxConsultantThreeEffort" Visible="false" Text="0" runat="server"></asp:TextBox>
                                                                    </div> 
                                                                </div>
                                                                <%--<div class="col-xs-12">
                                                                    <div class="col-xs-12"><asp:LinkButton class="green bigger-140 show-details-btn" ID="lnkBtnKart" Text='<i class="ace-icon fa fa-shopping-cart"></i> CLICK TO ADD PRODUCTS' ToolTip="ShoppingKart" OnCommand="PerformMemberAccountTransaction"  CommandName="AddToKart" CommandArgument="" runat="server" /> </div>
                                                                       
                                                                 </div>
                                                                <div class="col-xs-12" style="background-color:lightblue;">
                                                                    <div class="col-xs-6"><strong>Product Used For Service :</strong><br />
                                                                        <asp:DropDownList ID="ddlUsedProductTitle" DataTextField="productTitle" DataValueField="inventoryID" runat="server"></asp:DropDownList>
                                                                        <asp:LinkButton  class="btn btn-xs btn-info" Text='<i class="ace-icon fa fa-plus fa-fw"></i> Add' OnCommand="UpdateServiceProductInventory" runat="server"></asp:LinkButton>
                                                                    </div>
                                                                    <div class="col-xs-6">
                                                                        <strong>Quantity :</strong><asp:TextBox ID="txtBoxUsedProductQuantity" runat="server"></asp:TextBox>
                                                                    </div>
                                                                </div>--%>
                                                                <div class="col-xs-12" style="margin-top:10px;">
                                                                     <asp:LinkButton ID="lnkBtnAddToInvoice"  class="btn btn-sm btn-warning" Text="Add To Bill" OnCommand="PerformMemberAccountTransaction" CommandName="DebitAccount" runat="server"></asp:LinkButton>
                                                                </div>
                                                            </div>
                                                        </div>
                                                  
												  
                                                </div>
                                                <!--Receive Payment body-->
												<div id="payment" class="tab-pane">
                                                    Account Balance :<asp:Label ID="lblServiceBalance" runat="server"></asp:Label>&nbsp&nbsp
                                                    <%--Product Balance :<asp:Label ID="lblProductBalance" runat="server"></asp:Label>
                                                    BonusWallet :<asp:Label ID="lblBonusWalletPoints" runat="server"></asp:Label>--%>
                                                    <div class="row">
                                                        <div class="col-sm-12">
                                                            <div class="col-xs-12 style=margin-5;">
                                                                <div class="col-xs-6"><strong>Amount</strong><asp:TextBox class="form-control input-sm"  ID="txtBoxCreditAmount" runat="server"></asp:TextBox></div>
                                                                    <%--<asp:RequiredFieldValidator runat="server" ControlToValidate="txtBoxCreditAmount"
                                                                            CssClass="text-danger" ErrorMessage="The email field is required." />--%>
                                                                <div class="col-xs-6"><strong>Mode Of Payment</strong><asp:DropDownList class="form-control input-sm" ID="ddlModeOfPayment" runat="server">
                                                                    <asp:ListItem>Cash</asp:ListItem>
                                                                    <asp:ListItem>Paytm</asp:ListItem>
                                                                    <asp:ListItem>Card</asp:ListItem>
                                                                    <asp:ListItem>Cheque</asp:ListItem>
                                                                    <asp:ListItem>NEFT</asp:ListItem>
                                                                    <asp:ListItem>BonusWallet</asp:ListItem>
                                                                    <asp:ListItem>Others</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </div>
                                                            </div>
                                                            <div class="col-xs-12 style=margin-5;">
                                                                <div class="col-xs-6"><strong>Location</strong><asp:DropDownList class="form-control input-sm"  ID="ddlPaymentLocation" DataTextField="OrganizationName" DataValueField="OrganizationID"  runat="server"></asp:DropDownList>
                                                                   <%-- <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlPaymentLocation"
                                                                                                CssClass="text-danger" InitialValue="Select" ErrorMessage="Please select Payment Location" />--%>
                                                                        
                                                                </div>
                                                                <div class="col-xs-6">
                                                                    <strong>The Amount is for: </strong><asp:DropDownList class="form-control input-sm" ID="ddlPaymentFor" runat="server">
                                                                                            <asp:ListItem>RECEIPT-PREV-BILL</asp:ListItem>
                                                                                            <asp:ListItem>RECEIPT-CURR-BILL</asp:ListItem>
                                                                                            <asp:ListItem>RECEIPT-MEMBERSHIP</asp:ListItem>
                                                                                    </asp:DropDownList>
                                                                </div>
                                                            </div>
                                                            
                                                            <div class="col-xs-12 style=margin-5;">
                                                                <div class="col-xs-6"><strong>ConfirmationString</strong><asp:TextBox class="form-control input-sm" Text=""  ID="txtBoxConfirmationCode" runat="server"></asp:TextBox></div>
                                                                <div class="col-xs-6 style=margin-5;"><asp:Button  class="btn btn-sm btn-info" Text="Received" OnCommand="PerformMemberAccountTransaction" CommandName="CreditAccount" runat="server" /></div>
                                                                 
                                                            </div>
                                                            
                                                            <div class="col-xs-12 style=margin-5;">
                                                              <div class="col-xs-4"><strong>CID For Online Pay :</strong><asp:TextBox ID="txtBoxorderID" class="form-control input-sm" runat="server"></asp:TextBox> </div>
                                                               <div class="col-xs-4"><strong>Online Payment</strong><asp:LinkButton ID="lnkBtnFTCash" class="btn btn-sm btn-warning" Text="<i class='fa fa-credit-card'> FT Cash</i>" ToolTip="Initiate FT Cash Payment" CommandName="OnlinePayment" CommandArgument="" OnCommand="PerformMemberAccountTransaction"  runat="server"></asp:LinkButton></div>
                                                               <div class="col-xs-4"><strong>Receive Feedback</strong><asp:LinkButton ID="lnkBtnReceiveRating" class="btn btn-sm btn-warning"  Text='<i class="fa fa-star"></i> Receive Rating' ToolTip="Take Custome Rating"    OnCommand="PerformMemberAccountTransaction" CommandName="ReceiveRating"  runat="server"></asp:LinkButton></div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--Reward Voucher body-->
												<div id="voucher" class="tab-pane">
                                                    <div id="tblGiveGiftVoucher" border="1"  style="margin-top:10px;background-color: #f1f1c1;" class="div div-striped">
                                                        <caption>Reward Customer Account with Gift Voucher</caption>
                                                              <div class="row">                                                                
                                                                    <div class="col-xs-12"><strong>Gift Voucher Amount</strong><asp:TextBox class="form-control input-sm" Text=""  ID="txtBoxGiftVoucherAmount" runat="server"></asp:TextBox></div>
                                                                    <div class="col-xs-12"><strong>Remarks/Gifted By</strong><asp:TextBox class="form-control input-sm" Text=""  ID="txtBoxVoucherComments" runat="server"></asp:TextBox></div>
                                                                    <div class="col-xs-12"><asp:Button  class="btn btn-sm btn-info" Text="Reward" OnCommand="PerformMemberAccountTransaction" CommandName="CreditGiftVoucher" runat="server" /> </div>
                                                                </div>
                                                           </div>
                                                 </div>
                                                <!----Learning Tokens--->
                                                <div id="tokens" class="tab-pane">
                                                    <div id="tblLearnigToken" border="1"  style="margin-top:10px;background-color: #f1f1c1;" class="div div-striped">
                                                        <caption>Grant Learning Access</caption>
                                                              <!--Assign Candidates-->
                                                                <div class="row">
                                                                    <asp:Panel ID="pnlAssignCandidates" runat="server">
                                                                        <%--<div class="col-sm-12">            
                                                                            <div class="col-sm-2">Test Name :</div> 
                                                                            <div class="col-sm-6"><asp:Label ID="lblTestTitle" Text="No Valid Test Title" CssClass="col-sm-6" runat="server"></asp:Label></div>
                                                                            <div class="col-sm-2">Test ID : </div>
                                                                            <div class="col-sm-2"><asp:Label ID="lblTestID" class="col-sm-6" Text="No Valid Test ID" runat="server"></asp:Label></div>
                                                                        </div>--%>
                                                                        
                                                                        <div class="col-sm-12 col-xs-12">
                                                                            <asp:LinkButton ID="lnkBtnImportAllCourses" class="orange bigger-120 show-details-btn" Text="<i class='ace-icon fa fa-history bigger-120'></i>" ToolTip="ResetAllTokens" OnCommand="ResetLearningTokens"     CommandName="" CommandArgument=""  runat="server"></asp:LinkButton>
                                                                            <asp:GridView ID="gvAssignCandidates" DataKeyNames="TokenId" OnRowDataBound="gvAssignCandidates_RowDataBound" OnRowCommand="gvAssignCandidates_RowCommand"  CssClass="table table-hover table-bordered" AlternatingRowStyle-BackColor="" HorizontalAlign="left" AutoGenerateColumns="false" BorderWidth="1" CellPadding="4" GridLines="both"                                            
                                                                                    BackColor="White" BorderColor="#3366CC" BorderStyle="None" AllowSorting="true"   AllowPaging="false"  PagerStyle-Mode="NumericPages" PageSize="100" RowStyle-HorizontalAlign="left" runat="server">                           
                                                                                    <RowStyle Font-Names="Arial" Font-Size="9pt" ForeColor="#003399" ></RowStyle>
                                                                                    <Columns>
                                                                                        <asp:TemplateField HeaderText="S">
                                                                                            <ItemTemplate>
                                                                                                <asp:LinkButton ID="lnkBtnSubscribe" class="green bigger-120 show-details-btn" Text="<i class='ace-icon fa fa-edit bigger-120'></i>" ToolTip="Register"      CommandName="YES" CommandArgument='<%# Eval("TokenID")%>'  runat="server"></asp:LinkButton>
                                                                                            </ItemTemplate>
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField HeaderText="U">
                                                                                            <ItemTemplate>
                                                                                                <asp:LinkButton ID="lnkBtnUnsubscribe" class="orange bigger-120 show-details-btn" Text="<i class='ace-icon fa fa-history bigger-120'></i>" ToolTip="Unregister"     CommandName="NO" CommandArgument='<%# Eval("TokenID")%>'  runat="server"></asp:LinkButton>
                                                                                            </ItemTemplate>
                                                                                        </asp:TemplateField>
                                                                                        <asp:BoundField DataField="CourseID"  HeaderText="ID"></asp:BoundField>
                                                                                        <asp:BoundField DataField="CourseTitle"  HeaderText="Name"></asp:BoundField>

                                                                                        <asp:BoundField DataField="StartDate" HeaderText="Start"></asp:BoundField>
                                                                                        <asp:BoundField DataField="EndDate" HeaderText="End"></asp:BoundField>
                                                                                        <asp:BoundField DataField="TokenStatus" HeaderText="Permission"></asp:BoundField>
                                                                                        <%--<asp:BoundField DataField="AttendanceStatus" HeaderText="Registration"></asp:BoundField>--%>                                                             
                                                                                        <%--<asp:TemplateField HeaderText="M">
                                                                                            <ItemTemplate>
                                                                                                <asp:LinkButton ID="lnkBtnDetails" class="orange bigger-120 show-details-btn" Text="<i class='ace-icon fa fa-angle-double-down bigger-120'></i>" ToolTip="Details"    CommandName="ViewProfile" CommandArgument='<%#Eval("EnquiryId")+";"+Eval("RaisedOn","{0:MMM/dd/yyyy}")  %>'  runat="server"></asp:LinkButton>
                                                                                            </ItemTemplate>
                                                                                        </asp:TemplateField>--%>                           
                                                                                    </Columns>
                                                                                    <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                                                                                    <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                                                                                    <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                                                                                    <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />                           
                                                                            </asp:GridView>
                                                                            </div>

                                                                    </asp:Panel>
                                                                </div>
                                                                <!--EnfAssignCandidates-->
                                                           </div>
                                                 </div>
                                                <!--End Learning Tokens-->
												
											</div>
										</div>  
									</div>
                              <!--/Bill/Payment/Voucher Body-->
						</div>
						</div>
                        <!--/Tabbed-->
                         
                        <!--Invoice-->
                        <div class="col-sm-5 col-sm-offset-1">
						    <div class="widget-box transparent">
                                <asp:DataList ID="dlMemberInvoice" runat="server">
                                    <ItemTemplate>
									    <div class="widget-header widget-header-large">
										    <h3 class="widget-title grey lighter">
										    <i class="ace-icon fa fa-files-o green"></i>
										    Invoice
									    </h3>
								    <div class="widget-toolbar no-border invoice-info">
									    <span class="invoice-info-label">Number:</span>
									    <asp:Label ID="lblTaxInvoiceNumber" class="red" Text='<%#Eval("TaxInvoiceNumber")%>' runat="server"></asp:Label>

									    <br />
									    <span class="invoice-info-label">Date:</span>
									    <asp:Label ID="lblInvoiceDate" class="blue" Text='<%#Eval("InvoiceDate")%>' runat="server"></asp:Label>
                                        <br />
									    <span class="invoice-info-label">Total:</span>
									    <asp:Label ID="Label2" class="red" Text='<%#Eval("SubTotal")%>' runat="server"></asp:Label>
                                        <br />
									    <span class="invoice-info-label">SAVING:</span>
									    <asp:Label ID="Label11" class="red" Text='<%#Eval("DiscountAmount")%>' runat="server"></asp:Label>
                                        <br />
									    <span class="invoice-info-label">CGST:</span>
									    <asp:Label ID="Label12" class="blue" Text='<%#Eval("CGSTAmount")%>' runat="server"></asp:Label>
                                        <br />
									    <span class="invoice-info-label">SGST:</span>
									    <asp:Label ID="Label13" class="blue" Text='<%#Eval("SGSTAmount")%>' runat="server"></asp:Label>
                                        <br />
									    <span class="invoice-info-label">Base Amt:</span>
									    <asp:Label ID="Label14" class="blue" Text='<%#Eval("BaseAmount")%>' runat="server"></asp:Label>
								    </div>

								    <div class="">
									    <asp:LinkButton ID="lnkBtnPrint" Text='<i class="ace-icon fa fa-print"></i> print' OnCommand="PrintInvoiceService" CommandArgument='<%#Eval("TaxInvoiceNumber")+";"+Eval("InvoiceDate")+";"+Eval("FullName") %>' runat="server"></asp:LinkButton><br /><br />
									    <asp:LinkButton ID="lnkBtnEmail" Text='<i class="ace-icon fa fa-envelope"></i> email' OnCommand="EmailInvoice" CommandArgument='<%#Eval("TaxInvoiceNumber")+";"+Eval("InvoiceDate")+";"+Eval("FullName")+";"+Eval("Email") %>' runat="server"></asp:LinkButton><br /><br />
                                        <asp:LinkButton ID="lnkBtnSms" Text='<i class="ace-icon fa fa-mobile"></i> sms' OnCommand="SMSInvoice" CommandArgument='<%#Eval("TaxInvoiceNumber") %>' runat="server"></asp:LinkButton><br /><br />
                                        <asp:LinkButton ID="LinkButton1" Text='<i class="ace-icon fa fa-inr"></i> NewInvoice' OnCommand="GenerateNewInvoiceNumber" CommandArgument='<%#Eval("MemberID") %>' runat="server"></asp:LinkButton>	
													
								    </div>
							    </div>
								    <div class="widget-body">
								    <div class="widget-main padding-24">
									    <div class="row">
										    <%--<div class="col-sm-8">
											    <div class="row">
												    <div class="col-xs-11 label label-lg label-info arrowed-in arrowed-right">
													    <b>SJA</b>
												    </div>
											    </div>
											    <div>
												    <ul class="list-unstyled spaced">
													    <li>
														    <i class="ace-icon fa fa-map-marker blue"></i>
                                                            <b class="blue"></b>
													    </li>
													    <li>
														    <i class="ace-icon fa fa-phone blue"></i>
                                                            <b class="red"></b>
													    </li>
													    <li>
														    <i class="ace-icon fa fa-envelope blue"></i> 
													    </li>
													    <li class="divider"></li>
												    </ul>
											    </div>
										    </div>--%><!-- /.col -->

										    <%--<div class="col-sm-4">
											    <div class="row">
												    <div class="col-xs-11 label label-lg label-success arrowed-in arrowed-right">
													    <b>Member Info</b>
												    </div>
											    </div>

											    <div>
												    <ul class="list-unstyled  spaced">
													    <li>
														    <i class="ace-icon fa fa-user green"></i><%#Eval("FullName") %>
													    
														    <i class="ace-icon fa fa-envelope green"></i><%#Eval("Email") %>
													    
														    <i class="ace-icon fa fa-phone green"></i><%#Eval("PhoneOne") %>
													    </li>

													    <li class="divider"></li>

																	
												    </ul>
											    </div>
										    </div>--%><!-- /.col -->
									    </div><!-- /.row -->
                                            </ItemTemplate>
                                </asp:DataList>

									    <div class="space"></div>
                                        <!--Invoice Items-->
									    <div>
                                            <!---Service Items-->
                                            <asp:GridView ID="gvInvoiceDetails" class="table table-striped table-bordered" AutoGenerateColumns="false" runat="server">
                                                <RowStyle Font-Names="Arial" Font-Size="8pt" ForeColor="#000000" ></RowStyle>
                                                    <Columns>
                                                        <asp:BoundField DataField="SkuTitle" HeaderText="Item"></asp:BoundField>
                                                        <asp:BoundField DataField="DiscountAmount" HeaderText="Disc"></asp:BoundField>
                                                        <asp:BoundField DataField="CGSTAmount" HeaderText="CGST"></asp:BoundField>
                                                        <asp:BoundField DataField="SGSTAmount" HeaderText="SGST"></asp:BoundField>
                                                        <asp:BoundField DataField="DebitAmount" HeaderText="Bill"></asp:BoundField>
                                                        <asp:BoundField DataField="CreditAmount" HeaderText="Paid"></asp:BoundField>
                                                    </Columns>
                                                <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                                                <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                                                <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />   
                                                <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" /> 
                                            </asp:GridView>
                                            <!--Product Items-->
                                            <%--<asp:GridView ID="gvInvoiceDetailsProduct" class="table table-striped table-bordered" AutoGenerateColumns="false" runat="server">
                                                         <RowStyle Font-Names="Arial" Font-Size="8pt" ForeColor="#000000" ></RowStyle>
                                                               <Columns>
                                                                    <asp:BoundField DataField="ProductTitle" HeaderText="Products"></asp:BoundField>
                                                                    <asp:BoundField DataField="DiscountAmount" HeaderText="Disc"></asp:BoundField>
                                                                    <asp:BoundField DataField="CGSTAmount" HeaderText="CGST"></asp:BoundField>
                                                                    <asp:BoundField DataField="SGSTAmount" HeaderText="SGST"></asp:BoundField>
                                                                    <asp:BoundField DataField="DebitAmount" HeaderText="Bill"></asp:BoundField>
                                                                    <asp:BoundField DataField="CreditAmount" HeaderText="Paid"></asp:BoundField>
                                                                </Columns>
                                                            <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                                                            <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                                                            <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />   
                                                            <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" /> 
                                              </asp:GridView>--%>
									    </div>

									    <div class="hr hr8 hr-double hr-dotted"></div>

									    <div class="space-6"></div>
									    <div class="well">
										    Thank you for choosing SJA
				                            We believe you will be satisfied by our services.
									    </div>
								    </div>
							    </div>
                        <!--/Invoice--> 
                    </div>

                      <!--Customer Info-->
                      <div class="col-xs-12">
                          <div class="space-6"></div> 
                            <div class="col-sm-8"> 
                             <strong>Member Tx</strong> &nbsp&nbsp ID:<asp:Label ID="lblCustId" Text="" runat="server"></asp:Label> 
                             <asp:DataList ID="dlMemberAccountTransaction" DataKeyField="MemberId"  runat="server">
                                <ItemTemplate>
                                <span class="fa fa-user green"></span><asp:Label Style="padding-right:10px;" ID="lblFirstName" Text='<%# Eval("FullName")+" "+Eval("Gender") %>' runat="server"></asp:Label>
                                
                               <span class="fa fa-phone green"></span> <asp:Label Style="padding-right:30px;" ID="lblPhoneOne" Text='<%#Eval("PhoneOne") %>' runat="server"></asp:Label>
                               <span class="fa fa-envelope green"></span> <asp:Label Style="padding-right:30px;" ID="lblEmail" Text='<%#Eval("Email") %>' runat="server"></asp:Label>                 
                               <span class="fa fa-certificate green"></span> <asp:Label Style="padding-right:30px;" ID="lblMembershipTitle" Text='<%#Eval("MembershipType") %>' runat="server"></asp:Label>
                              </ItemTemplate>                     
                             </asp:DataList>
                            </div>  
                            <div class="col-sm-4">
                                <asp:LinkButton ID="lnkBtnMiniTransaction" class="btn btn-sm btn-info" Text='<i class="fa fa-info"> Mini...</i>' OnCommand="DisplayMoreTransactions" CommandName="Last10" CommandArgument="10" runat="server"></asp:LinkButton>&nbsp&nbsp
                                <asp:LinkButton ID="lnkBtn100Transaction" class="btn btn-sm btn-info" Text='<span class="fa  fa-info"> 100 more...</span>' OnCommand="DisplayMoreTransactions" CommandName="Last100" CommandArgument="100" runat="server"></asp:LinkButton>&nbsp&nbsp
                                <asp:LinkButton ID="lnk200Transaction" class="btn btn-sm btn-info" Text='<i class="fa  fa-info"> 200 more...</i>' OnCommand="DisplayMoreTransactions" CommandName="Last200" CommandArgument="200" runat="server"></asp:LinkButton>
                            </div>
                        </div>
                      <!--/Customer Info-->
                      <!--Account Statement-->
                      <div class="col-xs-12">
                         <asp:GridView ID="dgMemberSkuStatement"  CssClass="table table-hover table-bordered" OnRowDataBound="dgMemberSkuStatement_RowDataBound" AlternatingItemStyle-BackColor="Silver" AutoGenerateColumns="false" CellPadding="4" GridLines="both"
                            AllowSorting="true" AllowPaging="false" PagerStyle-Mode="NumericPages" PageSize="30" ItemStyle-HorizontalAlign="left" runat="server">
                            <HeaderStyle Font-Names="Arial"   Font-Size="10pt" Font-Bold="false" BackColor="#333333" ForeColor="#FFFFFF" />
                             <RowStyle Font-Names="Arial" Font-Size="8pt" ForeColor="#000000" ></RowStyle>
                           <Columns>
                                <asp:BoundField DataField="custName" HeaderText="Name" Visible="false"></asp:BoundField>
                                <asp:BoundField DataField="TransactionID" HeaderText="TransactionID" Visible="false"></asp:BoundField>
                                <asp:BoundField DataField="SkuTitle" HeaderText="Item"></asp:BoundField>
                                <asp:BoundField DataField="consName" HeaderText="Counsultant"></asp:BoundField>
                                <asp:BoundField DataField="Notes" HeaderText="Remarks"></asp:BoundField>
                                <asp:BoundField DataField="TxDate" DataFormatString="{00:dd/MMM/yyyy}" HeaderText="Date"></asp:BoundField>
                                <asp:BoundField DataField="TxDate" DataFormatString="{0:t}" HeaderText="Time"></asp:BoundField>
                                
                                <asp:BoundField DataField="OfferedRate" HeaderText="Bill"></asp:BoundField>
                                <asp:BoundField DataField="DiscountAmount" HeaderText="Savings"></asp:BoundField>
                                <asp:BoundField DataField="DebitAmount" HeaderText="BillTotal"></asp:BoundField>
                                <asp:BoundField DataField="CreditAmount" HeaderText="Received"></asp:BoundField>
                                <asp:BoundField DataField="PaymentMode" HeaderText="Mode"></asp:BoundField>
                                <asp:BoundField DataField="DigitalPaymentRefCode" HeaderText="ConfStr"></asp:BoundField>
                                <asp:BoundField DataField="BalanceAmount" HeaderText="Balance"></asp:BoundField> 
                               
                               <asp:TemplateField HeaderText="Remove">
                                    <ItemTemplate>
                                        <%--<asp:LinkButton ID="lnkBtn_CancelItem" ToolTip="Remove From Invoice" Visible='<%# string.Equals(Eval("Notes").ToString(),"ItemAdded") %>'  Text='<i class="ace-icon fa fa-trash-o" style="font-size:18px;color:red"></i>'  CommandName="ReverseDebit" CommandArgument='<%# Eval("ServiceID") + ";" + Eval("DebitAmount")+ ";" + Eval("DiscountAmount") %>' OnCommand="PerformMemberAccountTransaction" runat="server" ></asp:LinkButton>--%>
                                        <asp:LinkButton ID="lnkBtn_CancelItem" ToolTip="Remove From Invoice" Text='<i class="ace-icon fa fa-trash-o" style="font-size:18px;color:red"></i>'  CommandName="ReverseDebit" CommandArgument='<%# Eval("TransactionID") + ";" + Eval("DebitAmount")+ ";" + Eval("DiscountAmount") %>' OnCommand="PerformMemberAccountTransaction" runat="server" ></asp:LinkButton>                          
                                    </ItemTemplate>
                                 </asp:TemplateField>
                               <%--<asp:TemplateField HeaderText="Delete">
                                    <ItemTemplate>
                                        <asp:LinkButton ToolTip="DeleteItem" Visible='<%# string.Equals(Eval("Notes").ToString(),"ItemAdded") %>'  Text='<i class="ace-icon fa fa-trash-o" style="font-size:18px;color:red"></i>'  CommandName="ReverseDebit" CommandArgument='<%# Eval("ServiceID") + ";" + Eval("DebitAmount")+ ";" + Eval("DiscountAmount") %>' OnCommand="PerformMemberAccountTransaction" runat="server" ></asp:LinkButton>                          
                                    </ItemTemplate>
                                 </asp:TemplateField> --%>
                            </Columns>
                                <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                                <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                                <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />   
                                <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />                           
                        </asp:GridView>
                        <asp:ImageButton ImageUrl="~/Images/Return.png" Height="30px" Width="30px" ToolTip="Return" OnCommand="ManagePnlVisibility"  CommandName="FromPnlMemberServiceStatementToPnlCustomers" runat="server" />&nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp
                      </div>
                      <!--/Account Statement-->
                </asp:Panel>
             </div>
     <!--End Billing-->

     <!-- Enquiries-->                  
           
     <!--end Enquiries-->
                        
           <div class="row">
               <div class="col-xs-12">
                 <!--Pannel To display Completed Fees-->
                  <asp:Panel ID="pnlCompletedSku"  ScrollBars="Vertical" runat="server">
                    <asp:Panel ID="pnlFilterFee"  runat="server">
                            <table class="table  table-bordered table-hover">
                            <tr>
                                <td><strong>Total:</strong></td>
                                <td><asp:Label class="name" ID="lblTotal" runat="server"></asp:Label></td>                              
                                <td><strong>Consultant:</strong></td>
                                <td><asp:DropDownList ID="ddlConsultant" DataTextField="FullName" DataValueField="EmployeeID" runat="server"></asp:DropDownList></td>                                
                                
                            </tr>
                            <tr>
                                <td><strong>From:</strong></td>
                                <td><asp:TextBox ID="txtBoxFromDate" Type="Date"   runat="server"></asp:TextBox></td>
                                <td><strong>To:</strong></td>
                                <td><asp:TextBox ID="txtBoxToDate" Type="Date"   runat="server"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td><asp:Button ID="btnFeeFilter" class="btn-sm btn-info"  Text="GO" OnCommand="DisplayStudentsReport" CommandArgument="FILTERSERV" runat="server" /></td>
                            </tr>
                          </table>                   
                        </asp:Panel>
                    <asp:Panel ID="pnlMyCompletedFees"  runat="server">
                            <fieldset class="login">
                        <legend>Completed Fees:<asp:Label ID="Label10" runat="server"></asp:Label></legend>
                        
                        <asp:DataGrid ID="dgCompletedFees" AlternatingItemStyle-BackColor="Silver" AutoGenerateColumns="false" CellPadding="4" GridLines="both" 
                            AllowSorting="true" AllowPaging="false" PagerStyle-Mode="NumericPages" PageSize="30" ItemStyle-HorizontalAlign="left" runat="server">
                            <HeaderStyle Font-Names="Arial" Font-Size="10pt" Font-Bold="false" BackColor="#333333" ForeColor="#FFFFFF" />
                            <ItemStyle Font-Names="Arial" Font-Size="8pt" ForeColor="#000000" />
                            <Columns>
                                <asp:BoundColumn DataField="SkuId" HeaderText="BillNumber"></asp:BoundColumn>                               
                                <asp:BoundColumn DataField="ConsultantName" HeaderText="Consultant"></asp:BoundColumn>
                                <%--<asp:BoundColumn DataField="Reference" HeaderText="ReferenceFrom" ></asp:BoundColumn>--%>
                                <asp:BoundColumn DataField="SkuTitle" HeaderText="Fee"></asp:BoundColumn>
                                <asp:BoundColumn DataField="FullName" HeaderText="StudentName"></asp:BoundColumn>
                                <asp:BoundColumn DataField="TxDate" HeaderText="Date"></asp:BoundColumn>
                                <asp:BoundColumn DataField="DebitAmount" HeaderText="Bill"></asp:BoundColumn>                                                               
                                                                                      
                            <asp:TemplateColumn HeaderText="Seek Feedback">                               
                                <ItemTemplate>
                                   <asp:ImageButton ImageUrl="~/Images/sms_icon.png"  Width ="30px" Height="30px" ID="btnSendSMS" Text="SendSMS" ToolTip="SendFeedbck" AlternateText="Seek Feedback" OnCommand="SendSmsToStudent" CommandArgument='<%#Eval("PhoneOne") + ";" + Eval("FullName")+";"+Eval("SkuId") %>' CommandName="UnicastStudentFeedback" runat="server" /></td>
                                </ItemTemplate>
                            </asp:TemplateColumn>
                            </Columns>                           
                        </asp:DataGrid>
                        <asp:ImageButton ImageUrl="~/Images/Return.png" Height="30px" Width="30px" ToolTip="Return" OnCommand="ManagePnlVisibility"  CommandName="FromPnlCompletedFeesToPnlStudents" runat="server" />&nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp
                    </fieldset>
                        </asp:Panel>
                </asp:Panel>
                </div>
           </div>
                       
           <div class="row">
               <div class="col-xs-12">
                <!--Pannel To display Sent Messages Trail-->
                  <asp:Panel ID="pnlSentMessageHistory" Class="span8" ScrollBars="Vertical" runat="server">
                    <fieldset class="login">
                        <legend>Message History:<asp:Label ID="Label8" runat="server"></asp:Label></legend>
                        <asp:DataGrid ID="dgSmsMsgHistory" AlternatingItemStyle-BackColor="Silver" AutoGenerateColumns="false" CellPadding="4" GridLines="None" 
                            AllowSorting="true" AllowPaging="false" PagerStyle-Mode="NumericPages" PageSize="30" ItemStyle-HorizontalAlign="left" runat="server">
                            <HeaderStyle Font-Names="Arial" Font-Size="10pt" Font-Bold="false" BackColor="#333333" ForeColor="#FFFFFF" />
                            <ItemStyle Font-Names="Arial" Font-Size="8pt" ForeColor="#000000" />
                            <Columns>                               
                                <asp:BoundColumn DataField="smsTo" HeaderText="Phone" SortExpression="Name"></asp:BoundColumn>
                                <asp:BoundColumn DataField="FullName" HeaderText="Name" SortExpression="Name"></asp:BoundColumn>
                                <asp:BoundColumn DataField="smsMsg" HeaderText="Message" SortExpression="Name"></asp:BoundColumn>
                                <asp:BoundColumn DataField="smsDate" DataFormatString="{00:dd/MMM/yyyy}" HeaderText="Sent Date"></asp:BoundColumn>                                                                                                                                             
                            </Columns>                           
                        </asp:DataGrid>

                        <asp:DataGrid ID="dgMailMsgHistory" AlternatingItemStyle-BackColor="Silver" AutoGenerateColumns="false" CellPadding="4" GridLines="None" 
                            AllowSorting="true" AllowPaging="false" PagerStyle-Mode="NumericPages" PageSize="30" ItemStyle-HorizontalAlign="left" runat="server">
                            <HeaderStyle Font-Names="Arial" Font-Size="10pt" Font-Bold="false" BackColor="#333333" ForeColor="#FFFFFF" />
                            <ItemStyle Font-Names="Arial" Font-Size="8pt" ForeColor="#000000" />
                            <Columns>  
                                <asp:BoundColumn DataField="mailTo" HeaderText="Email"></asp:BoundColumn>
                                <asp:BoundColumn DataField="FullName" HeaderText="Name" SortExpression="Name"></asp:BoundColumn>
                                <asp:BoundColumn DataField="mailMsg" HeaderText="Message"></asp:BoundColumn>
                                <asp:BoundColumn DataField="mailDate" DataFormatString="{00:dd/MMM/yyyy}" HeaderText="Sent Date" SortExpression="TxDate"></asp:BoundColumn>                                                                                                                 
                            </Columns>                           
                        </asp:DataGrid>
                        <asp:ImageButton ImageUrl="~/Images/Return.png" Height="30px" Width="30px" ToolTip="Return" OnCommand="ManagePnlVisibility"  CommandName="FromPnlMemberFeeStatementToPnlStudents" runat="server" />&nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp
                    </fieldset>
                </asp:Panel>
                </div>
           </div>
                       
           <div class="row">
               <div class="col-xs-12">
                 <!--Pannel to send FeeReminders-->
                  <asp:Panel ID="pnlSkuReminders" runat="server">
                    <table>
                        <tr>
                            <td><strong>Send Reminders :</strong></td>
                            <td><asp:ImageButton ID="btnSendReminders" ImageUrl="~/Images/reminder.png" OnCommand="SendFeeReminders" CommandName=""  Width="50px" runat="server" /></td>
                        </tr>
                    </table><br /><br />
                    <asp:GridView ID="gvFeeReminders" AlternatingRowStyle-BackColor="Silver" HorizontalAlign="left" AutoGenerateColumns="false" CellPadding="10" GridLines="both" 
                            AllowSorting="true"   AllowPaging="false"  PagerStyle-Mode="NumericPages" PageSize="100" RowStyle-HorizontalAlign="center" runat="server">
                            <HeaderStyle Font-Names="Arial"   Font-Size="10pt" Font-Bold="false" BackColor="#333333" ForeColor="#FFFFFF" />
                            <RowStyle Font-Names="Arial" Font-Size="8pt" ForeColor="#000000" ></RowStyle>
                            <Columns>                        
                                <asp:BoundField DataField="FeeReminderID" HeaderText="Reminder ID"></asp:BoundField>
                                <asp:BoundField DataField="SkuTitle" HeaderText="Fee"></asp:BoundField>
                                <asp:BoundField DataField="MemberName" HeaderText="Name"></asp:BoundField>
                                <asp:BoundField DataField="PhoneOne" HeaderText="Contact"></asp:BoundField>
                                <asp:BoundField DataField="Email" HeaderText="Email"></asp:BoundField>
                                <asp:BoundField DataField="PreviousTransactionDate" HeaderText="PreviousTransactionDate"></asp:BoundField>
                                <asp:BoundField DataField="FeeDueDate" HeaderText="DueDate"></asp:BoundField>
                                <asp:BoundField DataField="ReminderStatus" HeaderText="Reminder"></asp:BoundField>
                            </Columns>                           
                        </asp:GridView><br />
                </asp:Panel>
               </div>
           </div>

            <!--Membership Reminder-->  
         <div class="row">
               <div class="col-xs-12">
                 <!--Panel to send MembershipReminders-->
                  <asp:Panel ID="pnlMembershipReminders" runat="server">
                    <%--<table>
                        <tr>
                            <td><strong>Send Membership Reminders :</strong></td>
                            <td><asp:ImageButton ID="ImageButton1" ImageUrl="~/Images/reminder.png" OnCommand="SendMembershipReminders" CommandName="MEMBERSHIP"  Width="50px" runat="server" /></td>
                        </tr>
                    </table><br /><br />
                    <asp:GridView ID="gvMembershipReminders" CssClass="table table-hover table-bordered" AlternatingRowStyle-BackColor="Silver" HorizontalAlign="left" AutoGenerateColumns="false" CellPadding="10" GridLines="both" 
                            AllowSorting="true"   AllowPaging="false"  PagerStyle-Mode="NumericPages" PageSize="100" RowStyle-HorizontalAlign="center" runat="server">
                            <HeaderStyle Font-Names="Arial"   Font-Size="10pt" Font-Bold="false" BackColor="#333333" ForeColor="#FFFFFF" />
                            <RowStyle Font-Names="Arial" Font-Size="8pt" ForeColor="#000000" ></RowStyle>
                            <Columns>                        
                                 <asp:BoundField DataField="MemberId" HeaderText="ID"></asp:BoundField>
                                 <asp:BoundField DataField="FullName" HeaderText="Name"></asp:BoundField>
                                 <asp:BoundField DataField="PhoneOne" HeaderText="Contact"></asp:BoundField>
                                 <asp:BoundField DataField="Email" HeaderText="Email"></asp:BoundField>
                                 <asp:BoundField DataField="MembershipExpiringDate" HeaderText="ExpiryDate"></asp:BoundField>
                                 <asp:BoundField DataField="MembershipTitle" HeaderText="MembershipType"></asp:BoundField>
                               
                                <asp:BoundField DataField="ReminderStatus" HeaderText="Reminder"></asp:BoundField>
                            </Columns> 
                            <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                            <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                            <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                            <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />                            
                        </asp:GridView><br />--%>
                </asp:Panel>
               </div>
           </div>
         
    <!--Membership Reminder--> 

                       
           <div class="row">
               <div class="col-xs-12">
                 <!--Pannel to send Greetings-->
                   <asp:Panel ID="pnlGreetings" runat="server">
                    <table>
                        <tr>
                            <td><strong>BirthDayGreetings :</strong></td>
                            <td><asp:ImageButton ID="imgBtnGreetings" ImageUrl="~/Images/greetings.png" ToolTip="Send Greetings" OnCommand="SendGreetings" CommandArgument="" CommandName="BIRTHDAY"  Width="50px" runat="server" /></td>
                        </tr>
                    </table><br /><br />
                    <asp:GridView ID="gvGreetings" AlternatingRowStyle-BackColor="Silver" HorizontalAlign="left" AutoGenerateColumns="false" CellPadding="10" GridLines="both" 
                            AllowSorting="true"   AllowPaging="false"  PagerStyle-Mode="NumericPages" PageSize="100" RowStyle-HorizontalAlign="center" runat="server">
                            <HeaderStyle Font-Names="Arial"   Font-Size="10pt" Font-Bold="false" BackColor="#333333" ForeColor="#FFFFFF" />
                            <RowStyle Font-Names="Arial" Font-Size="8pt" ForeColor="#000000" ></RowStyle>
                            <Columns>                        
                                <asp:BoundField DataField="MemberID" HeaderText="ID"></asp:BoundField>
                                <asp:BoundField DataField="FullName" HeaderText="Name"></asp:BoundField>
                                <asp:BoundField DataField="PhoneOne" HeaderText="Contact"></asp:BoundField>
                                <asp:BoundField DataField="Email" HeaderText="Email"></asp:BoundField>
                                <asp:BoundField DataField="DateOfBirth" HeaderText="B'Date"></asp:BoundField>
                                <asp:BoundField DataField="Anniversary" HeaderText="Anniversary" Visible="false"></asp:BoundField>
                                
                            </Columns>                           
                        </asp:GridView><br />
                </asp:Panel>
               </div>
           </div>
</asp:Content>
