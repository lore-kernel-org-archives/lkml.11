Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0534C43334
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jun 2022 18:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237147AbiFWSWA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jun 2022 14:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236897AbiFWSQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 14:16:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FFB62C29;
        Thu, 23 Jun 2022 10:23:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D2C761DC6;
        Thu, 23 Jun 2022 17:23:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 351F6C3411B;
        Thu, 23 Jun 2022 17:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656005016;
        bh=GJjPzaE1Xp4leBAxjdOS0+AqdSMbVLMu+pd/8Sgp3ck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TwcNGpidp4w4VcROdnABMofXAr7rtFBMWYXBJUBBdAykYwgTnw7maWjkEAA6jqWln
         +YdonRTDnx89UVct0AvEdqjXIaaoIwlzZZoZDpZpSWuhZvZMQvtbPMOxCTdZJtLV1S
         V9dhGnGrBwdUZodp0ztsnQsN3j0Ih2oQwIWTi35M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH 4.19 225/234] s390/mm: use non-quiescing sske for KVM switch to keyed guest
Date:   Thu, 23 Jun 2022 18:44:52 +0200
Message-Id: <20220623164349.416773391@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220623164343.042598055@linuxfoundation.org>
References: <20220623164343.042598055@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Borntraeger <borntraeger@linux.ibm.com>

commit 3ae11dbcfac906a8c3a480e98660a823130dc16a upstream.

The switch to a keyed guest does not require a classic sske as the other
guest CPUs are not accessing the key before the switch is complete.
By using the NQ SSKE things are faster especially with multiple guests.

Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Suggested-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Link: https://lore.kernel.org/r/20220530092706.11637-3-borntraeger@linux.ibm.com
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/mm/pgtable.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -716,7 +716,7 @@ void ptep_zap_key(struct mm_struct *mm,
 	pgste_val(pgste) |= PGSTE_GR_BIT | PGSTE_GC_BIT;
 	ptev = pte_val(*ptep);
 	if (!(ptev & _PAGE_INVALID) && (ptev & _PAGE_WRITE))
-		page_set_storage_key(ptev & PAGE_MASK, PAGE_DEFAULT_KEY, 1);
+		page_set_storage_key(ptev & PAGE_MASK, PAGE_DEFAULT_KEY, 0);
 	pgste_set_unlock(ptep, pgste);
 	preempt_enable();
 }


