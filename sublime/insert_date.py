import sublime, sublime_plugin
from datetime import datetime

class InsertDateCommand(sublime_plugin.TextCommand):
    def run(self, edit):
        current_date = datetime.now().strftime("%d.%m.%Y")

        for sel in self.view.sel():
            self.view.insert(edit, sel.begin(), current_date)
