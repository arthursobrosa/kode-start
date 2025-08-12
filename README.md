
# Rick & Morty

Aplicativo desenvolvido para o **Desafio Kode Start 2025**.  
Este app consome a [Rick and Morty API](https://rickandmortyapi.com/) para listar personagens e exibir seus detalhes.

## Funcionalidades

- **Listagem de personagens**: cada personagem é mostrado através de um card com sua imagem e seu nome;

- **Página de detalhes**: ao clicar em um card, o usuário é redirecionado para uma página de detalhes que contém
  nome, imagem, espécie, gênero, status, origem, última localização e primeira aparição.

- **Refresh**: também há um refresh para recarregar os personagens;

![listagem-refresh](https://github.com/user-attachments/assets/b73c5064-7513-47f4-8e7d-186458f43b89)

Note, também, que um círculo aparece
  ao lado do status/espécie do personagem. Vivo 🟢, Morto 🔴 ou Desconhecido ⚪️
  
<img width="300" height="648" alt="alive" src="https://github.com/user-attachments/assets/dfe87acc-c690-42e1-9315-b13cdc833c43" />
<img width="300" height="648" alt="dead" src="https://github.com/user-attachments/assets/9633a6be-488c-4221-b51c-71e25aa11500" />
<img width="300" height="648" alt="unknown" src="https://github.com/user-attachments/assets/af015fbe-6487-4178-9194-7a2894b955e0" />


- **Paginação**: ao scrollar a lista até o final, a próxima página contendo mais personagens é carregada, até que todos estejam visíveis na tela;

![paginacao](https://github.com/user-attachments/assets/2f491f48-e9cf-41ee-95f4-c13695259ac7)


- **Pesquisa**: o usuário pode, também, utilizar a lupa para abrir a barra de pesquisa e visualizar todos os personagens correspondentes;
![pesquisa](https://github.com/user-attachments/assets/c57b3345-dc77-4b8d-8fe7-c6efb940e678)


- **Filtros**: para ampliar o escopo da pesquisa, o usuário pode escolhar entre uma lista de filtros para procurar o personagem que deseja. Esses filtros são, na verdade,
  os "query parameters" listados na documentação da API utilizada;

![filtros](https://github.com/user-attachments/assets/86d8ec20-5e45-41e7-8592-ef2284cf3d9e)


Caso não haja resultados para a pesquisa, o usuário recebe uma empty view:

<img width="300" height="648" alt="empty" src="https://github.com/user-attachments/assets/7e8f6294-09da-4faa-be6f-f739e67ba58d" />

- **Menu Lateral**: ao clicar no menu lateral na parte superior esquerda da Home, o usuário pode escolher entre três listas a serem visualizadas:
  Personagens 🙋, Episódios 🎬 e Localizações 🗺️








 
