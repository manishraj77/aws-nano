# TODO: Designate a cloud provider, region, and credentials
provider "aws" {
    access_key = "ASIAXRI6BIRLXZZNALNC"
    secret_key = "3nY7lD2QWeRRzzjdpLnkfQKjyCCULzicOtn65BRK"
    token = "FwoGZXIvYXdzEOr//////////wEaDHP/rzkW5YyqS3wqJiLVAbg/B7CAgKYziWqi+4nraCrTL+zvrIw8BRjmS17DsKtQhIBoSj8d08CvH9aD3uV7R4BF04iCMHIxmupdqIafILM+lxarOxPgAUD2wPc0uq+3xDsKYF8QCt9fCYW19LiGlDa439UAlI0fpqTeyH5nu5MygZtedbsmN0Bh9VoAJEJcd1s0xTeRaNdNr3SSqDabCvApUEIb3puHjgeL3057Em7SfBMxplUQIO/y1aYXlS0KmTfMsgGpsDksmYf2IgF9zeTZdhVjkG3VJsxTGnSnxpjjGXYhwiitsPKRBjItj5zQxY+WimgE/oco3NaQ7wrBS3e+qLkc9qW3pnA/IXf3Uxv+bMIBs7OyaFBw"
    region = "us-east-1"
}

# TODO: provision 4 AWS t2.micro EC2 instances named Udacity T2
resource "aws_instance" "Udacity_T2" {
    count = "4"
    ami = "ami-0323c3dd2da7fb37d"
    instance_type = "t2.micro" 
}

# TODO: provision 2 m4.large EC2 instances named Udacity M4
resource "aws_instance" "Udacity_M4" {
    count = "2"
    ami = "ami-0323c3dd2da7fb37d"
    instance_type = "m4.large"
}
