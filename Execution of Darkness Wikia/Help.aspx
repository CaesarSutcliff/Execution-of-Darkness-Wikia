<%@ Page Title="Ajuda" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Help.aspx.cs" Inherits="Execution_of_Darkness_Wikia.Help" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <link href="~/Content/eod-characters.css" rel="stylesheet" />

    <div class="eod-page-hero">
        <h1>Centro de Ajuda</h1>
        <p>Guias, tutoriais e referências para contribuir com a Wiki Execution of Darkness. Aprenda a criar artigos, editar conteúdo, usar comentários e navegar pelo universo da saga.</p>
    </div>

    <div class="eod-details-layout">
        <div>
            <div class="eod-details-section">
                <h3>Primeiros Passos</h3>
                <p>Para começar a contribuir com a wiki:</p>
                <ol style="color:var(--eod-muted); line-height:2; padding-left:1.2rem;">
                    <li>Crie sua conta na página de <a class="eod-link" href="/Account/Register.aspx">Registro</a> ou faça <a class="eod-link" href="/Account/Login.aspx">Login</a></li>
                    <li>Navegue pelas seções: Personagens, Facções, Locais, Linha do Tempo e Artigos</li>
                    <li>Clique em "Editar" em qualquer artigo para contribuir com conteúdo</li>
                    <li>Sempre descreva suas mudanças no campo "Resumo da Mudança" ao salvar</li>
                    <li>Use a visualização prévia antes de publicar para conferir a formatação</li>
                </ol>
            </div>

            <div class="eod-details-section">
                <h3>Editando Artigos</h3>
                <p>A wiki suporta formatação básica para organizar o conteúdo dos artigos:</p>
                <div class="eod-detail-grid">
                    <div class="eod-detail-fact"><strong>Negrito</strong><code>**texto**</code></div>
                    <div class="eod-detail-fact"><strong>Itálico</strong><code>*texto*</code></div>
                    <div class="eod-detail-fact"><strong>Título</strong><code># Título</code></div>
                    <div class="eod-detail-fact"><strong>Subtítulo</strong><code>## Subtítulo</code></div>
                    <div class="eod-detail-fact"><strong>Link</strong><code>[texto](url)</code></div>
                    <div class="eod-detail-fact"><strong>Lista</strong><code>- Item da lista</code></div>
                </div>
                <div style="margin-top:1rem;">
                    <p>Dicas para bons artigos:</p>
                    <ul style="color:var(--eod-muted); line-height:2; padding-left:1.2rem;">
                        <li>Use títulos descritivos e claros</li>
                        <li>Mantenha o resumo conciso (máximo 500 caracteres)</li>
                        <li>Verifique a visualização antes de salvar</li>
                        <li>Cite fontes e referências quando apropriado</li>
                        <li>Evite spoilers desnecessários nos resumos</li>
                    </ul>
                </div>
            </div>

            <div class="eod-details-section">
                <h3>Sistema de Comentários</h3>
                <p>Os comentários permitem discussões organizadas em cada artigo:</p>
                <ul style="color:var(--eod-muted); line-height:2; padding-left:1.2rem;">
                    <li>Discuta mudanças propostas antes de editar</li>
                    <li>Faça perguntas sobre o conteúdo do universo</li>
                    <li>Sugira melhorias e correções</li>
                    <li>Reporte erros ou inconsistências no lore</li>
                    <li>Use a função "Responder" para manter conversas organizadas em threads</li>
                </ul>
                <div class="eod-details-section" style="margin-top:1rem; background:rgba(138,31,53,.08); border-color:rgba(138,31,53,.2);">
                    <h3 style="font-size:1rem;">Regras da Comunidade</h3>
                    <p>Seja respeitoso e construtivo. Evite spoilers desnecessários. Mantenha o foco no conteúdo da wiki. Comentários ofensivos serão removidos.</p>
                </div>
            </div>

            <div class="eod-details-section">
                <h3>Histórico de Versões</h3>
                <p>Cada edição cria uma nova versão do artigo, permitindo rastrear todas as mudanças:</p>
                <ul style="color:var(--eod-muted); line-height:2; padding-left:1.2rem;">
                    <li>Veja todas as versões anteriores de um artigo</li>
                    <li>Identifique quem fez cada mudança e quando</li>
                    <li>Leia o resumo de cada alteração</li>
                    <li>O histórico completo fica disponível na página de edição</li>
                </ul>
            </div>

            <div class="eod-details-section">
                <h3>Estrutura da Wiki</h3>
                <p>A wiki é organizada em seções temáticas para facilitar a navegação:</p>
                <div class="eod-detail-grid">
                    <div class="eod-detail-fact"><strong>Personagens</strong>Perfis completos com biografia, relações, facção, status e habilidades</div>
                    <div class="eod-detail-fact"><strong>Facções</strong>Ordens, casas nobres, alianças e grupos de poder</div>
                    <div class="eod-detail-fact"><strong>Locais</strong>Cidades, ruínas, acadêmias, mansões e zonas hostis</div>
                    <div class="eod-detail-fact"><strong>Linha do Tempo</strong>Eventos cronológicos organizados por era e importância</div>
                    <div class="eod-detail-fact"><strong>Artigos</strong>Conteúdo livre sobre qualquer aspecto do universo</div>
                    <div class="eod-detail-fact"><strong>Schema Compare</strong>Ferramenta administrativa para validar o banco de dados</div>
                </div>
            </div>
        </div>

        <div>
            <div class="eod-details-section">
                <h3>Links Rápidos</h3>
                <ul class="eod-rel-list">
                    <li><a class="eod-link" href="/Pages/Articles/ArticleList.aspx">Lista de Artigos</a></li>
                    <li><a class="eod-link" href="/Pages/Articles/ArticleEdit.aspx">Criar Novo Artigo</a></li>
                    <li><a class="eod-link" href="/Pages/Characters/CharacterList.aspx">Personagens</a></li>
                    <li><a class="eod-link" href="/Pages/Factions/FactionList.aspx">Facções</a></li>
                    <li><a class="eod-link" href="/Pages/Locations/LocationList.aspx">Locais</a></li>
                    <li><a class="eod-link" href="/Pages/Timeline/TimelineList.aspx">Linha do Tempo</a></li>
                    <li><a class="eod-link" href="/Pages/Admin/SchemaCompare.aspx">Schema Compare</a></li>
                </ul>
            </div>

            <div class="eod-details-section">
                <h3>Precisa de Ajuda?</h3>
                <p>Entre em contato através da página de contato ou deixe um comentário em qualquer artigo para tirar dúvidas.</p>
                <a class="eod-btn-alt" href="/Contact.aspx" style="display:inline-block; margin-top:.5rem;">Página de Contato</a>
            </div>

            <div class="eod-details-section">
                <h3>Sobre o Universo</h3>
                <p>Execution of Darkness é uma saga de dark fantasy ambientada em Ostium e arredores, onde demônios, trevas, hierarquia social e degradação espiritual coexistem. A wiki documenta personagens, facções, locais, eventos e toda a mitologia da obra.</p>
            </div>
        </div>
    </div>
</asp:Content>
