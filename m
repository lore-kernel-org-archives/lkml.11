Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F9BC433EF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jun 2022 13:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbiFBNCI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jun 2022 09:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235120AbiFBNCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 09:02:05 -0400
Received: from outgoing-stata.csail.mit.edu (outgoing-stata.csail.mit.edu [128.30.2.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B14B9183
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 06:02:03 -0700 (PDT)
Received: from [77.23.249.31] (helo=srivatsab-a02.vmware.com)
        by outgoing-stata.csail.mit.edu with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.82)
        (envelope-from <srivatsa@csail.mit.edu>)
        id 1nwkSd-000aHy-Hc; Thu, 02 Jun 2022 09:01:59 -0400
Subject: Re: [PATCH v4] x86/vmware: use BIT() macro for shifting
To:     Shreenidhi Shedi <yesshedi@gmail.com>, amakhalov@vmware.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com
Cc:     pv-drivers@vmware.com, x86@kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Shreenidhi Shedi <sshedi@vmware.com>
References: <20220601101820.535031-1-sshedi@vmware.com>
From:   "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Message-ID: <f62fcdee-7d38-6bef-f60a-2b7ca3deba47@csail.mit.edu>
Date:   Thu, 2 Jun 2022 15:01:55 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20220601101820.535031-1-sshedi@vmware.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/22 3:18 AM, Shreenidhi Shedi wrote:
> From: Shreenidhi Shedi <sshedi@vmware.com>
> 
> Using BIT() macro improves readability & it uses unsigned long for
> shifting which is an added advantage.
> 
> Kernel builds with -fno-strict-overflow CFLAG hence shifting a signed
> integer by 31 bits is not an issue in this case.
> 
> Signed-off-by: Shreenidhi Shedi <sshedi@vmware.com>
> ---

Looks good to me.

Reviewed-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>

>  arch/x86/kernel/cpu/vmware.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
> index c04b933f4..02039ec35 100644
> --- a/arch/x86/kernel/cpu/vmware.c
> +++ b/arch/x86/kernel/cpu/vmware.c
> @@ -476,8 +476,8 @@ static bool __init vmware_legacy_x2apic_available(void)
>  {
>  	uint32_t eax, ebx, ecx, edx;
>  	VMWARE_CMD(GETVCPU_INFO, eax, ebx, ecx, edx);
> -	return (eax & (1 << VMWARE_CMD_VCPU_RESERVED)) == 0 &&
> -	       (eax & (1 << VMWARE_CMD_LEGACY_X2APIC)) != 0;
> +	return !(eax & BIT(VMWARE_CMD_VCPU_RESERVED)) &&
> +		(eax & BIT(VMWARE_CMD_LEGACY_X2APIC));
>  }
> 
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
> --
> 2.36.1
>  
Regards,
Srivatsa
VMware Photon OS
