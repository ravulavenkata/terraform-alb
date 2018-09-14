/*

variable "ENV" {}
variable "AWS_REGION" {}

variable "AWS_BACKUP_REGION" {}

provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "destination" {
  bucket   = "gaia-em-backup-${var.ENV}"
  region   = "${var.AWS_BACKUP_REGION}"

  versioning {
    enabled = true
  }
}

resource "aws_iam_role" "replication" {
  name = "tf-iam-role-replication-12345"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "s3.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

resource "aws_s3_bucket" "bucket" {
  bucket   = "gaia-em-${var.ENV}"
  acl      = "private"
  region   = "${var.AWS_REGION}"

  versioning {
    enabled = true
  }

  replication_configuration {
    
    role = "${aws_iam_role.replication.arn}"
    rules {
      id     = "foobar"
      prefix = "foo"
      status = "Enabled"

      destination {
        bucket        = "${aws_s3_bucket.destination.arn}"
        storage_class = "STANDARD"
      }
    }
  }
}


*/