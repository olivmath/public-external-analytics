# "Análise Comparativa de Consumo de Gás: Public vs External em Funções Solidity"

## **ABSTRACT**

Você já se perguntou se deveria usar **public** ou **external** em suas funções Solidity para otimizar o consumo de gás? O consenso popular (e até o GPT) sugere que **external** é mais eficiente em chamadas externas, mas será que isso é sempre verdade?

Decidi testar e analisar a diferença de gas entre **public** ou **external** em suas funções Solidity.

Primeiro, fiz testes simples, depois aumentei a complexidade utilizando **Fuzz Testing** para explorar uma maior variedade de inputs. Os resultados revelaram algumas nuances interessantes.

---

## **METODOLOGIA**

### 1. **Sem Fuzz Testing:**

- Escrevi funções que alteram dados no storage usando **public** e **external**.
- Os tipos de dados testados foram: `uint256`, `string`, `uint8[]`.
- Cada função foi chamada 256 vezes com valores fixos para comparar o consumo de gás.

### 2. **Com Fuzz Testing:**

- Substituí os valores fixos por entradas dinâmicas (geradas aleatoriamente pelo Foundry).
- Usei a ferramenta `vm.assume()` para garantir que os arrays tivessem pelo menos um elemento.
- Cada função foi chamada 512 vezes com uma variedade de entradas para testar cenários mais realistas.

---

## **RESULTADOS**

### **1. Sem Fuzz Testing**

Os testes com valores fixos apresentaram um comportamento consistente e resultados previsíveis.

| **Função**          | **Gas (min)** | **Gas (média)** | **Gas (máx)** | **Chamadas** |
| ------------------- | ------------- | --------------- | ------------- | ------------ |
| `setNumberPublic`   | 43563         | 43563           | 43563         | 256          |
| `setNumberExternal` | 43606         | 43606           | 43606         | 256          |
| `setNamePublic`     | 44835         | 44835           | 44835         | 256          |
| `setNameExternal`   | 44858         | 44858           | 44858         | 256          |
| `setArrayPublic`    | 80929         | 80929           | 80929         | 256          |
| `setArrayExternal`  | 81017         | 81017           | 81017         | 256          |

#### **Principais Observações:**

1. **Diferença mínima entre `public` e `external`**:

- O modificador **public** foi ligeiramente mais eficiente em todas as funções.
- A diferença foi de apenas algumas unidades de gás, praticamente irrelevante em aplicações reais.

2. **Arrays custam mais gás**:

- Manipular arrays consome significativamente mais gás do que strings ou números inteiros.

---

### **2. Com Fuzz Testing**

Os testes com entradas dinâmicas revelaram mais nuances no comportamento das funções.

| **Função**          | **Gas (min)** | **Gas (média)** | **Gas (máx)** | **Chamadas** |
| ------------------- | ------------- | --------------- | ------------- | ------------ |
| `setNumberPublic`   | 23627         | 43489           | 43911         | 512          |
| `setNumberExternal` | 23670         | 43418           | 43954         | 512          |
| `setNamePublic`     | 24511         | 56166           | 112317        | 512          |
| `setNameExternal`   | 24534         | 55169           | 112352        | 512          |
| `setArrayPublic`    | 78223         | 156711          | 389889        | 512          |
| `setArrayExternal`  | 58399         | 150677          | 390115        | 512          |

#### **Principais Observações:**

1. **Maior variabilidade no gás consumido**:

- Para strings e arrays, os valores de entrada influenciaram bastante o consumo de gás.
- A função **external** lidou melhor com entradas maiores no caso de arrays.

2. **Consistência para números (`uint256`)**:

- Para entradas simples como `uint256`, o consumo de gás foi estável e similar ao teste sem Fuzz.

---

## **DISCUSSÃO**

1. **`public` vs `external`:**

- Em chamadas externas, a diferença entre os dois foi insignificante, especialmente para tipos simples.

2. **Impacto do tamanho dos dados:**

- Para strings e arrays, o tamanho e o conteúdo dos dados influenciam significativamente o consumo de gás.
- **external** teve um desempenho ligeiramente melhor em arrays grandes.

3. **Limitações do Teste Sem Fuzz:**

- Usar valores fixos pode mascarar comportamentos que só aparecem com entradas variadas.
- O **Fuzz Testing** revelou cenários em que a diferença de desempenho entre **public** e **external** foi ampliada.

---

## **CONCLUSÃO**

1. **Chame internamente?** Prefira **public**.

- Ele consome menos gás em chamadas internas.

2. **Chame externamente?** Use **external**.

- Especialmente em cenários com arrays grandes, **external** se sai ligeiramente melhor.

3. **Use Fuzz Testing!**

- Ele revela comportamentos que testes tradicionais podem não captar, ajudando a identificar gargalos de desempenho.
