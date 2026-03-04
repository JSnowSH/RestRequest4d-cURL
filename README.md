🚀 Exemplo de Uso — TCurlRequestWrapper (RestRequest4D)

Este exemplo demonstra como utilizar a classe TCurlRequestWrapper para:

Criar uma requisição com RestRequest4D

Executar normalmente

Gerar automaticamente o cURL equivalente

Obter a resposta da API

📌 Exemplo Completo
program Project1;

{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  RESTRequest4D,
  classe.restrequest4d.curl;

var
  LReq : TCurlRequestWrapper;
  LResp: IResponse;

begin
  try
    LReq :=
      TCurlRequestWrapper.New
        .BaseURL('https://api.exemplo.com')
        .Resource('/usuarios')
        .AddHeader('Authorization', 'Bearer 123')
        .AddHeader('Content-Type', 'application/json')
        .AddParam('pagina', '1')
        .AddBody('{"nome":"José"}');

    LResp := LReq.Post;

    Writeln('=== CURL GERADO ===');
    Writeln(LReq.ToCurl);
    Writeln;

    Writeln('=== RESPONSE ===');
    Writeln(LResp.Content);

  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

  Readln;
end.
📤 cURL Gerado (Exemplo)
curl -X POST \
  "https://api.exemplo.com/usuarios?pagina=1" \
  -H "Authorization: Bearer 123" \
  -H "Content-Type: application/json" \
  --data-raw '{"nome":"José"}'
