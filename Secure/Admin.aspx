<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Admin.aspx.cs" Inherits="Admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
    <asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder1">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:FriskisSvettisConnectionString %>" 
                SelectCommand="SELECT DISTINCT Pass.PassID, Pass.Datum, Anlaggning.Namn, Vikarie.Namn, NewLeader.Namn, Traningsform.Namn, Pass.AntalNej FROM Pass 
            LEFT JOIN Vikarie ON Pass.OrdinarieLedare = Vikarie.VikarieID 
            LEFT JOIN Vikarie as NewLeader ON Pass.NyLedare = NewLeader.VikarieID 
            LEFT JOIN Anlaggning ON Pass.Anlaggning = Anlaggning.AnlaggningID 
            LEFT JOIN Traningsform ON Pass.TraningsForm = Traningsform.TraningsformID LEFT JOIN Respons ON Pass.PassID = Respons.PassID">

    </asp:SqlDataSource>
<asp:GridView style="margin-top:20px" ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" Width="100%" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="10" ForeColor="Black" GridLines="Horizontal" AllowSorting="True" DataKeyNames="PassID">
    
        <Columns>
            <asp:BoundField DataField="PassID" HeaderText="PassID" InsertVisible="False" ReadOnly="True" SortExpression="PassID" Visible="False" />
            <asp:BoundField DataField="Datum" HeaderText="Datum" SortExpression="Datum" />
            <asp:BoundField DataField="Namn1" HeaderText="Ordinarie ledare" SortExpression="Namn1" />
            <asp:BoundField DataField="Namn2" HeaderText="Vikarierande ledare" SortExpression="Namn2" />

            <asp:BoundField DataField="Namn" HeaderText="Anläggning" SortExpression="Namn" />
            
            <asp:BoundField DataField="Namn3" HeaderText="Träningsform" SortExpression="Namn3" />
            <asp:BoundField DataField="AntalNej" HeaderText="Antal nej" SortExpression="AntalNej"  ItemStyle-HorizontalAlign="Center" >
            <HeaderStyle HorizontalAlign="Center" />
<ItemStyle HorizontalAlign="Center"></ItemStyle>
            </asp:BoundField>
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


