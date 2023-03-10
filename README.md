# Connect to OpenVPN SSL Server GitHub Action

An GitHub Action for connecting to an OpenVPN SSL Server.
Only works on ubuntu runner.

## Usage

- Save your `.ovpn` config to  `.github/vpn/config.ovpn`
- Replace `remote your-vpn-server.example 443` with `remote AUTO_REPLACED_HOST AUTO_REPLACED_PORT`
- Replace `<ca>` with `ca ca.crt` and repeat for every cert or key
  - `ca` -> `ca.crt`
  - `cert` -> `cert.cer`
  - `cert key` -> `cert.key`
- Create all the secrets you need (also save certs as secrets)
- Required options
  - username
  - password

```yaml
name: Test VPN

on:
  workflow_dispatch:

env:
  VPN_DNS_SERVER: 192.168.1.1

jobs:
  test:
    runs-on: ubuntu-latest
    permissions:
      contents: read

    steps:
      - name: Checkout repository
        uses: actions/checkout@v3

      - name: Connect VPN
        uses: ./
        with:
          host: ${{ secrets.VPN_HOST }}
          port: ${{ secrets.VPN_PORT }} #optional
          username: ${{ secrets.VPN_USERNAME }}
          password: ${{ secrets.VPN_PASSWORD }}
          otp-hex: ${{ secrets.VPN_OTP }} #optional
          otp-timezone: 'Europe/Zurich' #optional
          dns-server: ${{ env.VPN_DNS_SERVER }} #optional
          ovpn-config: ${{ env.VPN_CONFIG}} #optional (default is .github/vpn/config.ovpn)
          ca: ${{ secrets.VPN_CA_CRT }} #optional
          cert: ${{ secrets.VPN_CERT_CRT }} #optional
          cert-key: ${{ secrets.VPN_CERT_KEY }} #optional
          test-ping-ip-host: ${{ env.VPN_DNS_SERVER }} #optional
          test-dns-host: google.ch #optional
          logs: true #optional

      - name: Test Ping
        run: ping ${{ env.VPN_DNS_SERVER }} -c5
        
      - name: Test DNS
        run: dig google.ch
```