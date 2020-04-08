<%@ Page Title="Contact" Language="C#" MasterPageFile="~/Site.Master" EnableEventValidation="false" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="EduSpherePro.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
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
                    <li class="active"><a href="#">Contact</a></li>
                </ul><!-- /.list-unstyled -->
                <h2 class="inner-banner__title">Contact</h2><!-- /.inner-banner__title -->
            </div><!-- /.container -->
        </section><!-- /.inner-banner -->
        <section class="contact-info-one">
            <div class="container">
                <div class="row">
                    <div class="col-lg-4">
                        <div class="contact-info-one__single wow fadeInDown" data-wow-duration="1500ms">
                            <div class="contact-info-one__icon"><i class="kipso-icon-manager"></i><!-- /.kipso-icon-manager -->
                            </div><!-- /.contact-info-one__icon -->
                            <h2 class="contact-info-one__title">About Us </h2><!-- /.contact-info-one__title -->
                            <p class="contact-info-one__text">Lorem ipsum is simply free text <br> available in the market to
                                use <br>
                                deliver satisfaction.</p><!-- /.contact-info-one__text -->
                        </div><!-- /.contact-info-one__single -->
                    </div><!-- /.col-lg-4 -->
                    <div class="col-lg-4">
                        <div class="contact-info-one__single wow fadeInUp" data-wow-duration="1500ms">
                            <div class="contact-info-one__icon"><i class="kipso-icon-placeholder"></i>
                                <!-- /.kipso-icon-manager -->
                            </div><!-- /.contact-info-one__icon -->
                            <h2 class="contact-info-one__title">Head Office</h2><!-- /.contact-info-one__title -->
                            <p class="contact-info-one__text">206/2B, N.G. Suncity Phase II, <br>
                                Thakur Village, Kandivali (E) <br> Mumbai 400 101</p><!-- /.contact-info-one__text -->
                        </div><!-- /.contact-info-one__single -->
                    </div><!-- /.col-lg-4 -->
                    <div class="col-lg-4">
                        <div class="contact-info-one__single wow fadeInDown" data-wow-duration="1500ms">
                            <div class="contact-info-one__icon"><i class="kipso-icon-contact"></i><!-- /.kipso-icon-manager -->
                            </div><!-- /.contact-info-one__icon -->
                            <h2 class="contact-info-one__title">Contact Info</h2><!-- /.contact-info-one__title -->
                            <p class="contact-info-one__text">welcome@poonamshuklainstitute.in <br>
                                +91 777 702 3021 <br> &nbsp; </p><!-- /.contact-info-one__text -->
                        </div><!-- /.contact-info-one__single -->
                    </div><!-- /.col-lg-4 -->
                </div><!-- /.row -->
            </div><!-- /.container -->
        </section><!-- /.contact-info-one -->


        <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d4562.753041141002!2d-118.80123790098536!3d34.152323469614075!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x80e82469c2162619%3A0xba03efb7998eef6d!2sCostco+Wholesale!5e0!3m2!1sbn!2sbd!4v1562518641290!5m2!1sbn!2sbd" class="google-map__contact" allowfullscreen></iframe>
</asp:Content>
