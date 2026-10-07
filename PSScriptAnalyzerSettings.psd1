@{
    IncludeRules = @(
        'PSUseConsistentIndentation',
        'PSUseConsistentWhitespace',
        'PSAvoidUsingCmdletAliases',
        'PSAvoidTrailingWhitespace',
        'PSUseCorrectCasing'
    )
    Rules = @{
        PSUseConsistentIndentation = @{
            Enable = $true
            IndentationSize = 4
            Kind = 'space'
        }
        PSUseConsistentWhitespace = @{
            Enable = $true
            CheckInnerBrace = $true
            CheckOpenBrace = $true
            CheckOpenParen = $true
            CheckOperator = $true
            CheckPipe = $true
            CheckSeparator = $true
        }
    }
}
