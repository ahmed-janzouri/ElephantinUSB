Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Create Window
$form = New-Object System.Windows.Forms.Form
$form.Text = "ElephantinUSB Setup Wizard"
$form.Size = New-Object System.Drawing.Size(500, 420)
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = "FixedDialog"
$form.MaximizeBox = $false
$form.BackColor = [System.Drawing.Color]::FromArgb(30, 30, 30)

# Title Label
$labelTitle = New-Object System.Windows.Forms.Label
$labelTitle.Text = "ElephantinUSB Setup"
$labelTitle.Font = New-Object System.Drawing.Font("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)
$labelTitle.ForeColor = [System.Drawing.Color]::White
$labelTitle.Location = New-Object System.Drawing.Point(30, 20)
$labelTitle.AutoSize = $true
$form.Controls.Add($labelTitle)

# Subtitle
$labelSub = New-Object System.Windows.Forms.Label
$labelSub.Text = "Zero-Cloud Offline Companion Setup"
$labelSub.Font = New-Object System.Drawing.Font("Segoe UI", 9)
$labelSub.ForeColor = [System.Drawing.Color]::Gray
$labelSub.Location = New-Object System.Drawing.Point(33, 55)
$labelSub.AutoSize = $true
$form.Controls.Add($labelSub)

# Model Label
$labelModel = New-Object System.Windows.Forms.Label
$labelModel.Text = "Select AI Companion Engine:"
$labelModel.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
$labelModel.ForeColor = [System.Drawing.Color]::White
$labelModel.Location = New-Object System.Drawing.Point(30, 100)
$labelModel.AutoSize = $true
$form.Controls.Add($labelModel)

# Model Dropdown Box
$dropdown = New-Object System.Windows.Forms.ComboBox
$dropdown.Location = New-Object System.Drawing.Point(30, 130)
$dropdown.Size = New-Object System.Drawing.Size(420, 25)
$dropdown.Font = New-Object System.Drawing.Font("Segoe UI", 10)
$dropdown.DropDownStyle = "DropDownList"
$dropdown.Items.Add("Llama 3.2 3B (Recommended - Balanced & Wise)") | Out-Null
$dropdown.Items.Add("Llama 3.2 1B (Ultra-Fast / Low RAM)") | Out-Null
$dropdown.Items.Add("Mistral 7B (Heavy / Advanced Capability)") | Out-Null
$dropdown.SelectedIndex = 0
$form.Controls.Add($dropdown)

# Status Label
$labelStatus = New-Object System.Windows.Forms.Label
$labelStatus.Text = "Ready to install on USB drive."
$labelStatus.Font = New-Object System.Drawing.Font("Segoe UI", 9)
$labelStatus.ForeColor = [System.Drawing.Color]::LightGreen
$labelStatus.Location = New-Object System.Drawing.Point(30, 190)
$labelStatus.Size = New-Object System.Drawing.Size(420, 20)
$form.Controls.Add($labelStatus)

# Progress Bar
$progressBar = New-Object System.Windows.Forms.ProgressBar
$progressBar.Location = New-Object System.Drawing.Point(30, 220)
$progressBar.Size = New-Object System.Drawing.Size(420, 25)
$form.Controls.Add($progressBar)

# Install Button
$btnInstall = New-Object System.Windows.Forms.Button
$btnInstall.Text = "Start 1-Click Setup"
$btnInstall.Font = New-Object System.Drawing.Font("Segoe UI", 11, [System.Drawing.FontStyle]::Bold)
$btnInstall.BackColor = [System.Drawing.Color]::FromArgb(0, 122, 204)
$btnInstall.ForeColor = [System.Drawing.Color]::White
$btnInstall.Location = New-Object System.Drawing.Point(130, 280)
$btnInstall.Size = New-Object System.Drawing.Size(240, 45)
$form.Controls.Add($btnInstall)

# Helper function for responsive chunked downloads
function Download-FileResponsive($url, $destination) {
    $uri = New-Object System.Uri($url)
    $request = [System.Net.HttpWebRequest]::Create($uri)
    $response = $request.GetResponse()
    $totalLength = $response.ContentLength
    $stream = $response.GetResponseStream()
    $targetFile = New-Object System.IO.FileStream($destination, [System.IO.FileMode]::Create)
    
    [byte[]]$buffer = New-Object byte[] 65536
    $totalBytesRead = 0
    
    while (($bytesRead = $stream.Read($buffer, 0, $buffer.Length)) -gt 0) {
        $targetFile.Write($buffer, 0, $bytesRead)
        $totalBytesRead += $bytesRead
        if ($totalLength -gt 0) {
            $percent = [int](($totalBytesRead / $totalLength) * 100)
            $progressBar.Value = [Math]::Min($percent, 100)
            $mbRead = [Math]::Round($totalBytesRead / 1MB, 1)
            $mbTotal = [Math]::Round($totalLength / 1MB, 1)
            $labelStatus.Text = "Downloading Model: $mbRead MB / $mbTotal MB ($percent%)"
        }
        [System.Windows.Forms.Application]::DoEvents()
    }
    $targetFile.Close()
    $stream.Close()
    $response.Close()
}

# Click Event Handler
$btnInstall.Add_Click({
    $btnInstall.Enabled = $false
    $dropdown.Enabled = $false
    
    $usbRoot = $PSScriptRoot
    $ollamaDir = Join-Path $usbRoot "ollama"
    $modelsDir = Join-Path $usbRoot "models"
    $tempDir = Join-Path $usbRoot "temp"

    [System.IO.Directory]::CreateDirectory($ollamaDir) | Out-Null
    [System.IO.Directory]::CreateDirectory($modelsDir) | Out-Null
    [System.IO.Directory]::CreateDirectory($tempDir) | Out-Null

    try {
        # 1. Download & Install Ollama (Visible mode so it never hides/hangs)
        $ollamaExe = Join-Path $ollamaDir "ollama.exe"
        if (-not (Test-Path $ollamaExe)) {
            $labelStatus.Text = "Downloading AI Engine (Ollama)..."
            $form.Refresh()
            
            $installerPath = Join-Path $tempDir "OllamaSetup.exe"
            Download-FileResponsive "https://ollama.com/download/OllamaSetup.exe" $installerPath
            
            [System.Windows.Forms.Application]::DoEvents()

            $labelStatus.Text = "Please complete the Ollama setup window..."
            $form.Refresh()
            
            # Run without silent flags so user can see it and click through if needed
            $proc = Start-Process -FilePath $installerPath -ArgumentList "/DIR=$ollamaDir" -PassThru
            while (-not $proc.HasExited) {
                Start-Sleep -Milliseconds 300
                [System.Windows.Forms.Application]::DoEvents()
            }
        }

        # 2. Determine Model URL
        $selectedText = $dropdown.SelectedItem.ToString()
        if ($selectedText -like "*1B*") {
            $modelUrl = "https://huggingface.co/bartowski/Llama-3.2-1B-Instruct-GGUF/resolve/main/Llama-3.2-1B-Instruct-Q4_K_M.gguf"
            $modelName = "llama-3.2-1b.gguf"
        } elseif ($selectedText -like "*Mistral*") {
            $modelUrl = "https://huggingface.co/TheBloke/Mistral-7B-Instruct-v0.2-GGUF/resolve/main/mistral-7b-instruct-v0.2.Q4_K_M.gguf"
            $modelName = "mistral-7b.gguf"
        } else {
            $modelUrl = "https://huggingface.co/bartowski/Llama-3.2-3B-Instruct-GGUF/resolve/main/Llama-3.2-3B-Instruct-Q4_K_M.gguf"
            $modelName = "llama-3.2-3b.gguf"
        }

        $targetModelPath = Join-Path $modelsDir $modelName
        if (-not (Test-Path $targetModelPath)) {
            $labelStatus.Text = "Downloading Model ($modelName)..."
            $form.Refresh()
            Download-FileResponsive $modelUrl $targetModelPath
        }

        # Clean temp
        if (Test-Path $tempDir) { Remove-Item -Recurse -Force $tempDir }

        voices:
        $progressBar.Value = 100
        $labelStatus.Text = "Setup Complete! You can now launch start.bat."
        $btnInstall.Text = "Installation Complete"
        [System.Windows.Forms.MessageBox]::Show("ElephantinUSB setup completed successfully!", "Success", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
    }
    catch {
        [System.Windows.Forms.MessageBox]::Show("Error during setup: $_", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
        $btnInstall.Enabled = $true
        $dropdown.Enabled = $true
    }
})

[void]$form.ShowDialog()