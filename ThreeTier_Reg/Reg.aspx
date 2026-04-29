<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Reg.aspx.cs" Inherits="ThreeTier_Reg.Reg" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>User Profile Management</title>
    <link href="Styles.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div class="container">
            
            <div class="card">
                <h2>👤 User Registration</h2>
                <div class="form-grid">
                    <div class="form-group">
                        <label>First Name</label>
                        <asp:TextBox ID="txtFirstName" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvFN" runat="server" ControlToValidate="txtFirstName" 
                         ErrorMessage="First name is required" CssClass="error" Display="Dynamic" EnableClientScript="true" SetFocusOnError="true"/>
                    </div>

                    <div class="form-group">
                        <label>Last Name</label>
                        <asp:TextBox ID="txtLastName" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvLN" runat="server" ControlToValidate="txtLastName" 
                          ErrorMessage="Last name is required" CssClass="error" Display="Dynamic" />
                    </div>

                    <div class="form-group">
                        <label>Mobile (Used for Find/Update/Delete)</label>
                        <div style="display:flex;">
                        <asp:TextBox ID="txtMobile" runat="server" style="flex:1;"></asp:TextBox>
                        <asp:Button ID="btnFetch" runat="server" Text="Find" OnClick="btnFetch_Click" 
                            CausesValidation="false" CssClass="btn btn-fetch" />
                    </div>
                        <asp:RequiredFieldValidator ID="rfvMob" runat="server" ControlToValidate="txtMobile" 
                           ErrorMessage="Mobile is required" CssClass="error" Display="Dynamic" />
                        <asp:RegularExpressionValidator ID="revMobile" runat="server" 
                                ControlToValidate="txtMobile"
                                ValidationExpression="^[0-9]{10}$"
                                ErrorMessage="Enter a valid 10-digit mobile number."
                                CssClass="error" Display="Dynamic" />

                    </div>
                    <div class="form-group">
                        <label>Email Address</label>
                        <asp:TextBox ID="txtEmail" runat="server" TextMode="Email"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" 
                         ErrorMessage="Email is required" CssClass="error" Display="Dynamic" />
                        <asp:CustomValidator ID="cvEmailUnique" runat="server" 
                            ControlToValidate="txtEmail" 
                            OnServerValidate="cvEmailUnique_ServerValidate" 
                            ErrorMessage="Email already exists!" 
                            ForeColor="Red" Display="Dynamic" />
                    </div>
                    <div class="form-group">
                        <label>Password</label>
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvPass" runat="server" ControlToValidate="txtPassword" 
                         ErrorMessage="Password required" CssClass="error" Display="Dynamic" />
                    </div>

                    <div class="form-group">
                        <label>Confirm Password</label>
                        <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvCPass" runat="server" ControlToValidate="txtConfirmPassword" 
                         ErrorMessage="Please confirm password" CssClass="error" Display="Dynamic" />
                        <asp:CompareValidator ID="cvPasswordMatch" runat="server" 
                            ControlToCompare="txtPassword" 
                            ControlToValidate="txtConfirmPassword" 
                            ErrorMessage="Passwords do not match!" 
                            CssClass="error" Display="Dynamic" 
                            Operator="Equal" Type="String" />
                    </div>

                    <div class="form-group">
                        <label>Gender</label>
                        <div class="radio-group">
                            <asp:RadioButton ID="rbMale" runat="server" Text=" Male" GroupName="gender"  />
                            <asp:RadioButton ID="rbFemale" runat="server" Text=" Female" GroupName="gender" />
                            <asp:CustomValidator ID="cvGender" runat="server" 
                             OnServerValidate="cvGender_ServerValidate" 
                                ErrorMessage="Gender is required" 
                                CssClass="error" 
                                Display="Dynamic" />
                        </div>
                    </div>

                    <div class="form-group">
                        <label>Hobbies</label>
                        <div class="check-group">
                            <asp:CheckBox ID="chkCricket" runat="server" Text=" Cricket" />
                            <asp:CheckBox ID="chkMusic" runat="server" Text=" Music" />
                            <asp:CheckBox ID="chkReading" runat="server" Text=" Reading" />
                        </div>
                    </div>

                   <div class="form-group" style="grid-column: span 2;">
                    <label>Date of Birth</label>
                    <div class="dob-container">
                        <asp:DropDownList ID="ddlDay" runat="server"></asp:DropDownList>
        
                        <asp:DropDownList ID="ddlMonth" runat="server">
                            <asp:ListItem Text="Month" Value="0" />
                            <asp:ListItem Text="Jan" Value="1" />
                            <asp:ListItem Text="Feb" Value="2" />
                            <asp:ListItem Text="Mar" Value="3" />
                            <asp:ListItem Text="Apr" Value="4" />
                            <asp:ListItem Text="May" Value="5" />
                            <asp:ListItem Text="Jun" Value="6" />
                            <asp:ListItem Text="Jul" Value="7" />
                            <asp:ListItem Text="Aug" Value="8" />
                            <asp:ListItem Text="Sep" Value="9" />
                            <asp:ListItem Text="Oct" Value="10" />
                            <asp:ListItem Text="Nov" Value="11" />
                            <asp:ListItem Text="Dec" Value="12" />
                           
                        </asp:DropDownList>
        
                        <asp:DropDownList ID="ddlYear" runat="server"></asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfvMonth" runat="server" ControlToValidate="ddlMonth" 
                         InitialValue="0" ErrorMessage="Select Month" CssClass="error" Display="Dynamic" />
                    </div>
                </div>
                </div>
                </div>
        

                <div class="button-section">
                    <asp:Button ID="btnSubmit" runat="server" Text="Register" OnClick="btnSubmit_Click" CssClass="btn btn-submit" />
                    <asp:Button ID="btnUpdate" runat="server" Text="Update" OnClick="btnUpdate_Click" CausesValidation="false" CssClass="btn btn-update" />
                    <asp:Button ID="btnDelete" runat="server" Text="Delete" OnClick="btnDelete_Click" CausesValidation="false" CssClass="btn btn-delete" OnClientClick="return confirm('Delete?');" />
    
                    <asp:Button ID="btnViewAll" runat="server" Text="View All" OnClick="btnViewAll_Click" CausesValidation="false" CssClass="btn btn-update" style="background-color: #9b59b6;" />
    
                    <asp:Button ID="btnReset" runat="server" Text="Reset" OnClick="btnReset_Click" CausesValidation="false" CssClass="btn btn-reset" />
                </div>
                
                <asp:Label ID="lblDisplay" runat="server" Text=""></asp:Label>
            </div>

            <div class="card">
                <h3>System Records</h3>
                <div class="grid-container">
   
    <div class="grid-wrapper">
        <asp:GridView ID="gvUserInfo" runat="server" AutoGenerateColumns="False" 
            CssClass="modern-grid" GridLines="None">
            <Columns>
                <asp:BoundField DataField="UserID" HeaderText="ID" />
                <asp:BoundField DataField="FirstName" HeaderText="First Name" />
                <asp:BoundField DataField="LastName" HeaderText="Last Name" />
                <asp:BoundField DataField="Mobile" HeaderText="Mobile" />
                <asp:BoundField DataField="Email" HeaderText="Email" />
                <asp:BoundField DataField="Gender" HeaderText="Gender" />
                <asp:BoundField DataField="Hobbies" HeaderText="Hobbies" />
                <asp:BoundField DataField="DOB" HeaderText="DOB" DataFormatString="{0:yyyy-MM-dd}" />
            </Columns>
        </asp:GridView>
    </div>
</div>
                
            </div>

        
    </form>
</body>
</html>