Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418D6C433FE
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Mar 2022 10:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241835AbiCGKVU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Mar 2022 05:21:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240470AbiCGKBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 05:01:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B2D7663;
        Mon,  7 Mar 2022 01:48:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E5FF60010;
        Mon,  7 Mar 2022 09:48:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91CF7C340F5;
        Mon,  7 Mar 2022 09:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646646518;
        bh=iFwxgd4D3nV04ruy4pLo/XsfpWUFmnSQgq18Byp2Xp4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VBmHT9+2gm0rA4MZWjlLXzjsGtCA6dwVrKO+1RtQdfaX/LnkanaCaYYlV805NKym8
         YjF1wwVXZ9PpqrBbPOKh/naHLNYZSnpG0D6NtrXaFoQV+ZoNlk8aNB5lr5/4bczOPr
         aA5gP1Co7ClKIDI4pYsomB02MjWZOoATodZ0kkUw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Like Xu <likexu@tencent.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.15 262/262] KVM: x86/mmu: Passing up the error state of mmu_alloc_shadow_roots()
Date:   Mon,  7 Mar 2022 10:20:06 +0100
Message-Id: <20220307091711.225991898@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220307091702.378509770@linuxfoundation.org>
References: <20220307091702.378509770@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Like Xu <likexu@tencent.com>

commit c6c937d673aaa1d603f62f134e1ca9c173eeeed3 upstream.

Just like on the optional mmu_alloc_direct_roots() path, once shadow
path reaches "r = -EIO" somewhere, the caller needs to know the actual
state in order to enter error handling and avoid something worse.

Fixes: 4a38162ee9f1 ("KVM: MMU: load PDPTRs outside mmu_lock")
Signed-off-by: Like Xu <likexu@tencent.com>
Reviewed-by: Sean Christopherson <seanjc@google.com>
Message-Id: <20220301124941.48412-1-likexu@tencent.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/mmu/mmu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3579,7 +3579,7 @@ set_root_pgd:
 out_unlock:
 	write_unlock(&vcpu->kvm->mmu_lock);
 
-	return 0;
+	return r;
 }
 
 static int mmu_alloc_special_roots(struct kvm_vcpu *vcpu)


