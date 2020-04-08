<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Admission.aspx.cs" Inherits="EduSpherePro.Admission" %>
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
                    <li class="active"><a href="#">Admission</a></li>
                </ul><!-- /.list-unstyled -->
                <h2 class="inner-banner__title">Admission</h2><!-- /.inner-banner__title -->
            </div><!-- /.container -->
        </section><!-- /.inner-banner -->

     <section class="contact-one">
            <div class="container">
                <h2 class="contact-one__title text-center">Register Now <br>
                    </h2><!-- /.contact-one__title -->
                <form action="Content/TemplateSite/inc/sendemail.php" class="contact-one__form contact-form-validated">
                    <div class="row low-gutters">
                        <div class="col-lg-6">
                            <%--<input type="text" name="name" placeholder="Your Name">--%>
                            <asp:TextBox ID="txtBoxFullName" class="form-control" Placeholder="Your Name" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtBoxFullName"
                                            CssClass="text-danger" ForeColor="white" ErrorMessage="The Name field is required." />
                        </div><!-- /.col-lg-6 -->
                        <div class="col-lg-6">
                            <asp:TextBox ID="txtBoxEmail" class="form-control" Placeholder="Your Email" runat="server"></asp:TextBox>
                                       <asp:RequiredFieldValidator runat="server" ControlToValidate="txtBoxEmail"
                                            CssClass="text-danger"  ForeColor="white" ErrorMessage="The Email field is required." />
                        </div><!-- /.col-lg-6 -->
                        <div class="col-lg-6">
                            <asp:TextBox ID="txtBoxPhone" class="form-control" Placeholder="Phone" runat="server"></asp:TextBox>
                                       <asp:RequiredFieldValidator runat="server" ControlToValidate="txtBoxPhone"
                                            CssClass="text-danger" ForeColor="white" ErrorMessage="The Phone field is required." />
                        </div><!-- /.col-lg-6 -->
                        <div class="col-lg-6">
                            <asp:TextBox ID="txtBoxCity" Visible="true" class="form-control" Placeholder="city/taluka" runat="server"></asp:TextBox>
                        </div><!-- /.col-lg-6 -->
                        <div class="col-lg-6">
                            <asp:DropDownList ID="ddlRequestedRole" class="form-control"  runat="server">
                               <%-- <asp:ListItem>Member</asp:ListItem>--%>
                                <asp:ListItem>Student</asp:ListItem>
							</asp:DropDownList>
                        </div><!-- /.col-lg-6 -->
                        <div class="col-lg-6">
                            <asp:DropDownList ID="ddlState" class="form-control" DataTextField="StateName" DataValueField="StateID" runat="server">
						   </asp:DropDownList>
                        </div><!-- /.col-lg-6 -->
                        <div class="col-lg-12">
                            <asp:DropDownList ID="ddlEducationCentre" class="form-control" DataTextField="OrganizationName" DataValueField="OrganizationID" runat="server">
						   </asp:DropDownList>
                        </div><!-- /.col-lg-12 -->
                        <div class="col-lg-12">
                            <asp:TextBox ID="txtBoxAddress" Visible="true" class="form-control" Placeholder="Address" runat="server"></asp:TextBox>
                        </div><!-- /.col-lg-12 -->
                         <!--Captcha-->
                                    <div class="col-lg-12">  
                                            
                                            <asp:Image ID="Image2" runat="server" Height="55px" ImageUrl="~/Captcha.aspx" Width="186px" />  
                                            <br />  
                                            <asp:Label Style="background-color:red;color:white;" runat="server" ID="lblCaptchaMessage"></asp:Label> 
             
                                            <asp:TextBox CssClass="col-lg-12"  runat="server" Style="color:black;" placeholder="EnterAboveCode" ID="txtVerificationCode"></asp:TextBox>  
                                    </div>
                                
                                    <div class="col-lg-12"></div>
                                    <div class="col-lg-12"></div>
									
                                <!--Captcha-->	
                        <div class="col-lg-12">
                            <asp:TextBox ID="txtBoxComments" Visible="true"  Placeholder="Remarks /Additional Message" runat="server"></asp:TextBox>
                            
                            <div class="text-center">
                                <%--<button type="submit" class="contact-one__btn thm-btn">Submit</button>--%>
                                <asp:LinkButton ID="lnkBtnSubmit" class="contact-one__btn thm-btn" OnCommand="RequestAccess" Text="Submit" runat="server"></asp:LinkButton>
                            </div><!-- /.text-center -->
                        </div><!-- /.col-lg-12 -->
                    </div><!-- /.row -->
                </form><!-- /.contact-one__form -->
                <div class="result text-center"></div><!-- /.result -->
            </div><!-- /.container -->
        </section><!-- /.contact-one -->
</asp:Content>
