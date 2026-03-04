# 🚀 RestRequest4D cURL Wrapper

Wrapper para **RestRequest4D** que permite:

- Executar requisições normalmente
- Gerar automaticamente o **cURL equivalente**
- Facilitar debug e logging de APIs
- Manter o padrão fluent do RestRequest4D

---

## 📦 Instalação

Basta adicionar a unit `classe.restrequest4d.curl` ao seu projeto Delphi.

Requer:
- Delphi
- RestRequest4D

---

## 🛠 Como Usar

### Exemplo Completo (Console)

```delphi
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
        .AddBody('{"nome":"Nilton"}');

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
```

---

## 📤 Exemplo de cURL Gerado

```bash
curl -X POST \
  "https://api.exemplo.com/usuarios?pagina=1" \
  -H "Authorization: Bearer 123" \
  -H "Content-Type: application/json" \
  --data-raw '{"nome":"Nilton"}'
```

---

## 🎯 Objetivo

O RestRequest4D não permite acessar diretamente os dados internos da requisição para gerar um cURL.

Este wrapper resolve isso armazenando:

- BaseURL
- Resource
- Headers
- Params
- Body
- Método HTTP

E gerando o cURL correspondente antes ou depois da execução.

---

## ✅ Vantagens

✔ Não implementa `IRequest`  
✔ Não acessa membros privados  
✔ Mantém fluent interface  
✔ Compatível com qualquer versão do RestRequest4D  
✔ Ideal para debug e auditoria  

---

## 📄 Licença

Use livremente em seus projetos.
