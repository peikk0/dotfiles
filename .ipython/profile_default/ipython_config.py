# Configuration file for ipython.

from IPython.terminal.prompts import Prompts, Token


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


c.TerminalInteractiveShell.highlighting_style_overrides = {
    Token.Prompt: 'ansigreen',
    Token.OutPrompt: 'ansired',
    Token: 'ansiblue',
}

c.TerminalInteractiveShell.prompts_class = MyPrompts

c.TerminalIPythonApp.display_banner = False
