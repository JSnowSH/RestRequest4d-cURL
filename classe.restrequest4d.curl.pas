unit classe.restrequest4d.curl;

interface

uses
  System.SysUtils,
  System.Classes,
  RESTRequest4D;

type
  TCurlRequestWrapper = class
  private
    FRequest  : IRequest;
    FBaseURL  : string;
    FResource : string;
    FHeaders  : TStringList;
    FParams   : TStringList;
    FBody     : string;
    FMethod   : string;

    function BuildCurl: string;
  public
    constructor Create;
    destructor Destroy; override;

    class function New: TCurlRequestWrapper;

    function BaseURL(const AValue: string): TCurlRequestWrapper;
    function Resource(const AValue: string): TCurlRequestWrapper;
    function AddHeader(const AName, AValue: string): TCurlRequestWrapper;
    function AddParam(const AName, AValue: string): TCurlRequestWrapper;
    function AddBody(const AContent: string): TCurlRequestWrapper;

    function Get: IResponse;
    function Post: IResponse;
    function Put: IResponse;
    function Delete: IResponse;

    function Request: IRequest;  // retorna o IRequest real
    function ToCurl: string;
  end;

implementation

{ TCurlRequestWrapper }

constructor TCurlRequestWrapper.Create;
begin
  FRequest := TRequest.New;
  FHeaders := TStringList.Create;
  FParams  := TStringList.Create;
end;

destructor TCurlRequestWrapper.Destroy;
begin
  FHeaders.Free;
  FParams.Free;
  inherited;
end;

class function TCurlRequestWrapper.New: TCurlRequestWrapper;
begin
  Result := Self.Create;
end;

function TCurlRequestWrapper.BaseURL(const AValue: string): TCurlRequestWrapper;
begin
  FBaseURL := AValue;
  FRequest.BaseURL(AValue);
  Result := Self;
end;

function TCurlRequestWrapper.Resource(const AValue: string): TCurlRequestWrapper;
begin
  FResource := AValue;
  FRequest.Resource(AValue);
  Result := Self;
end;

function TCurlRequestWrapper.AddHeader(const AName, AValue: string): TCurlRequestWrapper;
begin
  FHeaders.Add(AName + ': ' + AValue);
  FRequest.AddHeader(AName, AValue);
  Result := Self;
end;

function TCurlRequestWrapper.AddParam(const AName, AValue: string): TCurlRequestWrapper;
begin
  FParams.Add(AName + '=' + AValue);
  FRequest.AddParam(AName, AValue);
  Result := Self;
end;

function TCurlRequestWrapper.AddBody(const AContent: string): TCurlRequestWrapper;
begin
  FBody := AContent;
  FRequest.AddBody(AContent);
  Result := Self;
end;

function TCurlRequestWrapper.Get: IResponse;
begin
  FMethod := 'GET';
  Result := FRequest.Get;
end;

function TCurlRequestWrapper.Post: IResponse;
begin
  FMethod := 'POST';
  Result := FRequest.Post;
end;

function TCurlRequestWrapper.Put: IResponse;
begin
  FMethod := 'PUT';
  Result := FRequest.Put;
end;

function TCurlRequestWrapper.Delete: IResponse;
begin
  FMethod := 'DELETE';
  Result := FRequest.Delete;
end;

function TCurlRequestWrapper.Request: IRequest;
begin
  Result := FRequest;
end;

function TCurlRequestWrapper.BuildCurl: string;
var
  I: Integer;
  LURL: string;
begin
  Result := 'curl -X ' + FMethod;

  LURL := FBaseURL + FResource;

  if FParams.Count > 0 then
    LURL := LURL + '?' + StringReplace(FParams.CommaText, ',', '&', [rfReplaceAll]);

  Result := Result + ' "' + LURL + '"';

  for I := 0 to FHeaders.Count - 1 do
    Result := Result + ' -H "' + FHeaders[I] + '"';

  if (FBody <> '') and (FMethod <> 'GET') then
    Result := Result + ' --data-raw ''' +
      StringReplace(FBody, '''', '\''', [rfReplaceAll]) + '''';
end;

function TCurlRequestWrapper.ToCurl: string;
begin
  Result := BuildCurl;
end;

end.
