<%@ Page Language="C#" AutoEventWireup="true" EnableEventValidation="false" CodeBehind="Test_WebHook.aspx.cs" Inherits="EduSpherePro.Test.Test_WebHook" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
         <!--New Enquiry -->
    <div class="row">
        <div class="col-xs-12">
            <!-- PAGE CONTENT BEGINS -->
            <!--Add New Enquiry-->
            <asp:Panel ID="pnlAddEnquiry" ScrollBars="Auto" runat="server">
                <form class="form-horizontal" role="form">
                    <table id="simple-table" class="table  table-bordered table-hover">
                        <tbody>
                            <tr>
                                <th</th>
                                <td></td>
                                <th class="col-sm-1">Program</th>
                                <td><asp:DropDownList ID="ddlProgramId"  runat="server">
                                        <asp:ListItem>100</asp:ListItem>
                                        <asp:ListItem>101</asp:ListItem>
                                    </asp:DropDownList></td>
                            </tr>
                            <tr>
                                <th class="col-sm-1">Preferred Centre</th>
                                <td><asp:DropDownList ID="ddlFranchiseeID"  runat="server">
                                        <asp:ListItem>100</asp:ListItem>
                                        <asp:ListItem>101</asp:ListItem>
                                    </asp:DropDownList></td>
                                <th class="col-sm-1">Comments</th>
                                <td><asp:TextBox ID="txtBoxEnquiryMessage" TextMode="MultiLine" runat="server"></asp:TextBox></td> 
                            </tr>
                            <tr>
                                <th class="col-sm-1">Name</th>
                                <td><asp:TextBox ID="txtBoxStudentName" runat="server"></asp:TextBox></td>
                                <th class="col-sm-1">City</th>
                                <td><asp:TextBox ID="txtBoxCity" runat="server"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <th class="col-sm-1">Email</th>
                                <td><asp:TextBox ID="txtBoxEmail" runat="server"></asp:TextBox></td>
                                <th class="col-sm-1">Phone</th>
                                <td><asp:TextBox ID="txtBoxPhone" runat="server"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <th class="col-sm-1">Gender</th>
                                <td><asp:DropDownList ID="ddlGender" runat="server">
                                        <asp:ListItem>MALE</asp:ListItem>
                                        <asp:ListItem>FEMALE</asp:ListItem>
                                    </asp:DropDownList></td>
                                <th class="col-sm-1">Education</th>
                                <td><asp:TextBox ID="txtBoxEducation" placeholder="highest education" runat="server"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <th class="col-sm-1">School/College</th>
                                <td><asp:TextBox ID="txtBoxInstitute" runat="server"></asp:TextBox></td>
                                <th class="col-sm-1">Stream</th>
                                <td><asp:TextBox ID="txtBoxStream" placeholder="Science/Commenrce/Arts" runat="server"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <th class="col-sm-1">State</th>
                                <td><asp:TextBox ID="txtBoxState" runat="server"></asp:TextBox></td>
                                <th class="col-sm-1">PinCode</th>
                                <td><asp:TextBox ID="txtBoxPinCode" runat="server"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <th class="col-sm-1">Raised By Id</th>
                                <td><asp:Label ID="lblRaisedById"  runat="server"></asp:Label></td>
                                <th class="col-sm-1">Enquiry Source</th>
                                <td><asp:TextBox ID="txtBoxSource" placeholder="Enquiry Source"  runat="server"></asp:TextBox></td>
                            </tr>
                            
                        </tbody>
                    </table>


                    <div class="clearfix form-actions">
                        <div class="col-md-offset-3 col-md-9">
                            <asp:LinkButton ID="btnSubmit" class="btn btn-info" Text='<i class="ace-icon fa fa-check bigger-110"></i>Submit' OnCommand="SendUrl" runat="server"></asp:LinkButton>
                            &nbsp; &nbsp; &nbsp;
                            
							
                        </div>
                    </div>
                    <br />
                    <br />
                </form>
            </asp:Panel>
        </div>
        <!-- /.col -->
    </div>
    <!-- /.row -->
    
    </div>
    </form>
</body>
</html>
