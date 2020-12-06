alias vlc='/Applications/VLC.app/Contents/MacOS/VLC'
alias appcode="open -a AppCode.app"
alias xcph='swift package generate-xcodeproj | grep -o ".\/.*.xcodeproj$"'
alias xcp='xcph | xargs open'
alias xcpa='xcph | xargs open -a AppCode.app'

function telekomrechnung() {
    cd /Volumes/Secomba/tsaul/Boxcryptor/Dropbox\ \(Personal\)/Verwaltung/Finanzen/Rechnungen/Telekom/wd
    gpg --output rg.zip --decrypt $1 && unzip rg.zip
    rm rg.zip
}
