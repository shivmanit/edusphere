<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Enquiry.aspx.cs" Inherits="EduSpherePro.Enquiry" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<audio id="audio" src="http://www.soundjay.com/button/beep-07.wav" autostart="false" ></audio>
    <script type="text/javascript">
    function playSound() {
          var sound = document.getElementById("audio");
          sound.play();
      }
    </script>
        <section class="inner-banner">
            <div class="container">
                <ul class="list-unstyled thm-breadcrumb">
                    <li><a href="#">Home</a></li>
                    <li class="active"><a href="#">Enquiry</a></li>
                </ul><!-- /.list-unstyled -->
                <h2 class="inner-banner__title">Enquiry</h2><!-- /.inner-banner__title -->
            </div><!-- /.container -->
        </section><!-- /.inner-banner -->

        <section class="contact-one">
            <div class="container">
                <h2 class="contact-one__title text-center">Enquire Now <br>
                    </h2><!-- /.contact-one__title -->
                <form action="Content/TemplateSite/inc/sendemail.php" class="contact-one__form contact-form-validated">
                    <div class="row low-gutters wow fadeInUp" data-wow-delay="0.6s">
                        
							
								<%--<asp:ValidationSummary runat="server" CssClass="text-danger" ForeColor="orange" />--%>
                                    <asp:Label ID="lblOrgID" Visible="false" runat="server"></asp:Label>
									
                                    <div class="col-lg-6">
										<asp:TextBox ID="txtBoxFullName" class="form-control" Placeholder="Full Name" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtBoxFullName"
                                            CssClass="text-danger" ForeColor="white" ErrorMessage="The Name field is required." />
									</div>
                                    <div class="col-lg-6">
									<asp:TextBox ID="txtBoxEmail" class="form-control" Placeholder="Your Email" runat="server"></asp:TextBox>
                                       <asp:RequiredFieldValidator runat="server" ControlToValidate="txtBoxEmail"
                                            CssClass="text-danger"  ForeColor="white" ErrorMessage="The Email field is required." />
									</div>
                                    <div class="col-lg-6">
										<asp:TextBox ID="txtBoxPhone" class="form-control" Placeholder="Phone" runat="server"></asp:TextBox>
                                       <asp:RequiredFieldValidator runat="server" ControlToValidate="txtBoxPhone"
                                            CssClass="text-danger" ForeColor="white" ErrorMessage="The Phone field is required." />
									</div>
                                    <div class="col-lg-6">
										<asp:TextBox ID="txtBoxPinCode" Visible="true" class="form-control" Placeholder="PinCode" runat="server"></asp:TextBox>
									</div>
									<%--<div class="col-lg-12">
										<asp:DropDownList class="form-control"  ID="ddlProgramGroup"  DataTextField="ProgramGroup" DataValueField="ProgramGroupId" OnSelectedIndexChanged="ddlProgramGroup_SelectedIndexChanged" AutoPostBack="true" runat="server"></asp:DropDownList>
                                    </div>--%>
                                    <div class="col-lg-12">
                                        <%--<asp:TextBox ID="txtBoxLocation" Visible="true" class="form-control" Placeholder="City/District, State, Country" runat="server"></asp:TextBox>--%>
										<strong>STATE:</strong>
                                        
                                        <asp:DropDownList ID="ddlState" class="form-control" DataTextField="StateName" DataValueField="StateID" runat="server">
										</asp:DropDownList>
									</div><br />
                                    <div class="col-lg-12">
                                        <strong>PROGRAM:</strong>
										<asp:DropDownList class="form-control" ID="ddlProgramId" DataTextField="ProgramTitle" DataValueField="ProgramId" runat="server"></asp:DropDownList>
                                    </div>
                                    <div class="col-lg-12">
                                        <strong>EDUCATION:</strong>
										<asp:DropDownList ID="ddlEducation" Visible="true" class="form-control" runat="server">
                                            <asp:ListItem>SSC</asp:ListItem>
                                            <asp:ListItem>HSC</asp:ListItem>
                                            <asp:ListItem>GRADUATE</asp:ListItem>
                                            <asp:ListItem>POSTGRADUATE</asp:ListItem>
										</asp:DropDownList>
									</div>
                                    <%--<div class="col-lg-12">
										<asp:TextBox ID="txtBoxInstitute" Visible="true" class="form-control" Placeholder="Institute" runat="server"></asp:TextBox>
									</div>
                                    <div class="col-lg-12">
										<asp:DropDownList class="form-control" ID="ddlGender" runat="server">
                                            <asp:ListItem>MALE</asp:ListItem>
                                            <asp:ListItem>FEMALE</asp:ListItem>
                                        </asp:DropDownList>
									</div>--%>
									
                                   <%--<div class="col-lg-12">
										<asp:TextBox ID="txtBoxCity" Visible="true" class="form-control" Placeholder="City" runat="server"></asp:TextBox>
									</div>--%>
                                   
									
                                <!--Captcha-->
                                    <div class="col-lg-12">  
                                            
                                            <asp:Image ID="Image2" runat="server" Height="55px" ImageUrl="~/Captcha.aspx" Width="186px" />  
                                            <br />  
                                            <asp:Label Style="background-color:red;color:white;" runat="server" ID="lblCaptchaMessage"></asp:Label> 
             
                                            <asp:TextBox CssClass="col-lg-12"  runat="server" Style="color:black;" placeholder="EnterAboveCode" ID="txtVerificationCode"></asp:TextBox>  
                                    </div>
                                
                                    <div class="col-lg-12"></div>
                                    <div class="col-lg-12"></div>
									
								
							
						

                        <div class="col-lg-12">
                            <asp:TextBox ID="txtBoxComments" class="form-control" Visible="true"  Placeholder="Remarks /Additional Message" runat="server"></asp:TextBox>
                            
                            <div class="text-center">
                                <%--<button type="submit" class="contact-one__btn thm-btn">Submit</button>--%>
                                <asp:LinkButton ID="lnkBtnSubmit" class="contact-one__btn thm-btn" OnCommand="SubmitEnquiry" Text="Submit" runat="server"></asp:LinkButton>
                            </div><!-- /.text-center -->
                        </div><!-- /.col-lg-12 -->
                    </div><!-- /.row -->
                </form>
                <div class="result text-center"></div><!-- /.result -->
            </div><!-- /.container -->
        </section><!-- /.contact-one -->

        
</asp:Content>
