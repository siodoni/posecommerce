PL/SQL Developer Test script 3.0
20
declare 
  cursor cCor is
    select a.codigo_html,
           a.descricao
      from cor a
     order by a.descricao;
begin
  dbms_output.put_line('<html>');
  dbms_output.put_line('<body>');
  dbms_output.put_line('<h1> Palheta de cores HTML</h1><p></p>');
  dbms_output.put_line('<table border="1px"><tr>');
  dbms_output.put_line('<tr><td>Nome Cor</td><td>Cor</td><td>Código Cor</td></tr>');  
  for i in cCor
  loop
    dbms_output.put_line('<tr><td>' || i.descricao || '</td>'  ||
                         '<td bgcolor=#' || i.codigo_html || '>&nbsp;</td>'||
                         '<td>#'|| i.codigo_html || '</td></tr>');
  end loop;
  dbms_output.put_line('</tr></table></body></html>');
end;
0
0
