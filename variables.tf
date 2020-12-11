# required for AWS
variable "region" {
    default = "eu-central-1"
}

# specific to our site
variable "root_domain" {
    default = "maksimulkin"
}

variable "website_bucket_subdomain" {
    default = "www"
}
