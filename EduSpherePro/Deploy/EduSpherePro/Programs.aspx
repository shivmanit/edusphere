<%@ Page Title="" Language="C#" MasterPageFile="~/EduSpherePro/EduSpherePro.Master" AutoEventWireup="true" CodeBehind="Programs.aspx.cs" Inherits="EduSpherePro.EduSpherePro.Programs" %>
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
			          <asp:Label ID="lblProgramAction" Text="Programs / Courses" runat="server"></asp:Label>
	               </h4>
	              <div class="hr hr-18 dotted hr-double"></div>
               </div>
               <div class="col-sm-4">
                    <div id="membersbar" class="navbar-buttons navbar-header pull-right" role="navigation">
					    <ul class="nav ace-nav">
						    <li class="light-blue dropdown-modal">
							    <a data-toggle="dropdown" href="#" class="dropdown-toggle">
                                    Programs <i class="ace-icon fa fa-caret-down"></i> 
							    </a>
							    <ul class="user-menu dropdown-menu-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">
						            <li>
                                        <asp:LinkButton ID="lnkBtnViewPrograms"   OnCommand="ManageVisibility" CommandName="ViewPrograms" CommandArgument="" Text='<i class="ace-icon fa fa-eye fa-fw"></i> Programs' runat="server"></asp:LinkButton>
								    </li>
								    <li class="divider"></li>
								    <li>
									    <asp:LinkButton ID="lnkBtnViewCourses"    OnCommand="ManageVisibility" CommandName="ViewCourses" CommandArgument="" Text='<i class="ace-icon fa fa-eye"></i> Courses/Subjects' runat="server"></asp:LinkButton>
								    </li>
                                    <li class="divider"></li>
								    <li>
									    <asp:LinkButton ID="lnkBtnLearningContent"  OnCommand="ManageVisibility" CommandName="AddLearning" Text='<i class="ace-icon fa fa-plus"></i> Learning Resources' runat="server"></asp:LinkButton>
								    </li>
                                    <li class="divider"></li>
                                    <li>
									    <asp:LinkButton ID="lnkBtnBatches"  OnCommand="ManageVisibility" CommandName="AddBatch" Text='<i class="ace-icon fa fa-eye"></i> Batches' runat="server"></asp:LinkButton>
								    </li>
                                    <li class="divider"></li>
                                    <li>
									    <asp:LinkButton ID="lnkBtnAssessments"  OnCommand="ManageVisibility" CommandName="ViewAssessments" Text='<i class="ace-icon fa fa-eye"></i>  Assessments' runat="server"></asp:LinkButton>
								    </li>
                                    <li class="divider"></li>
                                    <li>
									    <asp:LinkButton ID="lnkBtnStudentAttendance"  OnCommand="ManageVisibility" CommandName="StudentAttendance" Text='<i class="ace-icon fa fa-signal"></i> Student Attendance' runat="server"></asp:LinkButton>
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
   
          
   <!--View Programs/Add New Programs-->         
   <div class="row">
            <div class="col-xs-12">  
              <asp:Panel ID="pnlPrograms"  ScrollBars="Auto"   runat="server">
                 <!--Tabbed-->
                <div class="col-sm-6 widget-container-col" id="widget-container-col-10">
                    <div class="widget-box" id="widget-box-10">
                       <div class="widget-header widget-header-small">
						    <h5 class="widget-title smaller">Program Management</h5>
						    <div class="widget-toolbar no-border">
							    <ul class="nav nav-tabs" id="myTab">
								    <li class="active">
									    <a data-toggle="tab" href="#programs">Programs</a>
								    </li>
								    <li>
									    <a data-toggle="tab" href="#addnewprogram">Add Program</a>
								    </li>
							    </ul>
						    </div>
					    </div>

                       <!--Tab Body-->
					    <div class="widget-body">
                            <div class="widget-main padding-6">
								<div class="tab-content">
                                    <div id="programs" class="tab-pane in active">
                                        <div class="row">
                                            <asp:GridView ID="gvPrograms" OnRowCommand="gvPrograms_RowCommand" CssClass="table table-hover table-bordered" AlternatingRowStyle-BackColor="Silver" HorizontalAlign="left" AutoGenerateColumns="false" BorderWidth="1" CellPadding="4" GridLines="both" 
                                               BackColor="White" BorderColor="#3366CC" BorderStyle="None" AllowSorting="true"   AllowPaging="false"  PagerStyle-Mode="NumericPages" PageSize="100" RowStyle-HorizontalAlign="left" runat="server">
                           
                                                <RowStyle Font-Names="Arial" Font-Size="10pt" ForeColor="#003399" ></RowStyle>
                                                <Columns>
                                                    <asp:BoundField DataField="ProgramID" HeaderText="ID"></asp:BoundField>
                                                    <asp:BoundField DataField="ProgramTitle" HeaderText="Title"></asp:BoundField>
                                                    <asp:BoundField DataField="ProgramDescription" HeaderText="Program Description"></asp:BoundField>
                                                    <asp:BoundField DataField="ProgramVision" HeaderText="Vision"></asp:BoundField>                                 
                                                    <asp:BoundField DataField="ProgramMission" HeaderText="Mission"></asp:BoundField>
                                                    <asp:TemplateField HeaderText="Courses">
                                                        <ItemTemplate>
                                                         <asp:LinkButton ID="lnkBtnViewProgramCourses"    CommandName="ViewCourses" CommandArgument='<%#Eval("ProgramID") %>' Text="<i class='ace-icon fa fa-angle-double-down bigger-120'></i>" runat="server"></asp:LinkButton>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                                <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                                                <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                                                <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                                                <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />                           
                                        </asp:GridView>
                                          </div>
                                    </div>
                                    <div id="addnewprogram" class="tab-pane">
                                         <!--Add new Program-->
                                        <div class="row">
                                          <table class="table  table-bordered table-hover">
                                             <caption style="font-style:italic; font-size:15px; color:Green;">To add new Program, Enter details below and Submit</caption>
                                                <tr>
                                                    <th>ProgramTitle</th>
                                                     <th>Description</th>
                                                </tr>
                                                <tr>
                                                     <td><asp:TextBox ID="txtBoxProgTitle" runat="server"></asp:TextBox></td>
                                                     <td><asp:TextBox ID="txtBoxProgDescription" runat="server"></asp:TextBox> </td>
                                                </tr>
                                                <tr>
                                                     <th>Vision</th> 
                                                     <th>Mission</th> 
                                                </tr>
                                                <tr>
                                                    <td><asp:TextBox ID="txtBoxProgVision" TextMode="Multiline" runat="server"></asp:TextBox></td>
                                                    <td><asp:TextBox ID="txtBoxProgMission" TextMode="Multiline" runat="server"></asp:TextBox></td>
                                                </tr>
                                                <tr>
                                                    <td><asp:ImageButton ID="ImageButton5"  ImageUrl="~/Images/Return.png" Width="20px" Height="20px"  ToolTip="Return" OnCommand="ReturnToPanel" CommandName="FromPnlCoToPnlCourses" runat="server" /></td>
                                                    <td><asp:Button ID="brnSubmitProg" class="btn btn-xs btn-info"  Text="Submit" OnClick="AddProgram" runat="server" /></td>
                                                </tr>
                                             </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                  </div>
                    
                </div>
                <!--End Tabbed-->
                 <div class="col-sm-4">
                      <asp:GridView ID="gvProgramCourses" OnRowCommand="gvPrograms_RowCommand" CssClass="table table-hover table-bordered" AlternatingRowStyle-BackColor="Silver" HorizontalAlign="left" AutoGenerateColumns="false" BorderWidth="1px" CellPadding="4" GridLines="both" 
                           BackColor="White" BorderColor="#3366CC" BorderStyle="None" AllowSorting="true"   AllowPaging="false"  PagerStyle-Mode="NumericPages" PageSize="100" RowStyle-HorizontalAlign="left" runat="server">
                           
                            <RowStyle Font-Names="Arial" Font-Size="10pt" ForeColor="#003399" ></RowStyle>
                            <Columns>
                                <asp:BoundField DataField="CourseID" HeaderText="ID"></asp:BoundField>
                                <asp:BoundField DataField="CourseTitle" HeaderText="Course/Subect/Module"></asp:BoundField>
                                <asp:BoundField DataField="CourseDescription" HeaderText="Description"></asp:BoundField>
                                
                            </Columns>
                            <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                            <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                            <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                            <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />                           
                    </asp:GridView>
                   </div>
                </asp:Panel>
           </div>
   </div>
    <!--End View Programs/Add New Programs-->
  
    <!--View /Create New Batch-->
     <div class="row">
            <div class="col-xs-12">  
              <asp:Panel ID="pnlProgramBatches"  ScrollBars="Auto"   runat="server">
                 <!--Tabbed-->
                <div class="col-sm-6 widget-container-col" id="widget-container-col-10">
                    <div class="widget-box" id="widget-box-10">
                       <div class="widget-header widget-header-small">
						    <h5 class="widget-title smaller">Batch Management</h5>
						    <div class="widget-toolbar no-border">
							    <ul class="nav nav-tabs" id="myTab">
								    <li class="active">
									    <a data-toggle="tab" href="#batches">Batches</a>
								    </li>
								    <li>
									    <a data-toggle="tab" href="#createbatch">Create Batch</a>
								    </li>
							    </ul>
						    </div>
					    </div>

                       <!--Tab Body-->
					    <div class="widget-body">
                            <div class="widget-main padding-6">
								<div class="tab-content">
                                    <div id="batches" class="tab-pane in active">
                                        <div class="row">
                                             <asp:GridView ID="gvProgramBatches" OnRowCommand="gvProgramBatches_RowCommand" CssClass="table table-hover table-bordered" AlternatingRowStyle-BackColor="Silver" HorizontalAlign="left" AutoGenerateColumns="false" BorderWidth="1" CellPadding="4" GridLines="both" 
                                               BackColor="White" BorderColor="#3366CC" BorderStyle="None" AllowSorting="true"   AllowPaging="false"  PagerStyle-Mode="NumericPages" PageSize="100" RowStyle-HorizontalAlign="left" runat="server">
                           
                                                <RowStyle Font-Names="Arial" Font-Size="10pt" ForeColor="#003399" ></RowStyle>
                                                <Columns>
                                                    <asp:BoundField DataField="BatchID" HeaderText="ID"></asp:BoundField>
                                                    <asp:BoundField DataField="BatchCode" HeaderText="BatchCode"></asp:BoundField>
                                                    <asp:BoundField DataField="ProgramTitle" HeaderText="Program"></asp:BoundField>
                                                    <asp:BoundField DataField="StartDate" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Start"></asp:BoundField>                                 
                                                    <asp:BoundField DataField="EndDate" DataFormatString="{0:dd/MM/yyyy}" HeaderText="End"></asp:BoundField>
                                                    <asp:TemplateField HeaderText="Students">
                                                        <ItemTemplate>
                                                         <asp:LinkButton ID="lnkBtnViewStudents"    CommandName="StudentList" CommandArgument='<%#Eval("BatchID") %>' Text="<i class='ace-icon fa fa-graduation-cap bigger-120'></i>" runat="server"></asp:LinkButton>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Schedule">
                                                        <ItemTemplate>
                                                         <asp:LinkButton ID="lnkBtnViewSchedule"    CommandName="BatchSchedule" CommandArgument='<%#Eval("BatchID") %>' Text="<i class='ace-icon fa fa-calendar-o bigger-120'></i>" runat="server"></asp:LinkButton>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                                <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                                                <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                                                <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                                                <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />                           
                                        </asp:GridView>
                                        </div>
                                    </div>
                                    <div id="createbatch" class="tab-pane">
                                         <!--Create new Batch-->
                                        <div class="row">
                                            <table class="table  table-bordered table-hover">
                                             <caption style="font-style:italic; font-size:15px; color:Green;">To add new Program, Enter details below and Submit</caption>
                                                <tr>
                                                    <th>Program</th>
                                                    <th>BatchCode</th>
                                                </tr>
                                                <tr>
                                                     <td><asp:DropDownList ID="ddlProgramID" DataTextField="ProgramTitle" DataValueField="ProgramID" runat="server"></asp:DropDownList></td>
                                                     <td><asp:TextBox ID="txtBoxBatchCode" Text="UniqueBatchCode" runat="server"></asp:TextBox> </td>
                                                </tr>
                                                <tr>
                                                     <th>StartDate</th> 
                                                     <th>EndDate</th> 
                                                </tr>
                                                <tr>
                                                    <td><asp:TextBox ID="txtBoxBatchStartDate" TextMode="Date" runat="server"></asp:TextBox></td>
                                                    <td><asp:TextBox ID="txtBoxBatchEndDate" TextMode="Date" runat="server"></asp:TextBox></td>
                                                </tr>
                                                <tr>
                                                    <td><asp:ImageButton ID="ImageButton4"  ImageUrl="~/Images/Return.png" Width="20px" Height="20px"  ToolTip="Return" OnCommand="ManageVisibility" CommandName="ReturnToPrograms" runat="server" /></td>
                                                    <td><asp:LinkButton ID="Button1" class="btn btn-xs btn-info"  Text="Submit" OnClick="CreateNewBatch" runat="server" /></td>
                                                </tr>
                                             </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                      
                  </div>
                    
                </div>
                <!--End Tabbed-->
                  <!--Extended View- Schedule/Students-->
                 <div class="col-sm-4">
                     <h3 class="pink"><asp:Label ID="lblBatchID" Visible="true" runat="server"></asp:Label></h3>
                      <asp:GridView ID="gvBatchSchedule"  DataKeyNames="DayID" OnRowCommand="gvBatchSchedule_RowCommand"  CssClass="table table-hover table-bordered" AlternatingRowStyle-BackColor="Silver" HorizontalAlign="left" AutoGenerateColumns="false" BorderWidth="1px" CellPadding="4" GridLines="both" 
                           OnRowEditing="gvEditBatchSchedule" OnRowCancelingEdit="gvCancelBatchSchedule" OnRowUpdating="gvUpdateBatchSchedule"
                          onrowdatabound="gvBatchSchedule_RowDataBound"
                          BackColor="White" BorderColor="#3366CC" BorderStyle="None" AllowSorting="true"   AllowPaging="false"  PagerStyle-Mode="NumericPages" PageSize="100" RowStyle-HorizontalAlign="left" runat="server">
                           <RowStyle Font-Names="Arial" Font-Size="10pt" ForeColor="#003399" ></RowStyle>
                            <Columns>
                                <asp:CommandField ShowEditButton="true" />
                                <asp:BoundField  DataField="SessionDate" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Date" ReadOnly="true"></asp:BoundField>
                                <asp:BoundField DataField="SessionDay" HeaderText="Day" ReadOnly="true"></asp:BoundField>
                                <asp:BoundField DataField="SessionTime" HeaderText="Time"></asp:BoundField>
                                 <asp:TemplateField HeaderText="Course Title">
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="ddlEditCourseID" runat="server" 
                                            DataTextField="CourseTitle" DataValueField="CourseID">
                                        </asp:DropDownList>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblCourseTitle" runat="server" Text='<%# Bind("CourseTitle") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="SessionTitle" HeaderText="Topic"></asp:BoundField>
                                <asp:BoundField DataField="SessionDetails" HeaderText="TopicDetails"></asp:BoundField>
                            </Columns>
                            <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                            <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                            <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                            <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />                           
                    </asp:GridView>
                     <!--Batch Students-->
                     <asp:GridView ID="gvStudentsList" OnRowCommand="gvStudentsList_RowCommand" CssClass="table table-hover table-bordered" AlternatingRowStyle-BackColor="Silver" HorizontalAlign="left" AutoGenerateColumns="false" BorderWidth="1px" CellPadding="4" GridLines="both" 
                           BackColor="White" BorderColor="#3366CC" BorderStyle="None" AllowSorting="true"   AllowPaging="false"  PagerStyle-Mode="NumericPages" PageSize="100" RowStyle-HorizontalAlign="left" runat="server">
                           <RowStyle Font-Names="Arial" Font-Size="10pt" ForeColor="#003399" ></RowStyle>
                            <Columns>
                                <asp:BoundField DataField="FullName" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Date"></asp:BoundField>
                                <asp:BoundField DataField="PhoneOne" HeaderText="Day"></asp:BoundField>
                                <asp:BoundField DataField="Email" HeaderText="Time"></asp:BoundField>
                                
                            </Columns>
                            <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                            <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                            <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                            <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />                           
                    </asp:GridView>
                     <!--End Batch Students-->
                   </div>
                  <!--End Extended View- Scheudle/Students-->
                </asp:Panel>
           </div>
   </div>
    <!--End Ciew/Create New Batch-->   
    
    <!--View/Create New Assessment-->
     <div class="row">
            <div class="col-xs-12">  
              <asp:Panel ID="pnlAssessments"  ScrollBars="Auto"   runat="server">
                  <div class="col-xs-12">
                      Batch Code :<asp:DropDownList ID="ddlAssessmentBatchFilter" DataTextField="BatchCode" DataValueField="BatchID" OnSelectedIndexChanged="AssessmentBatchFilter_IndexChanged" AutoPostBack="true" runat="server"></asp:DropDownList>
                  </div>
                 <!--Tabbed Assessments-->
                <div class="col-sm-8 widget-container-col" id="widget-container-col-10">
                    <div class="widget-box" id="widget-box-10">
                       <div class="widget-header widget-header-small">
						    <h5 class="widget-title smaller">Assessments for Course/Batch</h5>
						    <div class="widget-toolbar no-border">
							    <ul class="nav nav-tabs" id="myTab">
								    <li class="active">
									    <a data-toggle="tab" href="#assessments">Assessments</a>
								    </li>
								    <li>
									    <a data-toggle="tab" href="#createassessment">Create Assessment</a>
								    </li>
							    </ul>
						    </div>
					    </div>

                       <!--Tab Body Assessments-->
					    <div class="widget-body">
                            <div class="widget-main padding-6">
								<div class="tab-content">
                                    <div id="assessments" class="tab-pane in active">
                                        <div class="row">
                                            <asp:GridView ID="gvAssessments" OnRowCommand="gvAssessments_RowCommand" CssClass="table table-hover table-bordered" AlternatingRowStyle-BackColor="Silver" HorizontalAlign="left" AutoGenerateColumns="false" BorderWidth="1" CellPadding="4" GridLines="both" 
                                               BackColor="White" BorderColor="#3366CC" BorderStyle="None" AllowSorting="true"   AllowPaging="false"  PagerStyle-Mode="NumericPages" PageSize="100" RowStyle-HorizontalAlign="left" runat="server">
                           
                                                <RowStyle Font-Names="Arial" Font-Size="10pt" ForeColor="#003399" ></RowStyle>
                                                <Columns>
                                                    <asp:BoundField DataField="AssessmentID" HeaderText="ID"></asp:BoundField>
                                                    <asp:BoundField DataField="AssessmentCode" HeaderText="Assessment Code"></asp:BoundField>
                                                    <asp:BoundField DataField="AssessmentTitle" HeaderText="Assessment Title"></asp:BoundField>
                                                    <asp:BoundField DataField="CourseTitle" HeaderText="Course"></asp:BoundField>
                                                    <asp:BoundField DataField="BatchCode" HeaderText="Student Batch"></asp:BoundField>                                  
                                                    <asp:BoundField DataField="AssessmentDate" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Exam Date"></asp:BoundField>
                                                    <asp:BoundField DataField="TotalMarks" HeaderText="Total Marks"></asp:BoundField>
                                                    <asp:BoundField DataField="PassingMarks" HeaderText="To Pass"></asp:BoundField>
                                                    <asp:TemplateField HeaderText="Result">
                                                        <ItemTemplate>
                                                         <asp:LinkButton ID="lnkBtnViewStudentAssessment"    CommandName="StudentAssessment" CommandArgument='<%#Eval("AssessmentID")+";"+Eval("TotalMarks")+";"+Eval("PassingMarks") %>' Text="<i class='ace-icon fa fa-graduation-cap bigger-120'></i>" runat="server"></asp:LinkButton>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    
                                                </Columns>
                                                <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                                                <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                                                <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                                                <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />                           
                                        </asp:GridView>
                                        </div>
                                    </div>
                                    <div id="createassessment" class="tab-pane">
                                         <div class="row">
                                            <!--Create new Assessment-->
                                            <h3 class="pink">Create new Assessment on Course for a Batch</h3>
                                            <table class="table  table-bordered table-hover">
                                                <tr>
                                                    <th>Course</th>
                                                    <th>Batch</th>
                                                </tr>
                                                <tr>
                                                     <td><asp:DropDownList ID="ddlAssessmentCourse" DataTextField="CourseTitle" DataValueField="CourseID" runat="server"></asp:DropDownList></td>
                                                     <td><asp:DropDownList ID="ddlAssessmentBatch" DataTextField="BatchCode" DataValueField="BatchID" runat="server"></asp:DropDownList></td>
                                                </tr>
                                                <tr>
                                                     <th>Assessment Code</th> 
                                                     <th>AssessmentTitle</th> 
                                                </tr>
                                                <tr>
                                                    <td><asp:TextBox ID="txtBoxAssessmentCode"  runat="server"></asp:TextBox></td>
                                                    <td><asp:TextBox ID="txtBoxAssessmentTitle"  runat="server"></asp:TextBox></td>
                                                </tr>
                                                <tr>
                                                     <th>Assessment Description</th> 
                                                     <th>Assessment Date</th> 
                                                </tr>
                                                <tr>
                                                    <td><asp:TextBox ID="txtBoxAssessmentDescription"  runat="server"></asp:TextBox></td>
                                                    <td><asp:TextBox ID="txtBoxAssessmentDate"  runat="server"></asp:TextBox></td>
                                                </tr>
                                              <tr>
                                                     <th>Assessment Duration</th> 
                                                     <th>Total Marks</th> 
                                                </tr>
                                                <tr>
                                                    <td><asp:TextBox ID="txtBoxAssessmentDuration"  runat="server"></asp:TextBox></td>
                                                    <td><asp:TextBox ID="txtBoxTotalMarks"  runat="server"></asp:TextBox></td>
                                                </tr>
                                                <tr>
                                                     <th>PassingMarks</th> 
                                                     <th></th> 
                                                </tr>
                                                <tr>
                                                    <td><asp:TextBox ID="txtBoxPassingMarks"  runat="server"></asp:TextBox></td>
                                                    <td></td>
                                                </tr>
                                                <tr>
                                                    <td><asp:ImageButton ID="ImageButton6"  ImageUrl="~/Images/Return.png" Width="20px" Height="20px"  ToolTip="Return" OnCommand="ManageVisibility" CommandName="ReturnToPrograms" runat="server" /></td>
                                                    <td><asp:LinkButton ID="lnkBtnAddAssessment" class="btn btn-xs btn-info"  Text="Ctreate" OnClick="CreateNewAssessment" runat="server" /></td>
                                                </tr>
                                             </table>
                                         </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                         <!--End Tab Body Assessments-->
                      
                  </div>
                    
                </div>
                <!--End Tabbed-->
                  <!--Extended View/Edit- StudentAssessment-->
                 <div class="col-sm-3">
                     <h3 class="pink">AID:<asp:Label ID="lblAssessmentID" Visible="true" runat="server"></asp:Label>&nbsp&nbsp&nbsp
                         TM:<asp:Label ID="lblTotalMarks" runat="server"></asp:Label>&nbsp PM:<asp:Label ID="lblPassingMarks" runat="server"></asp:Label>
                     </h3>
                      <asp:GridView ID="gvStudentAssessment" Visible="false"  DataKeyNames="StudentAssessmentID" OnRowCommand="gvStudentAssessment_RowCommand"  CssClass="table table-hover table-bordered" AlternatingRowStyle-BackColor="Silver" HorizontalAlign="left" AutoGenerateColumns="false" BorderWidth="1px" CellPadding="4" GridLines="both" 
                           OnRowEditing="gvEditStudentAssessment" OnRowCancelingEdit="gvCancelStudentAssessment" OnRowUpdating="gvUpdateStudentAssessment"
                        
                          BackColor="White" BorderColor="#3366CC" BorderStyle="None" AllowSorting="true"   AllowPaging="false"  PagerStyle-Mode="NumericPages" PageSize="100" RowStyle-HorizontalAlign="left" runat="server">
                           <RowStyle Font-Names="Arial" Font-Size="10pt" ForeColor="#003399" ></RowStyle>
                            <Columns>
                                <asp:CommandField ShowEditButton="true" />
                                <asp:BoundField  DataField="FullName" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Date" ReadOnly="true"></asp:BoundField>
                                <asp:BoundField DataField="MarksObtained" HeaderText="Marks" ReadOnly="false"></asp:BoundField>
                                <asp:BoundField DataField="MarksPercentage" HeaderText="%" ReadOnly="true"></asp:BoundField>
                                <asp:BoundField DataField="PassStatus" HeaderText="Status" ReadOnly="true"></asp:BoundField>
                                <asp:BoundField DataField="Comments" HeaderText="Remarks" ReadOnly="false"></asp:BoundField>
                            </Columns>
                            <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                            <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                            <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                            <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />                           
                    </asp:GridView>
                     <!--Batch Students-->
                     
                     <!--End Batch Students-->
                   </div>
                  <!--End Extended View- Scheudle/Students-->
                </asp:Panel>
           </div>
   </div>
    <!--End View/Create New Assessment-->

    <!--Create AttendanceSheet and Mark Attendance-->
      <div class="row">
            <div class="col-xs-12">  
              <asp:Panel ID="pnlStudentAttendance"  ScrollBars="Auto"   runat="server">
                 <!--Tabbed-->
                <div class="col-sm-8 widget-container-col" id="widget-container-col-10">
                    <div class="widget-box" id="widget-box-10">
                       <div class="widget-header widget-header-small">
						    <h5 class="widget-title smaller">Student Attendance</h5>
						    <div class="widget-toolbar no-border">
							    <ul class="nav nav-tabs" id="myTab">
								    <li class="active">
									    <a data-toggle="tab" href="#attendancesheets">Attendance Sheets</a>
								    </li>
								    <li>
									    <a data-toggle="tab" href="#newattendancesheet">New Attendance Sheet</a>
								    </li>
							    </ul>
						    </div>
					    </div>

                       <!--Tab Body Student Attendance-->
					    <div class="widget-body">
                            <div class="widget-main padding-6">
								<div class="tab-content">
                                    <div id="attendancesheets" class="tab-pane in active">
                                        <div class="row">
                                           <asp:GridView ID="gvAttendanceSheets" OnRowCommand="gvAttendanceSheets_RowCommand" CssClass="table table-hover table-bordered" AlternatingRowStyle-BackColor="Silver" HorizontalAlign="left" AutoGenerateColumns="false" BorderWidth="1" CellPadding="4" GridLines="both" 
                                               BackColor="White" BorderColor="#3366CC" BorderStyle="None" AllowSorting="true"   AllowPaging="false"  PagerStyle-Mode="NumericPages" PageSize="100" RowStyle-HorizontalAlign="left" runat="server">
                           
                                                <RowStyle Font-Names="Arial" Font-Size="10pt" ForeColor="#003399" ></RowStyle>
                                                <Columns>
                                                    <asp:BoundField DataField="AttendanceDate" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Date"></asp:BoundField>
                                                    <asp:BoundField DataField="CourseTitle" HeaderText="Course"></asp:BoundField>
                                                    <asp:BoundField DataField="BatchID" HeaderText="Batch"></asp:BoundField>
                                                    <asp:BoundField DataField="Topic" HeaderText="Topic"></asp:BoundField>
                                                    <asp:BoundField DataField="ClassLocation" HeaderText="ClassRoom"></asp:BoundField>
                                                    <asp:BoundField DataField="AttendanceTakenByID" HeaderText="TakenBy"></asp:BoundField>
                                                    <asp:TemplateField HeaderText="ViewSheet">
                                                        <ItemTemplate>
                                                         <asp:LinkButton ID="lnkBtnViewAttendanceSheet"    CommandName="ViewAttendanceSheet" CommandArgument='<%#Eval("AttendanceSheetID") %>' Text="<i class='ace-icon fa fa-eye bigger-120'></i>" runat="server"></asp:LinkButton>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    
                                                </Columns>
                                                <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                                                <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                                                <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                                                <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />                           
                                        </asp:GridView>
                                         </div>
                                    </div>
                                    <div id="newattendancesheet" class="tab-pane">
                                         <!--Create new Attendace Sheet-->
                                         <div class="row">
                                            <strong>Create AttendaceSheet for Class</strong>
                                             <table class="table  table-bordered table-hover">
                                                <tr>
                                                     <th>Course</th>
                                                     <td><asp:DropDownList ID="ddlAttendanceSheetCourse" DataTextField="CourseTitle" DataValueField="CourseID" runat="server"></asp:DropDownList></td>
                                                     <th>Batch</th>
                                                     <td><asp:DropDownList ID="ddlAttendanceSheetBatch" DataTextField="BatchCode" DataValueField="BatchID" runat="server"></asp:DropDownList></asp:TextBox> </td>
                                                </tr>
                                                <tr>
                                                    <th>Topic</th> 
                                                    <td><asp:TextBox ID="txtBoxTopic"  runat="server"></asp:TextBox></td>
                                                    <th>Class Location</th> 
                                                    <td><asp:TextBox ID="txtBoxClassLocation"  runat="server"></asp:TextBox></td>
                                                </tr>
                                                <tr>
                                                    <th>Attendance Date</th> 
                                                    <td><asp:TextBox ID="txtBoxAttendanceDate" TextMode="Date"  runat="server"></asp:TextBox></td>
                                                    <th>Attendace Taken By</th> 
                                                    <td><asp:Label ID="lblAttendanceTakebByID"  runat="server"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td><asp:ImageButton ID="ImageButton7"  ImageUrl="~/Images/Return.png" Width="20px" Height="20px"  ToolTip="Return" OnCommand="ManageVisibility" CommandName="ReturnToPrograms" runat="server" /></td>
                                                    <td><asp:LinkButton ID="lbkBtnNewASheet" class="btn btn-xs btn-info"  Text="Submit" OnClick="CreateNewAttendanceSheet" runat="server" /></td>
                                                </tr>
                                             </table>
                                         </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                  </div>
                    
                </div>
                <!--End Tabbed-->
                  <!--Extended View/MarkAttendance- StudentAttendance-->
                 <div class="col-sm-3">
                     <h3 class="pink">ASHEETID:<asp:Label ID="lblAttendanceSheetID" Visible="true" runat="server"></asp:Label>&nbsp&nbsp&nbsp
                         <asp:Label ID="Label2" runat="server"></asp:Label>&nbsp <asp:Label ID="Label3" runat="server"></asp:Label>
                     </h3>
                      <asp:GridView ID="gvStudentAttendance"  DataKeyNames="StudentSwipeID" OnRowCommand="gvStudentAttendance_RowCommand"  CssClass="table table-hover table-bordered" AlternatingRowStyle-BackColor="Silver" HorizontalAlign="left" AutoGenerateColumns="false" BorderWidth="1px" CellPadding="4" GridLines="both" 
                          
                          BackColor="White" BorderColor="#3366CC" BorderStyle="None" AllowSorting="true"   AllowPaging="false"  PagerStyle-Mode="NumericPages" PageSize="100" RowStyle-HorizontalAlign="left" runat="server">
                           <RowStyle Font-Names="Arial" Font-Size="10pt" ForeColor="#003399" ></RowStyle>
                            <Columns>
                                <asp:BoundField  DataField="FullName" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Date" ReadOnly="true"></asp:BoundField>
                                <asp:BoundField DataField="AttendanceStatus" HeaderText="P/A" ReadOnly="false"></asp:BoundField>
                                <asp:TemplateField HeaderText="Mark Attendance">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkBtnPresent" class="btn btn-xs btn-success" Text='<i class="ace-icon fa fa-arrow-circle-up bigger-120"></i> P'    CommandName="1" CommandArgument='<%#Eval("StudentSwipeID") %>'  runat="server"></asp:LinkButton>
                                        <asp:LinkButton ID="lnkBtnAbsent" class="btn btn-xs btn-danger"  Text='<i class="fa fa-arrow-circle-down" bigger-120"></i> A'   CommandName="0" CommandArgument='<%#Eval("StudentSwipeID") %>'  runat="server"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                            <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                            <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                            <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />                           
                    </asp:GridView>
                     <!--Batch Students-->
                     
                     <!--End Batch Students-->
                   </div>
                  <!--End Extended View- Scheudle/Students-->
                </asp:Panel>
           </div>
   </div>
    <!--End Create AttendanceSheet and Mark Attendance-->

   <!--Add Learning Artifact for a Course-->     
   <div class="row">
            <div class="col-xs-12">
            <!--Panel to add new document details. Displayed in response to Click on AddNewDocument button-->
            <asp:Panel ID="pnlAddDoc" runat="server">
                  <table class="table  table-bordered table-hover">
                        <caption>Enter Artifact Details</caption>
                            <tr>
                                <td>Program:</td><td> <asp:DropDownList ID="ddlDocProgram" DataTextField="ProgramTitle" DataValueField="ProgramID" runat="server"></asp:DropDownList></td>
                                <td>Course ID:</td><td><asp:DropDownList ID="ddlArtifactCourse" DataTextField="CourseTitle" DataValueField="CourseID" runat="server"></asp:DropDownList></td>
                            </tr>
                            <tr>
                               <td>Artifact Type:</td><td><asp:DropDownList ID="ddlArtifactType" runat="server">
                                                                    <asp:ListItem>CourseDesign</asp:ListItem>
                                                                    <asp:ListItem>Lab Manual</asp:ListItem>
                                                                    <asp:ListItem>Tutorials</asp:ListItem>
                                                                </asp:DropDownList></td>
                                    </tr>
                                    <tr>      
                                     <td><asp:TextBox ID="txtBoxArtifactPath"  Visible="false" runat="server"></asp:TextBox></td>
                                     <td><asp:TextBox ID="txtBoxArtifactName"  Visible="true" runat="server"></asp:TextBox></td>    
                                     <td><asp:FileUpload id="flUpload"  runat="server" /></td>
     
                                     <td><asp:Button  class="btn btn-1" Text="Click to Upload" OnClick="UploadFile" runat="server" /></td> 
                                     </tr>
                                     <tr>
                                     <td></td>
                                         <td>
                                         <asp:LinkButton ID="lnkBtnUpdateStaffProfile"  class="btn btn-white btn-info btn-bold" Text="<i class='ace-icon fa fa-floppy-o bigger-120 blue'>Save</i>" ToolTip="Save" OnClick="InsertRecord" runat="server" ></asp:LinkButton>
                                         <asp:LinkButton ID="lnkBtnReturnToViewCusatomers"  class="btn btn-white btn-default btn-round" Text="<i class='ace-icon fa fa-times red2'> Return</i>" ToolTip="Cancel" OnCommand="ReturnToPanel"  CommandName="ToPnlCourses" runat="server" ></asp:LinkButton></td>
                                     </tr>
                                 </table>
                                 </asp:Panel>
           </div>
   </div>
    <!--End Add Learning Artifact for a Course-->
    
    <!--View Courses/Add New Course-->  
    <div class="row">
          <div class="col-xs-12"> 
             <!--Panel to display course list for selected Program. Contains panel to filter the courses -->
              <asp:Panel ID="pnlCourses" runat="server">
                   <!--Tabbed-->
                <div class="col-sm-10 widget-container-col" id="widget-container-col-10">
                    <div class="widget-box" id="widget-box-10">
                       <div class="widget-header widget-header-small">
						    <h5 class="widget-title smaller">Course Management</h5>
						    <div class="widget-toolbar no-border">
							    <ul class="nav nav-tabs" id="myTab">
								    <li class="active">
									    <a data-toggle="tab" href="#courses">Courses</a>
								    </li>
								    <li>
									    <a data-toggle="tab" href="#addnewcourse">Add Course</a>
								    </li>
							    </ul>
						    </div>
					    </div>

                       <!--Tab Body-->
					    <div class="widget-body">
                            <div class="widget-main padding-6">
								<div class="tab-content">
                                    <div id="courses" class="tab-pane in active">
                                         <div class="col-xs-12">
                                                ProgID:<asp:Label  ID="lblProgramID"  runat="server"></asp:Label>
                                                <asp:Label ID="lblRole" Visible="false"  runat="server"></asp:Label>
                                                <strong>Program:</strong>
                                                <asp:DropDownList  ID="ddlProgramsFilter" DataTextField="ProgramTitle" DataValueField="ProgramID" runat="server"></asp:DropDownList>&nbsp&nbsp&nbsp
                                                <asp:LinkButton ID="lnkBtnFilterCourses"  class="btn btn-xs btn-info"    OnCommand="ManageVisibility" CommandName="FilterCourses" CommandArgument="" Text='<i class="ace-icon fa fa-filter"></i> GO' runat="server"></asp:LinkButton>
                                          </div>
                                           
                                            <asp:GridView ID="dgCourses"  CssClass="table table-hover table-bordered"  AutoGenerateColumns="false" CellPadding="2" DataKeyNames="CourseID" GridLines="both" OnRowEditing="dgCourses_RowEditing" 
                                                          AlternatingItemStyle-BackColor="Silver" OnRowCancelingEdit="dgCourses_RowCancelingEdit" OnRowDeleting="dgCourses_RowDeleting"
			                                            OnRowUpdating="dgCourses_RowUpdating" 
			                                            AllowSorting="true" AllowPaging="false" PagerStyle-Mode="NumericPages" PageSize="12" 
                                                        OnPageIndexChanging="dgCourses_PageIndexChanging" ItemStyle-HorizontalAlign="left" runat="server">
                                            <HeaderStyle Font-Names="Arial" Font-Italic="true" Font-Size="12pt" Font-Bold="false"  BackColor="#465c71" ForeColor="#FFFFFF"  />
                                            <RowStyle Font-Names="Arial" Font-Size="10pt" ForeColor="#003399" ></RowStyle>
                                            <Columns>
                                                <asp:CommandField ShowEditButton="true" />  
                                                <asp:CommandField ShowDeleteButton="true" /> 
                                                <asp:BoundField DataField="CourseID" HeaderText="CourseID" ReadOnly="true"  ></asp:BoundField>
                                                <asp:BoundField DataField="CourseTitle" HeaderText="Course Title" ></asp:BoundField>
                                                <asp:BoundField DataField="CourseDescription" HeaderText="Course Description" ></asp:BoundField>
                                                <asp:BoundField  DataField="Credits" HeaderText="Credits"  ></asp:BoundField>      
                                                <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:ImageButton id="imgBtnCD" ToolTip="Course Outcomes" ImageUrl="~/Images/co.png" Width="20px" Height="20px"  CommandName="CourseOutcomes" CommandArgument='<%#Eval("CourseID") %>' OnCommand="DisplayCourseDetails" runat="server" />
                                                    <asp:ImageButton id="imgBtnCM" ToolTip="Course Material" ImageUrl="~/Images/doc.png" Width="20px" Height="20px"  CommandName="CourseMaterial" CommandArgument='<%#Eval("CourseID") %>' OnCommand="DisplayCourseDetails" runat="server" />
                                                    <asp:ImageButton id="imgBtnQB" ToolTip="Question Bank" ImageUrl="~/Images/qb.png" Width="20px" Height="20px"  CommandName="QuestionBank" CommandArgument='<%#Eval("CourseID") %>' OnCommand="DisplayCourseDetails" runat="server" />
                                                    <asp:ImageButton ID="imgBtnDelete" ImageUrl="~/Images/del.png" ImageAlign="Right" ToolTip="Delete Course" Width="20px" Height="20px" CommandName="Delete" runat="server" /> 
                                                </ItemTemplate>
                                                </asp:TemplateField>   
                                            </Columns>
                                                <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                                                <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                                                <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                                                <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />    
                                            </asp:GridView>
                                           
                                             <!--<asp:ButtonColumn ButtonType="LinkButton" Text="Delete" CommandName="Delete"  />-->
                                            <asp:GridView ID="dgCoursesView"  AutoGenerateColumns="false" CellPadding="2" AlternatingItemStyle-BackColor="Silver" GridLines="Horizontal" AllowSorting="true" AllowPaging="true" PagerStyle-Mode="NumericPages" PageSize="30" 
                                                                             OnPageIndexChanging="dgCourses_PageIndexChanging" ItemStyle-HorizontalAlign="left" runat="server">
                                            <HeaderStyle Font-Names="Arial" Font-Size="12pt" Font-Italic="true" Font-Bold="false"  BackColor="#465c71" ForeColor="#FFFFFF"  />
                                             <RowStyle Font-Names="Arial" Font-Size="10pt" ForeColor="#003399" ></RowStyle>
                                            <Columns>       
                                                <asp:BoundField DataField="CourseID" HeaderText="CourseID"  ></asp:BoundField>
                                                <asp:BoundField DataField="CourseTitle" HeaderText="Course"  ></asp:BoundField>
                                                <asp:BoundField  DataField="Credits" HeaderText="Credits"  ></asp:BoundField>
                                                <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:ImageButton id="imgBtnCD" ToolTip="Course Outcomes" ImageUrl="~/Images/co.png" Width="20px" Height="20px"  CommandName="CourseOutcomes" CommandArgument='<%#Eval("CourseID") %>' OnCommand="DisplayCourseDetails" runat="server" />
                                                    <asp:ImageButton id="imgBtnCM" ToolTip="Course Material" ImageUrl="~/Images/doc.png" Width="20px" Height="20px"  CommandName="CourseMaterial" CommandArgument='<%#Eval("CourseID") %>' OnCommand="DisplayCourseDetails" runat="server" />
                                                    <asp:ImageButton id="imgBtnQB" ToolTip="Question Bank" ImageUrl="~/Images/qb.png" Width="20px" Height="20px"  CommandName="QuestionBank" CommandArgument='<%#Eval("CourseID") %>' OnCommand="DisplayCourseDetails" runat="server" />
                                                </ItemTemplate>
                                                </asp:TemplateField>                 
                                            </Columns>
                                                 <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                                                <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                                                <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                                                <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />       
                                            </asp:GridView>
                                       
                                    </div>
                                    <div id="addnewcourse" class="tab-pane">
                                         <!--Add new course-->
                                            <table class="table  table-bordered table-hover">
                                            <tr>
                                                    <th>Program</th>
                                                    <td><asp:DropDownList ID="ddlProgramAddCourse" DataTextField="ProgramTitle" DataValueField="ProgramID" runat="server"></asp:DropDownList></td>
                                                    <th>Credits:</th>
                                                   <td><asp:TextBox ID="txtBoxCredits" runat="server"></asp:TextBox></td>
                                            </tr>
                                            <tr>
                                                    <th>Course Title:</th>
                                                    <td> <asp:TextBox ID="txtBoxCourseTitle" runat="server"></asp:TextBox> </td>
                                                    <th>Lecture Hours:</th><td><asp:TextBox ID="txtBoxLectureHours" runat="server"></asp:TextBox></td>
                                                </tr>
                                                <tr>
                                                    <th>Practical Hours:</th><td><asp:TextBox ID="txtBoxPractcalHours" runat="server"></asp:TextBox></td>
                                                    <th>Regulation:</th><td><asp:DropDownList ID="ddlRegulation" runat="server">
                                                                            <asp:ListItem>R2017</asp:ListItem>
                                                                            <asp:ListItem>R2022</asp:ListItem>
                                                                            </asp:DropDownList></td>
                                                </tr>
                                            <tr>
                                                <td><asp:ImageButton ID="btnCancel" class="btn-xs btn-info"   ImageUrl="~/Images/Return.png" Width="30px" Height="30px"  ToolTip="Return" OnCommand="ReturnToPanel" CommandName="FromPnlCoToPnlCourses" runat="server" /></td>
                                                <td><asp:Button ID="btnSubmitCourse" class="btn btn-xs btn-info"  Text="Submit" OnClick="AddCourse" runat="server" /></td>
                                            </tr>    
                                            </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                  </div>
                    
                </div>
                <!--End Tabbed-->

                    </asp:Panel>
           </div>
   </div>
    <!--End View Courses/Add New Course-->  

    <!--Add CO-->
    <div class="row">
           <div class="col-xs-12"> 
              <!--Panel to display/Add/Edit course outcome-->
              <asp:Panel BorderWidth="1px" ID="pnlCo" ScrollBars="Both"  Height="400px" runat="server">
                       <div class="col-xs-12">
                           <asp:Label ID="lblCourseID"  runat="server"></asp:Label>:Course Outcomes
                           <asp:ImageButton ID="btnAddNewCO" ImageUrl="~/Images/add.png" Width="25px" Height="25px" ToolTip="New Course Outcome"  style="float:right;"   Text="Add CO"  OnCommand="AddNewCourseOutcome"  runat="server" />              
                          <asp:ImageButton ID="imgBtnBack"  ImageUrl="~/Images/Return.png" Width="20px" Height="20px"  ToolTip="Return" OnCommand="ReturnToPanel" CommandName="FromPnlCoToPnlCourses" runat="server" />        
                        </div>
                       <div class="col-xs-12">
                        <asp:DataList ID="dlCo" DataKeyField="CoID" OnEditCommand="dlCoEditHandler" 
                                    OnUpdateCommand="dlCoUpdateHandler" OnCancelCommand="dlCoCancelHandler" runat="server">
                            <ItemTemplate>       
                                <table class="table  table-bordered table-hover">               
                                <tr>
                                    <td><asp:Label  ID="lblCO" Text='<%#Eval("CourseOutcome")%>' runat="server"></asp:Label></td>
                                    <td><asp:Label ID="txtBoxCoDescription" TextMode="MultiLine" ReadOnly="true" Text='<%#Eval("CourseOutcomeDescription")%>' runat="server"></asp:Label></td>
                                </tr>
                                  
                                </table>
                                <asp:LinkButton ID="lnkBtnEditCO" Text='<i class="ace-icon fa fa-edit fa-fw"></i>edit' CommandName="edit" runat="server"></asp:LinkButton>
                                <asp:LinkButton ID="imgBtnViewCOPOMap" Text='<i class="ace-icon fa fa-eye fa-fw"></i>PO mapping' OnCommand="DisplayCOPOMapping" CommandArgument='<%#Eval("CoID")%>' CommandName='<%#Eval("CourseOutcomeDescription")%>' ToolTip="Associate with PO" runat="server"></asp:LinkButton>       
                            </ItemTemplate>
                            <EditItemTemplate>
                                <table>
                                    <tr>
                                        <th>
                                         <h3><asp:Label ID="lblCourseID" Text='<%#Eval("CourseID") %>' runat="server"></asp:Label>            
                                            <asp:Label ID="lblCourseTitle" Text='<%#Eval("CourseTitle") %>' runat="server"></asp:Label>
                                        </h3>
                                       </th>
                                </tr>
                                <tr>
                                    <td><asp:TextBox ID="txtBoxCo"   TextMode="MultiLine"  Text='<%#Eval("CourseOutcome") %>' runat="server"></asp:TextBox></td>
                                    <td><asp:TextBox ID="txtBoxCoDescription" TextMode="MultiLine"  Text='<%#Eval("CourseOutcomeDescription") %>' runat="server"></asp:TextBox></td>           
                                    
                                </tr>
                                </table>
                                
                                     <asp:Button ID="btnUpdate" class="btn btn-xs btn-info" Text="Update" CommandName="update" runat="server" />
                                    <asp:Button ID="btnCancel" class="btn btn-xs btn-info" Text="Cancel" CommandName="cancel" runat="server" />
                                       
                        </EditItemTemplate>    
                    </asp:DataList>
                           </div>
                    </asp:Panel>
            </div>
    </div>
    <!--End Add CO-->

    <!--Add PO-->
    <div class="row">
            <div class="col-xs-12"> 
                    <!--Panel to Add PO to COPOMap and edit MapIntensity for selected CO-->
             <asp:Panel BorderWidth="1px" ID="pnlCOPOMap" Visible="false" ScrollBars="Both" Width="750px" Height="500px" runat="server">            
                        <asp:ImageButton ID="ImageButton3" ImageUrl="~/Images/Return.png" Width="20px" Height="20px"  ToolTip="Return" OnCommand="ReturnToPanel" CommandName="FromPnlCOPOMapToPnlCo" runat="server" /><br /><br />        
     
                        <strong>Choose PO that improves due to below mentioned CO </strong><br /><br />
                        <asp:Label ID="lblCOID" Text="CoID" Visible="false"  runat="server"></asp:Label>
                         <strong>Prog:</strong>&nbsp&nbsp<asp:DropDownList ID="ddlPrograms" DataTextField="ProgramTitle" DataValueField="ProgramID" AutoPostBack="true" OnSelectedIndexChanged="SelectedProgramIndexChanged" runat="server"></asp:DropDownList><br /><br />
                         <strong>CO:</strong>&nbsp&nbsp<asp:Label ID="lblCoDescription" Text="Co Description"  Font-Italic="true" BackColor="Silver" Visible="true"  runat="server"></asp:Label><br /><br />                                                
                        <strong>Select PO:</strong>&nbsp&nbsp&nbsp&nbsp<asp:DropDownList ID="ddlPO" Width="650px"   DataTextField="PODescription" DataValueField="POID" runat="server"></asp:DropDownList><br /> <br />                          
                        <asp:ImageButton ID="imgBtnAddPO" ImageUrl="~/Images/add.png"  style="float:right;height:20px;width:20px;"  OnCommand="InsertPOtoCOPOMap" ToolTip="High Contribution" CommandArgument="3" runat="server" />&nbsp&nbsp&nbsp&nbsp
                        <asp:ImageButton ID="ImageButton1" ImageUrl="~/Images/add.png"  style="float:right;height:20px;width:20px;"  OnCommand="InsertPOtoCOPOMap" ToolTip="Med Contribution" CommandArgument="2" runat="server" />&nbsp&nbsp&nbsp&nbsp
                        <asp:ImageButton ID="ImageButton2" ImageUrl="~/Images/add.png"  style="float:right;height:20px;width:20px;"  OnCommand="InsertPOtoCOPOMap" ToolTip="Low Contribution" CommandArgument="1" runat="server" /><br /><br />
                     
     
    
                        <asp:DataGrid ID="dgCOPOMap" AutoGenerateColumns="false" CellPadding="4" 
			                                              GridLines="None" OnEditCommand="dgEditMapValue" OnCancelCommand="dgCancelMapValue" Width="730px"
			                                              OnUpdateCommand="dgUpdateMapValue" OnDeleteCommand="dgDeleteCOPOMap" DataKeyField="COPOMapID" 
			                                              AllowSorting="true" AllowPaging="false"   ItemStyle-HorizontalAlign="left" runat="server">
			                                    <ItemStyle Font-Names="Arial" Font-Size="9pt" ForeColor="#000000"  />
			                                    <HeaderStyle Font-Names="Arial" Font-Size="9pt" Font-Bold="false"  BackColor="#465c71" ForeColor="#FFFFFF"  />
			                                    <AlternatingItemStyle Font-Names="Arial" Font-Size="9pt" BackColor="#CCCCCC" />
                            
			                                    <Columns>
			                                        <asp:EditCommandColumn EditText="Edit" CancelText="Cancel" UpdateText="Update" Visible="true" />
                                                    <asp:BoundColumn DataField="COPOMapID" HeaderText="COPOMapID" ReadOnly="true" Visible="false" ></asp:BoundColumn>
			                                        <asp:BoundColumn DataField="POID" HeaderText="PO ID" ReadOnly="true" Visible="false"  SortExpression="POID" />
                                                    <asp:BoundColumn DataField="POName" HeaderText="PO Name" ReadOnly="true"  SortExpression="POName" Visible="true"/>
			                                        <asp:BoundColumn DataField="PODescription" HeaderText="PO Description" ReadOnly="true"  SortExpression="AcadYear"/>
                                                    <asp:BoundColumn DataField="COPOMapValue" HeaderText="CO Contribution" ReadOnly="false"  SortExpression="AcadSem"/>
                                                    <asp:TemplateColumn>
                                                        <ItemTemplate>
                                                            <asp:ImageButton ID="imgBtnDelPO" ImageUrl="~/Images/del.png" Width="20px" Height="20px" OnCommand="dgDeleteCOPOMap" CommandArgument='<%#Eval("COPOMapID") %>'  runat="server" />
                                                        </ItemTemplate>
                                                    </asp:TemplateColumn>			   
			                                    </Columns>
                            
                         </asp:DataGrid>
                    </asp:Panel>
           </div>
    </div>
     <!--End Add PO-->

    <!--Add Questions to a Course-->
    <div class="row">
            <div class="col-xs-12"> 
             <!--Panel to Diplay/Add/Edit New Question to Question Bank for online test -->
             <asp:Panel BorderWidth="2px" Visible="false" ID="pnlObjQ" ScrollBars="Both"  Height="500px" runat="server">
                 <!------Tabbed------>
                 <div class="col-sm-10 widget-container-col" id="widget-container-col-10">
                    <div class="widget-box" id="widget-box-10">
                       <div class="widget-header widget-header-small">
						    <h5 class="widget-title smaller">Course ID: <asp:Label ID="lblCID"  runat="server"></asp:Label>:Objective Questions</h5>
						    <div class="widget-toolbar no-border">
							    <ul class="nav nav-tabs" id="myTab">
								    <li class="active">
									    <a data-toggle="tab" href="#questions">Questions</a>
								    </li>
								    <li>
									    <a data-toggle="tab" href="#addquestion">Add Question</a>
								    </li>
							    </ul>
						    </div>
					    </div>

                       <!--Tab Body-->
					    <div class="widget-body">
                            <div class="widget-main padding-6">
								<div class="tab-content">
                                    <div id="questions" class="tab-pane in active">
                                        <asp:LinkButton ID="lnkBtnReturn" CssClass="btn btn-xs btn-info"  Text='<i class="ace-icon fa fa-undo"></i> Return' OnCommand="ReturnToPanel" CommandName="FromPnlObjQToPnlCourses" runat="server" />
                                                <hr />
                                              <asp:DataList ID="dlObjQ" DataKeyField="QuestionID" OnEditCommand="dlQEditHandler" 
                                                 OnUpdateCommand="dlQUpdateHandler" OnCancelCommand="dlQCancelHandler" runat="server">
                                                <ItemTemplate>       
                                            <table width="680"   cellspacing="1px" cellpadding="1px">               
                                            <tr>
                                                <td valign="top">Q<%#Eval("QuestionID")%>:</td>
                                                <td colspan="3"><asp:TextBox ID="lblQuestion" TextMode="MultiLine" ReadOnly="true" Height="50px"   Width="600px" Text='<%#Eval("Question")%>' runat="server"></asp:TextBox></td>           
                                            <tr></tr>
                                            </tr> 
                                            <tr>
                                                <td>A.</td><td ><%#Eval("OptionA")%></td>
                                                <td>B.</td><td><%#Eval("OptionB")%></td>
                                            </tr>
                                            <tr>
                                                <td>C.</td><td><%#Eval("OptionC")%></td>
                                                <td>D.</td><td><%#Eval("OptionD")%></td>
                                            </tr>           
                                            <tr>
                                               <td align="right" colspan="4"><asp:LinkButton ID="lnkBtnEditQ" Text='<i class="ace-icon fa fa-edit fa-fw"></i>edit' CommandName="edit" runat="server"></asp:LinkButton></td>
                                            </tr> 
                                                <tr>
                                                    <td><hr /></td>
                                                </tr>         
                                            </table>
            
                                        </ItemTemplate>
                                            <EditItemTemplate>
                                            <table class="table  table-bordered table-hover"> 
                                            <tr>                
                                                <td>Q :<asp:Label ID="lblEditID"  Text='<%#Eval("QuestionID") %>' runat="server"></asp:Label>:
                                                <asp:TextBox ID="txtBoxQuestion" width="400px" TextMode="MultiLine"  Text='<%#Eval("Question") %>' runat="server"></asp:TextBox></td>
                                                <td>Ans:<asp:TextBox ID="txtBoxCorrectAnswer"  TextMode="MultiLine"  Text='<%#Eval("CorrectAnswer") %>' runat="server"></asp:TextBox></td>
                                           </tr>
                                           <tr>
                                                <td>A:<asp:TextBox ID="txtBoxOptionA" Text='<%#Eval("OptionA")%>' runat="server"></asp:TextBox></td>
                                                <td>B:<asp:TextBox ID="txtBoxOptionB" Text='<%#Eval("OptionB")%>' runat="server"></asp:TextBox></td>
                                            </tr>
                                            <tr>
                                                <td>C:<asp:TextBox ID="txtBoxOptionC" Text='<%#Eval("OptionC")%>' runat="server"></asp:TextBox></td>
                                                <td>D:<asp:TextBox ID="txtBoxOptionD" Text='<%#Eval("OptionD")%>' runat="server"></asp:TextBox></td>
                                            </tr>
                                           <tr>
                                                <td colspan="2"><asp:Button CssClass="btn btn-xs btn-info" ID="btnUpdate" Text="Update" CommandName="update" runat="server" />
                                                               <asp:Button CssClass="btn btn-xs btn-warning" ID="btnCancel" Text="Cancel" CommandName="cancel" runat="server" /></td>
                                            </tr>
                                            </table>
                                               </EditItemTemplate>    
                                             </asp:DataList>
                                          </div>
                                    
                                    <div id="addquestion" class="tab-pane">
                                         <!--Add new course-->
                                         <table class="table  table-bordered table-hover"> 
                                            <tr>                
                                                <td>
                                                <asp:TextBox ID="txtBoxNewQuestion" TextMode="MultiLine" class="col-lg-8" Placeholder="Type your question here" runat="server"></asp:TextBox></td>
                                                <td><asp:TextBox ID="txtBoxNewCorrectAnswer" TextMode="MultiLine" class="col-lg-4" Placeholder="Correct answer here" runat="server"></asp:TextBox></td>
                                           </tr>
                                           <tr>
                                                <td>A:<asp:TextBox ID="txtBoxNewOptionA" Placeholder="Opetion A" runat="server"></asp:TextBox></td>
                                                <td>B:<asp:TextBox ID="txtBoxNewOptionB" Placeholder="Opetion B" runat="server"></asp:TextBox></td>
                                            </tr>
                                            <tr>
                                                <td>C:<asp:TextBox ID="txtBoxNewOptionC" Placeholder="Opetion C" runat="server"></asp:TextBox></td>
                                                <td>D:<asp:TextBox ID="txtBoxNewOptionD" Placeholder="Opetion D" runat="server"></asp:TextBox></td>
                                            </tr>
                                           <tr>
                                                <td colspan="2"><asp:Button CssClass="btn btn-xs btn-info" ID="btnAddNewQuestion" Text="Save" OnCommand="AddNewObjQ" runat="server" />
                                               <asp:Button CssClass="btn btn-xs btn-warning" ID="btnCncelQuestion" Text="Cancel" CommandName="cancel" runat="server" /></td>
                                            </tr>
                                            </table>   
                                    </div>
                                </div>
                            </div>
                        </div>
                  </div>
                   </div> 
              
                 <!----End Tabbbed--->
            </asp:Panel>                  
        </div>
   </div>
     <!--End Add Questions to a Course-->

    <!--View Learning Artifacts-->
  <div class="row">
            <div class="col-xs-12"> 
            <!--Panel to Display Artifacts of selected course-->
             <asp:Panel ID="pnlCourseDocs"  ScrollBars="auto"  Height="400px"   runat="server">
                 <div class="col-sm-4">  
                 <asp:GridView ID="dgCoursePlanner" CssClass="table table-hover table-bordered"  AutoGenerateColumns="false" AlternatingItemStyle-BackColor="Gainsboro"   CellPadding="2" GridLines="None"  DataKeyNames="CourseID" AllowPaging="true" runat="server">
                        <HeaderStyle Font-Names="Arial" Font-Italic="true" Font-Size="12pt" Font-Bold="false"  BackColor="#465c71" ForeColor="#FFFFFF"  />
                                            <RowStyle Font-Names="Arial" Font-Size="10pt" ForeColor="#003399" ></RowStyle>
                        <Columns>
                            <asp:BoundField DataField="CourseID" HeaderText="CourseID"  ></asp:BoundField>
                            <asp:BoundField DataField="CourseTitle" HeaderText="Course"  ></asp:BoundField>
                            
                            <asp:HyperLinkField  DataTextField="ArtifactName" HeaderText="Title" Target="learnFrame"  DataNavigateUrlFields="ArtifactPath"></asp:HyperLinkField>  
                            
                        </Columns>
                            <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                                                <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                                                <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                                                <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />    
                        </asp:GridView>
                   <asp:LinkButton ID="lnkBtn"  Text="<i class='ace-icon fa fa-undo'> Return</i>" OnCommand="ReturnToPanel" CommandName="FromPnlCourseDocsToPnlCourses" runat="server" />        
                 </div>
                 <div class="col-sm-8">
                     <iframe id="learnFrame"  style="width:600px; height:500px;" frameborder="0" runat="server"></iframe>

                 </div>
             </asp:Panel>
         </div>
  </div> 
     <!--End View Learning Artifacts-->  
</asp:Content>
