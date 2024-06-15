{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  backoff,
  httpx,
  idna,
  langchain,
  llama-index,
  openai,
  packaging,
  poetry-core,
  pydantic,
  wrapt,
}:

buildPythonPackage rec {
  pname = "langfuse";
  version = "2.36.1";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "langfuse";
    repo = "langfuse-python";
    rev = "refs/tags/v${version}";
    hash = "sha256-qPSkATK+IRgtK43B9nr5rC3zZ7qm+/uBJrm7mVhZyUE=";
  };

  build-system = [ poetry-core ];


  pythonRelaxDeps = [ "packaging" ];

  dependencies = [
    backoff
    httpx
    idna
    packaging
    pydantic
    wrapt
  ];

  optional-dependencies = {
    langchain = [ langchain ];
    llama-index = [ llama-index ];
    openai = [ openai ];
  };

  pythonImportsCheck = [ "langfuse" ];

  # tests require network access and openai api key
  doCheck = false;

  meta = {
    description = "Instrument your LLM app with decorators or low-level SDK and get detailed tracing/observability";
    homepage = "https://github.com/langfuse/langfuse-python";
    changelog = "https://github.com/langfuse/langfuse-python/releases/tag/${src.rev}";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ natsukium ];
  };
}
