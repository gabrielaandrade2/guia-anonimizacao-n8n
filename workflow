{
  "nodes": [
    {
      "parameters": {
        "path": "d6d52de7-62ef-4b64-8366-9cd9ce259d7c",
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
              "fieldLabel": "Liste as colunas do seu dataset separadas por vírgula",
              "fieldType": "textarea",
              "placeholder": "Ex: idade, nome, cpf, email, cidade, estado",
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
              "placeholder": "Ex.: cpf, e-mail, id_cliente"
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
                    "option": "Raça/Etnia"
                  },
                  {
                    "option": "Dados de trabalho e Ocupação"
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
              "fieldType": "textarea",
              "placeholder": " Algo importante que devemos saber?"
            }
          ]
        },
        "responseMode": "responseNode",
        "options": {}
      },
      "id": "49e5d0bd-7200-48b0-a00b-385e52651346",
      "name": "User Input Form",
      "type": "n8n-nodes-base.formTrigger",
      "position": [
        -1264,
        144
      ],
      "webhookId": "d6d52de7-62ef-4b64-8366-9cd9ce259d7c",
      "typeVersion": 2.1
    },
    {
      "parameters": {
        "jsCode": "//Bloco 2: Processar Respostas do Formulário\nconst input = $input.first().json;\n\n//Extrair e organizar respostas\nconst respostas = {\n  dataset_name: input['Qual o nome do Dataset?'] || 'dataset_sem_nome',\n  colunas_dataset: input['Liste as colunas do seu dataset separadas por víírgula'] || '',\n  tem_repetidos: input['Existe algum dado que possui o mesmo valor em todas as linhas?'] || 'Não',\n  quais_repetidos: input['Se sim, qual(is) dado(s) se repetem?'] ||'',\n  identificadores_unicos: input['Quais colunas identificam UNICAMENTE cada registro?'] || 'Nenhum identificador único',\n  dados_sensiveis: input['Quais dados você considera sensíveis?'] || [],\n  finalidade: input['Qual a finalidade do uso após anonimização?'] || '',\n  tamanho_arquivo: input['Quantas linhas tem seu arquivo (aproximadamente)?'] || '',\n  preferencia: input['O que é mais importante para você?'] || '',\n  observacoes: input['Observações ou requisitos especiais'] || ''\n};\n\n//Gerar ID único para esta requisição\nconst requestld = Date.now().toString(36) + Math.random().toString(36).substring(2);\n\n//Retornar dados organizados\nreturn[{\n  json:{\n    request_id: requestld,\n    timestamp: new Date().toISOString(),\n    respostas: respostas\n  }\n}];"
      },
      "type": "n8n-nodes-base.code",
      "typeVersion": 2,
      "position": [
        -1056,
        144
      ],
      "id": "702b6be2-d4b2-4052-b4ff-9eb1634549ce",
      "name": "Parse Form Responses"
    },
    {
      "parameters": {
        "jsCode": "const data = $input.first().json;\nconst r = data.respostas;\n\nconst dadosSensiveis = Array.isArray(r.dados_sensiveis)\n  ? r.dados_sensiveis.join(', ')\n  : r.dados_sensiveis;\n\nlet kRecomendado = 5;\nif (r.tamanho_arquivo.includes('Menos de 1.000')) {\n  kRecomendado = 3;\n} else if (r.tamanho_arquivo.includes('Entre 1.000 e 10.000')) {\n  kRecomendado = 5;\n} else if (r.tamanho_arquivo.includes('Entre 10.000 e 100.000')) {\n  kRecomendado = 7;\n} else if (r.tamanho_arquivo.includes('Mais de 100.000')) {\n  kRecomendado = 10;\n}\n\nconst systemPrompt = `Você é um especialista em anonimização de dados e no uso do ARX Data Anonymization Tool.\nSua tarefa é criar guias PRÁTICOS, DETALHADOS e TECNICAMENTE CORRETOS para usuários iniciantes no ARX.\nUse linguagem SIMPLES e CLARA, com instruções passo-a-passo numeradas.\nResponda SEMPRE em português, sem exceções.\n\nREGRAS ABSOLUTAS — NUNCA VIOLE:\n1. Use SOMENTE as colunas informadas pelo usuário. NUNCA invente, renomeie ou omita colunas.\n2. NUNCA traduza os nomes das colunas. Use SEMPRE os nomes exatos em inglês conforme recebidos.\n3. Para cada coluna, atribua OBRIGATORIAMENTE um tipo ARX: IDENTIFYING, QUASI-IDENTIFYING, SENSITIVE ou INSENSITIVE.\n4. Para cada coluna QUASI-IDENTIFYING, defina OBRIGATORIAMENTE o tipo de transformação ARX: Generalization, Microaggregation ou Masking.\n5. Para cada coluna QUASI-IDENTIFYING com Generalization, forneça a hierarquia COMPLETA com todos os níveis detalhados.\n6. Todos os exemplos devem usar dados FICTÍCIOS — nunca dados reais.\n7. NUNCA use formato de tabela markdown (proibido usar | coluna |).\n8. NUNCA use asteriscos para negrito (**texto**).\n9. Separe cada bloco de coluna com uma linha em branco.\n10. Na PARTE 1, NÃO exiba as regras de formato — apenas processe as colunas diretamente.\n11. Responda SEMPRE em português.\n\nATENÇÃO ESPECIAL — TIPOS ARX E SUAS TRANSFORMAÇÕES:\n- IDENTIFYING: coluna que identifica diretamente o indivíduo (ex: CPF, ID). Ação = REMOVER. Transformação = N/A.\n- QUASI-IDENTIFYING: coluna que combinada com outras pode identificar o indivíduo. Ação = GENERALIZAR. Transformação = Generalization ou Microaggregation.\n- SENSITIVE: coluna com dado sensível protegido por l-Diversity. Ação = GENERALIZAR. Transformação = Generalization com hierarquia. NUNCA use Masking em atributos SENSITIVE.\n- INSENSITIVE: coluna sem risco de identificação. Ação = MANTER. Transformação = N/A.\n\nREGRA CRÍTICA SOBRE MASKING:\n- Masking é usado APENAS para atributos IDENTIFYING antes de removê-los.\n- Atributos SENSITIVE NUNCA usam Masking — usam SEMPRE Generalization.\n- O l-Diversity é aplicado sobre o atributo SENSITIVE generalizado.`;\n\nconst userPrompt = `INFORMAÇÕES DO DATASET\n======================\n- Nome do dataset: ${r.dataset_name}\n- Colunas do dataset (USE APENAS ESTAS): ${r.colunas_dataset}\n- Dados repetidos em todas as linhas: ${r.tem_repetidos}${r.quais_repetidos ? ' (' + r.quais_repetidos + ')' : ''}\n- Identificadores únicos: ${r.identificadores_unicos}\n- Dados sensíveis informados pelo usuário: ${dadosSensiveis}\n- Finalidade da anonimização: ${r.finalidade}\n- Tamanho do dataset: ${r.tamanho_arquivo}\n- Preferência de anonimização: ${r.preferencia}\n- Observações adicionais: ${r.observacoes}\n\n==========================================================================\nCRIE O GUIA COMPLETO SEGUINDO EXATAMENTE ESTA ESTRUTURA:\n==========================================================================\n\nPARTE 1: ANÁLISE E CLASSIFICAÇÃO DAS COLUNAS\n==========================================================================\n\nINSTRUÇÃO OBRIGATÓRIA:\nPrimeiro, liste as colunas recebidas numeradas:\n1. [coluna 1]\n2. [coluna 2]\n...e assim por diante até a última coluna.\n\nEste será seu ÚNICO referencial. Processe EXATAMENTE este número de colunas,\nna mesma ordem, sem adicionar, renomear ou omitir nenhuma.\n\nEm seguida, processe cada coluna usando EXATAMENTE este formato:\n\n==========================================\nCOLUNA: [nome exato conforme listado acima]\n==========================================\n\n-> Ação: [REMOVER / GENERALIZAR / MANTER]\n\n-> Tipo ARX: [IDENTIFYING / QUASI-IDENTIFYING / SENSITIVE / INSENSITIVE]\n\n-> Transformação ARX: [Generalization / Microaggregation / N/A]\n   LEMBRE-SE: SENSITIVE usa Generalization. IDENTIFYING usa N/A. INSENSITIVE usa N/A.\n\n-> Por quê: [explicação simples e direta]\n\n-> Exemplo: [valor original] -> [valor transformado]\n\n-> Hierarquia (preencher APENAS se Transformação ARX = Generalization):\n   Nível 0 (original): [valor real do dataset]\n   Nível 1 (agrupamento): [categoria ou faixa intermediária]\n   Nível 2 (agrupamento maior): [categoria mais ampla, se necessário]\n   Nível N (supressão): *\n\n[repita o bloco acima para cada coluna da lista]\n\n==========================================================================\nPARTE 2: PASSO-A-PASSO NO ARX\n==========================================================================\n\n1. ABRIR O ARX\n   - Onde baixar: http://arx.deidentifier.org/\n   - Como instalar e abrir o programa (ARX.jar)\n\n2. IMPORTAR OS DADOS\n   - Caminho no menu: File -> New Project -> Import Data -> From File\n   - Formato: CSV\n   - Delimitador: vírgula (,)\n   - Marcar \"First row contains header\"\n\n3. CONFIGURAR CADA COLUNA\n   Para cada coluna do dataset:\n   - Clique com botão direito no cabeçalho da coluna\n   - Selecione \"Edit attribute\"\n   - Defina o Tipo ARX conforme classificação da PARTE 1\n   Repita individualmente para CADA coluna listada em \"${r.colunas_dataset}\"\n\n4. CRIAR HIERARQUIAS DE GENERALIZAÇÃO\n   Para cada coluna QUASI-IDENTIFYING ou SENSITIVE com Transformação = Generalization:\n   - Clique com botão direito no cabeçalho da coluna\n   - Selecione \"Edit Hierarchy\"\n   - Escolha o tipo de hierarquia:\n     Order-based -> para dados numéricos (agrupa por intervalos automaticamente)\n     Custom -> para dados categóricos (você define os grupos manualmente)\n   - Configure os níveis conforme a hierarquia definida na PARTE 1\n\n5. CONFIGURAR MODELOS DE PRIVACIDADE\n   - Acesse a aba \"Privacy models\" no painel direito\n   - Clique em \"+\" para adicionar modelos:\n     K-Anonymity: k = ${kRecomendado}\n     ${dadosSensiveis !== 'Nenhum' ? `L-Diversity (Distinct): L = 2, Atributo = ${dadosSensiveis}` : ''}\n   - Em \"General settings\", defina Suppression Limit = 5%\n\n6. EXECUTAR ANONIMIZAÇÃO\n   - Clique no botão \"Anonymize\" na barra superior\n   - Aguarde o processamento\n   - Verifique o resultado nas abas \"Explore results\" e \"Analyze risk\"\n\n==========================================================================\nPARTE 3: CONFIGURAÇÕES DE PRIVACIDADE RECOMENDADAS\n==========================================================================\n\nBaseado na finalidade \"${r.finalidade}\" e no tamanho \"${r.tamanho_arquivo}\":\n\nK-Anonymity: k = ${kRecomendado}\nMotivo: [explicar por que este valor é adequado para este dataset]\n\n${dadosSensiveis !== 'Nenhum' ? `L-Diversity (Distinct): L = 2\nAtributo sensível: ${dadosSensiveis}\nMotivo: [explicar por que l-diversity é necessário aqui]` : ''}\n\nSuppression Limit: 5%\nMotivo: [explicar o que significa e por que 5% é adequado]\n\n==========================================================================\nPARTE 4: VERIFICAÇÃO DO RESULTADO\n==========================================================================\n\nApós executar a anonimização, verifique:\n\n1. VERIFICAÇÃO VISUAL\n   - O que checar na aba \"Explore results\"\n   - Exemplos de como os dados devem aparecer após anonimização\n\n2. MÉTRICAS NA ABA \"Analyze risk\"\n   - Prosecutor risk: deve ser baixo (idealmente < 50%)\n   - Journalist risk: referência aceitável\n   - Marketer risk: referência aceitável\n   - Records affected by suppression: deve ser menor ou igual a 5%\n\n3. CHECKLIST FINAL\n   [ ] Todas as colunas IDENTIFYING foram suprimidas\n   [ ] Todas as colunas QUASI-IDENTIFYING foram generalizadas\n   [ ] Atributos SENSITIVE foram generalizados com hierarquia\n   [ ] k-Anonymity = ${kRecomendado} satisfeito\n   ${dadosSensiveis !== 'Nenhum' ? `[ ] L-Diversity = 2 satisfeito para ${dadosSensiveis}` : ''}\n   [ ] Suppression menor ou igual a 5%\n   [ ] Dados ainda são úteis para a finalidade: ${r.finalidade}\n\n==========================================================================\nPARTE 5: CUIDADOS IMPORTANTES\n==========================================================================\n\nPara a finalidade \"${r.finalidade}\", atenção especial em:\n- [cuidado específico 1 relacionado à finalidade]\n- [cuidado específico 2 relacionado ao tipo de dado]\n- [cuidado específico 3 relacionado ao risco de re-identificação]\n\n---\nGere o guia COMPLETO seguindo EXATAMENTE esta estrutura.\nSeja DETALHADO, TÉCNICO e use apenas exemplos com dados FICTÍCIOS.`;\n\nreturn [{\n  json: {\n    ...data,\n    prompt: {\n      system: systemPrompt,\n      user: userPrompt\n    },\n    config: {\n      k_recomendado: kRecomendado,\n      usar_l_diversity: dadosSensiveis !== 'Nenhum'\n    }\n  }\n}];"
      },
      "type": "n8n-nodes-base.code",
      "typeVersion": 2,
      "position": [
        -848,
        144
      ],
      "id": "316b5a4b-12c3-42d3-a628-9dfb39a0d726",
      "name": "Build Anonymization Prompt"
    },
    {
      "parameters": {
        "jsCode": "const data = $input.first().json;\n\n//escapar o prompt corretamente\nconst promptCompleto = data.prompt.system + \"\\n\\n\" + data.prompt.user;\n\n//construir payload seguro\nconst payload = {\n  model: \"llama3.1:latest\",\n  prompt: promptCompleto,\n  stream: false,\n  options: {\n    temperature: 0.3,\n    num_predict: 4000\n  }\n};\n\nreturn[{\n  json: {\n    ...data,\n    ollama_payload: payload\n  }\n}];"
      },
      "type": "n8n-nodes-base.code",
      "typeVersion": 2,
      "position": [
        -640,
        144
      ],
      "id": "c6360699-6a0e-4b46-b7c8-9ebb9a486466",
      "name": "Build Ollama Payload"
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
      "id": "bf175036-fb68-4057-b01a-49dc94e58dbe",
      "name": "Send Prompt to Ollama ",
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
      "id": "c98cce4b-7cae-4c44-965c-af77ee20ad1c",
      "name": "Check Ollama Response"
    },
    {
      "parameters": {
        "jsCode": "//pegar a resposta do HTTP Request (ollama)\nconst ollamaResponse = $input.first().json;\n\n//pegar os dados da requisição original\nconst requestData = $('Build Anonymization Prompt').first().json;\n\n//=========== DEBUG COMPLETO =============\nconsole.log('===== DEBUG PROCESSAR SUCESSO =====');\nconsole.log('1. Tipo de ollamaResponse:', typeof ollamaResponse);\nconsole.log('2. Keys de ollamaResponse:', Object.keys(ollamaResponse));\nconsole.log('3. ollamaResponse completo:', JSON.stringify(ollamaResponse, null, 2));\n\n//tentar diferentes formas de extrair o texto\nlet guiaGerado = null;\n\n//opção 1: response direto\nif (ollamaResponse.response) {\n  console.log('Entrou response');\n  guiaGerado = ollamaResponse.response;\n}\n\n//opção 2: message.content\nelse if(ollamaResponse.message?.content){\n  console.log('Encontrou message.content');\n  guiaGerado = ollamaResponse.message.content;\n}\n\n//opção 3: choices[0]\nelse if(ollamaResponse.choices?.[0]?.message?.content){\n  console.log('Encontrou choices[0].message.contant');\n  guiaGerado = ollamaResponse.choices[0].message.content;\n}\n\n//opção 4: text\nelse if(ollamaResponse.text){\n  console.log('Encontrou text');\n  guiaGerado = ollamaResponse.text;\n}\n\n//opção 5: content\nelse if(ollamaResponse.content){\n  console.log('Encontrou content');\n  guiaGerado = ollamaResponse.content;\n}\n\n//opção 6: body (caso venha encapsulado)\nelse if(ollamaResponse.body?.response){\n  console.log('Encontrou body.response');\n  guiaGerado = ollamaResponse.body.response;\n}\n\n//se ainda não encontrou, verificar se tem erro\nif (!guiaGerado) {\n  console.log('NÃO ENCONTROU CONTEÚDO');\n  if (ollamaResponse.error) {\n    console.log('ERRO DETECTADO:', ollamaResponse.error);\n    guiaGerado = `ERRO NA GERAÇÃO: \\n${JSON.stringify(ollamaResponse.error, null, 2)}`;\n  }\n  else{\n    guiaGerado = `ERRO: Resposta do Ollama está vazia ou em formato desconhecido.\\n\\nResposta recebida:\\n${JSON.stringify(ollamaResponse, null, 2)}`;\n  }\n}\n\nconsole.log('4. Tamanho do guiaGerado:', guiaGerado ? guiaGerado.length : 0);\nconsole.log('5. Primeiros 200 chars:', guiaGerado ? guiaGerado.substring(0, 200): 'VAZIO');\nconsole.log('===== FIM DO DEBUG =====');\n\nconst datasetName = requestData.respostas.dataset_name;\nconst timestamp = new Date().toLocaleString('pt-BR');\n\nconst cabecalho = `====================================================================\nGUIA DE ANONIMIZAÇÃO - ARX DATA ANONYMIZATION TOOL\n====================================================================\nDataset: ${datasetName}\nData de geração: ${timestamp}\nGerado por: Gerador de Guia ARX\n====================================================================`;\n\nconst rodape = `\n====================================================================\nFIM DO GUIA\n====================================================================\n\nPRÓXIMOS PASSOS:\n1. Baixe o ARX: http://arx.deidentifier.org/\n2. Prepare seus dados conforme orientado\n3. Siga o passo-a-passo detalhado\n4. Valide os resultados\n\nIMPORTANTE:\n- Faça backup dos dados originais\n- Teste com amostra pequena primeiro\n- Valide se os dados atendem sua necessidade\n\nBoa anonomização!\n`;\n\nconst guiaCompleto = cabecalho + guiaGerado + rodape;\nconst nomeArquivo = `guia_arx_${datasetName.replace(/[^a-z0-9]/gi, '_').toLowerCase()}_${Date.now()}.txt`;\n\nreturn [{\n  json: {\n    sucesso: true,\n    guia_completo: guiaCompleto,\n    nome_arquivo: nomeArquivo,\n    dataset_name: datasetName,\n    timestamp: new Date().toISOString(),\n    //DEBUG adicional no autput\n    debug:{\n      response_keys: Object.keys(ollamaResponse),\n      has_response: !!ollamaResponse.response,\n      response_length: guiaGerado ? guiaGerado.length : 0\n    }\n  }\n}];"
      },
      "type": "n8n-nodes-base.code",
      "typeVersion": 2,
      "position": [
        144,
        272
      ],
      "id": "c8e45c4c-e0e0-4aa9-8cff-91af12cdb64a",
      "name": "Extract Generated Guide"
    },
    {
      "parameters": {
        "jsCode": "const requestData = $('Build Anonymization Prompt').first().json;\nconst r = requestData.respostas;\nconst datasetName = r.dataset_name;\nconst timestamp = new Date().toLocaleString('pt-BR');\n\nconst guiaFallback = `======================================================================GUIA DE ANONIMIZAÇÃO - ${datasetName}\n=======================================================================\n\nAVISO: Este é um guia genérico gerado automaticamente pois o serviço de IA não está disponíível no momento.\n\nDataset: ${datasetName}\nData de geração: ${timestamp}\n\n=====================================================================\n\nPARTE 1: ANÁLISE DOS SEUS DADOS\n\n---------------------------------------------------------------------\n\nTipos de dados: ${Array.isArray(r.tipos_dados) ? r.tipos_dados.join(',') : r.tipos_dados}\nIdentificadores únicos: ${r.identificadores_unicos}\nDados sensíveis: ${Array.isArray(r.dados_sensiveis) ? r.dados_sensiveis.join(',') : r.dados_sensiveis}\nFinalidade: ${r.finalidade}\n\nPARTE 2: RECOMENDAÇÕES GERAIS\n---------------------------------------------------------------------\n\n1. IDENTIFICADORES DIRETOS (CPF, E-mail, Nome):\n- Ação: REMOVER completamente\n- Motivo: Re-identificação direta\n\n2. QUASE-IDENTIFICADORES (Idade, CEP, Cidade):\n- Ação: GENERALIZAR usando hierarquias\n- Exemplo Idade: 25 anos -> 20-30 anos -> 20-40 anos\n- Exemplo CEP: 58400-123 -> 58400-*** -> 584**-***\n\n3. DADOS SENSÍVEIS:\n- Aplicar L-Diversity (l = 2)\n- Garantir variedade nos grupos\n\nPARTE 3: PASSO-A-PASSO NO ARX\n--------------------------------------------------------------------\n\n1. BAIXAR O ARX:\n- Acesse: https://arx.deidentifier.org/\n- Baixe a versão para seu sistema\n- Instale e abre o software\n\n2. IMPORTAR DADOS:\n- File -> Import Data\n- Selecione seu arquivo CSV\n- Configure delimitador (geralmente vírgula)\n\n3. CONFIGURAR ATRIBUTOS:\n- Identifiers: ${r.identificadores_unicos}\n- Quasi-Identifiers: Idade, CEP, Cidade (se houver)\n- Sensitive: Dados de saúde, renda (se houver)\nInsensitive: Outros campos\n\n4. CRIAR HIERARQUIAS:\n- Para cada Quasi-Identifier\n- Hierarchy -> Create Hierarchy\n- Defina 3-4 níveis de generalização\n\n5. CONFIGURAR PRIVACIDADE:\n- K-Anonymity: k = ${requestData.config.k_recomendado}\n${requestData.config.usar_l_diversity ? '- L-Diversity: l = 2' : ''}\n- Suppression Limit: 5%\n\n6. EXECUTAR:\n- Anonymize -> Start\nAguarde o processo\n- Verifique métricas de qualidade\n\n7. EXPORTAR:\n- File -> Export Data\n- Salve como CSV\n\nPARTE 4: CHECKLIST DE VALIDAÇÃO\n---------------------------------------------------------------------\n\n*Nenhum identificador direto presente\n*k-anonymity alcançado (k>=${requestData.config.k_recomendado})\n*Taxa de supressão < 5%\n*Dados ainda são úteis para: ${r.finalidade}\n*Impossível re-identificar indivíduos\n\nPARTE 5: CUIDADOS IMPORTANTES\n---------------------------------------------------------------------\n\n*Sempre faça backup dos dados originais\n*Teste com amostrapequena primeiro\n*Valide se os dados atendem a finalidade\n*Considere combinação de atributos\n*Documente o processo de anonimização\n\n====================================================================\n\nPara um guia mais detalhado e personalizado, entre em contato quando o serviço de IA estiver disponível.\n\n====================================================================\n\n`;\nconst nomeArquivo = `guia_arx_${datasetName.replace(/[^a-z0-9]/gi, '_').toLowerCase()}_${Date.now()}.txt`;\n\nreturn[{\n  json:{\n    sucesso: false,\n    guia_completo: guiaFallback,\n    nome_arquivo: nomeArquivo,\n    dataset_name: datasetName,\n    timestamp: new Date().toISOString()\n  }\n}];"
      },
      "type": "n8n-nodes-base.code",
      "typeVersion": 2,
      "position": [
        144,
        16
      ],
      "id": "e100da83-dab3-4170-9573-ec0ff7dc1b9f",
      "name": "Fallback Guide Generator"
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
      "id": "77ae4e9c-f89f-4684-9baa-36424f40d0db",
      "name": "Render Guide as HTML"
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
      "id": "cf3fc7fe-1ee2-4c98-ab37-0a625e8978e9",
      "name": "Return Guide to User"
    }
  ],
  "connections": {
    "User Input Form": {
      "main": [
        [
          {
            "node": "Parse Form Responses",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Parse Form Responses": {
      "main": [
        [
          {
            "node": "Build Anonymization Prompt",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Build Anonymization Prompt": {
      "main": [
        [
          {
            "node": "Build Ollama Payload",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Build Ollama Payload": {
      "main": [
        [
          {
            "node": "Send Prompt to Ollama ",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Send Prompt to Ollama ": {
      "main": [
        [
          {
            "node": "Check Ollama Response",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Check Ollama Response": {
      "main": [
        [
          {
            "node": "Fallback Guide Generator",
            "type": "main",
            "index": 0
          }
        ],
        [
          {
            "node": "Extract Generated Guide",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Extract Generated Guide": {
      "main": [
        [
          {
            "node": "Render Guide as HTML",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Fallback Guide Generator": {
      "main": [
        [
          {
            "node": "Render Guide as HTML",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Render Guide as HTML": {
      "main": [
        [
          {
            "node": "Return Guide to User",
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
