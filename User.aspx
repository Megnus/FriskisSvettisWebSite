<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="User.aspx.cs" Inherits="User" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <head>
        <meta charset="utf-8">	
        <script src="js/jquery-1.10.2.js"></script>
        <script src="js/jquery-ui-1.10.4.custom.js"></script>
        <script type="text/javascript" src="js/jquery.timepicker.js"></script>
        <link rel="stylesheet" type="text/css" href="css/jquery.timepicker.css" />
        <link rel="stylesheet" type="text/css" href="css/jquery-ui-1.10.4.custom.css">
        <link rel="stylesheet" type="text/css" href="css/user.css" /> 
    </head>
    <p id="button-header">Lägg till ett pass</p>
    <p class="round-button"><a href="User.aspx?Add" class="round-button">+</a></p>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <script src="js/user.js"></script>
    <link rel="stylesheet" type="text/css" href="css/user.css" /> 
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:FriskisSvettisConnectionString %>" 
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
    <asp:SqlDataSource ID="SqlDataSourceFacility" runat="server" ConnectionString="<%$ ConnectionStrings:FriskisSvettisConnectionString %>" SelectCommand="SELECT [Namn] FROM [Anlaggning]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTrainingCategory" runat="server" ConnectionString="<%$ ConnectionStrings:FriskisSvettisConnectionString %>" SelectCommand="SELECT [Namn] FROM [Traningsform]"></asp:SqlDataSource>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="GetEmployees" TypeName="EmployeeBLL"></asp:ObjectDataSource>   
    <p id="table-header">Mina pass</p> 
    <asp:GridView ID="SetGrid" runat="server" AutoGenerateColumns="False" Width="100%" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="10" ForeColor="Black" GridLines="Horizontal" AllowSorting="True" DataKeyNames="PassID" DataSourceID="SqlDataSource1">
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
        <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
        <HeaderStyle  Font-Bold="False" ForeColor="#444444" HorizontalAlign="Left" BackColor="#F5FCF5" />
        <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Left" />
        <SelectedRowStyle BackColor="#CC3333" Font-Bold="False" ForeColor="White" />
        <SortedAscendingCellStyle BackColor="#F7F7F7" />
        <SortedAscendingHeaderStyle BackColor="Silver" />
        <SortedDescendingCellStyle BackColor="#F7F7F7" />
        <SortedDescendingHeaderStyle BackColor="Silver" />
    </asp:GridView>
    <br/>
    <br/>
    <asp:GridView ID="FreeGrid" runat="server" AutoGenerateColumns="False" DataSourceID="ObjectDataSource1" Width="100%" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="10" ForeColor="Black" GridLines="Horizontal" AllowSorting="True" OnRowCommand="FreeGrid_RowCommand" DataKeyNames="PassID" OnRowDataBound="FreeGrid_RowDataBound">    
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
        <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
        <HeaderStyle  Font-Bold="False" ForeColor="#444444" HorizontalAlign="Left" BackColor="#FAFAFA" />
        <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Left" />
        <SelectedRowStyle BackColor="#CC3333" Font-Bold="False" ForeColor="White" />
        <SortedAscendingCellStyle BackColor="#F7F7F7" />
        <SortedAscendingHeaderStyle BackColor="Silver" />
        <SortedDescendingCellStyle BackColor="#F7F7F7" />
        <SortedDescendingHeaderStyle BackColor="Silver" />
    </asp:GridView>
    <div id="background-wrapper-div" class="wrapper-div"></div>
    <div id="forground-wrapper-div" class="wrapper-div">
        <div id="div-pass">
           <form method="POST" action="User.aspx">
            <p class="message-p">.</p>
            <asp:Label runat="server" Text="Datum" Width="115px" Font-Size="Small" Font-Names="Verdana"></asp:Label>
            <input type="text" id="datepicker" name="datepicker"  /><br/>
            <asp:Label runat="server" Text="Starttid" Width="115px" Font-Size="Small" Font-Names="Verdana"></asp:Label>
            <input id="timepicker" name="someElement" type="text" data-time-format="H:i:s" /><br/>
            <asp:Label runat="server" Text="Anläggning" Width="115px" Font-Size="Small" Font-Names="Verdana"></asp:Label>
            <asp:DropDownList ID="DropDownListFacility" runat="server" DataSourceID="SqlDataSourceFacility" DataTextField="Namn" DataValueField="Namn" CssClass="DropDownList"></asp:DropDownList><br/>
            <asp:Label runat="server" Text="Träningsform" Width="115px" Font-Size="Small" Font-Names="Verdana"></asp:Label>
            <asp:DropDownList id="DropDownListTrainingCategory" runat="server" DataSourceID="SqlDataSourceTrainingCategory" DataTextField="Namn" DataValueField="Namn" CssClass="DropDownList"></asp:DropDownList><br/>
            <asp:Button ID="CreatePassButton" CssClass="send-button" runat="server" Text="Skapa pass" runat="server" BackColor="#FFFBFF" BorderColor="black" BorderStyle="dotted" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.9em" Height="25px" Width="204px" OnClick="CreatePassButton_Click" />
            </form>
        </div>
        <div id="div-settings">  
            <p id="message" class="message-p">Du måste fylla i alla uppgifter...</p>
            <asp:Label runat="server" Text="Namn" Width="110px" Font-Size="Small" Font-Names="Verdana"></asp:Label>
            <asp:TextBox ID="tbxNamn" CssClass="textbox" Text="" runat="server" BorderColor="black" BorderStyle="Solid" BorderWidth="1px" Height="20px" Width="200px"></asp:TextBox><br>
            <asp:Label runat="server" Text="Telefonnummer" Width="110px" Font-Size="Small" Font-Names="Verdana"></asp:Label>
            <asp:TextBox ID="tbxTelefon" CssClass="textbox" runat="server" BorderColor="black" BorderStyle="Solid" BorderWidth="1px" Height="20px" Width="200px"></asp:TextBox><br>
            <asp:Label runat="server" Text="E-mail" Width="110px" Font-Size="Small" Font-Names="Verdana"></asp:Label>
            <asp:TextBox ID="tbxEmail" CssClass="textbox" runat="server" BorderColor="black" BorderStyle="Solid" BorderWidth="1px" Height="20px" Width="200px"></asp:TextBox><br>
            <asp:Label runat="server" Text="Personnummer" Width="110px" Font-Size="Small" Font-Names="Verdana"></asp:Label>
            <asp:TextBox ID="tbxPersonNum" CssClass="textbox" runat="server" BorderColor="black" BorderStyle="Solid" BorderWidth="1px" Height="20px" Width="200px"></asp:TextBox><br>
            <asp:Button ID="SaveSettingsButton" CssClass="send-button" runat="server" Text="Spara ändringar" BackColor="#FFFBFF" BorderColor="black" BorderStyle="dotted" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.9em" Height="25px" Width="204px" OnClick="SaveSettingsButton_Click" />
        </div>
        <div id="cancel-button-wrapper">  
            <asp:Button ID="CancelButton" CssClass="send-button" runat="server" Text="Återgå" runat="server" BackColor="#FFFBFF" BorderColor="black" BorderStyle="dotted" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.9em" Height="25px" Width="204px" OnClick="CancelButton_Click" />
        </div>
    </div>  
</asp:Content>

