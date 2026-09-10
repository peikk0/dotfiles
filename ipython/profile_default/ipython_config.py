"""
Configuration file for ipython.
"""

from IPython.terminal.prompts import Prompts, Token
from IPython.utils.PyColorize import linux_theme, theme_table
from copy import deepcopy


class MyPrompts(Prompts):
    def in_prompt_tokens(self):
        return [
            (Token, "\ue73c "),
            (Token.Prompt, "❯ "),
        ]

    def continuation_prompt_tokens(self, width=None):
        if width is None:
            width = self._width()
        return [
            (Token.Prompt, (' ' * (width - 5)) + "  \ue621 "),
        ]

    def out_prompt_tokens(self):
        return [
            (Token, "  "),
            (Token.Prompt, "❮ "),
        ]

c = get_config()

c.TerminalInteractiveShell.highlighting_style_overrides = {
    Token.Prompt: 'ansigreen',
    Token.OutPrompt: 'ansired',
    Token: 'ansiblue',
}

c.TerminalInteractiveShell.prompts_class = MyPrompts

c.TerminalIPythonApp.display_banner = False

# Catppuccin Mocha theme
# https://github.com/catppuccin/python/issues/111#issuecomment-3114285378

theme = deepcopy(linux_theme)
catppuccin_theme = "catppuccin-mocha"
theme.base = catppuccin_theme
theme_table[catppuccin_theme] = theme

c.TerminalInteractiveShell.true_color = True
c.TerminalInteractiveShell.colors = catppuccin_theme
