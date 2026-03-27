# Execution of Darkness Wikia — Foundation Overlay

Esse pacote foi montado para ser aplicado por cima do seu repositório atual `Execution-of-Darkness-Wikia`,
que já está em WebForms .NET Framework 4.8.

## O que ele adiciona
- Base de domínio da wiki
- Entity Framework 6
- `WikiDbContext`
- Seed inicial
- Página admin de Schema Compare
- Páginas-base de navegação da wiki
- Ajustes de `Web.config`, `packages.config`, `Site.Master` e `Default.aspx`

## Como aplicar
1. Feche o Visual Studio.
2. Extraia este pacote por cima da pasta do projeto.
3. No `.csproj`, aceite substituir pelo arquivo deste pacote.
4. Abra a solução no VS2022.
5. Restaure os pacotes NuGet.
6. Compile o projeto.
7. Rode a aplicação.
8. Acesse:
   - `/`
   - `/Pages/Characters/CharacterList.aspx`
   - `/Pages/Factions/FactionList.aspx`
   - `/Pages/Locations/LocationList.aspx`
   - `/Pages/Timeline/TimelineList.aspx`
   - `/Pages/Admin/SchemaCompare.aspx`

## Observações
- A connection string padrão está apontando para `LocalDB`.
- O schema compare compara a estrutura esperada em código contra o banco atual.
- O projeto está preparado para crescer depois com CRUD, upload, editor HTML e autenticação admin.
