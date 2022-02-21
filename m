Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1188C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 09:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351116AbiBUJuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 04:50:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351367AbiBUJpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 04:45:24 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204763F33A;
        Mon, 21 Feb 2022 01:18:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8282FCE0EA6;
        Mon, 21 Feb 2022 09:18:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75275C340E9;
        Mon, 21 Feb 2022 09:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645435100;
        bh=6wwCy+7tkebM8/7dK4CKcqnK1CtFIcuPJOwlQ8zq+bc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=imOh8pCzKkoYebuXY8VIT6Mr3iykDaNxnsmlheR5K9GyjayNzAew0pToHEBBJD+WM
         EAOMjLdr1kxcpvWcXNFvkqfdxfu3XYBHfRDE9T81m3q/i8hYaFNfv4d2GHIvLx4Fjd
         /zYZuTMuuLhCdmiL9+mc02HZZSnFXAA774ZkrE3Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.16 012/227] Revert "svm: Add warning message for AVIC IPI invalid target"
Date:   Mon, 21 Feb 2022 09:47:11 +0100
Message-Id: <20220221084935.246938526@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221084934.836145070@linuxfoundation.org>
References: <20220221084934.836145070@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <seanjc@google.com>

commit dd4589eee99db8f61f7b8f7df1531cad3f74a64d upstream.

Remove a WARN on an "AVIC IPI invalid target" exit, the WARN is trivial
to trigger from guest as it will fail on any destination APIC ID that
doesn't exist from the guest's perspective.

Don't bother recording anything in the kernel log, the common tracepoint
for kvm_avic_incomplete_ipi() is sufficient for debugging.

This reverts commit 37ef0c4414c9743ba7f1af4392f0a27a99649f2a.

Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-Id: <20220204214205.3306634-2-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/svm/avic.c |    2 --
 1 file changed, 2 deletions(-)

--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -342,8 +342,6 @@ int avic_incomplete_ipi_interception(str
 		avic_kick_target_vcpus(vcpu->kvm, apic, icrl, icrh);
 		break;
 	case AVIC_IPI_FAILURE_INVALID_TARGET:
-		WARN_ONCE(1, "Invalid IPI target: index=%u, vcpu=%d, icr=%#0x:%#0x\n",
-			  index, vcpu->vcpu_id, icrh, icrl);
 		break;
 	case AVIC_IPI_FAILURE_INVALID_BACKING_PAGE:
 		WARN_ONCE(1, "Invalid backing page\n");


