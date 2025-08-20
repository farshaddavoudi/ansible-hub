# Manual Xray Service Debugging

## 1. Check if Xray binary exists
```bash
ls -la /usr/local/bin/xray
which xray
```

## 2. Check if service file was created
```bash
ls -la /etc/systemd/system/xray.service
cat /etc/systemd/system/xray.service
```

## 3. Check if config directory and file exist
```bash
ls -la /usr/local/etc/xray/
cat /usr/local/etc/xray/config.json
```

## 4. Reload systemd and check service status
```bash
sudo systemctl daemon-reload
sudo systemctl list-unit-files | grep xray
sudo systemctl status xray
```

## 5. Try to start the service manually
```bash
sudo systemctl start xray
sudo systemctl status xray
```

## 6. Check service logs if it fails
```bash
sudo journalctl -u xray -f
sudo journalctl -u xray --no-pager
```

## 7. Test Xray binary directly
```bash
sudo /usr/local/bin/xray version
sudo /usr/local/bin/xray run -config /usr/local/etc/xray/config.json -test
```

## 8. Check for permission issues
```bash
sudo chown nobody:nogroup /usr/local/etc/xray/config.json
sudo chmod 644 /usr/local/etc/xray/config.json
```

## 9. Alternative: Run Xray manually for testing
```bash
# Stop any running instance
sudo pkill xray

# Run manually in foreground
sudo -u nobody /usr/local/bin/xray run -config /usr/local/etc/xray/config.json
```

## 10. Check if port is available
```bash
sudo netstat -tlnp | grep 1080
sudo ss -tlnp | grep 1080
```
