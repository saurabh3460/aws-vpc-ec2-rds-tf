aws ec2 describe-key-pairs --key-names final_assg_key --query 'KeyPairs[*].PublicKeyMaterial' --output text


aws ec2 describe-key-pairs --key-names final_assg_key --query 'KeyPairs[*].PublicKey' --output text