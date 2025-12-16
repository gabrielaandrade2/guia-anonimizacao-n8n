{
  "nodes": [
    {
      "parameters": {
        "path": "arx-guide",
        "formTitle": "Gerador de Guia ARX - Anonimização de Dados",
        "formDescription": "Responda as perguntas abaixo para receber um guia personalizado de anonimização que pode ser utilizado no software ARX - Data Anonymization.",
        "formFields": {
          "values": [
            {
              "fieldLabel": "Qual o nome do Dataset?",
              "placeholder": "Ex.: clientes_2025, vendas_q3, pacientes_hospital",
              "requiredField": true
            },
            {
              "fieldLabel": "Quais tipos de dados existem no seu arquivo? Marque todos os que se aplicam.",
              "fieldType": "checkbox",
              "fieldOptions": {
                "values": [
                  {
                    "option": "Nome completo"
                  },
                  {
                    "option": "CPF/RG"
                  },
                  {
                    "option": "E-mail"
                  },
                  {
                    "option": "Telefone"
                  },
                  {
                    "option": "Endereço"
                  },
                  {
                    "option": "CEP"
                  },
                  {
                    "option": "Cidade"
                  },
                  {
                    "option": "Data de nascimento"
                  },
                  {
                    "option": "Idade"
                  },
                  {
                    "option": "Gênero"
                  },
                  {
                    "option": "Renda"
                  },
                  {
                    "option": "Dados de saúde"
                  }
                ]
              },
              "requiredField": true
            },
            {
              "fieldLabel": "Existe algum dado que possui o mesmo valor em todas as linhas?",
              "fieldType": "dropdown",
              "fieldOptions": {
                "values": [
                  {
                    "option": "Sim"
                  },
                  {
                    "option": "Não"
                  },
                  {
                    "option": "Não sei"
                  }
                ]
              },
              "requiredField": true
            },
            {
              "fieldLabel": "Se sim, qual(is) dado(s) se repetem?",
              "placeholder": "Ex.: cidade, estado"
            },
            {
              "fieldLabel": "Quais colunas identificam UNICAMENTE cada registro?",
              "placeholder": "Ex.: cpf, e-mail, id_cliente",
              "requiredField": true
            },
            {
              "fieldLabel": "Quais dados você considera sensíveis?",
              "fieldType": "checkbox",
              "fieldOptions": {
                "values": [
                  {
                    "option": "Dados de saúde (doenças, tratamentos)"
                  },
                  {
                    "option": "Dados financeiros (renda, dívidas)"
                  },
                  {
                    "option": "Orientação sexual"
                  },
                  {
                    "option": "Religião"
                  },
                  {
                    "option": "Filiação política"
                  },
                  {
                    "option": "Histórico criminal"
                  },
                  {
                    "option": "Nenhum dado sensível"
                  }
                ]
              },
              "requiredField": true
            },
            {
              "fieldLabel": "Qual a finalidade do uso após anonimização?",
              "fieldType": "dropdown",
              "fieldOptions": {
                "values": [
                  {
                    "option": "Pesquisa acadêmica"
                  },
                  {
                    "option": "Análise estatística interna"
                  },
                  {
                    "option": "Publicação aberta (dados públicos)"
                  },
                  {
                    "option": "Compartilhamento com parceiros"
                  },
                  {
                    "option": "Treinamento de modelos de machine learning"
                  }
                ]
              },
              "requiredField": true
            },
            {
              "fieldLabel": "Quantas linhas tem seu arquivo (aproximadamente)?",
              "fieldType": "dropdown",
              "fieldOptions": {
                "values": [
                  {
                    "option": "Menos de 1.000"
                  },
                  {
                    "option": "Entre 1.000 e 10.000"
                  },
                  {
                    "option": "Entre 10.000 e 100.000"
                  },
                  {
                    "option": "Mais de 100.000"
                  }
                ]
              },
              "requiredField": true
            },
            {
              "fieldLabel": "O que é mais importante para você?",
              "fieldType": "dropdown",
              "fieldOptions": {
                "values": [
                  {
                    "option": "Máxima privacidade (pode perder precisão)"
                  },
                  {
                    "option": "Equilíbrio entre privacidade e utilidade"
                  },
                  {
                    "option": "Manter dados precisos (privacidade mínima)"
                  }
                ]
              },
              "requiredField": true
            },
            {
              "fieldLabel": "Observações ou requisitos especiais",
              "placeholder": " Algo importante que devemos saber?"
            }
          ]
        },
        "responseMode": "responseNode",
        "options": {}
      },
      "id": "3fdc371c-cc46-4066-85ea-9f121753652e",
      "name": "Formulário",
      "type": "n8n-nodes-base.formTrigger",
      "position": [
        -1264,
        144
      ],
      "webhookId": "13594f4e-0936-49e7-a825-d28c74736b24",
      "typeVersion": 2.1
    },
    {
      "parameters": {
        "jsCode": "//Bloco 2: Processar Respostas do Formulário\nconst input = $input.first().json;\n\n//Extrair e organizar respostas\nconst respostas = {\n  dataset_name: input['Qual o nome do Dataset?'] || 'dataset_sem_nome',\n  tipos_dados: input['Quais tipos de dados existem no seu arquivo? Marque todos os que se aplicam.'] || [],\n  tem_repetidos: input['Existe algum dado que possui o mesmo valor em todas as linhas?'] || 'Não',\n  quais_repetidos: input['Se sim, qual(is) dado(s) se repetem?'] ||'',\n  identificadores_unicos: input['Quais colunas identificam UNICAMENTE cada registro?'] || '',\n  dados_sensiveis: input['Quais dados você considera sensíveis?'] || [],\n  finalidade: input['Qual a finalidade do uso após anonimização?'] || '',\n  tamanho_arquivo: input['Quantas linhas tem seu arquivo (aproximadamente)?'] || '',\n  preferencia: input['O que é mais importante para você?'] || '',\n  observacoes: input['Observações ou requisitos especiais'] || ''\n};\n\n//Gerar ID único para esta requisição\nconst requestld = Date.now().toString(36) + Math.random().toString(36).substring(2);\n\n//Retornar dados organizados\nreturn[{\n  json:{\n    request_id: requestld,\n    timestamp: new Date().toISOString(),\n    respostas: respostas\n  }\n}];"
      },
      "type": "n8n-nodes-base.code",
      "typeVersion": 2,
      "position": [
        -1056,
        144
      ],
      "id": "1140e304-148c-4fd5-b4f3-806813215b87",
      "name": "Processar Respostas do Formulário"
    },
    {
      "parameters": {
        "jsCode": "const data = $input.first().json;\nconst r = data.respostas;\n\n//Construir lista formatada de tipos de dados\nconst tiposDados = Array.isArray(r.tipos_dados)\n  ? r.tipos_dados.join(',')\n  : r.tipos_dados;\n\n//Construir lista de dados sensíveis\nconst dadosSensiveis = Array.isArray(r.dados_sensiveis)\n  ? r.dados_sensiveis.join(',')\n  : r.dados_sensiveis;\n//Determinar o valor de K baseado no tamanho\nlet kRecomendado = 5;\nif(r.tamanho_arquivo.includes('Menos de 1.000')){\n  kRecomendado = 7;\n}\n\n//Construir Prompt detalhado\nconst systemPrompt = 'Você é um especialista em anonimização de dados e no uso do ARX Anonymization Tool. Sua tarefa é criar guias PRÁTICOS e DETALHADOS para usuários que nunca usaram o ARX antes. Use linguagem SIMPLES e CLARA, com instruções passo-a-passo numeradas.'\n\nconst userPrompt = `INFORMAÇÕES DO DATASET\n  Dataset: ${r.dataset_name}\n  Tipos de dados presentes: ${tiposDados}\n  Dados repetidos em todas as linhas: ${r.tem_repetidos}${r.quais_repetidos ? '('+ r.quais_repetidos + ')' : ''}\n  Identificadores únicos: ${dadosSensiveis}\n  Finalidade: ${r.finalidade}\n  Tamanho: ${r.tamanho_arquivo}\n  Preferência: ${r.preferencia}\n  \n  ---\n  \n  CRIE UM GUIA COMPLETO DE ANONIMIZAÇÃO seguindo EXATAMENTE esta estrutura:\n  =========================================================================\n  GUIA DE ANONIMIZAÇÃO - ${r.dataset_name}\n  =========================================================================\n  PARTE 1: PREPARAÇÃO DOS DADOS (ANTES DO ARX)\n  =========================================================================\n  \n  Liste TODAS as colunas mencionadas pelo usuário e para cada uma:\n  * Nome da coluna\n  * Classificação: [REMOVER/ MASCARAR/ GENERALIZAR/ MANTER]\n  * Motivo da decisão\n  * Exemplo de transformação (use dados fictícios)\n  \n  Formato:\n  NOME_COLUNA\n  -> Ação: [ação escolhida]\n  -> Por quê: [explicação simples]\n  -> Exemplo: [antes] -> [depois]\n  \n  PARTE 2: PASSO-A-PASSO NO ARX\n  =========================================================================\n  \n  Dê instruções DETALHADAS e NUMERADAS para cada etapa:\n  \n  1. ABRIR O ARX\n  -onde baixar\n  -como instalar\n  -como abrir o programa\n  \n  2. IMPORTAR OS DADOS\n  -onde clicar\n  -que formato de arquivo usar\n  -que delimitador escolher\n  \n  3. CONFIGURAR CADA COLUNA\n  para cada coluna explique:\n  - onde clicar para configurar\n  - que tipo de atributo escolher:\n  *IDENTIFYING: [quando usar]\n  *QUASI-IDENTIFYING: [quando usar]\n  *SENSITIVE: [quando usar]\n  *INSENSITIVE: [quando usar]\n  \n  4. CRIAR HIERARQUIAS DE GENERALIZAÇÃO\n  para cada coluna QUASI-IDENTIFYING, crie uma hierarquia COMPLETA:\n  \n  Exemplo de formato:\n  \n  Hierarquia para IDADE:\n  nível 0 (original): 25 anos\n  nível 1 (faixa pequena): 20-30 anos\n  nível 2 (faixa média): 20-40 anos\n  nível 3 (faixa grande): 18-60 anos\n  nível 4 (Supressão): *\n  \n  Como criar no ARX:\n  - Clique com o botão direito na coluna\n  -Selecione \"Create Hierarchy\"\n  - Escolha tipo: [Internal/ Order/ Custom]\n  - Configure níveis conforme acima\n  \n  5. CONFIGURAR PRIVACIDADE\n  - Ir em: Configuration -> Privacy Models\n  - Adicionar K-Anonymity: k = ${kRecomendado}\n  ${dadosSensiveis !== 'Nenhum' ? '-Adicionar L-Diversity: L = 2': ''}\n  - Configurar Suppression Limit: 5%\n  \n  6. EXECUTAR ANONIMIZAÇÃO\n  - Clicar em \"Anonymize\"\n  - Aguardar processamento\n  - Verificar resultado\n  \n  PARTE 3: HIERARQUIAS ESPECÍFICAS\n  =========================================================================\n  \n  para CADA coluna que precisa de hierarquia, forneça um exemplo COMPLETO:\n  [Criar pelo menos 3 exemplos baseados nos dados do usuário]\n  \n  PARTE 4: CONFIGURAÇÕES DE PRIVACIDADE RECOMENDADAS\n  =========================================================================\n  \n  Baseado na finalidade \"${r.finalidade}\":\n  \n  K-Anonymity: k = ${kRecomendado}\n  Motivo: [explicar por que este valor]\n  \n  ${dadosSensiveis !== 'Nenhum' ?`L-Diversity: L = 2\n  Motivo: [explicar por que este valor]\n  Aplicar nas colunas: ${dadosSensiveis}` : ''}\n  \n  Suppression Limit: 5%\n  Motivo: [explicar]\n  \n  Outras comfigurações importantes:\n  -[listar outras]\n  \n  PARTE 5: VALIDAÇÃO E VERIFICAÇÃO\n  =========================================================================\n  \n  Após anonimizar, SEMPRE verificar:\n  1. VERIFICAÇÃO VISUAL\n  -[o que verificar]\n  \n  2. MÉTRICAS DO ARX\n  - onde ver as métricas\n  -que valores esperar\n  \n  3. TESTES DE RE-IDENTIFICAÇÃO\n  - como testar\n  - o que é aceitável\n  \n  4. CHECKLIST FINAL\n  [item 1]\n  [item 2]\n  [item 3]\n  \n  PARTE 6: CUIDADOS IMPORTANTES\n  =========================================================================\n  \n  para a finalidade \"${r.finalidade}\", tenha atenção especial em:\n  * [cuidado 1]\n  * [cuidado 2]\n  * [cuidado 3]\n  \n  ---\n  \n  Gere o guia COMPLETO seguindo EXATAMENTE esta estrutura.\n  Seja DETALHADO e use exemplos PRÁTICOS.\n  Todos os exemplos devem usar dados FICTÍCIOS (nunca dados reais).`;\n\nreturn [{\n  json:{\n    ...data,\n    prompt:{\n      system: systemPrompt,\n      user: userPrompt\n    },\n    config:{\n      k_recomendado: kRecomendado,\n      usar_I_diversity: dadosSensiveis !== 'Nenhum'\n    }\n  }\n}];\n\n"
      },
      "type": "n8n-nodes-base.code",
      "typeVersion": 2,
      "position": [
        -848,
        144
      ],
      "id": "c391e656-6ef8-4b93-8b2a-a10f80a50984",
      "name": "Construir Prompt Ollama"
    },
    {
      "parameters": {
        "method": "POST",
        "url": "http://127.0.0.1:11434/api/generate",
        "sendBody": true,
        "specifyBody": "json",
        "jsonBody": "={{ $json.ollama_payload }}",
        "options": {
          "timeout": 360000
        }
      },
      "type": "n8n-nodes-base.httpRequest",
      "typeVersion": 4.3,
      "position": [
        -432,
        144
      ],
      "id": "99d7b0f1-9c51-440d-85a4-e9897436838a",
      "name": "HTTP Request",
      "onError": "continueRegularOutput"
    },
    {
      "parameters": {
        "conditions": {
          "options": {
            "caseSensitive": true,
            "leftValue": "",
            "typeValidation": "strict",
            "version": 2
          },
          "conditions": [
            {
              "id": "09140e27-4104-4f21-a42b-0199d18667c1",
              "leftValue": "=={{ $json.error}}",
              "rightValue": "",
              "operator": {
                "type": "string",
                "operation": "empty",
                "singleValue": true
              }
            }
          ],
          "combinator": "and"
        },
        "options": {}
      },
      "type": "n8n-nodes-base.if",
      "typeVersion": 2.2,
      "position": [
        -176,
        144
      ],
      "id": "6b4838a1-6393-4b05-ba0c-d4491532ab55",
      "name": "If"
    },
    {
      "parameters": {
        "jsCode": "//pegar a resposta do HTTP Request (ollama)\nconst ollamaResponse = $input.first().json;\n\n//pegar os dados da requisição original\nconst requestData = $('Construir Prompt Ollama').first().json;\n\n//=========== DEBUG COMPLETO =============\nconsole.log('===== DEBUG PROCESSAR SUCESSO =====');\nconsole.log('1. Tipo de ollamaResponse:', typeof ollamaResponse);\nconsole.log('2. Keys de ollamaResponse:', Object.keys(ollamaResponse));\nconsole.log('3. ollamaResponse completo:', JSON.stringify(ollamaResponse, null, 2));\n\n//tentar diferentes formas de extrair o texto\nlet guiaGerado = null;\n\n//opção 1: response direto\nif (ollamaResponse.response) {\n  console.log('Entrou response');\n  guiaGerado = ollamaResponse.response;\n}\n\n//opção 2: message.content\nelse if(ollamaResponse.message?.content){\n  console.log('Encontrou message.content');\n  guiaGerado = ollamaResponse.message.content;\n}\n\n//opção 3: choices[0]\nelse if(ollamaResponse.choices?.[0]?.message?.content){\n  console.log('Encontrou choices[0].message.contant');\n  guiaGerado = ollamaResponse.choices[0].message.content;\n}\n\n//opção 4: text\nelse if(ollamaResponse.text){\n  console.log('Encontrou text');\n  guiaGerado = ollamaResponse.text;\n}\n\n//opção 5: content\nelse if(ollamaResponse.content){\n  console.log('Encontrou content');\n  guiaGerado = ollamaResponse.content;\n}\n\n//opção 6: body (caso venha encapsulado)\nelse if(ollamaResponse.body?.response){\n  console.log('Encontrou body.response');\n  guiaGerado = ollamaResponse.body.response;\n}\n\n//se ainda não encontrou, verificar se tem erro\nif (!guiaGerado) {\n  console.log('NÃO ENCONTROU CONTEÚDO');\n  if (ollamaResponse.error) {\n    console.log('ERRO DETECTADO:', ollamaResponse.error);\n    guiaGerado = `ERRO NA GERAÇÃO: \\n${JSON.stringify(ollamaResponse.error, null, 2)}`;\n  }\n  else{\n    guiaGerado = `ERRO: Resposta do Ollama está vazia ou em formato desconhecido.\\n\\nResposta recebida:\\n${JSON.stringify(ollamaResponse, null, 2)}`;\n  }\n}\n\nconsole.log('4. Tamanho do guiaGerado:', guiaGerado ? guiaGerado.length : 0);\nconsole.log('5. Primeiros 200 chars:', guiaGerado ? guiaGerado.substring(0, 200): 'VAZIO');\nconsole.log('===== FIM DO DEBUG =====');\n\nconst datasetName = requestData.respostas.dataset_name;\nconst timestamp = new Date().toLocaleString('pt-BR');\n\nconst cabecalho = `====================================================================\nGUIA DE ANONIMIZAÇÃO - ARX DATA ANONYMIZATION TOOL\n====================================================================\nDataset: ${datasetName}\nData de geração: ${timestamp}\nGerado por: Gerador de Guia ARX\n====================================================================`;\n\nconst rodape = `\n====================================================================\nFIM DO GUIA\n====================================================================\n\nPRÓXIMOS PASSOS:\n1. Baixe o ARX: http://arx.deidentifier.org/\n2. Prepare seus dados conforme orientado\n3. Siga o passo-a-passo detalhado\n4. Valide os resultados\n\nIMPORTANTE:\n- Faça backup dos dados originais\n- Teste com amostra pequena primeiro\n- Valide se os dados atendem sua necessidade\n\nBoa anonomização!\n`;\n\nconst guiaCompleto = cabecalho + guiaGerado + rodape;\nconst nomeArquivo = `guia_arx_${datasetName.replace(/[^a-z0-9]/gi, '_').toLowerCase()}_${Date.now()}.txt`;\n\nreturn [{\n  json: {\n    sucesso: true,\n    guia_completo: guiaCompleto,\n    nome_arquivo: nomeArquivo,\n    dataset_name: datasetName,\n    timestamp: new Date().toISOString(),\n    //DEBUG adicional no autput\n    debug:{\n      response_keys: Object.keys(ollamaResponse),\n      has_response: !!ollamaResponse.response,\n      response_length: guiaGerado ? guiaGerado.length : 0\n    }\n  }\n}];"
      },
      "type": "n8n-nodes-base.code",
      "typeVersion": 2,
      "position": [
        144,
        272
      ],
      "id": "6e8303f0-ae31-4781-bd5f-0a19e06dff3b",
      "name": "Processar Sucesso"
    },
    {
      "parameters": {
        "jsCode": "const requestData = $('Construir Prompt Ollama').first().json;\nconst r = requestData.respostas;\nconst datasetName = r.dataset_name;\nconst timestamp = new Date().toLocaleString('pt-BR');\n\nconst guiaFallback = `======================================================================GUIA DE ANONIMIZAÇÃO - ${datasetName}\n=======================================================================\n\nAVISO: Este é um guia genérico gerado automaticamente pois o serviço de IA não está disponíível no momento.\n\nDataset: ${datasetName}\nData de geração: ${timestamp}\n\n=====================================================================\n\nPARTE 1: ANÁLISE DOS SEUS DADOS\n\n---------------------------------------------------------------------\n\nTipos de dados: ${Array.isArray(r.tipos_dados) ? r.tipos_dados.join(',') : r.tipos_dados}\nIdentificadores únicos: ${r.identificadores_unicos}\nDados sensíveis: ${Array.isArray(r.dados_sensiveis) ? r.dados_sensiveis.join(',') : r.dados_sensiveis}\nFinalidade: ${r.finalidade}\n\nPARTE 2: RECOMENDAÇÕES GERAIS\n---------------------------------------------------------------------\n\n1. IDENTIFICADORES DIRETOS (CPF, E-mail, Nome):\n- Ação: REMOVER completamente\n- Motivo: Re-identificação direta\n\n2. QUASE-IDENTIFICADORES (Idade, CEP, Cidade):\n- Ação: GENERALIZAR usando hierarquias\n- Exemplo Idade: 25 anos -> 20-30 anos -> 20-40 anos\n- Exemplo CEP: 58400-123 -> 58400-*** -> 584**-***\n\n3. DADOS SENSÍVEIS:\n- Aplicar L-Diversity (l = 2)\n- Garantir variedade nos grupos\n\nPARTE 3: PASSO-A-PASSO NO ARX\n--------------------------------------------------------------------\n\n1. BAIXAR O ARX:\n- Acesse: https://arx.deidentifier.org/\n- Baixe a versão para seu sistema\n- Instale e abre o software\n\n2. IMPORTAR DADOS:\n- File -> Import Data\n- Selecione seu arquivo CSV\n- Configure delimitador (geralmente vírgula)\n\n3. CONFIGURAR ATRIBUTOS:\n- Identifiers: ${r.identificadores_unicos}\n- Quasi-Identifiers: Idade, CEP, Cidade (se houver)\n- Sensitive: Dados de saúde, renda (se houver)\nInsensitive: Outros campos\n\n4. CRIAR HIERARQUIAS:\n- Para cada Quasi-Identifier\n- Hierarchy -> Create Hierarchy\n- Defina 3-4 níveis de generalização\n\n5. CONFIGURAR PRIVACIDADE:\n- K-Anonymity: k = ${requestData.config.k_recomendado}\n${requestData.config.usar_l_diversity ? '- L-Diversity: l = 2' : ''}\n- Suppression Limit: 5%\n\n6. EXECUTAR:\n- Anonymize -> Start\nAguarde o processo\n- Verifique métricas de qualidade\n\n7. EXPORTAR:\n- File -> Export Data\n- Salve como CSV\n\nPARTE 4: CHECKLIST DE VALIDAÇÃO\n---------------------------------------------------------------------\n\n*Nenhum identificador direto presente\n*k-anonymity alcançado (k>=${requestData.config.k_recomendado})\n*Taxa de supressão < 5%\n*Dados ainda são úteis para: ${r.finalidade}\n*Impossível re-identificar indivíduos\n\nPARTE 5: CUIDADOS IMPORTANTES\n---------------------------------------------------------------------\n\n*Sempre faça backup dos dados originais\n*Teste com amostrapequena primeiro\n*Valide se os dados atendem a finalidade\n*Considere combinação de atributos\n*Documente o processo de anonimização\n\n====================================================================\n\nPara um guia mais detalhado e personalizado, entre em contato quando o serviço de IA estiver disponível.\n\n====================================================================\n\n`;\nconst nomeArquivo = `guia_arx_${datasetName.replace(/[^a-z0-9]/gi, '_').toLowerCase()}_${Date.now()}.txt`;\n\nreturn[{\n  json:{\n    sucesso: false,\n    guia_completo: guiaFallback,\n    nome_arquivo: nomeArquivo,\n    dataset_name: datasetName,\n    timestamp: new Date().toISOString()\n  }\n}];"
      },
      "type": "n8n-nodes-base.code",
      "typeVersion": 2,
      "position": [
        144,
        16
      ],
      "id": "bbbdf0a9-064b-476f-ad02-b29010132f03",
      "name": "Guia Fallback"
    },
    {
      "parameters": {
        "respondWith": "binary",
        "options": {}
      },
      "type": "n8n-nodes-base.respondToWebhook",
      "typeVersion": 1.4,
      "position": [
        640,
        144
      ],
      "id": "8932786f-956b-4a35-b757-0ea15b461f6d",
      "name": "Respond to Webhook"
    },
    {
      "parameters": {
        "jsCode": "const data = $input.first().json;\n\n//escapar o prompt corretamente\nconst promptCompleto = data.prompt.system + \"\\n\\n\" + data.prompt.user;\n\n//construir payload seguro\nconst payload = {\n  model: \"gemma3:12b\",\n  prompt: promptCompleto,\n  stream: false,\n  options: {\n    temperature: 0.3,\n    num_predict: 4000\n  }\n};\n\nreturn[{\n  json: {\n    ...data,\n    ollama_payload: payload\n  }\n}];"
      },
      "type": "n8n-nodes-base.code",
      "typeVersion": 2,
      "position": [
        -640,
        144
      ],
      "id": "bbc2d3f7-8222-4b21-8743-8c653cb1fbc5",
      "name": "Code in JavaScript"
    },
    {
      "parameters": {
        "jsCode": "const data = $input.first().json;\nconst guia = data.guia_completo;\nconst datasetName = data.dataset_name;\n\nconst linhas = guia.split('\\n');\nlet htmlFormatado = '';\n\nlinhas.forEach(linha => {\n  linha = linha.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');\n\n  if (linha.includes('====')) {\n    htmlFormatado += '<hr style=\"border: 2px solid #333; margin: 30px 0;\">';\n  }\n  else if(linha.match(/PARTE \\d+:/)){\n    htmlFormatado += '<h2 style=\"color: #2563eb; margin-top: 30px;\">' + linha + '</h2>';\n  }\n  else if(linha.match(/^\\d+\\.\\s+[A-Z]/)){\n    htmlFormatado += '<h3 style=\"color: #059669; margin-top: 20px;\">' + linha + '</h3>';\n  }\n  else if(linha.trim().startsWith('*') || linha.trim().startsWith('-')){\n    htmlFormatado += '<li>' + linha.substring(1) + '</li>';\n  }\n  else if(linha.trim() === ''){\n    htmlFormatado += '<br>';\n  }\n  else{\n    htmlFormatado += '<p>' + linha + '</p>';\n  }\n});\n\n//Adicionar estrutura HTML\nlet htmlCompleto = '<!DOCTYPE html><html lang=\"pt-BR\"><head><meta charset=\"UTF-8\"><title>Guia ARX</title><style>';\n\n//Adicionar CSS (dentro da variáável acima, depois do <style>)\nhtmlCompleto += 'body{font-family:Arial;padding:40px;background:#f5f5f5;}';\nhtmlCompleto += '.container{max-width:900px;margin:0 auto;background:white;padding:50px;border-radius:8px;}';\nhtmlCompleto += 'h1{color:#1e40af;border-bottom:3px solid #2563eb;padding-bottom:15px;}';\nhtmlCompleto += 'h2{color:#2563eb;margin-top:30px;}';\nhtmlCompleto += 'h3{color:#059669;}';\nhtmlCompleto += '.btn{background:#2563eb;color:white;padding:15px 30px;border:none;border-radius:5px;cursor:pointer;font-size:16px:};';\nhtmlCompleto += '.btn:hover{background:#1e40af;}';\nhtmlCompleto += '@media print{.no-print{display:none;}}';\n\n//fechar CSS e adicionar corpo HTML:\nhtmlCompleto += '</style></head><body><div class=\"container\">';\nhtmlCompleto += '<h1>Guia de Anonimização ARX - ' + datasetName + '</h1>';\nhtmlCompleto += '<button class=\"btn no-print\" onclick=\"window.print()\"> Salvar como PDF</button>';\nhtmlCompleto += htmlFormatado;\nhtmlCompleto += '</div>';\n\n//Adicionar script de auto-print\nhtmlCompleto += '<script>';\nhtmlCompleto += 'setTimeout(function(){';\nhtmlCompleto += 'if(confirm(\"Deseja salvar este guia como PDF?\")){window.print();}';\nhtmlCompleto += '}, 2000);';\nhtmlCompleto += '</script></body></html>';\n\n//Retornar o resultado\nreturn [{\n  json: {\n    ...data,\n    nome_arquivo: data.nome_arquivo.replace('.txt', '.html')\n  },\n  binary: {\n    data: {\n      data: Buffer.from(htmlCompleto, 'utf-8').toString('base64'),\n      mimeType: 'text/html',\n      fileName: data.nome_arquivo.replace('.txt', '.html')\n    }\n  }\n}];"
      },
      "type": "n8n-nodes-base.code",
      "typeVersion": 2,
      "position": [
        432,
        144
      ],
      "id": "aef7dae7-9a91-43f9-a15b-6e5f2aaa0646",
      "name": "Gerar HTML"
    }
  ],
  "connections": {
    "Formulário": {
      "main": [
        [
          {
            "node": "Processar Respostas do Formulário",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Processar Respostas do Formulário": {
      "main": [
        [
          {
            "node": "Construir Prompt Ollama",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Construir Prompt Ollama": {
      "main": [
        [
          {
            "node": "Code in JavaScript",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "HTTP Request": {
      "main": [
        [
          {
            "node": "If",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "If": {
      "main": [
        [
          {
            "node": "Guia Fallback",
            "type": "main",
            "index": 0
          }
        ],
        [
          {
            "node": "Processar Sucesso",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Processar Sucesso": {
      "main": [
        [
          {
            "node": "Gerar HTML",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Guia Fallback": {
      "main": [
        [
          {
            "node": "Gerar HTML",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Code in JavaScript": {
      "main": [
        [
          {
            "node": "HTTP Request",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Gerar HTML": {
      "main": [
        [
          {
            "node": "Respond to Webhook",
            "type": "main",
            "index": 0
          }
        ]
      ]
    }
  },
  "pinData": {},
  "meta": {
    "templateCredsSetupCompleted": true,
    "instanceId": "ea2d9400f8e08f4ca94c1d1e42f5187924502e52a6ced129591d3722a2bf3c1f"
  }
}
