<%@ Page Title="" Language="C#" MasterPageFile="~/EduSpherePro/EduSpherePro.Master" AutoEventWireup="true" CodeBehind="Blogs.aspx.cs" Inherits="EduSpherePro.EduSpherePro.Blogs" %>
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
        <div class="col-sm-3">
            <div class="col-sm-3">
                <asp:Label ID="lblRole" Visible="false" runat="server"></asp:Label>
            </div>  
        </div>
        <div class="col-sm-4">
                    <div id="membersbar" class="navbar-buttons navbar-header pull-right" role="navigation">
					    <ul class="nav ace-nav">
						    <li class="light-blue dropdown-modal">
							    <a data-toggle="dropdown" href="#" class="dropdown-toggle">
                                    Blogs <i class="ace-icon fa fa-caret-down"></i> 
							    </a>
							    <ul class="user-menu dropdown-menu-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">					                                               								   
                                    <li>
									    <asp:LinkButton ID="lnkBtnViewBlogs" class="btn btn-purple btn-sm" Text="<span class='ace-icon fa fa-eye icon-on-right bigger-110'></span> View Blogs" OnCommand="ManageBlogPanelVisibility" CommandName="pnlViewBlogs" runat="server"></asp:LinkButton>
								    </li>
                                    <li class="divider"></li>
                                    <li>
                                        <asp:LinkButton ID="lbkBtnViewResult" class="btn btn-xs btn-info" Text="<i class='ace-icon fa fa-plus bigger-120'></i> Create Blog" ToolTip="Create Blog" OnCommand="ManageBlogPanelVisibility"  CommandName="pnlCreateBlog" CommandArgument="" runat="server"></asp:LinkButton>
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

    <!--View Blog-->
    <div class="container">
    <asp:Panel ID="pnlViewBlogs" runat="server">
        <div class="row">
            <div>
                <asp:LinkButton ID="lnkBtnTranslate" class="btn btn-purple btn-sm" Text="<span class='ace-icon fa fa-language icon-on-right bigger-110'></span> HINDI" OnCommand="Translate" CommandName="hi" runat="server"></asp:LinkButton>
            </div>
            <asp:DataList ID="dlBlogsGallery" DataKeyField="BlogID" OnItemDataBound="dlBlogsGallery_ItemDataBound" OnEditCommand="dlBlogsGalleryEditHandler" OnCancelCommand="dlBlogsGalleryCancelHandler" 
                        OnDeleteCommand="dlBlogsGalleryDeleteHandler" OnUpdateCommand="dlBlogsGalleryUpdateHandler" Cellpadding="3" CellSpacing="12"   
                         GridLines="none" runat="server">
                <HeaderTemplate>
                </HeaderTemplate>
                <ItemTemplate>
                    <div class="col-sm-12" style="font-family: Arial, sans-serif; font-size:13px; color: #444444; min-height: 200px;" bgcolor="#E4E6E9" leftmargin="0" topmargin="0" marginheight="0" marginwidth="0">
                    <div class="col-xs-10">
                 <table class="table-row" style="table-layout: auto; padding-right: 24px; padding-left: 24px; width: 600px; background-color: #ffffff;" bgcolor="#FFFFFF" width="600" cellspacing="0" cellpadding="0" border="0">
                    
                        <tbody>
                        <tr height="55px" style="font-family: Arial, sans-serif; line-height: 19px; color: #444444; font-size: 13px; height: 55px;">
                            <td class="table-row-td" style="height: 55px; padding-right: 16px; font-family: Arial, sans-serif; line-height: 19px; color: #444444; font-size: 13px; font-weight: normal; vertical-align: middle;" valign="middle" align="left">
                                <a href="#" style="color: #428bca; text-decoration: none; padding: 0px; font-size: 18px; line-height: 20px; height: 50px; background-color: transparent;">
	                           <asp:Label ID="lblBlogTitle" Text='<%#Eval("Title") %>' runat="server"></asp:Label>
	                            </a>
                            </td>
                       </tr>
                    </tbody>
                </table>
                <!--Space-->
                <table class="table-space" height="6" style="height: 6px; font-size: 0px; line-height: 0; width: 600px; background-color: #e4e6e9;" width="600" bgcolor="#E4E6E9" cellspacing="0" cellpadding="0" border="0"><tbody><tr><td class="table-space-td" valign="middle" height="6" style="height: 6px; width: 600px; background-color: #e4e6e9;" width="600" bgcolor="#E4E6E9" align="left">&nbsp;</td></tr></tbody></table>
                <table class="table-space" height="16" style="height: 16px; font-size: 0px; line-height: 0; width: 600px; background-color: #ffffff;" width="600" bgcolor="#FFFFFF" cellspacing="0" cellpadding="0" border="0"><tbody><tr><td class="table-space-td" valign="middle" height="16" style="height: 16px; width: 600px; background-color: #ffffff;" width="600" bgcolor="#FFFFFF" align="left">&nbsp;</td></tr></tbody></table>
                <!--Main PhotoOne-->
                <table class="table-row" width="600" bgcolor="#FFFFFF" style="table-layout: fixed; background-color: #ffffff;" cellspacing="0" cellpadding="0" border="0"><tbody><tr><td class="table-row-td" style="font-family: Arial, sans-serif; line-height: 19px; color: #444444; font-size: 13px; font-weight: normal; padding-left: 24px; padding-right: 24px;" valign="top" align="left">
                <table class="table-col" align="center" width="552" cellspacing="0" cellpadding="0" border="0" style="table-layout: fixed;"><tbody><tr><td class="table-col-td" width="552" style="font-family: Arial, sans-serif; line-height: 19px; color: #444444; font-size: 13px; font-weight: normal;" valign="top" align="left">	
	                <div style="font-family: Arial, sans-serif; line-height: 19px; color: #444444; font-size: 13px; text-align: center;">
		                <img src="<%# Eval("PhotoOnePath") %>" alt="" style="border: 0px none #444444; vertical-align: middle; display: block; padding-bottom: 9px;" hspace="0" vspace="0" border="0">
	                </div>
                    </td></tr></tbody></table>
                </td></tr></tbody></table>

                <!--Header Row-->
                <table class="table-row" width="600" bgcolor="#FFFFFF" style="table-layout: fixed; background-color: #ffffff;" cellspacing="0" cellpadding="0" border="0"><tbody><tr><td class="table-row-td" style="font-family: Arial, sans-serif; line-height: 19px; color: #444444; font-size: 13px; font-weight: normal; padding-left: 36px; padding-right: 36px;" valign="top" align="left">
                   <table class="table-col" align="left" width="528" cellspacing="0" cellpadding="0" border="0" style="table-layout: fixed;"><tbody><tr><td class="table-col-td" width="528" style="font-family: Arial, sans-serif; line-height: 19px; color: #444444; font-size: 13px; font-weight: normal;" valign="top" align="left">
	                 <table class="header-row" width="528" cellspacing="0" cellpadding="0" border="0" style="table-layout: fixed;"><tbody><tr><td class="header-row-td" width="528" style="font-size: 28px; margin: 0px; font-family: Arial, sans-serif; font-weight: normal; line-height: 19px; color: #478fca; padding-bottom: 10px; padding-top: 15px;" valign="top" align="left">Event Highlights</td></tr></tbody></table>
	                 <table class="header-row" width="528" cellspacing="0" cellpadding="0" border="0" style="table-layout: fixed;"><tbody><tr><td class="header-row-td" width="528" style="font-family: Arial, sans-serif; font-weight: normal; line-height: 19px; color: #444444; margin: 0px; font-size: 18px; padding-bottom: 8px; padding-top: 10px;" valign="top" align="left"> <asp:Label ID="lblParaOne" Text='<%#Eval("ParaOne") %>' runat="server"></asp:Label></td></tr></tbody></table>
                        
                   </td></tr></tbody></table>
                </td></tr></tbody></table>
                 
                <!--ParaTwo-->
                <table class="table-space" height="12" style="height: 12px; font-size: 0px; line-height: 0; width: 600px; background-color: #ffffff;" width="600" bgcolor="#FFFFFF" cellspacing="0" cellpadding="0" border="0"><tbody><tr><td class="table-space-td" valign="middle" height="12" style="height: 12px; width: 600px; background-color: #ffffff;" width="600" bgcolor="#FFFFFF" align="left">&nbsp;</td></tr></tbody></table>
                <table class="table-row" width="600" bgcolor="#FFFFFF" style="table-layout: fixed; background-color: #ffffff;" cellspacing="0" cellpadding="0" border="0"><tbody><tr><td class="table-row-td" style="font-family: Arial, sans-serif; line-height: 19px; color: #444444; font-size: 13px; font-weight: normal; padding-left: 36px; padding-right: 36px;" valign="top" align="left">
                   <table class="table-col" align="left" width="528" cellspacing="0" cellpadding="0" border="0" style="table-layout: fixed;"><tbody><tr><td class="table-col-td" width="528" style="font-family: Arial, sans-serif; line-height: 19px; color: #444444; font-size: 13px; font-weight: normal;" valign="top" align="left">
	                 <table width="100%" cellspacing="0" cellpadding="0" border="0" style="table-layout: fixed;"><tbody><tr><td width="100%" bgcolor="#d9edf7" style="font-family: Arial, sans-serif; line-height: 19px; color: #31708f; font-size: 14px; font-weight: normal; padding: 15px; border: 1px solid #bce8f1; background-color: #d9edf7;" valign="top" align="left">
	                   <asp:Label ID="lblParaTwo" Text='<%#Eval("ParaTwo") %>' runat="server"></asp:Label>
	                   <br>
	                 
	                 </td></tr></tbody></table>
                      <table width="100%" cellspacing="0" cellpadding="0" border="0" style="table-layout: fixed;"><tbody><tr><td width="100%" bgcolor="#d9edf7" style="font-family: Arial, sans-serif; line-height: 19px; color: #31708f; font-size: 14px; font-weight: normal; padding: 15px; border: 1px solid #bce8f1; background-color: #d9edf7;" valign="top" align="left">
	                   <asp:Label ID="lblParaThree" Text='<%#Eval("ParaThree") %>' runat="server"></asp:Label>
	                   <br>
	                 
	                 </td></tr></tbody></table>
                   </td></tr></tbody></table>
                </td></tr></tbody></table>

                <!--Photos-Two and Three Header-->
                <table class="table-row" width="600" bgcolor="#FFFFFF" style="table-layout: fixed; background-color: #ffffff;" cellspacing="0" cellpadding="0" border="0"><tbody><tr><td class="table-row-td" style="font-family: Arial, sans-serif; line-height: 19px; color: #444444; font-size: 13px; font-weight: normal; padding-left: 36px; padding-right: 36px;" valign="top" align="left">
                     <table class="table-col" align="left" width="528" cellspacing="0" cellpadding="0" border="0" style="table-layout: fixed;"><tbody><tr><td class="table-col-td" width="528" style="font-family: Arial, sans-serif; line-height: 19px; color: #444444; font-size: 13px; font-weight: normal; width: 528px;" valign="top" align="left">
                      <table class="header-row" width="528" cellspacing="0" cellpadding="0" border="0" style="table-layout: fixed;"><tbody><tr><td class="header-row-td" width="528" style="font-family: Arial, sans-serif; font-weight: normal; line-height: 19px; color: #6397bf; margin: 0px; font-size: 18px; padding-bottom: 8px; padding-top: 10px;" valign="top" align="left">Event Pictures</td></tr></tbody></table>
                     </td></tr></tbody></table>
                    </td></tr></tbody></table>

                <!--Photo Two-->
                <table class="table-row" width="600" bgcolor="#FFFFFF" style="table-layout: fixed; background-color: #ffffff;" cellspacing="0" cellpadding="0" border="0"><tbody><tr><td class="table-row-td" style="font-family: Arial, sans-serif; line-height: 19px; color: #444444; font-size: 13px; font-weight: normal; padding-left: 36px; padding-right: 36px;" valign="top" align="left">
                   <table class="table-col-border" align="left" width="250" style="padding-right: 16px; table-layout: fixed;" cellspacing="0" cellpadding="0" border="0"><tbody><tr><td class="table-col-td" width="165" style="font-family: Arial, sans-serif; line-height: 19px; color: #444444; font-size: 13px; font-weight: normal;" valign="top" align="left">
	                <img class="pull-left" alt="" src='<%#Eval("PhotoTwoPath") %>' style="border: 0px none #444444; vertical-align: middle; display: block; padding-bottom: 9px;" hspace="0" vspace="0" border="0">
	                <span style="font-family: Arial, sans-serif; line-height: 19px; color: #444444; font-size: 13px;">
		                <a href="#" style="color: #5b7a91; text-decoration: none; background-color: transparent;"><b></b></a>
		                <br>
		               
	                </span>
                   </td></tr></tbody></table>
                    <!--Photo Three-->
                  <table class="table-col-border" align="right" width="250" style="padding-right: 16px; table-layout: fixed;" cellspacing="0" cellpadding="0" border="0"><tbody><tr><td class="table-col-td" width="165" style="font-family: Arial, sans-serif; line-height: 19px; color: #444444; font-size: 13px; font-weight: normal;" valign="top" align="left">
	                <img class="pull-right" alt="" src='<%#Eval("PhotoThreePath") %>' style="border: 0px none #444444; vertical-align: middle; display: block; padding-bottom: 9px;" hspace="0" vspace="0" border="0">
	                <span style="font-family: Arial, sans-serif; line-height: 19px; color: #444444; font-size: 13px;">
		                <a href="#" style="color: #5b7a91; text-decoration: none; background-color: transparent;"><b></b></a>
		                <br>
		                
	                </span>
                   </td></tr></tbody></table>
                </td></tr></tbody></table>
                         <hr />
               </div>

                    <div class="col-xs-2" style="margin-top:200px;">
                        <h3>Status :<asp:Label ID="lblPublishStatus" Text='<%#Eval("PublishStatus") %>' runat="server"></asp:Label></h3>

                        
                                <asp:LinkButton ID="lnkBtnApprove" class="btn btn-pink btn-sm" Text="<span class='ace-icon fa fa-thumbs-up icon-on-right bigger-110'></span>" OnCommand="ManageBlogs" CommandName="APPROVED" CommandArgument='<%#Eval("BlogID") %>' runat="server"></asp:LinkButton><br /><br />
                           
                                <asp:LinkButton ID="lnkBtnReject" class="btn btn-warning  btn-sm" Text="<span class='ace-icon fa fa-thumbs-down icon-on-right bigger-110 red'></span>" OnCommand="ManageBlogs" CommandName="REJECTED" CommandArgument='<%#Eval("BlogID") %>' runat="server"></asp:LinkButton>
                            
                        
                        
                    </div>
            </div>
                </ItemTemplate>
            </asp:DataList>
        </div>
    </asp:Panel>
    </div>
    <!--End Create Blog-->

    <!--Add Blog-->
     <div class="row">
                <asp:Panel ID="pnlAddBlog" runat="server">
                    <div class="col-xs-12">
                    <div class="col-sm-6">
                        <strong>Create New Letter</strong>                   
                        <table class="table  table-bordered table-hover">
                         <tr>    
                            <th>Title:</th>
                            <td> <asp:TextBox ID="txtBoxBlogTitle" runat="server"></asp:TextBox> </td>
                        </tr>           
                        <tr>
                            <th>BlogGroup:</th>
                            <td><asp:DropDownList ID="ddlBlogGroup" runat="server">
                                <asp:ListItem>EVENT</asp:ListItem>
                                <asp:ListItem>TESTIMONIAL</asp:ListItem>
                                <asp:ListItem>TREATMENT</asp:ListItem>            
                            </asp:DropDownList>
                            </td>
                          </tr>
                           <tr>
                                <th>Para One</th>
                                <td><asp:TextBox ID="txtBoxParaOne" Placeholder="Introduction" runat="server"></asp:TextBox> </td>
                                 </tr>
                            <tr> 
                                <th>Para Two</th>
                                <td><asp:TextBox ID="txtBoxParaTwo" Placeholder="Main Content" runat="server"></asp:TextBox> </td>
                            </tr>
                            
                        <tr>
                            <th>Para Three:</th>
                            <td class="span2"><asp:TextBox ID="txtBoxParaThree" Placeholder="Conclusion" runat="server"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <th>ImageOne:</th>
                            <td colspan="1"><asp:FileUpload ID="flOne" runat="server" /></td>
                             </tr>
                            <tr> 
                            <th><asp:Button ID="btnSubmittPhoto" class="btn-1" Text="Upload" OnCommand="CreateBlog" CommandName="UploadBlogImage" CommandArgument="flOne" runat="server" /></th>
                            <td><asp:TextBox ID="txtBoxImageOnePath" runat="server"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <th>ImageTwo:</th>
                            <td colspan="1"><asp:FileUpload ID="flTwo" runat="server" /></td>
                             </tr>
                            <tr> 
                            <td><asp:Button ID="Button1" class="btn-1" Text="Upload" OnCommand="CreateBlog" CommandName="UploadBlogImage" CommandArgument="flTwo" runat="server" /></td>
                            <td><asp:TextBox ID="txtBoxImageTwoPath" runat="server"></asp:TextBox></td>
                            
                         </tr>
                         <tr>
                            <th>ImageThree:</th>
                            <td colspan="1"><asp:FileUpload ID="flThree" runat="server" /></td>
                             </tr>
                            <tr> 
                             <td><asp:Button ID="Button2" class="btn-1" Text="Upload" OnCommand="CreateBlog" CommandName="UploadBlogImage" CommandArgument="flThree" runat="server" /></td>
                             <td><asp:TextBox ID="txtBoxImageThreePath" runat="server"></asp:TextBox></td>
                         </tr>
                         <tr>
                            <td><asp:Button ID="btnSubmit" class="btn btn-1" OnCommand="CreateBlog" CommandName="SubmitNewBlog" Text="Submit"  runat="server" /></td> 
                            <td><asp:Label ID="lblInsertServiceStatus" Style="color:green;" runat="server"></asp:Label> </td>
                             </tr>
                            <tr> 
                             <td><asp:ImageButton ID="imgBtnBack"  ImageUrl="~/Images/Return.png" Width="30px" Height="30px"  ToolTip="Return" OnCommand="ManageBlogPanelVisibility" CommandName="ReturnToMyBlog" runat="server" /></td>
                            <td></td>
                         </tr>
                        </table>
                    </div>
                </asp:Panel>
            
       </div>
    <!--End Add Blog-->
</asp:Content>
