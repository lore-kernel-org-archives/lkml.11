Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBA2C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Apr 2022 09:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234386AbiDMJZT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Apr 2022 05:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234406AbiDMJZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:25:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F4D653705
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649841762;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=etNogBidbFvzG587dPz0EWEzFmzslPPD/UlHCJ6dM0k=;
        b=a8XGpArFIvGZdlSSBflpENbY0bAZwGwGOyJOfIbg10GFOZ64X/uaSjhfgF8W6cwei4I3zv
        7KN0kshMc9j7Bg5g5q64yztrbE85S05I2Y5Dja+5w5NDWhXbYzLr6pNsC/zlyuN3DIBxQB
        d148c1PJ//ZRbgSSGbFWgi7s6SNGeV8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-EfPFCYQhPdGHFp6PNVnNaQ-1; Wed, 13 Apr 2022 05:22:40 -0400
X-MC-Unique: EfPFCYQhPdGHFp6PNVnNaQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 298FD296A60B;
        Wed, 13 Apr 2022 09:22:40 +0000 (UTC)
Received: from [10.72.13.171] (ovpn-13-171.pek2.redhat.com [10.72.13.171])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A55CAC15E73;
        Wed, 13 Apr 2022 09:22:33 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v5 10/10] selftests: KVM: aarch64: Add
 KVM_REG_ARM_FW_REG(3) to get-reg-list
To:     Raghavendra Rao Ananta <rananta@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Peter Shier <pshier@google.com>, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org
References: <20220407011605.1966778-1-rananta@google.com>
 <20220407011605.1966778-11-rananta@google.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <b3cfe975-de18-ea21-f174-1124803f314d@redhat.com>
Date:   Wed, 13 Apr 2022 17:22:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20220407011605.1966778-11-rananta@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Raghavendra,

On 4/7/22 9:16 AM, Raghavendra Rao Ananta wrote:
> Add the register KVM_REG_ARM_FW_REG(3)
> (KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_3) to the base_regs[] of
> get-reg-list.
> 
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> ---
>   tools/testing/selftests/kvm/aarch64/get-reg-list.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/kvm/aarch64/get-reg-list.c b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
> index 281c08b3fdd2..7049c31aa443 100644
> --- a/tools/testing/selftests/kvm/aarch64/get-reg-list.c
> +++ b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
> @@ -691,6 +691,7 @@ static __u64 base_regs[] = {
>   	KVM_REG_ARM_FW_REG(0),
>   	KVM_REG_ARM_FW_REG(1),
>   	KVM_REG_ARM_FW_REG(2),
> +	KVM_REG_ARM_FW_REG(3),
>   	KVM_REG_ARM_FW_FEAT_BMAP_REG(0),	/* KVM_REG_ARM_STD_BMAP */
>   	KVM_REG_ARM_FW_FEAT_BMAP_REG(1),	/* KVM_REG_ARM_STD_HYP_BMAP */
>   	KVM_REG_ARM_FW_FEAT_BMAP_REG(2),	/* KVM_REG_ARM_VENDOR_HYP_BMAP */
> 

It seems the same fixup has been done in another patch.

https://www.mail-archive.com/kvmarm@lists.cs.columbia.edu/msg38027.html

Thanks,
Gavin

