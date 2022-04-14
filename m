Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD12C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 14:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345579AbiDNOKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 10:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343668AbiDNN3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:29:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030B29F6EA;
        Thu, 14 Apr 2022 06:25:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0D2BB82984;
        Thu, 14 Apr 2022 13:25:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B903C385A9;
        Thu, 14 Apr 2022 13:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649942710;
        bh=GnHbWgyEcZfkJ6Nh4RSoHGyW7aWmdAfaQ/vyEPNkw2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pdQ1x0aqtiQbsic1o7L1xTj6i+0e+1abdwdbEazUxoTSu+kXJBv/2tHK70D/HXYrs
         S2weyjyOgc0zPVOzVJcKah1nT2UcltT0cm5JMajpEA1XLEeCMtLXOP/R+7ZWTZBc++
         7FusqNOqq7iYUgvH8sDDnTzYi/wREJMvFkryB6qI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Li RongQing <lirongqing@baidu.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.19 232/338] KVM: x86: fix sending PV IPI
Date:   Thu, 14 Apr 2022 15:12:15 +0200
Message-Id: <20220414110845.493063922@linuxfoundation.org>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220414110838.883074566@linuxfoundation.org>
References: <20220414110838.883074566@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li RongQing <lirongqing@baidu.com>

commit c15e0ae42c8e5a61e9aca8aac920517cf7b3e94e upstream.

If apic_id is less than min, and (max - apic_id) is greater than
KVM_IPI_CLUSTER_SIZE, then the third check condition is satisfied but
the new apic_id does not fit the bitmask.  In this case __send_ipi_mask
should send the IPI.

This is mostly theoretical, but it can happen if the apic_ids on three
iterations of the loop are for example 1, KVM_IPI_CLUSTER_SIZE, 0.

Fixes: aaffcfd1e82 ("KVM: X86: Implement PV IPIs in linux guest")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
Message-Id: <1646814944-51801-1-git-send-email-lirongqing@baidu.com>
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/kvm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -480,7 +480,7 @@ static void __send_ipi_mask(const struct
 		} else if (apic_id < min && max - apic_id < KVM_IPI_CLUSTER_SIZE) {
 			ipi_bitmap <<= min - apic_id;
 			min = apic_id;
-		} else if (apic_id < min + KVM_IPI_CLUSTER_SIZE) {
+		} else if (apic_id > min && apic_id < min + KVM_IPI_CLUSTER_SIZE) {
 			max = apic_id < max ? max : apic_id;
 		} else {
 			ret = kvm_hypercall4(KVM_HC_SEND_IPI, (unsigned long)ipi_bitmap,


