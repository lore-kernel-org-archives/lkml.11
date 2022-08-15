Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4A1C00140
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Aug 2022 21:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350281AbiHOVwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Aug 2022 17:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350288AbiHOVrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 17:47:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5262B634;
        Mon, 15 Aug 2022 12:31:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B3A660EF0;
        Mon, 15 Aug 2022 19:31:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14821C433D6;
        Mon, 15 Aug 2022 19:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660591901;
        bh=hVge2b40hrymoACoRoPHQOleTSb2rRVyOkW4WS8IgBU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=flowuNYV4yBgInJ337f2gvVlvXmifOFo25pJCEgtTdcDjPynuoJxGV8Sdgp5MXEr+
         pioZFHeCVmIhBdVp9zkjaSWeGXT/awRh1KaNZMK0uBM7ArOEI4mwbtjHzgwYBGY+JI
         4AeTbtYLJSsr2X4Gw8fnAofHBmhtQGTbrZLTQ134=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.19 0028/1157] KVM: Put the extra pfn reference when reusing a pfn in the gpc cache
Date:   Mon, 15 Aug 2022 19:49:44 +0200
Message-Id: <20220815180440.551008180@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220815180439.416659447@linuxfoundation.org>
References: <20220815180439.416659447@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <seanjc@google.com>

commit 3dddf65b4f4c451c345d34ae85bdf1791a746e49 upstream.

Put the struct page reference to pfn acquired by hva_to_pfn() when the
old and new pfns for a gfn=>pfn cache match.  The cache already has a
reference via the old/current pfn, and will only put one reference when
the cache is done with the pfn.

Fixes: 982ed0de4753 ("KVM: Reinstate gfn_to_pfn_cache with invalidation support")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-Id: <20220429210025.3293691-5-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 virt/kvm/pfncache.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/virt/kvm/pfncache.c
+++ b/virt/kvm/pfncache.c
@@ -206,6 +206,14 @@ int kvm_gfn_to_pfn_cache_refresh(struct
 
 		if (gpc->usage & KVM_HOST_USES_PFN) {
 			if (new_pfn == old_pfn) {
+				/*
+				 * Reuse the existing pfn and khva, but put the
+				 * reference acquired hva_to_pfn_retry(); the
+				 * cache still holds a reference to the pfn
+				 * from the previous refresh.
+				 */
+				gpc_release_pfn_and_khva(kvm, new_pfn, NULL);
+
 				new_khva = old_khva;
 				old_pfn = KVM_PFN_ERR_FAULT;
 				old_khva = NULL;


