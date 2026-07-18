return {
  {
    "mrcjkb/rustaceanvim",
    version = "^9",
    lazy = true,
    ft = "rust",
    init = function()
      vim.g.rustaceanvim = {
        tools = {
          test_executor = "background",
        },
        server = {
          default_settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
              },
              check = {
                command = "clippy",
              },
              lens = {
                enable = true,
              },
            },
          },
        },
      }
    end,
    keys = {
      { "<leader>rr", "<cmd>RustLsp runnables<CR>",   desc = "Rust Runnables" },
      { "<leader>rR", "<cmd>RustLsp run<CR>",         desc = "Rust Run Under Cursor" },
      { "<leader>rt", "<cmd>RustLsp testables<CR>",   desc = "Rust Testables" },
      { "<leader>rd", "<cmd>RustLsp debuggables<CR>", desc = "Rust Debuggables" },
      { "<leader>rD", "<cmd>RustLsp debug<CR>",       desc = "Rust Debug Under Cursor" },
    },
  },

  {
    "nwiizo/cargo.nvim",
    build = "cargo build --release",
    config = function()
      require("cargo").setup({
        float_window = true,
        window_width = 0.8,
        window_height = 0.8,
        border = "rounded",
        auto_close = true,
        close_timeout = 5000,
      })
    end,
    ft = { "rust" },
    cmd = {
      "CargoBench",
      "CargoBuild",
      "CargoClean",
      "CargoDoc",
      "CargoNew",
      "CargoRun",
      "CargoRunTerm",
      "CargoTest",
      "CargoUpdate",
      "CargoCheck",
      "CargoClippy",
      "CargoAdd",
      "CargoRemove",
      "CargoFmt",
      "CargoFix"
    }
  },
  {
    "saecki/crates.nvim",
    tag = "stable",
    event = { "BufRead Cargo.toml", "BufNewFile Cargo.toml" },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("crates").setup({
        smart_insert = true,
        remove_enabled_default_features = true,
        remove_empty_features = true,
        insert_closing_quote = true,

        autoload = true,
        autoupdate = true,
        autoupdate_throttle = 250,

        loading_indicator = true,
        search_indicator = true,

        date_format = "%Y-%m-%d",
        thousands_separator = ".",

        notification_title = "crates.nvim",
        curl_args = { "-sL", "--retry", "1" },

        -- I would reduce this from 80. 80 is pretty aggressive.
        max_parallel_requests = 20,

        expand_crate_moves_cursor = true,
        enable_update_available_warning = true,

        on_attach = function(bufnr)
          local crates = require("crates")

          local function map(lhs, rhs, desc)
            vim.keymap.set("n", lhs, rhs, {
              buffer = bufnr,
              silent = true,
              desc = desc,
            })
          end

          map("<leader>cct", crates.toggle, "Crates: Toggle")
          map("<leader>ccr", crates.reload, "Crates: Reload")

          map("<leader>ccv", crates.show_versions_popup, "Crates: Versions")
          map("<leader>ccf", crates.show_features_popup, "Crates: Features")
          map("<leader>ccd", crates.show_dependencies_popup, "Crates: Dependencies")

          map("<leader>ccu", crates.update_crate, "Crates: Update crate")
          map("<leader>cca", crates.update_all_crates, "Crates: Update all")
          map("<leader>ccU", crates.upgrade_crate, "Crates: Upgrade crate")
          map("<leader>ccA", crates.upgrade_all_crates, "Crates: Upgrade all")

          map("<leader>ccx", crates.expand_plain_crate_to_inline_table, "Crates: Expand crate")
          map("<leader>ccX", crates.extract_crate_into_table, "Crates: Extract crate")

          map("<leader>ccH", crates.open_homepage, "Crates: Homepage")
          map("<leader>ccR", crates.open_repository, "Crates: Repository")
          map("<leader>ccD", crates.open_documentation, "Crates: Documentation")
          map("<leader>ccC", crates.open_crates_io, "Crates: crates.io")
        end,

        text = {
          searching = "   Searching",
          loading = "   Loading",
          version = "   %s",
          prerelease = "   %s",
          yanked = "   %s",
          nomatch = "   No match",
          upgrade = "   %s",
          error = "   Error fetching crate",
        },

        highlight = {
          searching = "CratesNvimSearching",
          loading = "CratesNvimLoading",
          version = "CratesNvimVersion",
          prerelease = "CratesNvimPreRelease",
          yanked = "CratesNvimYanked",
          nomatch = "CratesNvimNoMatch",
          upgrade = "CratesNvimUpgrade",
          error = "CratesNvimError",
        },

        popup = {
          autofocus = false,
          hide_on_select = false,
          copy_register = '"',
          style = "minimal",
          border = "rounded",
          show_version_date = false,
          show_dependency_version = true,
          max_height = 30,
          min_width = 20,
          padding = 1,

          text = {
            title = " %s",
            pill_left = "",
            pill_right = "",
            description = "%s",
            created_label = " created        ",
            created = "%s",
            updated_label = " updated        ",
            updated = "%s",
            downloads_label = " downloads      ",
            downloads = "%s",
            homepage_label = " homepage       ",
            homepage = "%s",
            repository_label = " repository     ",
            repository = "%s",
            documentation_label = " documentation  ",
            documentation = "%s",
            crates_io_label = " crates.io      ",
            crates_io = "%s",
            lib_rs_label = " lib.rs         ",
            lib_rs = "%s",
            categories_label = " categories     ",
            keywords_label = " keywords       ",
            version = "  %s",
            prerelease = " %s",
            yanked = " %s",
            version_date = "  %s",
            feature = "  %s",
            enabled = " %s",
            transitive = " %s",
            normal_dependencies_title = " Dependencies",
            build_dependencies_title = " Build dependencies",
            dev_dependencies_title = " Dev dependencies",
            dependency = "  %s",
            optional = " %s",
            dependency_version = "  %s",
            loading = "  ",
          },

          highlight = {
            title = "CratesNvimPopupTitle",
            pill_text = "CratesNvimPopupPillText",
            pill_border = "CratesNvimPopupPillBorder",
            description = "CratesNvimPopupDescription",
            created_label = "CratesNvimPopupLabel",
            created = "CratesNvimPopupValue",
            updated_label = "CratesNvimPopupLabel",
            updated = "CratesNvimPopupValue",
            downloads_label = "CratesNvimPopupLabel",
            downloads = "CratesNvimPopupValue",
            homepage_label = "CratesNvimPopupLabel",
            homepage = "CratesNvimPopupUrl",
            repository_label = "CratesNvimPopupLabel",
            repository = "CratesNvimPopupUrl",
            documentation_label = "CratesNvimPopupLabel",
            documentation = "CratesNvimPopupUrl",
            crates_io_label = "CratesNvimPopupLabel",
            crates_io = "CratesNvimPopupUrl",
            lib_rs_label = "CratesNvimPopupLabel",
            lib_rs = "CratesNvimPopupUrl",
            categories_label = "CratesNvimPopupLabel",
            keywords_label = "CratesNvimPopupLabel",
            version = "CratesNvimPopupVersion",
            prerelease = "CratesNvimPopupPreRelease",
            yanked = "CratesNvimPopupYanked",
            version_date = "CratesNvimPopupVersionDate",
            feature = "CratesNvimPopupFeature",
            enabled = "CratesNvimPopupEnabled",
            transitive = "CratesNvimPopupTransitive",
            normal_dependencies_title = "CratesNvimPopupNormalDependenciesTitle",
            build_dependencies_title = "CratesNvimPopupBuildDependenciesTitle",
            dev_dependencies_title = "CratesNvimPopupDevDependenciesTitle",
            dependency = "CratesNvimPopupDependency",
            optional = "CratesNvimPopupOptional",
            dependency_version = "CratesNvimPopupDependencyVersion",
            loading = "CratesNvimPopupLoading",
          },

          keys = {
            hide = { "q", "<esc>" },
            open_url = { "<cr>" },
            select = { "<cr>" },
            select_alt = { "s" },
            toggle_feature = { "<cr>" },
            copy_value = { "yy" },
            goto_item = { "gd", "K", "<C-LeftMouse>" },
            jump_forward = { "<c-i>" },
            jump_back = { "<c-o>", "<C-RightMouse>" },
          },
        },

        completion = {
          insert_closing_quote = true,

          text = {
            prerelease = "  pre-release ",
            yanked = "  yanked ",
          },

          cmp = {
            enabled = false,
          },

          coq = {
            enabled = false,
            name = "crates.nvim",
          },

          blink = {
            use_custom_kind = true,
            kind_text = {
              version = "Version",
              feature = "Feature",
            },
            kind_highlight = {
              version = "BlinkCmpKindVersion",
              feature = "BlinkCmpKindFeature",
            },
            kind_icon = {
              version = " ",
              feature = " ",
            },
          },

          crates = {
            enabled = true,
            min_chars = 3,
            max_results = 8,
          },
        },

        null_ls = {
          enabled = false,
          name = "crates.nvim",
        },

        neoconf = {
          enabled = false,
          namespace = "crates",
        },

        lsp = {
          enabled = false,
          name = "crates.nvim",
          on_attach = function(client, bufnr) end,
          actions = false,
          completion = false,
          hover = false,
        },
      })
    end,
  },
}
