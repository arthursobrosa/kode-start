# Rick & Morty

Aplicativo desenvolvido para o **Desafio Kode Start 2025**.  
Este app consome a [Rick and Morty API](https://rickandmortyapi.com/) para listar personagens e exibir seus detalhes.

## Funcionalidades

- **Listagem de personagens**: cada personagem é mostrado através de um card com sua imagem e seu nome.

- **Página de detalhes**: ao clicar em um card, o usuário é redirecionado para uma página de detalhes que contém
  nome, imagem, espécie, gênero, status, origem, última localização e primeira aparição.

- **Refresh**: também há um refresh para recarregar os personagens.

![listagem-refresh](https://github.com/user-attachments/assets/b73c5064-7513-47f4-8e7d-186458f43b89)

<br>

Note, também, que um círculo aparece
  ao lado do status/espécie do personagem. Vivo 🟢, Morto 🔴 ou Desconhecido ⚪️

<p>
  <img width="250" height="560" alt="alive" src="https://github.com/user-attachments/assets/dfe87acc-c690-42e1-9315-b13cdc833c43" />
  <img width="250" height="560" alt="dead" src="https://github.com/user-attachments/assets/9633a6be-488c-4221-b51c-71e25aa11500" />
  <img width="250" height="560" alt="unknown" src="https://github.com/user-attachments/assets/af015fbe-6487-4178-9194-7a2894b955e0" />
</p>

<br>


- **Paginação**: ao scrollar a lista até o final, a próxima página contendo mais personagens é carregada, até que todos estejam visíveis na tela.

![paginacao](https://github.com/user-attachments/assets/2f491f48-e9cf-41ee-95f4-c13695259ac7)


<br>

- **Pesquisa**: o usuário pode, também, utilizar a lupa para abrir a barra de pesquisa e visualizar todos os personagens correspondentes.
  
![pesquisa](https://github.com/user-attachments/assets/c57b3345-dc77-4b8d-8fe7-c6efb940e678)


<br>


- **Filtros**: para ampliar o escopo da pesquisa, o usuário pode escolhar entre uma lista de filtros para procurar o personagem que deseja. Esses filtros são, na verdade,
  os "query parameters" listados na documentação da API utilizada.

![filtros](https://github.com/user-attachments/assets/86d8ec20-5e45-41e7-8592-ef2284cf3d9e)


<br>


Caso não haja resultados para a pesquisa, o usuário recebe uma empty view:


<img width="300" height="648" alt="empty" src="https://github.com/user-attachments/assets/7e8f6294-09da-4faa-be6f-f739e67ba58d" />


<br>


- **Menu Lateral**: ao clicar no menu lateral na parte superior esquerda da Home, o usuário pode escolher entre três listas a serem visualizadas:
  Personagens 🙋, Episódios 🎬 e Localizações 🗺️. Essas listas também podem ser filtradas a partir dos seus "query parameters" correspondentes (personagens -> nome, status,
  espécie e gênero; episódios -> nome e código do episódio, tipo S01E10; localizações -> nome, tipo e dimensão).

![menu](https://github.com/user-attachments/assets/b6b90c62-9a7a-4ad0-8c51-9e91089ab9d7)


<br>


- **Configurações**: ao clicar no ícone de perfil, outro drawer é aberto, dessa vez da direita para a esquerda. Perceba que ele pode ser aberto tanto a partir da Home, quanto
  a partir da página de detalhes.

![settings](https://github.com/user-attachments/assets/c0f8db31-0129-4f31-a8ca-a76dce14798d)


<br>


- **Dark/Light Mode**: ao entrar na página de configurações o usuário pode escolher mudar de dark para light mode e vice-versa.
  
![light](https://github.com/user-attachments/assets/174c14c2-2cc2-4d96-903c-66551d327c69)


<br>


- **Detalhes**: todos os componentes que mostram alguma entidade (personagem, episódio ou localização) possuem um shimmer para ocupar seu espaço durante o carregamento. E a AppBar pode ser
  expandida ou colapsada.


<br>

___

<br>


## Arquitetura e organização do código

- **MVVM**: para esse desafio, decidi utilizar view models que cuidassem da lógica de negócios das minhas pages. Já os models foram os CharacterModel, EpisodeModel e LocationModel. A ViewModel se conecta com a page e realiza as requições à API, devolvendo os models já construídos.
  
<p align="center">
  <img width="500" height="300" alt="models" src="https://github.com/user-attachments/assets/304b1ba5-ad1e-4d52-9987-e63efaa15b29" />
  <img width="500" height="270" alt="pages" src="https://github.com/user-attachments/assets/16525683-b5b5-4d85-a993-9c1852addab0" />
  <img width="500" height="300" alt="viewmodels" src="https://github.com/user-attachments/assets/65373b29-7796-47d3-a5c0-e70aa1a70302" />
</p>


<br>


- **Serviço de API**: para realizar as requisições de forma abstrata, criei métodos genéricos dentro da minha classe de serviço, o que me possibilitou trabalhar com
  os três tipos de entidades disponíveis na [documentação](https://rickandmortyapi.com/documentation).

<img width="832" height="280" alt="Screenshot 2025-08-12 at 17 02 25" src="https://github.com/user-attachments/assets/5352a584-8343-4324-92d0-ddcbd18dbe07" />


<br>
<br>


- **Componentes**: todos os componentes (widgets) foram armazenados juntos para facilitar a organização.

<img width="400" height="600" alt="Screenshot 2025-08-12 at 17 05 31" src="https://github.com/user-attachments/assets/4d582c95-63be-4b18-ace0-a119be979eeb" />


<br>
<br>


- **Temas**: para facilitar a reutilização de estilos e cores, criei classes responsáveis por organizar o tema do app. Foi de grande ajuda para a implementação
  do Dark/Light mode, inclusive 😅
  
<img width="600" height="700" alt="Screenshot 2025-08-12 at 17 07 34" src="https://github.com/user-attachments/assets/09188f1d-ff19-450b-91d5-aba2a39e9335" />

___


## Utilização

Para rodar abra o projeto no seu IDE de preferência e rode ***flutter pub get*** e ***flutter run***

___

## Agradecimentos

Muito obrigado pela oportunidade de poder fazer parte deste grande projeto! Tenho certeza que as habilidades que adquiri aqui serão muito importantes no meu futuro 
como desenvolvedor 😀





