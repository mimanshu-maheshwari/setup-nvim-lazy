-----------------------------------------------------------
-- CodeLens
-----------------------------------------------------------

vim.api.nvim_create_autocmd("LspAttach", {
    desc = "Enable CodeLens if supported by LSP",
    callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)

        if not client then
            return
        end

        local supports_codelens = client.supports_method
            and client:supports_method("textDocument/codeLens")

        if not supports_codelens then
            return
        end

        if vim.lsp.codelens.enable then
            vim.lsp.codelens.enable(true, {
                bufnr = event.buf,
                client_id = client.id,
            })
        else
            vim.lsp.codelens.refresh({ bufnr = event.buf })

            vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
                buffer = event.buf,
                callback = function()
                    pcall(vim.lsp.codelens.refresh, { bufnr = event.buf })
                end,
            })
        end
    end,
})

vim.keymap.set("n", "<leader>cl", vim.lsp.codelens.run, {
    desc = "Run CodeLens",
})
