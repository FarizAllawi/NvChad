-- local opts = {
--   -- model= "gemma:2b"
--   model = "mistral", -- The default model to use.
--   quit_map = "q", -- set keymap for close the response window
--   retry_map = "<c-r>", -- set keymap to re-send the current prompt
--   accept_map = "<c-cr>", -- set keymap to replace the previous selection with the last result
--   host = "localhost", -- The host running the Ollama service.
--   port = "11434", -- The port on which the Ollama service is listening.
--   display_mode = "split", -- The display mode. Can be "float" or "split" or "horizontal-split".
--   show_prompt = false, -- Shows the prompt submitted to Ollama.
--   show_model = true, -- Displays which model you are using at the beginning of your chat session.
--   no_auto_close = false, -- Never closes the window automatically.
--   hidden = false, -- Hide the generation window (if true, will implicitly set `prompt.replace = true`), requires Neovim >= 0.10
--   init = function(options) pcall(io.popen, "ollama serve > /dev/null 2>&1 &") end,
--   -- Function to initialize Ollama
--   command = function(options)
--       local body = {model = options.model, stream = true}
--       return "curl --silent --no-buffer -X POST http://" .. options.host .. ":" .. options.port .. "/api/chat -d $body"
--   end,
--   -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
--   -- This can also be a command string.
--   -- The executed command must return a JSON object with { response, context }
--   -- (context property is optional).
--   -- list_models = '<omitted lua function>', -- Retrieves a list of model names
--   debug = false -- Prints errors and the command which is run. 
-- }
--
-- require("gen").setup(opts)


-- setup cmp


local llm = require('llm')

--- codegemma ---

--llm.setup({
--  model = "codegemma", -- the model ID, behavior depends on backend
--  backend = "ollama", -- backend ID, "huggingface" | "ollama" | "openai" | "tgi"
--  url = "http://localhost:11434/api/generate", -- the http url of the backend
--  --tokens_to_clear = { "<|end_of_turn|>" }, -- tokens to remove from the model's output
--  -- tokens_to_clear = { "<|file_separator|>" }, -- tokens to remove from the model's output
--  request_body = {
--    raw=true,
--    -- Modelfile options for the model you use
--    options = {
--      temperature = 0,
--      num_predict = 128,
--      top_p = 0.9,
--    }
--  },
--  -- set this if the model supports fill in the middle
--  fim = {
--    enabled = true,
--    prefix = "<|fim_prefix|>",
--    middle = "<|fim_middle|>",
--    suffix = "<|fim_suffix|>",
--  },
--  -- debounce_ms = 300,
--  accept_keymap = "<Tab>",
--  dismiss_keymap = "<S-Tab>",
--  tls_skip_verify_insecure = true,
--  debounce_ms=100,
--  context_window = 1024,
--  enable_suggestions_on_startup = true,
--  -- enable_suggestions_on_files = "*.php,*.py,*.lua,*.java,*.js,*.jsx,*.ts,*.tsx,*.html,*.css,*.scss,*.json,*.yaml,*.yml,*.md,*.rmd,*.tex,*.bib,*.cpp,*.h,*.hpp", -- pattern matching syntax to enable suggestions on specific files, either a string or a list of strings
--  enable_suggestions_on_files = "*", -- pattern matching syntax to enable suggestions on specific files, either a string or a list of strings
--  disable_url_path_completion = true, -- cf Backend
--})



llm.setup({
  model = "codellama:7b", -- the model ID, behavior depends on backend
  backend = "ollama", -- backend ID, "huggingface" | "ollama" | "openai" | "tgi"
  url = "http://localhost:11434/api/generate", -- the http url of the backend
  --tokens_to_clear = { "<|end_of_turn|>" }, -- tokens to remove from the model's output
  -- tokens_to_clear = { "<|file_separator|>" }, -- tokens to remove from the model's output
  request_body = {
    -- Modelfile options for the model you use
    --
    options = {
      temperature = 0.2,
      top_p = 0.95,
    }
  },
  -- set this if the model supports fill in the middle

  tokens_to_clear = { "<EOT>" },
  fim = {
    enabled = true,
    prefix = "<PRE> ",
    middle = " <MID>",
    suffix = " <SUF>",
  },
  -- debounce_ms = 300,
  accept_keymap = "<Tab>",
  dismiss_keymap = "<S-Tab>",
  debounce_ms=100,
  -- context_window = 1024,
  enable_suggestions_on_startup = true,
  -- enable_suggestions_on_files = "*.php,*.py,*.lua,*.java,*.js,*.jsx,*.ts,*.tsx,*.html,*.css,*.scss,*.json,*.yaml,*.yml,*.md,*.rmd,*.tex,*.bib,*.cpp,*.h,*.hpp", -- pattern matching syntax to enable suggestions on specific files, either a string or a list of strings
  enable_suggestions_on_files = "*", -- pattern matching syntax to enable suggestions on specific files, either a string or a list of strings
  --disable_url_path_completion = true, -- cf Backend
})

