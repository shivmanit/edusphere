<%@ Page Title="" Language="C#" MasterPageFile="~/EduSpherePro/EduSpherePro.Master" AutoEventWireup="true" CodeBehind="OnlineTest.aspx.cs" Inherits="EduSpherePro.EduSpherePro.OnlineTest" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
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
                <asp:TextBox class="form-control search-query" ID="txtBoxSearch" Placeholder="Name or Phone" runat="server"></asp:TextBox>
                <span class="input-group-btn">
                    <asp:LinkButton ID="lnkBtnSerachCandidate" class="btn btn-purple btn-sm" Text="<span class='ace-icon fa fa-search icon-on-right bigger-110'></span> Search"  OnCommand="ManageTestPanelVisibility" CommandName="pnlAssignCandidates" CommandArgument="SearchCandidate" runat="server"></asp:LinkButton>
                </span> 
            </div>
        </div>
        <!--Page Buttons-->
        <div class="col-sm-4">
                    <div id="membersbar" class="navbar-buttons navbar-header pull-right" role="navigation">
					    <ul class="nav ace-nav">
						    <li class="light-blue dropdown-modal">
							    <a data-toggle="dropdown" href="#" class="dropdown-toggle">
                                    TestManagement <i class="ace-icon fa fa-caret-down"></i> 
							    </a>
							    <ul class="user-menu dropdown-menu-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">
                                    <li>
                                        <asp:LinkButton ID="lnkBtnCreateTest" class="btn btn-xs btn-warning"   OnCommand="ManageTestPanelVisibility" CommandName="pnlCreateTest" CommandArgument="" Text='<i class="ace-icon fa fa-file"></i> Create Quiz' runat="server"></asp:LinkButton>
								    </li>
								    <li class="divider"></li>
                                    <li>
									    <asp:LinkButton ID="lnkBtnEnrolForTest" class="btn btn-xs btn-info" Text="<span class='ace-icon fa fa-check icon-on-right bigger-110'></span> Assign Candidates" OnCommand="ManageTestPanelVisibility" CommandName="pnlAssignCandidates" runat="server"></asp:LinkButton>
								    </li>
                                    <li class="divider"></li>
                                    <li>
                                        <asp:LinkButton ID="lnkBtnTakeTest" class="btn btn-xs btn-info"  OnCommand="ManageTestPanelVisibility" CommandName="pnlTest" CommandArgument="" Text='<i class="ace-icon fa fa-clock-o"></i> Take Quiz' runat="server"></asp:LinkButton>
								    </li>
								    <li class="divider"></li>
                                    <li>
                                        <asp:LinkButton ID="lnkBtnViewTestResults" class="btn btn-xs btn-info"  OnCommand="ManageTestPanelVisibility" CommandName="pnlViewTestResults" CommandArgument="" Text='<i class="ace-icon fa fa-clock-o"></i> ViewResults' runat="server"></asp:LinkButton>
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

