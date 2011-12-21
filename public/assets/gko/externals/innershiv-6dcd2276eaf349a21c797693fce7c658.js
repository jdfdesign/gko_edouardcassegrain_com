/* 
 * https://github.com/jdbartlett/innershiv/commit/f3a44f642df14bd9581fdb8f1b6e1d392b47de20
 * 
 * innerShiv: makes HTML5shim work on innerHTML & jQuery
 * http://jdbartlett.github.com/innershiv
 *
 * This program is free software. It comes without any warranty, to
 * the extent permitted by applicable law. You can redistribute it
 * and/or modify it under the terms of the Do What The Fuck You Want
 * To Public License, Version 2, as published by Sam Hocevar. See
 * http://sam.zoy.org/wtfpl/COPYING for more details.
 */
window.innerShiv=function(){function e(a,b,c){return/^(?:area|br|col|embed|hr|img|input|link|meta|param)$/i.test(c)?a:b+"></"+c+">"}var a,b=document,c,d="abbr article aside audio canvas datalist details figcaption figure footer header hgroup mark meter nav output progress section summary time video".split(" ");return function(f,g){if(!a){a=b.createElement("div"),a.innerHTML="<nav></nav>",c=a.childNodes.length!==1;if(c){var h=b.createDocumentFragment(),i=d.length;while(i--)h.createElement(d[i]);h.appendChild(a)}}f=f.replace(/^\s\s*/,"").replace(/\s\s*$/,"").replace(/<script\b[^<]*(?:(?!<\/script>)<[^<]*)*<\/script>/gi,"").replace(/(<([\w:]+)[^>]*?)\/>/g,e);var j;(j=f.match(/^<(tbody|tr|td|th|col|colgroup|thead|tfoot)[\s\/>]/i))?a.innerHTML="<table>"+f+"</table>":a.innerHTML=f;var k;j?k=a.getElementsByTagName(j[1])[0].parentNode:k=a;if(g===!1)return k.childNodes;var l=b.createDocumentFragment(),m=k.childNodes.length;while(m--)l.appendChild(k.firstChild);return l}}()