call plug#begin($XDG_DATA_HOME.'/vim/plugged')
  Plug 'junegunn/vim-plug', { 'tag': '0.11.0' }

  Plug 'junegunn/fzf', { 'dir': $HOME . '/.local/opt/fzf', 'tag': '0.35.1' }

  Plug 'AndrewRadev/splitjoin.vim', { 'commit': '956d67c88512b91c2938da3a9e0aeeea2b82cd0b' }
  Plug 'Joorem/vim-haproxy', { 'tag': 'v0.2.1' }
  Plug 'SirVer/ultisnips', { 'commit': 'e99fdf15cd55a4a8e0cb0a80a6810c1867a5c401' }
  Plug 'airblade/vim-gitgutter', { 'commit': '00df1089b6267f47c7c0f13536789feb9db1e65b' }
  Plug 'andrewstuart/vim-kubernetes', { 'commit': 'fda8845fc07bdbdf3ce445c0a1e21f74e04da630' }
  Plug 'ararslan/license-to-vim', { 'commit': '7a09025f33205467b0b689abe23736aa2b1133e9' }
  Plug 'arcticicestudio/nord-vim', { 'tag': 'v0.19.0' }
  Plug 'bfontaine/Brewfile.vim', { 'commit': 'f13b98b92f2e9b9e38f3b1d45d41e19049d671df' }
  Plug 'chr4/nginx.vim', { 'commit': '99694458062e4e1d138bd022b10432a05612a2db' }
  Plug 'chrisbra/csv.vim', { 'commit': 'fb159987bb430bb61e07928d132e4487e54a82ef' }
  Plug 'chrisbra/vim-zsh', { 'commit': '7dd09f8a27183b6fb2d417c4390e0b960260e8be' }
  Plug 'dense-analysis/ale', { 'tag': 'v3.3.0' }
  Plug 'edkolev/tmuxline.vim', { 'commit': '4119c553923212cc67f4e135e6f946dc3ec0a4d6' }
  Plug 'ekalinin/Dockerfile.vim', { 'commit': '2a31e6bcea5977209c05c728c4253d82fd873c82' }
  Plug 'elzr/vim-json', { 'commit': '3727f089410e23ae113be6222e8a08dd2613ecf2' }
  Plug 'ericpruitt/tmux.vim', { 'commit': '6d9499ba23f0d77bd0acb8ef2d915db1ce91a19a', 'rtp': 'vim/' }
  Plug 'fatih/vim-go', { 'tag': 'v1.28', 'do': ':GoUpdateBinaries' }
  Plug 'godlygeek/tabular', { 'commit': '339091ac4dd1f17e225fe7d57b48aff55f99b23a' }
  Plug 'google/vim-jsonnet', { 'commit': 'f27e1d67dff34ac9cf9c83ea2f2f814e53aa409c' }
  Plug 'hail2u/vim-css3-syntax', { 'commit': 'f6dde98e899927473aba1d30667391a181490ad6' }
  Plug 'hashivim/vim-terraform', { 'commit': 'f0b17ac9f1bbdf3a29dba8b17ab429b1eed5d443' }
  Plug 'honza/vim-snippets', { 'commit': '8c917944354552c1263159a4a218ad924969be0c' }
  Plug 'https://gitlab.com/dbeniamine/vim-mail.git', { 'commit': '532684331dfedc254ce4a998f98ccc25995ffdf2' }
  Plug 'iamcco/markdown-preview.nvim', { 'tag': 'v0.0.10', 'do': 'cd app && yarn install' }
  Plug 'jamessan/vim-gnupg', { 'commit': 'f9b608f29003dfde6450931dc0f495a912973a88' }
  Plug 'junegunn/fzf.vim', { 'commit': '0f03107bc94b31a9c7adcee6da8e5de7492e4b0b' }
  Plug 'junegunn/vim-easy-align', { 'commit': '12dd6316974f71ce333e360c0260b4e1f81169c3' }
  Plug 'lepture/vim-jinja', { 'commit': '7c54e2320c5f676636cdd8697480782eebfb2bf2' }
  Plug 'luochen1990/rainbow', { 'commit': '61f719aebe0dc5c3048330c50db72cfee1afdd34' }
  Plug 'markonm/traces.vim', { 'commit': '9663fcf84de5776bee71b6c816c25ccb6ea11d1a' }
  Plug 'mboughaba/i3config.vim', { 'commit': '5c753c56c033d3b17e5005a67cdb9653bbb88ba7' }
  Plug 'mhinz/vim-startify', { 'commit': '81e36c352a8deea54df5ec1e2f4348685569bed2' }
  Plug 'mustache/vim-mustache-handlebars', { 'commit': '0153fe03a919add2d6cf2d41b2d5b6e1188bc0e0p' }
  Plug 'othree/html5.vim', { 'commit': '7c9f6f38ce4f9d35db7eeedb764035b6b63922c6' }
  Plug 'pangloss/vim-javascript', { 'commit': 'c470ce1399a544fe587eab950f571c83cccfbbdc' }
  Plug 'pearofducks/ansible-vim', { 'commit': '93798e8c89c441d29d4678da0c0d5e1429eb43b0' }
  Plug 'preservim/nerdtree', { 'commit': 'fc85a6f07c2cd694be93496ffad75be126240068' }
  Plug 'preservim/vim-markdown', { 'commit': 'df4be8626e2c5b2a42eb60e1f100fce469b81f7d' }
  Plug 'python-mode/python-mode', { 'branch': 'develop', 'commit': '149ccf7c5be0753f5e9872c023ab2eeec3442105' }
  Plug 'rlue/vim-fold-rspec', { 'commit': '67cd4d3da80a312b9a0e896b85e729a29c514b56' }
  Plug 'rodjek/vim-puppet', { 'commit': '81943d532dee24f8518f855dfb17160809abfdfb' }
  Plug 'rust-lang/rust.vim', { 'commit': '889b9a7515db477f4cb6808bef1769e53493c578' }
  Plug 'ryanoasis/vim-devicons', { 'commit': '71f239af28b7214eebb60d4ea5bd040291fb7e33' }
  Plug 'shumphrey/fugitive-gitlab.vim', { 'commit': 'b73a8e97de95d26280082abb7f51465a3d3b239e' }
  Plug 'thaerkh/vim-workspace', { 'commit': 'c26b473f9b073f24bacecd38477f44c5cd1f5a62' }
  Plug 'towolf/vim-helm', { 'commit': 'c2e7b85711d410e1d73e64eb5df7b70b1c4c10eb' }
  Plug 'tpope/vim-bundler', { 'commit': 'ce4690e6fc1e76b4706109a08222bda135747950' }
  Plug 'tpope/vim-commentary', { 'commit': 'e87cd90dc09c2a203e13af9704bd0ef79303d755' }
  Plug 'tpope/vim-endwise', { 'commit': '4e5c8358d751625bb040b187b9fe430c2b769f0a' }
  Plug 'tpope/vim-fugitive', { 'commit': '99cdb88bc64063dc4656ae53496f06fb2a394cd4' }
  Plug 'tpope/vim-git', { 'commit': '5143bea9ed17bc32163dbe3ca706344d79507b9d' }
  Plug 'tpope/vim-haml', { 'commit': '95a095a4d29eaf0ba0851dcee5635053ec0f9f74' }
  Plug 'tpope/vim-rails', { 'commit': '959e94b76e6ebdf984acef61649ba7d0f62bd425' }
  Plug 'tpope/vim-sensible', { 'commit': '16283468becaa6985839f96fea212f8634fbd7d2' }
  Plug 'tpope/vim-surround', { 'commit': '3d188ed2113431cf8dac77be61b842acb64433d9' }
  Plug 'tpope/vim-unimpaired', { 'commit': '6d44a6dc2ec34607c41ec78acf81657248580bf1' }
  Plug 'vim-airline/vim-airline', { 'commit': '0913c0a3b6fc256e6de8dff00dfd1c9388cad9a6' }
  Plug 'vim-airline/vim-airline-themes', { 'commit': 'dd81554c2231e438f6d0e8056ea38fd0e80ac02a' }
  Plug 'vim-ruby/vim-ruby', { 'commit': 'd8ef4c3584d0403d26f69bfd0a8fc6bfe198aeee' }
  Plug 'vim-scripts/dhcpd.vim', { 'commit': '460075c2ad857b254340af3c17ba13e2d2cb99cf' }
  Plug 'vim-scripts/ntp.vim', { 'commit': 'abcc5c92d012e47edd8b98551987860989e6ff7c' }
  Plug 'vim-scripts/pam.vim', { 'commit': '0a87eb6e5a06c4a7b6e194e2829dc0d351de3c1a' }
  Plug 'vito-c/jq.vim', { 'tag': 'v1.0.2' }
  Plug 'ycm-core/YouCompleteMe', { 'commit': '6cc453397564164b7cdb341cd73f55a3aaf465c4', 'do': './install.py' }
call plug#end()