<!--Page Header-->
 <div class="row">
    <div class="col-sm-8" style="padding: 2px 2px 2px 2px; margin-top: 20px;">
        <%--<asp:Button ID="btnCreateTest" class="btn btn-1"  OnCommand="ManageTestPanelVisibility" CommandName="pnlCreateTest" Text="Create Test" runat="server" /><br /><br />--%>
        
        <%--<asp:Button ID="btnTakeTest" Visible="true" class="btn btn-1"  OnCommand="ManageTestPanelVisibility" CommandName="pnlTest" Text="Take Test" runat="server" />--%>
        
    </div>

    <div class="col-sm-10">
    <asp:Label ID="lblRole" Visible="false" runat="server"></asp:Label>
    <!---Create Question Paper-->
    <asp:Panel id="pnlCreateTest" Visible="false"  BorderWidth="1px"  runat="server">
        <table class="table  table-bordered table-hover">
            <tr>
                <th>CourseOne :</th>
                <td><asp:DropDownList ID="ddlTestSubjectOne" DataTextField="CourseTitle" DataValueField="CourseID"    runat="server"></asp:DropDownList></td>
                <th>CourseTwo :</th>
                <td><asp:DropDownList ID="ddlTestSubjectTwo" DataTextField="CourseTitle" DataValueField="CourseID"    runat="server"></asp:DropDownList></td>
            </tr>
            <tr>
                <th>CourseThree :</th>
                <td><asp:DropDownList ID="ddlTestSubjectThree" DataTextField="CourseTitle" DataValueField="CourseID"    runat="server"></asp:DropDownList></td>
                <th>CourseFour :</th>
                <td><asp:DropDownList ID="ddlTestSubjectFour" DataTextField="CourseTitle" DataValueField="CourseID"    runat="server"></asp:DropDownList></td>
               
            </tr>
            <tr>
                <th>Test Title :</th>
                <td><asp:TextBox class="col-sm-12" ID="txtBoxTestTitle" Placeholder="Test Name" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <th>Number of Questions</th>     
                <td><asp:TextBox Placeholder="25" ID="txtBoxNumberOfQuestions" runat="server"></asp:TextBox></td>
                <th>Duration in Minutes</th>     
                <td><asp:TextBox Placeholder="30" ID="txtBoxDuration" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <th>Exam Open Date</th>
                <td><asp:TextBox ID="txtBoxExamDateTime" Placeholder="Exam Date Time" TextMode="DateTimeLocal" runat="server"></asp:TextBox></td>
                <th>Exam Close Date</th>
                <td><asp:TextBox ID="txtBoxExamClosureDateTime" Placeholder="Exam Closing DateTime" TextMode="DateTimeLocal" runat="server"></asp:TextBox></td>    
            </tr>
        </table>
        <asp:LinkButton ID="lnkBtnCT" class="btn btn-xs btn-info"  OnCommand="CreateTestPaper" CommandName="" CommandArgument="ObjTest" Text='<i class="ace-icon fa fa-question-circle"></i> Generate Quiz' runat="server"></asp:LinkButton>
        <asp:DataList ID="dlObjTestPaper" AlternatingItemStyle-BackColor="silver"  Width="680px"  runat="server">
        <ItemTemplate>       
            <table width="680px"   cellspacing="1px" cellpadding="1px">               
            <tr>
                <td valign="top">Q<%#Eval("QuestionID")%>:</td>
                <td colspan="3"><asp:TextBox ID="txtBoxQuestion" TextMode="MultiLine" BorderWidth="0px"  Height="50px"   Width="480px" Text='<%#Eval("Question")%>' runat="server"></asp:TextBox></td>           
            </tr> 
            <tr>
                <td align="center">A.</td><td align="left"><%#Eval("OptionA")%></td>
                <td align="center">B.</td><td align="left"><%#Eval("OptionB")%></td>
            </tr>
            <tr>
                <td align="center">C.</td><td align="left"><%#Eval("OptionC")%></td>
                <td align="center">D.</td><td align="left"><%#Eval("OptionD")%></td>
            </tr>           
            <tr></tr><br />         
            </table>        
        </ItemTemplate>
        </asp:DataList>
    </asp:Panel>
  <!---End Create Question Paper---->
          
   <asp:Panel ID="pnlCandidate" Visible="true" runat="server">
      <table style="background-color: #f1f1c1;width:800px;">
          <tr>
              <th>Candidate Name :</th>
              <td><asp:TextBox ID="txtName" runat="server" ></asp:TextBox></td>
          </tr>
          <tr>
              <th>Course ID :</th>
              <td><asp:Label ID="lblCourseName"  runat="server"></asp:Label></td>
              <th>Course Title :</th>
              <td><asp:Label ID="lblCourseTitle"  runat="server"></asp:Label></td>
              </tr>
          <tr>
              <td></td>
              <td><asp:Button ID="btnStartExam" class="btn btn-1" runat="server" Text="Start" ToolTip="Start  Test" OnClick="StartTest" /></td>
              <td> <asp:TextBox ID="txtScore" runat="server" Visible="False" Width="63px">0</asp:TextBox></td>
          </tr>
        
   </table>
   </asp:Panel>
    

    <asp:Panel ID="pnlTest" runat="server" Visible="false" style="margin-top:50px;" BackColor="#E0E0E0" BorderColor="#E0E0E0" Height="264px"  Width="800px" ForeColor="#0000C0">
        
        <table class="tbl" width="800px">        
            <tr style="height:40px;">
            <td><asp:Label ID="lblName"  runat="server"  Text="Name : "  Width="300px"></asp:Label></td>
             
            <td><asp:Label ID="lblScore"  runat="server"   Text="Score : " Width="100px"></asp:Label></td>
            <td>Start Time: <asp:Label ID="lblTestStartTime"  Width="100px" runat="server"></asp:Label>
            <!--<asp:Panel ID="pnlTimer" runat="server" Visible="true" Height="14px" Width="119px">
                <span id="cd"  style ="left:100px;"></span>       
            </asp:Panel>--></td>
           
            <!--Test Code:Time control is used to update an UpdatePanel control. Here its put outside UpdatePanle its ID is used as trigger insied UpdatePanel-->
        
                <asp:ScriptManager ID= "SM1" runat="server"></asp:ScriptManager>
                <asp:Timer ID="timer1" runat="server" Interval="1000"  Enabled="true" OnTick="timer1_tick"></asp:Timer>             
            <td>
                <asp:UpdatePanel id="pnlTimeUpdate" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <asp:Label ID="lblTimer" Font-Size="Large" Width="200px" runat="server" ></asp:Label>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="timer1"  EventName="tick" />
                </Triggers>
                </asp:UpdatePanel>
            </td>
            </tr>
        </table>
       <hr style="elevation:lower;" />
       <asp:Panel ID="pnlQuestions" runat="server" Height="214px"  Width="696px">
            <asp:Label ID="lblQuestion" runat="server"  Text="Label" Width="682px"></asp:Label>
                
            <asp:RadioButtonList ID="RblOption" runat="server">
            </asp:RadioButtonList>
            <asp:Button ID="btnNextQ" runat="server" Text="Next" ToolTip="Click Here to Take Next Question" OnClick="DisplayNextQuestion" />
            <asp:Button ID="Finish" runat="server"  Text="Finish" ToolTip="Click Here to Finish The Test" Visible ="false" OnClick="Finish_Click" />
        </asp:Panel>
        <asp:Label ID="lblResult" runat="server" Visible ="false" Font-Bold ="true" Font-Size="Large" Text=""></asp:Label>
 </asp:Panel>
 
 
             </div>
         </div>

    <!--Assign Candidates-->
    <div class="row">
        <asp:Panel ID="pnlAssignCandidates" runat="server">
            <div class="col-sm-12">            
                <div class="col-sm-2">Test Name :</div> 
                <div class="col-sm-6"><asp:Label ID="lblTestTitle" Text="No Valid Test Title" CssClass="col-sm-6" runat="server"></asp:Label></div>
                <div class="col-sm-2">Test ID : </div>
                <div class="col-sm-2"><asp:Label ID="lblTestID" class="col-sm-6" Text="No Valid Test ID" runat="server"></asp:Label></div>
            </div>
            <div class="row">               
                <asp:GridView ID="gvAssignCandidates" DataKeyNames="RecordId" OnRowDataBound="gvAssignCandidates_RowDataBound" OnRowCommand="gvAssignCandidates_RowCommand"  CssClass="table table-hover table-bordered" AlternatingRowStyle-BackColor="" HorizontalAlign="left" AutoGenerateColumns="false" BorderWidth="1" CellPadding="4" GridLines="both"                                            
                        BackColor="White" BorderColor="#3366CC" BorderStyle="None" AllowSorting="true"   AllowPaging="false"  PagerStyle-Mode="NumericPages" PageSize="100" RowStyle-HorizontalAlign="left" runat="server">                           
                        <RowStyle Font-Names="Arial" Font-Size="9pt" ForeColor="#003399" ></RowStyle>
                        <Columns>
                            <asp:TemplateField HeaderText="S">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkBtnSubscribe" class="green bigger-120 show-details-btn" Text="<i class='ace-icon fa fa-edit bigger-120'></i>" ToolTip="Register"     CommandName="SUBSCRIBED" CommandArgument='<%# Eval("RecordID")%>'  runat="server"></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="U">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkBtnUnsubscribe" class="orange bigger-120 show-details-btn" Text="<i class='ace-icon fa fa-history bigger-120'></i>" ToolTip="Unregister"     CommandName="UNSUBSCRIBED" CommandArgument='<%# Eval("RecordID")%>'  runat="server"></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="MemberID"  HeaderText="ID"></asp:BoundField>
                            <asp:BoundField DataField="FullName"  HeaderText="Name"></asp:BoundField>
                            <asp:BoundField DataField="MembershipType" HeaderText="Type"></asp:BoundField>
                            <asp:BoundField DataField="PhoneOne" HeaderText="Phone"></asp:BoundField>
                            <asp:BoundField DataField="Email" HeaderText="Email"></asp:BoundField>
                            <asp:BoundField DataField="AttendanceStatus" HeaderText="Registration"></asp:BoundField>                                                             
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

    <!--View Test Results-->
    <div class="row">
        <asp:Panel ID="pnlViewTestResults" runat="server">
            <div class="col-sm-12">            
                <div class="col-sm-2">Test Name :</div> 
                <div class="col-sm-6"><asp:DropDownList ID="ddlTestList" DataTextField="TestTitle" DataValueField="TestID" AutoPostBack="true" OnSelectedIndexChanged="ddlTestList_SelectedIndexChanged" CssClass="col-sm-6" runat="server"></asp:DropDownList></div>
              <%--<div class="col-sm-2">Download </div>--%>
                <div class="col-sm-2"><asp:ImageButton ImageUrl="~/Images/excelExport.png" Height="30px" Width="30px" ToolTip="ExportToExcel" OnCommand="DownloadTestResults" CommandName="" CommandArgument="" runat="server" /></div>
            </div>
            <div class="row">               
                <asp:GridView ID="gvTestResults" DataKeyNames="OnlineTestRecordID" OnRowDataBound="gvTestResults_RowDataBound" OnRowCommand="gvTestResults_RowCommand"  CssClass="table table-hover table-bordered" AlternatingRowStyle-BackColor="" HorizontalAlign="left" AutoGenerateColumns="false" BorderWidth="1" CellPadding="4" GridLines="both"                                            
                        BackColor="White" BorderColor="#3366CC" BorderStyle="None" AllowSorting="true"   AllowPaging="false"  PagerStyle-Mode="NumericPages" PageSize="100" RowStyle-HorizontalAlign="left" runat="server">                           
                        <RowStyle Font-Names="Arial" Font-Size="9pt" ForeColor="#003399" ></RowStyle>
                        <Columns>
                            <%--<asp:TemplateField HeaderText="S">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkBtnSubscribe" class="green bigger-120 show-details-btn" Text="<i class='ace-icon fa fa-edit bigger-120'></i>" ToolTip="Register"     CommandName="SUBSCRIBED" CommandArgument='<%# Eval("RecordID")%>'  runat="server"></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="U">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkBtnUnsubscribe" class="orange bigger-120 show-details-btn" Text="<i class='ace-icon fa fa-history bigger-120'></i>" ToolTip="Unregister"     CommandName="UNSUBSCRIBED" CommandArgument='<%# Eval("RecordID")%>'  runat="server"></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>--%>
                            <asp:BoundField DataField="CandidateID"  HeaderText="ID"></asp:BoundField>
                            <asp:BoundField DataField="FullName"  HeaderText="Name"></asp:BoundField>
                            <asp:BoundField DataField="TestID"  HeaderText="TestID"></asp:BoundField>
                            <asp:BoundField DataField="Score" HeaderText="Score"></asp:BoundField>
                            <asp:BoundField DataField="MaxMarks" HeaderText="Max Marks"></asp:BoundField>
                            <asp:BoundField DataField="PercentageMarks" HeaderText="%"></asp:BoundField>
                            <asp:BoundField DataField="TestDate" HeaderText="Test Take On"></asp:BoundField>
                            <asp:BoundField DataField="TimeTaken" HeaderText="DurationMnts"></asp:BoundField>                                                             
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

</asp:Content>
