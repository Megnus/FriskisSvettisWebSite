<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="User.aspx.cs" Inherits="User" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <style type="text/css">
      .hiddencol { display: none; }
    </style>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:FriskisSvettisConnectionString %>" SelectCommand="SELECT DISTINCT Pass.PassID, Pass.Datum, Anlaggning.Namn, Vikarie.Anvandarnamn, Traningsform.Namn FROM Pass LEFT JOIN Vikarie ON Pass.OrdinarieLedare = Vikarie.VikarieID LEFT JOIN Anlaggning ON Pass.Anlaggning = Anlaggning.AnlaggningID LEFT JOIN Traningsform ON Pass.TraningsForm = Traningsform.TraningsformID LEFT JOIN Respons ON Pass.PassID = Respons.PassID WHERE Pass.NyLedare = (SELECT Vikarie.VikarieID FROM Vikarie WHERE Anvandarnamn = @UserName)">
        <SelectParameters>
            <asp:Parameter Name="UserName"/>
        </SelectParameters>
    </asp:SqlDataSource>

    
    

    <p style="padding:10px; border:1px solid #E1E1E1; border-bottom:none; background-color:#F1F1F1; font-family:Verdana; font-size:16px; margin-top:30px; margin-bottom:0px; margin-left: 0px;">Mina pass</p>
    
    <asp:GridView style="margin-top:0px" ID="GridView3" runat="server" AutoGenerateColumns="False" Width="100%" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="10" ForeColor="Black" GridLines="Horizontal" AllowSorting="True" DataKeyNames="PassID" DataSourceID="SqlDataSource1">
        <Columns>
            <asp:BoundField DataField="PassID" HeaderText="PassID" SortExpression="PassID" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol">
                <HeaderStyle CssClass="hiddencol"></HeaderStyle>
                <ItemStyle CssClass="hiddencol"></ItemStyle>
            </asp:BoundField>
            <asp:BoundField DataField="Datum" HeaderText="Datum" SortExpression="Datum" />
            <asp:BoundField DataField="Anvandarnamn" HeaderText="Ledare" SortExpression="Anvandarnamn"/>
            <asp:BoundField DataField="Namn" HeaderText="Anläggning" SortExpression="Namn" />
            <asp:BoundField DataField="Namn1" HeaderText="Pass" SortExpression="Namn1" />
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

    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="GetEmployees" TypeName="EmployeeBLL"></asp:ObjectDataSource>
        
    <p style="padding:10px; border:1px solid #E1E1E1; border-bottom:none; background-color:#F1F1F1; font-family:Verdana; font-size:16px; margin-top:30px; margin-bottom:0px; margin-left: 0px;">Vakanta pass</p>

        <asp:GridView style="margin-top:0px" ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="ObjectDataSource1" Width="100%" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="10" ForeColor="Black" GridLines="Horizontal" AllowSorting="True" OnRowCommand="GridView2_RowCommand" DataKeyNames="PassID" OnRowDataBound="GridView2_RowDataBound">    
        <Columns>
            <asp:BoundField DataField="PassID" HeaderText="PassID" SortExpression="PassID" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol">
                <HeaderStyle CssClass="hiddencol"></HeaderStyle>
                <ItemStyle CssClass="hiddencol"></ItemStyle>
            </asp:BoundField>
            <asp:BoundField DataField="Datum" HeaderText="Datum" SortExpression="Datum" />
            <asp:BoundField DataField="Anvandarnamn" HeaderText="Ledare" SortExpression="Anvandarnamn" />            
            <asp:BoundField DataField="Namn" HeaderText="Anläggning" SortExpression="Namn" />
            <asp:BoundField DataField="Namn1" HeaderText="Pass" SortExpression="Namn1" />
            <asp:ButtonField ButtonType="Button" CommandName="NejCommand" Text="Nej" />
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
</asp:Content>

