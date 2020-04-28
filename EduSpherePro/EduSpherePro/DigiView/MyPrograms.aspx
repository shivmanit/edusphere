<%@ Page Title="" Language="C#" MasterPageFile="~/DigiView/DigiViewSite.Master" AutoEventWireup="true" CodeBehind="MyPrograms.aspx.cs" Inherits="EduSpherePro.DigiView.MyPrograms" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
     <!--Page Command Buttons-->   
        <div class="row">
            <div class="col-xs-12">
               <div class="col-sm-6">  
                 <div class="hr hr-18 dotted hr-double"></div>
	               <h4 class="pink">
		              <i class="ace-icon fa fa-hand-o-right icon-animated-hand-pointer blue"></i>
			          <asp:Label ID="lblStudentAction" Text="My Academy/Program" runat="server"></asp:Label>
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
                                        <asp:LinkButton ID="lnkBtnViewContent"   OnCommand="ManageVisibility" CommandName="ViewContents" CommandArgument="" Text='<i class="ace-icon fa fa-eye fa-fw"></i> Learn' runat="server"></asp:LinkButton>
								    </li>
								    <li class="divider"></li>
								    <li>
									    <asp:LinkButton ID="lnkBtnTakeQuiz" Visible="false"    OnCommand="ManageVisibility" CommandName="TakeQuiz" CommandArgument="" Text='<i class="ace-icon fa fa-question-circle"></i> TakeQuiz' runat="server"></asp:LinkButton>
								    </li>
                                    
							    </ul>
						    </li>
					    </ul>
				    </div>
              
          </div>
            </div>
         </div>
  <!--end Page Command Buttons-->
     
    <!--Learn-->
    <div class="row">
        <div class="col-xs-12">
            <strong>Choose Program :</strong><asp:DropDownList ID="ddlMyPrograms" DataTextField="ProgramTitle" DataValueField="ProgramID" OnSelectedIndexChanged="ddlMyPrograms_SelectedIndexChanged" AutoPostBack="true" runat="server"></asp:DropDownList>
        </div>
        <br />
        <hr />
        <!--Videos and Course Docs-->
        <asp:Panel ID="pnlLearningContent" runat="server">
          <div class="col-sm-10 widget-container-col" id="widget-container-col-10">
                    <div class="widget-box" id="widget-box-10">
                       <div class="widget-header widget-header-small">
						    <h5 class="widget-title smaller">Learn</h5>
						    <div class="widget-toolbar no-border">
							    <ul class="nav nav-tabs" id="myTab">
								    <li class="active">
									    <a data-toggle="tab" href="#videos">Watch Videos</a>
								    </li>
								    <li>
									    <a data-toggle="tab" href="#docs">Read</a>
								    </li>
							    </ul>
						    </div>
					    </div>

                       <!--Tab Body-->
					    <div class="widget-body">
                            <div class="widget-main padding-6">
								<div class="tab-content">
                                    <div id="videos" class="tab-pane in active">
                                        <div class="row">
                                             <div class="col-xs-12">
                                                  <asp:GridView ID="gvCourseVideos"  CssClass="table table-hover table-bordered" AlternatingRowStyle-BackColor="Silver" HorizontalAlign="left" AutoGenerateColumns="false" BorderWidth="1" CellPadding="4" GridLines="both" 
                                                    BackColor="White" BorderColor="#3366CC" BorderStyle="None" AllowSorting="true"   AllowPaging="false"  PagerStyle-Mode="NumericPages" PageSize="100" RowStyle-HorizontalAlign="left" runat="server">
                           
                                                    <RowStyle Font-Names="Arial" Font-Size="10pt" ForeColor="#003399" ></RowStyle>
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Watch Videos">
                                                            <ItemTemplate>
                                                                <div>
                                                                    <h2>Course:<%#Eval("CourseTitle") %></h2>
                                                                    <p><strong>Title: <%#Eval("VideoTitle") %></strong></p>
                                                                    <p>Description :<%#Eval("VideoDescription") %></p>
                                                                    <div class="embed-responsive embed-responsive-16by9 hoverable">
                                                                      <video class="embed-responsive-item" controls>
                                                                        <source src="<%#Eval("VideoPath") %>" type="video/mp4">
                                                                      </video>
                                                                    </div>
                                                                    <%--<div>
                                                                        <iframe width="560" height="315" src="" frameborder="0" allow="accelerometer; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
                                                                    </div>--%>
                                                                    
                                                                </div>
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
                                    </div>
                                    <div id="docs" class="tab-pane">
                                         <!--Read Docs-->
                                        <div class="row">
                                           <div class="col-xs-12">
                                              <asp:GridView ID="gvCourseDocs" CssClass="table table-hover table-bordered"  AutoGenerateColumns="false" AlternatingItemStyle-BackColor="Gainsboro"   CellPadding="2" GridLines="None"  DataKeyNames="CourseID" AllowPaging="true" runat="server">
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
                                                </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                      
                  </div>
                    
                </div>
        
            
       
        </asp:Panel>
        <!--/Videos and Course Docs-->
 </div>
    <!--Course Videoss-->

    <!--TakeQuiz-->
    <div class="row">
        <div class="col-xsw-12">
            <asp:Panel ID="pnlTakeQuiz" runat="server">
                <asp:Panel ID="pnlCandidate" Visible="false" runat="server">
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
    <!--/Take Quiz-->
</asp:Content>
