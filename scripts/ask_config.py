#!/usr/bin/env python3
import json
from typing import Any, List, Dict, Type
from dataclasses import dataclass,field 

@dataclass
class ConfigGroup:
    name: str
    enabled: bool = False
    dependencies: list[str] = field(default_factory=list)
    conflicts: list[str] = field(default_factory=list)

    def on_global_config_change(self, name: str, value: Any) -> None:
        pass
    
    def get_extra_options(self) -> Dict[str, Any]:
        return {}

class Config:
    _config_groups: Dict[str, ConfigGroup] = {}
    _global_config: Dict[str, Any] = {}

    def add_global_config(self, name: str, value: Any) -> None:
        self._global_config[name] = value
        for group in self._config_groups.values():
            group.on_global_config_change(name, value)

    def add_group(
        self, 
        group: ConfigGroup
    ) -> None:
        self._config_groups[group.name] = group
    
    def set_group_enabled(self, name: str, enabled: bool) -> None:
        self._set_group_enabled_helper(name, enabled, set())
        for group in self._config_groups.values():
            group.on_global_config_change(f"enable_{name}", enabled)

    def _set_group_enabled_helper(self, name: str, enabled: bool, visited: set[str]) -> None:
        if name in visited:
            raise ValueError(f"Circular dependency detected in group dependencies: {visited}")
        if self._config_groups[name].enabled == enabled:
            return
        self._config_groups[name].enabled = enabled
        visited.add(name)
        for dependency in self._config_groups[name].dependencies:
            self._set_group_enabled_helper(dependency, enabled, visited)
        for conflict in self._config_groups[name].conflicts:
            self._set_group_enabled_helper(conflict, not enabled, visited)
    
    def validate(self) -> None:
        errors = []
        for name, group in self._config_groups.items():
            enabled = group.enabled
            for dependency in group.dependencies:
                if dependency not in self._config_groups:
                    errors.append(f"{name} depends on undefined {dependency}")
                elif enabled and not self._config_groups[dependency].enabled:
                    errors.append(f"{name} is enabled but depends on disabled {dependency}")
            for conflict in group.conflicts:
                if conflict not in self._config_groups:
                    errors.append(f"{name} conflicts with undefined {conflict}")
                elif enabled and self._config_groups[conflict].enabled:
                    errors.append(f"{name} is enabled but conflicts with enabled {conflict}")
        if errors:
            raise ValueError(f"Invalid config: {errors}")
    
    def generate_json(self) -> str:
        result = {}
        for name, group in self._config_groups.items():
            enabled = group.enabled
            result[f"enable_{name}"] = enabled
            if not enabled:
                continue
            inner = {}
            for key, value in group.get_extra_options().items():
                inner[key] = value
            result[name] = inner
        return json.dumps(result)

def raise_if_not_instance(value: Any, expected_type: Type) -> None:
    if not isinstance(value, expected_type):
        raise ValueError(f"Expected {expected_type}, got {type(value)}")

@dataclass
class GitConfigGroup(ConfigGroup):
    email: str = "INFCode@163.com"
    user: str = "INFCode"
    editor: str = "vim"

    def get_extra_options(self) -> Dict[str, Any]:
        return {
            "email": self.email,
            "user": self.user,
            "editor": self.editor
        }
    
    def on_global_config_change(self, name: str, value: Any) -> None:
        if name == "preferred_editor":
            raise_if_not_instance(value, str)
            self.editor = value

@dataclass
class FishConfigGroup(ConfigGroup):
    editor: str = "vim"
    proxy: bool = False
    mirror: str = ""

    def get_extra_options(self) -> Dict[str, Any]:
        return {
            "editor": self.editor,
            "proxy": self.proxy,
            "mirror": self.mirror
        }

    def on_global_config_change(self, name: str, value: Any) -> None:
        if name == "preferred_editor":
            raise_if_not_instance(value, str)
            self.editor = value
        if name == "proxy":
            raise_if_not_instance(value, bool)
            self.proxy = value
        if name == "mirror":
            raise_if_not_instance(value, str)
            self.mirror = value

def make_default() -> Config:
    config_groups = []
    config_groups.append(GitConfigGroup(name="git"))
    config_groups.append(FishConfigGroup(name="fish"))
    config_groups.append(ConfigGroup(name="neovim"))
    config_groups.append(ConfigGroup(name="alacritty"))
    config_groups.append(ConfigGroup(name="ohmyposh"))
    config_groups.append(ConfigGroup(name="uv"))
    config_groups.append(ConfigGroup(name="cargo"))
    
    default_config = Config()
    for group in config_groups:
        default_config.add_group(group)
    
    default_config.validate()

    return default_config

def ask_config(config: Config) -> None:
    pass 

def main():
    result = make_default()

    ask_config(result)
    result.validate()
    
    print(result.generate_json())

if __name__ == "__main__":
    main()