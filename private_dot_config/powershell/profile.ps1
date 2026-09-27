$PSStyle.FileInfo.Directory = $PSStyle.Foreground.FromRgb(141, 161, 1)
$PSStyle.FileInfo.Executable = $PSStyle.Foreground.FromRgb(248, 85, 82)
$PSStyle.FileInfo.SymbolicLink = $PSStyle.Foreground.FromRgb(53, 167, 124)
$PSStyle.Formatting.TableHeader = $PSStyle.Foreground.FromRgb(92, 106, 114)
$PSStyle.Formatting.Error = $PSStyle.Foreground.FromRgb(248, 85, 82)
$PSStyle.Formatting.Warning = $PSStyle.Foreground.FromRgb(223, 160, 0)
$PSStyle.Formatting.Verbose = $PSStyle.Foreground.FromRgb(58, 148, 197)
$PSStyle.Formatting.Debug = $PSStyle.Foreground.FromRgb(223, 105, 186)
Set-PSReadLineOption -Colors @{ Default = $PSStyle.Foreground.FromRgb(92, 106, 114) }

Set-Alias -Name vi -Value nvim
Set-Alias -Name vim -Value nvim
