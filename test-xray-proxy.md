# Testing Xray Proxy Success (Iran)

## 1. Basic Service Status Check
```bash
# Check if Xray service is running
sudo systemctl status xray
sudo systemctl is-active xray

# Check if proxy port is listening
sudo netstat -tlnp | grep 1080
sudo ss -tlnp | grep 1080

# Check Xray logs
sudo journalctl -u xray -f --no-pager
```

## 2. Test SOCKS5 Proxy Locally
```bash
# Test with curl using SOCKS5 proxy
curl --socks5 127.0.0.1:1080 https://www.google.com -I
curl --socks5 127.0.0.1:1080 https://httpbin.org/ip

# Debug steps if proxy fails:
# 1. Check current config
cat /usr/local/etc/xray/config.json

# 2. Test config syntax
sudo /usr/local/bin/xray run -config /usr/local/etc/xray/config.json -test

# 3. Restart service
sudo systemctl restart xray
sudo systemctl status xray

# 4. Check real-time logs
sudo journalctl -u xray -f

# 5. Test connectivity to your VLESS server
nc -zv www.esfahanrestaurant.ir 443

# 6. Test with verbose curl to see exact error
curl -v --socks5 127.0.0.1:1080 https://httpbin.org/ip

# Test with specific timeout
curl --socks5 127.0.0.1:1080 --connect-timeout 10 https://www.google.com

# Test accessing blocked sites (replace with actual blocked sites)
curl --socks5 127.0.0.1:1080 https://twitter.com -I
curl --socks5 127.0.0.1:1080 https://facebook.com -I
```

## 3. Test HTTP Proxy (if configured)
```bash
# Test HTTP proxy
curl --proxy http://127.0.0.1:1080 https://www.google.com -I
curl --proxy http://127.0.0.1:1080 https://httpbin.org/ip
```

## 4. Check Your External IP
```bash
# Without proxy (your Iran IP)
curl https://ipinfo.io/ip
curl https://httpbin.org/ip

# With proxy (should show VPN server IP)
curl --socks5 127.0.0.1:1080 https://ipinfo.io/ip
curl --socks5 127.0.0.1:1080 https://httpbin.org/ip

# Compare the IPs - they should be different
```

## 5. Test Environment Variables
```bash
# Check if proxy environment variables are set
echo $http_proxy
echo $https_proxy
echo $all_proxy
echo $no_proxy

# Source the profile and check again
source /etc/profile.d/proxy.sh
echo $http_proxy
```

## 6. Test Docker with Proxy (if Docker is installed)
```bash
# Check Docker daemon proxy settings
sudo systemctl show docker --property Environment

# Test Docker pull through proxy
sudo docker pull hello-world
```

## 7. Test SSH Tunnel (Advanced)
```bash
# Create SSH tunnel using the proxy
ssh -o ProxyCommand='nc -X 5 -x 127.0.0.1:1080 %h %p' user@external-server
```

## 8. Performance and Speed Test
```bash
# Test download speed through proxy
time curl --socks5 127.0.0.1:1080 -o /dev/null https://speed.hetzner.de/100MB.bin

# Test without proxy for comparison
time curl -o /dev/null https://speed.hetzner.de/1MB.bin
```

## 9. Browser Testing (if GUI available)
```bash
# Set browser to use SOCKS5 proxy: 127.0.0.1:1080
# Then visit:
# - https://whatismyipaddress.com
# - https://www.google.com
# - Any previously blocked sites
```

## 10. Debugging Connection Issues
```bash
# Test if Xray config is valid
sudo /usr/local/bin/xray run -config /usr/local/etc/xray/config.json -test

# Check if VMess server is reachable
nc -zv YOUR_SERVER_IP 443

# Test with verbose curl
curl -v --socks5 127.0.0.1:1080 https://www.google.com

# Check proxy chain
curl --socks5 127.0.0.1:1080 https://httpbin.org/headers
```

## 11. Expected Results for Success:

### ✅ **Successful Proxy Indicators:**
- Service status shows "active (running)"
- Port 1080 is listening
- External IP is different when using proxy
- Can access previously blocked websites
- No connection errors in logs

### ❌ **Common Failure Signs:**
- Service fails to start
- Connection timeout errors
- Same IP with and without proxy
- Cannot access any external sites through proxy

## 12. Troubleshooting Common Issues:

### If proxy doesn't work:
```bash
# Check VMess configuration
cat /usr/local/etc/xray/config.json

# Verify server details in config:
# - Correct server address
# - Valid UUID
# - Correct port (443)

# Test different protocols if available
curl --socks5 127.0.0.1:1080 --socks5-hostname 127.0.0.1:1080 https://www.google.com
```

### If environment variables don't work:
```bash
# Manually export for testing
export http_proxy="http://127.0.0.1:1080"
export https_proxy="http://127.0.0.1:1080"
export all_proxy="socks5://127.0.0.1:1080"

# Test
curl https://www.google.com -I
```

## 13. Security Test
```bash
# Check for DNS leaks
curl --socks5 127.0.0.1:1080 https://dnsleaktest.com

# Verify no direct connections
sudo netstat -an | grep :443 | grep -v 127.0.0.1
```

Run these tests in order, and you'll know exactly if your Xray proxy is working correctly!
