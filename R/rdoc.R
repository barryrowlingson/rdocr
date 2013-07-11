rdoc <- function(s){
    response = GET(makeURL(s))
    rj = fromJSON(rawToChar(response$content))
    class(rj)="rdoc"
    browseURL(rdochtml(rj))
    return(invisible(rj))
}

rdochtml <- function(rd){
tpl='
<html>
<head><title>RDocumentation Search Links</title></head>
<body>
<h1>RDocumentation Search Results</h1>

<h2>Packages</h2>

<table>
<% for(p in rd$packages) { %>
<tr><td><a href="<%=packageURL(p$name)%>"><%= p$name %></a></td></tr>
<% } %>
</table>

<h2>Functions</h2>

<table>
<% for(p in rd$functions) { %>
<tr>
<td><a href="<%=functionURL(p$package_name,p$name)%>"><%=p$name%></a></td>
<td><a href="<%=packageURL(p$package_name)%>">(<%=p$package_name%>)</a></td>
</tr>
<% } %>
</table>

</body>
</html>
'
out = tempfile()

brew(output=out, text=tpl)
out

}

rootURL=function(){"http://www.rdocumentation.org"}

makeURL = function(s){
    sprintf("%s/search/%s",rootURL(),s)
}

functionURL <- function(p,f){
    sprintf("%s/packages/%s/functions/%s",rootURL(),p,f)
}

packageURL <- function(p){
    sprintf("%s/packages/%s",rootURL(),p)
}


