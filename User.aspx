<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" Theme="Theme" AutoEventWireup="true" CodeFile="User.aspx.cs" Inherits="User" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <%--Imports--%>
    <head>
        <meta charset="utf-8">	
        <script type="text/javascript" src="js/jquery.timepicker.js"></script>
        <link rel="stylesheet" type="text/css" href="css/jquery.timepicker.css" />
        <link rel="stylesheet" type="text/css" href="css/jquery-ui-1.10.4.custom.css">
    </head>
    <%--Button markup--%>
    <p id="button-header">Lägg till ett pass</p>
    <p class="round-button"><a href="User.aspx?Add" class="round-button">+</a></p>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <%--Imports--%>
    <head>
        <script src="js/user.js"></script>
        <link rel="stylesheet" type="text/css" href="css/global.css" />
    </head>
    <%--Connections--%>
    <asp:SqlDataSource ID="SqlDataSourceUser" runat="server" ConnectionString="<%$ ConnectionStrings:FriskisSvettisConnectionString %>" 
        SelectCommand="SELECT DISTINCT Pass.PassID, Pass.Datum, Anlaggning.Namn, Vikarie.Namn, NewLeader.Namn, Traningsform.Namn FROM Pass 
            LEFT JOIN Vikarie ON Pass.OrdinarieLedare = Vikarie.VikarieID 
            LEFT JOIN Vikarie as NewLeader ON Pass.NyLedare = NewLeader.VikarieID 
            LEFT JOIN Anlaggning ON Pass.Anlaggning = Anlaggning.AnlaggningID 
            LEFT JOIN Traningsform ON Pass.TraningsForm = Traningsform.TraningsformID LEFT JOIN Respons ON Pass.PassID = Respons.PassID 
            WHERE Pass.NyLedare = (SELECT Vikarie.VikarieID FROM Vikarie WHERE Anvandarnamn = @UserName) 
                OR (Pass.OrdinarieLedare = (SELECT Vikarie.VikarieID FROM Vikarie WHERE Anvandarnamn = @UserName) 
                AND Pass.NyLedare IS NULL)">
        <SelectParameters>
            <asp:Parameter Name="UserName"/>
        </SelectParameters>
    </asp:SqlDataSource>  
    <asp:SqlDataSource ID="SqlDataSourceFacility" runat="server" ConnectionString="<%$ ConnectionStrings:FriskisSvettisConnectionString %>" 
        SelectCommand="SELECT [Namn] FROM [Anlaggning]">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTrainingCategory" runat="server" ConnectionString="<%$ ConnectionStrings:FriskisSvettisConnectionString %>" 
        SelectCommand="SELECT [Namn] FROM [Traningsform]">
    </asp:SqlDataSource>
    <asp:ObjectDataSource ID="ObjectDataSourceUser" runat="server" 
        SelectMethod="GetFreePass" TypeName="QueryResult">
    </asp:ObjectDataSource>
    <%--Grid views--%>
    <%--My selected pass--%>
    <p id="table-header">Mina pass</p> 
    <asp:GridView ID="SetGrid" CssClass="grid-view" runat="server" DataKeyNames="PassID" DataSourceID="SqlDataSourceUser" style="margin-top:0px;">
        <Columns>
            <asp:BoundField DataField="PassID" HeaderText="PassID" SortExpression="PassID" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol">
                <HeaderStyle CssClass="hiddencol"></HeaderStyle>
                <ItemStyle CssClass="hiddencol"></ItemStyle>
            </asp:BoundField>
            <asp:BoundField DataField="Datum" HeaderText="Datum" SortExpression="Datum" />
            <asp:BoundField DataField="Namn1" HeaderText="Ordinarie ledare" SortExpression="Namn1" />
            <asp:BoundField DataField="Namn2" HeaderText="Vikarierande ledare" SortExpression="Namn2"/>
            <asp:BoundField DataField="Namn" HeaderText="Anläggning" SortExpression="Namn"/>            
            <asp:BoundField DataField="Namn3" HeaderText="Pass" SortExpression="Namn3" />
        </Columns>
        <HeaderStyle BackColor="#F5FCF5" />
    </asp:GridView>
    <br/>
    <br/>
    <%--The available pass--%>
    <asp:GridView ID="FreeGrid" runat="server" DataSourceID="ObjectDataSourceUser" OnRowCommand="FreeGrid_RowCommand" DataKeyNames="PassID" OnRowDataBound="FreeGrid_RowDataBound">    
        <Columns>
            <asp:BoundField DataField="PassID" HeaderText="PassID" SortExpression="PassID" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol">
                <HeaderStyle CssClass="hiddencol"></HeaderStyle>
                <ItemStyle CssClass="hiddencol"></ItemStyle>
            </asp:BoundField>
            <asp:BoundField DataField="Datum" HeaderText="Datum" SortExpression="Datum" />
            <asp:BoundField DataField="Anvandarnamn" HeaderText="Ledare" SortExpression="Anvandarnamn" />            
            <asp:BoundField DataField="Namn" HeaderText="Anläggning" SortExpression="Namn" />
            <asp:BoundField DataField="Namn1" HeaderText="Pass" SortExpression="Namn1" />
            <asp:ButtonField ButtonType="Button" HeaderText="Tacka ja" CommandName="JaCommand" Text="Ja" />
            <asp:ButtonField ButtonType="Button" HeaderText="Tacka nej" CommandName="NejCommand" Text="Nej" />
        </Columns>
        <HeaderStyle BackColor="#FAFAFA" />
    </asp:GridView>
    <%--Input fields--%>
    <%--Background div--%>
    <div class="wrapper-div"></div>
    <%--Wrapper div--%>
    <div id="forground-wrapper-div" class="wrapper-div">
        <%--Input fields for adding a pass--%>
        <div id="div-pass">
           <form method="POST" action="User.aspx">
            <p class="message-p">.</p>
            <asp:Label runat="server" Text="Datum"></asp:Label>
            <input type="text" id="datepicker" name="datepicker" /><br/>
            <asp:Label runat="server" Text="Starttid"></asp:Label>
            <input id="timepicker" name="someElement" type="text" data-time-format="H:i:s" /><br/>
            <asp:Label runat="server" Text="Anläggning"></asp:Label>
            <asp:DropDownList ID="DropDownListFacility" CssClass="DropDownList" runat="server" DataSourceID="SqlDataSourceFacility" DataTextField="Namn" DataValueField="Namn"></asp:DropDownList><br/>
            <asp:Label runat="server" Text="Träningsform"></asp:Label>
            <asp:DropDownList id="DropDownListTrainingCategory" CssClass="DropDownList" runat="server" DataSourceID="SqlDataSourceTrainingCategory" DataTextField="Namn" DataValueField="Namn"></asp:DropDownList><br/>
            <asp:Button ID="CreatePassButton" CssClass="send-button" runat="server" Text="Skapa pass" OnClick="CreatePassButton_Click" />
            </form>
        </div>
        <%--Input fields for user settings--%>
        <div id="div-settings">  
            <p id="message" class="message-p">Du måste fylla i alla uppgifter...</p>
            <asp:Label runat="server" Text="Namn"></asp:Label>
            <asp:TextBox ID="tbxNamn" CssClass="textbox" Text="" runat="server"></asp:TextBox><br>
            <asp:Label runat="server" Text="Telefonnummer"></asp:Label>
            <asp:TextBox ID="tbxTelefon" CssClass="textbox" runat="server"></asp:TextBox><br>
            <asp:Label runat="server" Text="E-mail"></asp:Label>
            <asp:TextBox ID="tbxEmail" CssClass="textbox" runat="server"></asp:TextBox><br>
            <asp:Label runat="server" Text="Personnummer"></asp:Label>
            <asp:TextBox ID="tbxPersonNum" CssClass="textbox" runat="server"></asp:TextBox><br>
            <asp:Button ID="SaveSettingsButton" CssClass="send-button" runat="server" Text="Spara ändringar" OnClick="SaveSettingsButton_Click" />
        </div>
        <div id="cancel-button-wrapper">  
            <asp:Button ID="CancelButton" CssClass="send-button" runat="server" Text="Återgå" OnClick="CancelButton_Click" />
        </div>
    </div>  
</asp:Content>

