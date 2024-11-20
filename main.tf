provider "kubernetes" {
  host                   = "https://34.46.208.116"
  cluster_ca_certificate = <<EOT
-----BEGIN CERTIFICATE-----
MIIELDCCApSgAwIBAgIQayYnkMIsydkRgLBftVGL3TANBgkqhkiG9w0BAQsFADAv
MS0wKwYDVQQDEyRhNTczZWFmNC1hYzY3LTQ0MWYtOTU5ZS1iZmRmZDc1OWI2NDQw
IBcNMjQxMTIwMDY0NzA2WhgPMjA1NDExMTMwNzQ3MDZaMC8xLTArBgNVBAMTJGE1
NzNlYWY0LWFjNjctNDQxZi05NTllLWJmZGZkNzU5YjY0NDCCAaIwDQYJKoZIhvcN
AQEBBQADggGPADCCAYoCggGBAM6Ew0nCmHi5P+h0/Tm5dcDXVBRrxkT9keOA6UnF
+3T3DXbZp1h8NSV5imijydMBwyUtsOUGEVp2Ll7VH4UdScUFyDrq4jyHiVk8ITXI
+L1nV4eM9kuyADVLQIEVvcC6fzoGf3Rvh4B428efPYn58At02CowDaI126eTHdFM
MT8/ecrjXkYA9pc5Cemq13uq0VLW/dgpLr8HLXbSxDl4stD8dmZ7+5awwG/A5WO8
12gicb5rErLQAkX1DxVvs8xEaiGehdrkAG1U48+o+Eyedmxfm+3/chRCeRMvOP8k
2/D6ks8A6wawi7G1qzhMFbMa4f8BNpTtETxqFRhIxHBu2FpcN9zvqJfEo4H70kTW
ggvp8/mwJM+4jUXdj05syWzWShvaJIeI/06t4nkHK7wKZ71p55x7ZkxuD0fMixLF
NbWeg2PorwF9wrxOVsFK31wNUr7Pmmz5rgtmY/3scG26kS6V3VCdHBJOea2JrI0z
LDeDlA5e9SVsNLR3lRJymKewjwIDAQABo0IwQDAOBgNVHQ8BAf8EBAMCAgQwDwYD
VR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQULX5pJgpIzGuF1H6ATc8m8lWpA9kwDQYJ
KoZIhvcNAQELBQADggGBAIm15xnr7Oltlo0nJIti9s0mfQAtmeUdicp000tM2Ema
dH/9cJcmXIda1b4bamOagfRdIF59sfuGr17w1cRxJfwiXPUskQmyMopYkTNBw0Fy
txpGt9tdw0vWWqfoA3OJ646tvFw+bAOs3Y7DNEAhhbegdzeUtrgJS+jzgHgTf2dz
+Wzgf3wTLjUuC7fn86e5HEKPbr3rGCniqOfSdw5JIhjkCJH9+mqIzeTI90aSqV59
VcLbHIIbA3wNFg+69Z9en04XMKTinzIVOO4iR8Y4TVntn6M0gnVJogxLqoiBWzWl
78dIoHZhYYXMlu0ssyuqpHBDTdt+oA1I26T1W+rZ7RjMUXsEqsdhMEYhUY6rwrf6
harooHQatOswjP9ADGsQQ/G2zsKz1i4naGb64g5pmcaFo+sFbbifsFNj17njnmIW
5lZXsYUSUHMf3imrdeiCwMWa2tDiVWtOBiUCAil6jqhsFKBoc9VsMLYyob8NhFlj
DM1jOP/UrgmSs8JkK+0eIQ==
-----END CERTIFICATE-----
EOT
  token = "ya29.a0AeDClZAu2rFy6PsYDa4JRgANAmNsLkTUEpknxjH6-Gt0tjGmbUVajQ5hHgr2YT0-j94L6zUlqwED3wXxcaSpAw5MdXMzcTY1Ro_SEC_yUzwU-jw-hIZHm_GxURws7hnsSzJxAKC5UB1F-XlhnGwdy72BazqzdeuNV4cEwKeKSZ4MnuQaCgYKAVgSARMSFQHGX2Mii8t2l3ZPeZafsthbMNNX7g0182" # Use token obtained via gcloud auth print-access-token
}


resource "kubernetes_deployment" "blue" {
  metadata {
    name = "blue-app"
  }
  spec {
    replicas = 3
    selector {
      match_labels = {
        app = "blue"
      }
    }
    template {
      metadata {
        labels = {
          app = "blue"
        }
      }
      spec {
        container {
          name  = "blue-app-container"
          image = "my-app:blue-version"
          ports {
            container_port = 8080
          }
        }
      }
    }
  }
}

resource "kubernetes_deployment" "green" {
  metadata {
    name = "green-app"
  }
  spec {
    replicas = 3
    selector {
      match_labels = {
        app = "green"
      }
    }
    template {
      metadata {
        labels = {
          app = "green"
        }
      }
      spec {
        container {
          name  = "green-app-container"
          image = "my-app:green-version"
          ports {
            container_port = 8080
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "loadbalancer" {
  metadata {
    name = "my-app-lb"
  }
  spec {
    selector = {
      app = "blue"
    }
    port {
      port        = 80
      target_port = 8080
    }
    type = "LoadBalancer"
  }
}
