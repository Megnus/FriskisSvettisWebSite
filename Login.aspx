<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" Theme="Theme" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <%--Imports--%>
    <head>
        <script src="js/login.js"></script>
        <link rel="stylesheet" type="text/css" href="css/global.css" />
    </head> 
    <%--Connections--%>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:FriskisSvettisConnectionString %>" 
        SelectCommand="SELECT DISTINCT Pass.PassID, Pass.Datum, Anlaggning.Namn, Vikarie.Namn, Traningsform.Namn FROM Pass 
            LEFT JOIN Vikarie ON Pass.OrdinarieLedare = Vikarie.VikarieID 
            LEFT JOIN Anlaggning ON Pass.Anlaggning = Anlaggning.AnlaggningID 
            LEFT JOIN Traningsform ON Pass.TraningsForm = Traningsform.TraningsformID LEFT JOIN Respons ON Pass.PassID = Respons.PassID 
            WHERE Pass.NyLedare IS NULL">
    </asp:SqlDataSource>
    <%--Grid views--%>
    <asp:GridView style="margin-top:20px" ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" Width="100%" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="10" ForeColor="Black" GridLines="Horizontal" AllowSorting="True" DataKeyNames="PassID">
        <Columns>
            <asp:BoundField DataField="PassID" HeaderText="PassID" InsertVisible="False" ReadOnly="True" SortExpression="PassID" Visible="False" />
            <asp:BoundField DataField="Datum" HeaderText="Datum" SortExpression="Datum" />
            <asp:BoundField DataField="Namn1" HeaderText="Ordinarie ledare" SortExpression="Namn1" />
            <asp:BoundField DataField="Namn" HeaderText="Anläggning" SortExpression="Namn" />
            <asp:BoundField DataField="Namn2" HeaderText="Träningsform" SortExpression="Namn2" />
        </Columns>
        <HeaderStyle BackColor="#FAFAFA" />
    </asp:GridView>
    <%--Input fields--%>
    <div id="background-wrapper-div" class="wrapper-div" style="height:220px"></div>
    <div id="forground-wrapper-div" class="wrapper-div">
        <%--User login--%>
        <div id="login-user">
            <asp:Login ID="Login1" runat="server"  DestinationPageUrl="~/User.aspx" FailureAction="RedirectToLoginPage" OnLoggedIn="loggedin"></asp:Login>
        </div>
        <div id="create-user">
            <asp:CreateUserWizard ID="CreateUserWizard1" runat="server" OnCreatedUser="CreateUserWizard1_CreatedUser" CreateUserButtonText="Skapa användare">
                <WizardSteps>
                    <asp:CreateUserWizardStep ID="CreateUserWizardStep1" runat="server" title=""/>
                    <asp:CompleteWizardStep ID="CompleteWizardStep1" runat="server" />
                </WizardSteps>
            </asp:CreateUserWizard>
        </div>
        <%--Creating user--%>
        <div id="radio-button-wrapper"> 
	        <input type="radio" name="radio-group" id="first-choice" value="login-user" checked="checked"/>
	        <label for="first-choice">Logga in</label><br/>
	        <input type="radio" name="radio-group" id="second-choice" value="create-user"/>
	        <label for="second-choice">Skapa användare</label><br/><br/>
            <asp:Button ID="Button1" runat="server" Text="Återgå" OnClick="Button1_Click" />
        </div>    
    </div>
</asp:Content>


