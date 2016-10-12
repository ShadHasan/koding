// This file is auto-generated. DO NOT EDIT!

package config

import (
	"text/template"

	"github.com/koding/logging"
)

var DefaultConfig = &Config{
	Environment: defaultAliases.Get("default", "development"),
	Log:         logging.NewLogger("config"),
	Host2ip: map[string]string{
		"dev.koding.com": "127.0.0.1",
	},

	tmpls: map[string]*template.Template{
		`buckets.publicLogs`:     template.Must(template.New(`buckets.publicLogs`).Parse(`{"name":"kodingdev-publiclogs","region":"us-east-1"}`)),
		`endpoints.ip`:           template.Must(template.New(`endpoints.ip`).Parse(`"https://dev-p2.koding.com/-/ip"`)),
		`endpoints.ipCheck`:      template.Must(template.New(`endpoints.ipCheck`).Parse(`"https://dev-p2.koding.com/-/ipcheck"`)),
		`endpoints.kdLatest`:     template.Must(template.New(`endpoints.kdLatest`).Parse(`"https://koding-kd.s3.amazonaws.com/development/latest-version.txt"`)),
		`endpoints.klientLatest`: template.Must(template.New(`endpoints.klientLatest`).Parse(`"https://koding-klient.s3.amazonaws.com/{{.Environment}}/latest-version.txt"`)),
		`endpoints.kloud`:        template.Must(template.New(`endpoints.kloud`).Parse(`"https://sandbox.koding.com/kloud/kite"`)),
		`endpoints.kontrol`:      template.Must(template.New(`endpoints.kontrol`).Parse(`"https://sandbox.koding.com/kontrol/kite"`)),
		`endpoints.tunnelServer`: template.Must(template.New(`endpoints.tunnelServer`).Parse(`"http://dev-t.koding.com/kite"`)),
	},
}

// PublicLogsBucket returns bucket stored in publicLogs variable.
func (c *Config) PublicLogsBucket(env string) (*Bucket, error) {
	return DefaultConfig.GetBucket("buckets.publicLogs", c.GetEnvironment(env))
}

// MustPublicLogsBucket returns bucket stored in publicLogs variable. It panics in case of error.
func (c *Config) MustPublicLogsBucket(environment string) *Bucket {
	val, err := c.PublicLogsBucket(environment)
	if err != nil {
		panic(err)
	}

	return val
}

// IpURL returns endpoint stored in ip variable.
func (c *Config) IpURL(env string) (string, error) {
	return DefaultConfig.GetEndpoint("endpoints.ip", c.GetEnvironment(env))
}

// MustIpURL returns endpoint stored in ip variable. It panics in case of error.
func (c *Config) MustIpURL(environment string) string {
	val, err := c.IpURL(environment)
	if err != nil {
		panic(err)
	}

	return val
}

// IpCheckURL returns endpoint stored in ipCheck variable.
func (c *Config) IpCheckURL(env string) (string, error) {
	return DefaultConfig.GetEndpoint("endpoints.ipCheck", c.GetEnvironment(env))
}

// MustIpCheckURL returns endpoint stored in ipCheck variable. It panics in case of error.
func (c *Config) MustIpCheckURL(environment string) string {
	val, err := c.IpCheckURL(environment)
	if err != nil {
		panic(err)
	}

	return val
}

// KdLatestURL returns endpoint stored in kdLatest variable.
func (c *Config) KdLatestURL(env string) (string, error) {
	return DefaultConfig.GetEndpoint("endpoints.kdLatest", c.GetEnvironment(env))
}

// MustKdLatestURL returns endpoint stored in kdLatest variable. It panics in case of error.
func (c *Config) MustKdLatestURL(environment string) string {
	val, err := c.KdLatestURL(environment)
	if err != nil {
		panic(err)
	}

	return val
}

// KlientLatestURL returns endpoint stored in klientLatest variable.
func (c *Config) KlientLatestURL(env string) (string, error) {
	return DefaultConfig.GetEndpoint("endpoints.klientLatest", c.GetEnvironment(env))
}

// MustKlientLatestURL returns endpoint stored in klientLatest variable. It panics in case of error.
func (c *Config) MustKlientLatestURL(environment string) string {
	val, err := c.KlientLatestURL(environment)
	if err != nil {
		panic(err)
	}

	return val
}

// KloudURL returns endpoint stored in kloud variable.
func (c *Config) KloudURL(env string) (string, error) {
	return DefaultConfig.GetEndpoint("endpoints.kloud", c.GetEnvironment(env))
}

// MustKloudURL returns endpoint stored in kloud variable. It panics in case of error.
func (c *Config) MustKloudURL(environment string) string {
	val, err := c.KloudURL(environment)
	if err != nil {
		panic(err)
	}

	return val
}

// KontrolURL returns endpoint stored in kontrol variable.
func (c *Config) KontrolURL(env string) (string, error) {
	return DefaultConfig.GetEndpoint("endpoints.kontrol", c.GetEnvironment(env))
}

// MustKontrolURL returns endpoint stored in kontrol variable. It panics in case of error.
func (c *Config) MustKontrolURL(environment string) string {
	val, err := c.KontrolURL(environment)
	if err != nil {
		panic(err)
	}

	return val
}

// TunnelServerURL returns endpoint stored in tunnelServer variable.
func (c *Config) TunnelServerURL(env string) (string, error) {
	return DefaultConfig.GetEndpoint("endpoints.tunnelServer", c.GetEnvironment(env))
}

// MustTunnelServerURL returns endpoint stored in tunnelServer variable. It panics in case of error.
func (c *Config) MustTunnelServerURL(environment string) string {
	val, err := c.TunnelServerURL(environment)
	if err != nil {
		panic(err)
	}

	return val
}
