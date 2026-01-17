-- ddu.vim
-- 参考
-- ddu.vim 設定例の紹介 - アルパカログ - https://alpacat.com/blog/my-ddu-settings 
-- ddu.vimを導入する - https://zenn.dev/arccosine/articles/39ea605f99b7b5 
-- 新世代の ui 作成プラグイン ddu.vim - https://zenn.dev/shougo/articles/ddu-vim-beta#ui%2c-source%2c-filter%2c-kind-%e3%81%a8%e3%81%84%e3%81%86%e6%a6%82%e5%bf%b5

-- deniteの後継
return {
  {
    'shougo/ddu.vim',
    config = function()
      require("plugins/config/ddu")
    end
  },
  'shougo/ddu-ui-ff',
  'shougo/ddu-ui-filer',
  'ryota2357/ddu-column-icon_filename',
  'shougo/ddu-source-file',
  'shougo/ddu-source-register',
  {
    'lambdalisue/mr.vim',
    branch ='main'
  },
  'kuuote/ddu-source-mr',
  'shougo/ddu-kind-file',
  'shougo/ddu-source-file_rec',
  'shun/ddu-source-buffer',
  -- depends on ripgrep
  'shun/ddu-source-rg',
  'shougo/ddu-filter-matcher_substring',
  'shougo/ddu-commands.vim',
  'shougo/ddu-source-action',
  'shougo/ddu-source-line',
  "Shougo/ddu-filter-matcher_ignore_files",
}
