<%@ Page Title="" Language="C#" Async="true" MasterPageFile="~/DigiView/DigiViewSite.Master" AutoEventWireup="true" CodeBehind="Quizzes.aspx.cs" Inherits="EduSpherePro.DigiView.Quizzes" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!--Page Headers-->
    <div class="row">
        <%--<div class="col-sm-3">
            <h4 class="pink">
                <i class="ace-icon fa fa-hand-o-right icon-animated-hand-pointer blue"></i>
                <asp:Label ID="lblStaffAction" Text="" runat="server"></asp:Label>
            </h4>
        </div>--%>
        <%--<div class="col-sm-3">
            <div class="input-group">
                <span class="input-group-addon">
                    <i class="ace-icon fa fa-check"></i>
                </span>
                <asp:TextBox class="form-control search-query" ID="txtBoxSearchStaff" Placeholder="Name or Phone" runat="server"></asp:TextBox>
                <span class="input-group-btn">
                    <asp:LinkButton ID="lnkBtnSerachEnquiry" class="btn btn-purple btn-sm" Text="<span class='ace-icon fa fa-search icon-on-right bigger-110'></span> Search"  CommandName="SearchEnquiry" runat="server"></asp:LinkButton>
                </span> 
            </div>
        </div>--%>
        <!--Page Buttons-->
        <div class="col-sm-7">
            <div class="col-sm-3">
                <asp:Label ID="lblRole" Visible="false" runat="server"></asp:Label>
            </div>    
            <asp:Panel ID="pnlCandidate" Visible="true" runat="server">
              <div class="col-sm-12" style="background-color: #f1f1c1;">
                  <div class="col-xs-12">
                      <div class="col-xs-2">Name :</div>
                      <div class="col-xs-4"><asp:Label ID="lblCandidateName" runat="server"></asp:Label></div>
                      <div class="col-xs-2">ID :</div>
                      <div class="col-xs-3"><asp:Label ID="lblCandidateID" runat="server"></asp:Label></div>
                  </div>
                  <div class="col-xs-12">                     
                      <div class="col-xs-2">Title :</div>
                      <div class="col-xs-4"><asp:Label ID="lblTestTitle"  runat="server"></asp:Label></div>
                      <div class="col-xs-2">Test ID :</div>
                      <div class="col-xs-3"><asp:Label ID="lblTestID"  runat="server"></asp:Label></div>
                  </div>
                  <div class="col-xs-12">
                      <div class="col-xs-6">
                          <asp:LinkButton ID="btnStartExam" class="btn btn-purple btn-sm" Text="<span class='ace-icon fa fa-hourglass-start icon-on-right bigger-110'></span> START" OnClick="StartTest" runat="server"></asp:LinkButton>
			          </div>              
                      <div class="col-xs-6"> <asp:TextBox ID="txtScore" runat="server" Visible="False" Width="63px">0</asp:TextBox></div>
                  </div>        
           </div>
           </asp:Panel>          
        </div>
        <div class="col-sm-4">
                    <div id="membersbar" class="navbar-buttons navbar-header pull-right" role="navigation">
					    <ul class="nav ace-nav">
						    <li class="light-blue dropdown-modal">
							    <a data-toggle="dropdown" href="#" class="dropdown-toggle">
                                    Assessments <i class="ace-icon fa fa-caret-down"></i> 
							    </a>
							    <ul class="user-menu dropdown-menu-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">					                                               								   
                                    <li>
									    <asp:LinkButton ID="lnkBtnTakeTest" class="btn btn-purple btn-sm" Text="<span class='ace-icon fa fa-hourglass-start icon-on-right bigger-110'></span> Take Test" OnCommand="ManageTestPanelVisibility" CommandName="pnlTest" runat="server"></asp:LinkButton>
								    </li>
                                    <li class="divider"></li>
                                    <li>
                                        <asp:LinkButton ID="lbkBtnViewResult" class="btn btn-xs btn-info" Text="<i class='ace-icon fa fa-eye bigger-120'></i> View Test Report" ToolTip="View Test Report" OnCommand="ManageTestPanelVisibility"  CommandName="pnlResult" CommandArgument="" runat="server"></asp:LinkButton>
								    </li>
								    <li class="divider">

								    </li>
                                    
								    
							    </ul>
						    </li>
					    </ul>
				    </div>
              
          </div>
        <!--End Page Buttons-->
    </div>
    <div class="hr hr-18 dotted hr-double"></div>

