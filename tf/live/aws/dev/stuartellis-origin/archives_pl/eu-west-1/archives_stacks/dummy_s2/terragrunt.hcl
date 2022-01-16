include {
  path = find_in_parent_folders("root.hcl")
}

dependency "dummy_s1" {
  config_path = "../dummy_s1"

  mock_outputs = {
    kms_key_arn = "arn:aws:kms:us-east-1:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab"
  }

}

terraform {
  source = "../../../../../../../../../../stuartellis-org-tf-modules//aws/s3_archive_bucket"
}

inputs = {
  kms_key_arn = dependency.dummy_s1.outputs.kms_key_arn
}
