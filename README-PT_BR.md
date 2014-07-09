# Arquivos da Força

Mais do que dotfiles! São meus Arquivos da Força! xD


## Sobre

Já estava cansado de ter que digitar comandos longos no *bash* e ter que organizar uma estrutura inicial para meus projetos sempre. Tudo estava espalhado, um verdadeiro desperdício de tempo! Foi por isso, que decidi construir este repositório.

Percebi que poderia dividir meus arquivos de automação, atalhos do bash, configurações do meu editor e um monte de coisas das principais áreas que eu uso no meu trabalho.

**Mas por que um repositório?** É muito simples! Mesmo que algum dia ou em algum lugar eu precisar dele, ele estará lá. Para que eu possa verificar, escolher alguma parte ou baixá-lo para o meu sistema recentemente formatado.

> Observação: estou rodando em Mac OS X. Estes são os arquivos de configuração para configurar um sistema do jeito que eu utilizo em meu ambiente de trabalho.


## Instalação

```bash
$ bash -c "$(curl -fsSL raw.github.com/vitorbritto/forcefiles/master/bin/forcefiles)"
```


## Uso

**Opções**

- `./forcefiles --help`: instruções de uso
- `./forcefiles --list`: lista com todos os aplicativos e dependências a serem instaladas

**Scripts**

Existem alguns scripts opcionais que armazenei na pasta `scripts` para utilizar no durante meu fluxo de trabalho. Estes podem ser executados com o `alias` listado abaixo.

- `vms`: faz o download de vms, incluindo vagrant e virtualbox.
- `ahost`, `dhost`: adiciona e remove virtual hosts.
- `up`: atualiza o workflow.
- `yoda`: script para favoritar links.
- `mify`: uma ferramenta de desenvolvimento front-end para extrair classes, ids e hrefs de um documento HTML.
- `bkp`: script para backup de arquivos importantes.
- `nexus`: inicia um web server em _python_ ou _php_ com uma **porta** opcional.
- `call`: clona meus repositórios (para ser utilizado com o [octolist](https://www.npmjs.org/package/octolist) por enquanto).


## Agradecimentos

* [@necolas](https://github.com/necolas) (Nicolas Gallagher)
  [https://github.com/necolas/dotfiles](https://github.com/necolas/dotfiles)
* [@mathiasbynens](https://github.com/mathiasbynens) (Mathias Bynens)
  [https://github.com/mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles)
* [@cowboy](https://github.com/cowboy) (Ben Alman)
  [https://github.com/cowboy/dotfiles](https://github.com/cowboy/dotfiles)


> Que o ARQUIVOS DA FORÇA esteja com você! :)
