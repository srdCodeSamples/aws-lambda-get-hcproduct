
control 'aws_apigw_output' do

    # test a correct request for latest version
    describe http( attribute('download_url'),
        params: {product: 'terraform',
                os: 'linux',
                arch: 'amd64'}) do

        its('status') { should cmp 301 }
        its('body') { should match /.*redirected.*download/ }
        its('headers.Location') { should match /https:\/\/releases.hashicorp.com\// }
    end

    # test an incorrect request
    describe http( attribute('download_url'),
        params: {product: 'terraform',
                os: 'NONE',
                arch: 'amd64'}) do

        its('status') { should cmp 500 }
        its('body') { should match /No build found/ }
    end
  
end
  