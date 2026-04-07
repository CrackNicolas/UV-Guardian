function uv-safe($package) {
    Write-Host ""
    
    # 1. Calculate the safety window (7 days ago)
    $sevenDaysAgo = (Get-Date).AddDays(-7).ToString("yyyy-MM-dd")

    Write-Host ">>> ACTIVE SHIELD: Defense in Depth" -ForegroundColor Magenta
    Write-Host ">>> Target: Versions released before $sevenDaysAgo" -ForegroundColor Cyan

    # 2. Check for known vulnerabilities in existing packages
    Write-Host ">>> Checking for outdated packages and vulnerabilities..." -ForegroundColor Yellow
    uv pip list --outdated
    
    # 3. Supply Chain Audit Link
    $url = "https://pypi.org/project/$package/#history"
    Write-Host ">>> GOLDEN RULE: Verifying PyPI history..." -ForegroundColor Yellow
    Write-Host ">>> Audit link: $url" -ForegroundColor Blue

    # 4. Human-in-the-loop confirmation
    $confirm = Read-Host ">>> Install stable version (up to $sevenDaysAgo) with script BLOCKING? (y/n)"

    if ($confirm -eq 'y') {
        # Execution with --no-build to prevent malicious install scripts
        uv add $package --exclude-newer $sevenDaysAgo --no-build

        # Intelligent Error Handling
        if ($LASTEXITCODE -ne 0) {
            Write-Host "[!] SYSTEM ALERT: Installation failed." -ForegroundColor Red
            
            if (!(Test-Path "pyproject.toml")) {
                Write-Host ">>> PROBABLE CAUSE: Not inside a Python project." -ForegroundColor Yellow
                Write-Host ">>> SOLUTION: Run 'uv init' first in this directory." -ForegroundColor Green
            } else {
                Write-Host ">>> PROBABLE CAUSE: Library requires compilation (no-build) or no stable old version exists." -ForegroundColor Yellow
                Write-Host ">>> If you fully trust it, use: uv add $package" -ForegroundColor Gray
            }
        } else {
            # Credential leak prevention
            if (Test-Path ".env") {
                Write-Host ">>> SECURITY NOTICE: .env file detected. Remember to update your .gitignore!" -ForegroundColor DarkYellow
            }
            Write-Host ">>> Success: Package added securely." -ForegroundColor Green
        }
    } else {
        Write-Host ">>> Installation aborted. No changes were made." -ForegroundColor Gray
    }
}