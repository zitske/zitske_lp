# Configuração de Variáveis de Ambiente

## Setup Rápido

1. **Copie o arquivo de exemplo:**
   ```bash
   cp .env.example .env
   ```

2. **Configure suas credenciais no arquivo `.env`:**
   ```
   FORMSPREE_FORM_ID=seu_form_id_do_formspree
   TO_EMAIL=contact@zitskegroup.com
   ```

3. **Como obter o Form ID do Formspree:**
   - Acesse [formspree.io](https://formspree.io)
   - Crie uma conta gratuita
   - Crie um novo formulário
   - Copie o Form ID (ex: `xwpbqobn`)

## Segurança

✅ **O arquivo `.env` está no `.gitignore`** - suas credenciais não serão commitadas  
✅ **Use `.env.example`** como referência para outros desenvolvedores  
✅ **Nunca commite credenciais** no código fonte  

## Estrutura

```
.env              # Suas credenciais (não commitado)
.env.example      # Exemplo público (commitado)
lib/config/       # Configuração que lê as variáveis
```

## Troubleshooting

Se o erro "FORMSPREE_FORM_ID não encontrado" aparecer:
1. Verifique se o arquivo `.env` existe
2. Verifique se `FORMSPREE_FORM_ID` está preenchido
3. Reinicie a aplicação após alterar o `.env`