<!--Page Header-->


 
    <!--Questions & Options-->
    <asp:Panel ID="pnlTest" runat="server" Visible="false" style="margin-top:20px;" BackColor="#E0E0E0" BorderColor="#E0E0E0" Height="264px"  Width="800px" ForeColor="#0000C0">       
        <div class="row">
            <div class="col-sm-12">
               <div class="col-sm-3"><asp:Label ID="lblName" Visible="false" runat="server"  Text="Name : "></asp:Label></div>                                   
                <div class="col-sm-2"><asp:Label ID="lblScore"  runat="server" Visible="false"   Text="Score : "></asp:Label></div>
                <div class="col-sm-4">Start Time: <asp:Label ID="lblTestStartTime" runat="server"></asp:Label></div>          
            <!--Test Code:Time control is used to update an UpdatePanel control. Here its put outside UpdatePanle its ID is used as trigger insied UpdatePanel-->     
                <asp:ScriptManager ID= "SM1" runat="server"></asp:ScriptManager>
                <asp:Timer ID="timer1" runat="server" Interval="10000"  Enabled="true" OnTick="timer1_tick"></asp:Timer>             
                <div class="col-sm-3">
                    <asp:UpdatePanel id="pnlTimeUpdate" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <span>
                                <i class="ace-icon fa fa-hourglass-start icon-on-right bigger-110"></i>
                            </span>
                            <asp:Label ID="lblTimer" runat="server" ></asp:Label>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="timer1"  EventName="tick" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
      <%-- <hr style="elevation:lower;" />--%>
       <asp:Panel ID="pnlQuestions"  runat="server">
           <asp:LinkButton ID="lnkBtnTranslateQ" Visible ="true"  class="btn btn-purple" ToolTip="View Hindi" Text="<span class='ace-icon fa fa-send-o icon-on-right bigger-110'></span> hindi" OnCommand="Translate" CommandName="hindi" runat="server"></asp:LinkButton>
           <asp:LinkButton ID="LinkButton1" Visible ="true"  class="btn btn-purple" ToolTip="View Tamil" Text="<span class='ace-icon fa fa-send-o icon-on-right bigger-110'></span> tamil" OnCommand="Translate" CommandName="tamil" runat="server"></asp:LinkButton>
           <div class="row">
               <div class="clearfix form-actions">
                    <div class="col-sm-offset-1 col-sm-12"> 
                       <h4 class="pink">
                            <i class="ace-icon fa fa-hand-o-right icon-animated-hand-pointer blue"></i>
                           <asp:Label ID="lblQuestion" runat="server"  Text="Label"></asp:Label>
                       </h4>
                   </div>
                   <div class="col-sm-offset-1 col-sm-9">   
                        <asp:RadioButtonList ID="RblOption" runat="server">
                        </asp:RadioButtonList>
                   </div>
                   <div class="col-sm-offset-1 col-sm-6">          
                    <asp:LinkButton ID="btnNextQ" class="btn btn-sm btn-info" ToolTip="Click Here to Take Next Question" Text='<i class="ace-icon fa fa-hand-o-right bigger-110"></i> Next' OnCommand="DisplayNextQuestion" runat="server"></asp:LinkButton>
                    &nbsp; &nbsp; &nbsp;
                    <asp:LinkButton ID="Finish" Visible ="false"  class="btn btn-purple" ToolTip="Click Here to Submit The Test" Text="<span class='ace-icon fa fa-send-o icon-on-right bigger-110'></span> Submit" OnCommand="Finish_Click" runat="server"></asp:LinkButton>							
               </div>             
               </div>
               
           </div>
      
       </asp:Panel>
        <asp:Label ID="lblResult" runat="server" Visible ="false" Font-Bold ="true" Font-Size="Large" Text=""></asp:Label>
 </asp:Panel>
    

    <!--View Results-->
    <div class="row">
        <asp:Panel ID="pnlResult" runat="server">
            <div class="row">
                <div>
                    <div>
                        <asp:Label ID="lblResultTestTitle" Text="No Valid Test Title" class="col-sm-4" runat="server"></asp:Label>
                    </div>
                    <div>
                        <asp:Label ID="lblResultTestID" class="col-sm-6" Text="No Valid Test ID" runat="server"></asp:Label>
                    </div>
                </div>
                <div>
                    <asp:Label ID="lblResultCandidateName" class="col-sm-4" Text="" runat="server"></asp:Label>
                    <asp:Label ID="lblResultCandidateID" class="col-sm-6" Text="" runat="server"></asp:Label>
                </div>
                <div>
                    <asp:Label ID="lblAttendanceStatus" class="col-sm-6" Text="" runat="server"></asp:Label>
                </div>
            </div>
            <div class="row">
                
                
                <asp:GridView ID="gvResult" DataKeyNames="TransactionId" OnRowDataBound="gvResult_RowDataBound"   CssClass="table table-hover table-bordered" AlternatingRowStyle-BackColor="" HorizontalAlign="left" AutoGenerateColumns="false" BorderWidth="1" CellPadding="4" GridLines="both"                                            
                        BackColor="White" BorderColor="#3366CC" BorderStyle="None" AllowSorting="true"   AllowPaging="false"  PagerStyle-Mode="NumericPages" PageSize="100" RowStyle-HorizontalAlign="left" runat="server">                           
                        <RowStyle Font-Names="Arial" Font-Size="9pt" ForeColor="#003399" ></RowStyle>
                        <Columns>
                            <asp:BoundField DataField="QuestionID"  HeaderText="ID"></asp:BoundField>
                            <asp:BoundField DataField="Question"  HeaderText="Name"></asp:BoundField>
                            <asp:BoundField DataField="OptionA" HeaderText="A"></asp:BoundField>
                            <asp:BoundField DataField="OptionB" HeaderText="B"></asp:BoundField>
                            <asp:BoundField DataField="OptionC" HeaderText="C"></asp:BoundField>
                            <asp:BoundField DataField="OptionD" HeaderText="D"></asp:BoundField>
                            <asp:BoundField DataField="CorrectAnswer" HeaderText="Answer"></asp:BoundField>
                            <asp:BoundField DataField="CandidateSelection" HeaderText="YourAnswer"></asp:BoundField> 
                            <asp:BoundField DataField="EvaluationStatus" HeaderText="Result"></asp:BoundField>                                                                                           
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
    <!--EndViewResults-->
         
</asp:Content>
