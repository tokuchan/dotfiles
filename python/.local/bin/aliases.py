#!/usr/bin/env python3
import click
from rich.console import Console
from rich.table import Table
from rich.traceback import install
import sh
import re

import json
from collections import OrderedDict
from typing import *

install()


@click.command()
@click.option(
    "-d/-D",
    "--show-alias-definitions/--no-show-alias-definitions",
    default=True,
    show_default=True,
    help="Show alias definitions in output.",
)
@click.option(
    "-f",
    "--format",
    type=click.Choice(["rich", "simple", "json"]),
    default="rich",
    show_default=True,
    help="Select format for output.",
)
def cli(show_alias_definitions: bool, format: str):
    aliases = sh.git("--no-pager", "config", "--get-regexp", "^alias\.").split("\n")

    aliases__processed: OrderedDict[str, str] = OrderedDict()

    for alias in aliases:
        alias = re.sub(r"\x1b\[m", "", alias)
        alias = re.sub(r"\x1b\[?1h", "", alias)
        alias = re.sub(r"^alias\.", "", alias)
        m = re.fullmatch(r"(.*?) (.*)", alias)
        if m is None:
            continue
        alias = m.groups()[0]
        definition = m.groups()[1]
        aliases__processed[alias] = definition

    if format == "rich":
        table = Table(title="Git Aliases")

        table.add_column("Alias", justify="right", style="yellow", no_wrap=True)
        if show_alias_definitions:
            table.add_column("Definition", justify="left", style="bold white")

        for k, v in aliases__processed.items():
            if show_alias_definitions:
                table.add_row(k, v)
            else:
                table.add_row(k)

        console = Console()
        console.print(table)
    elif format == "simple":
        for k, v in aliases__processed.items():
            if show_alias_definitions:
                print(f"{k}\t{v}")
            else:
                print(k)
    elif format == "json":
        if show_alias_definitions:
            print(json.dumps(aliases__processed))
        else:
            print(json.dumps(list(aliases__processed.keys())))
    else:
        raise ValueError("Invalid choice")


if __name__ == "__main__":
    cli()
