<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Programs.aspx.cs" Inherits="EduSpherePro.Programs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <section class="inner-banner">
            <div class="container">
                <ul class="list-unstyled thm-breadcrumb">
                    <li><a href="#">Home</a></li>
                    <li class="active"><a href="#">Programs</a></li>
                </ul><!-- /.list-unstyled -->
                <h2 class="inner-banner__title">Programs</h2><!-- /.inner-banner__title -->
            </div><!-- /.container -->
        </section><!-- /.inner-banner -->
        <section class="course-one course-page">
            <div class="container">
                <div class="row">
                    <asp:DataList ID="dlPrograms" RepeatColumns="2" RepeatDirection="Horizontal" runat="server">
                        <HeaderStyle />
                        <ItemStyle />
                        <ItemTemplate>
                            <div class="col-lg-12">
                            <div class="course-one__single">
                            <div class="course-one__image">
                                <img src="<%#Eval("ProgramImagePath") %>" alt="">
                                <i class="far fa-heart"></i><!-- /.far fa-heart -->
                            </div><!-- /.course-one__image -->
                            <div class="course-one__content">
                                <a href="#" class="course-one__category"><%# Eval("ProgramGroup") %></a><!-- /.course-one__category -->
                                <div class="course-one__admin">
                                    <img src="Content/TemplateSite/images/team-1-1.jpg" alt="">
                                    by <a href="teacher-details.html">SJA Mumbai</a>
                                </div><!-- /.course-one__admin -->
                                <%--<asp:Label ID="lblProgramTitle" Text='<%# Eval("ProgramTitle") %>' runat="server"></asp:Label>--%>
                                <h2 class="course-one__title"><a href="course-details.html"><%# Eval("ProgramTitle") %></a></h2>
                                <!-- /.course-one__title -->
                                <div class="course-one__stars">
                                    <span class="course-one__stars-wrap">
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                    </span><!-- /.course-one__stars-wrap -->
                                    <span class="course-one__count">4.8</span><!-- /.course-one__count -->
                                    <span class="course-one__stars-count">250</span><!-- /.course-one__stars-count -->
                                </div><!-- /.course-one__stars -->
                                <div class="course-one__meta">
                                    <a href="course-details.html"><i class="far fa-clock"></i> <%# Eval("ProgramDuration") %> months</a>
                                    <a href="course-details.html"><i class="far fa-folder-open"></i> 126 Lectures</a>
                                    <a href="course-details.html"><i class="fas fa-rupee-sign"></i><%# Eval("ProgramCost") %></a>
                                </div><!-- /.course-one__meta -->
                                <p class="course-details__comment-text"><%# Eval("ProgramDescription") %></p>
                                <a href="enquiry" class="course-one__link">Enquire Now</a><!-- /.course-one__link -->
                            </div><!-- /.course-one__content -->
                        </div><!-- /.course-one__single -->
                    </div><!-- /.col-lg-12 -->

                        </ItemTemplate>
                    </asp:DataList>

                    
                </div><!-- /.row -->
                <%--<div class="post-pagination">
                    <a href="#"><i class="fa fa-angle-double-left"></i><!-- /.fa fa-angle-double-left --></a>
                    <a class="active" href="#">1</a>
                    <a href="#">2</a>
                    <a href="#">3</a>
                    <a href="#">4</a>
                    <a href="#"><i class="fa fa-angle-double-right"></i><!-- /.fa fa-angle-double-left --></a>
                </div>--%><!-- /.post-pagination -->

            </div><!-- /.container -->
        </section><!-- /.course-one course-page -->
</asp:Content>
