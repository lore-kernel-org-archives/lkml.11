Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5639C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Mar 2022 23:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbiCUXvV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Mar 2022 19:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233615AbiCUXvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 19:51:01 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6091E7462
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 16:49:08 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2e5a3c1384cso132314827b3.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 16:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eaMpQz/2+gIGl1l/NaHHR9r8rELtroyMHUNp7EK/mzA=;
        b=jZYdyGLDT1rPNya0zYp8WpaU+7kOP6KdfhIGOZTmttYfnyNJYfBrtepboIJ5odwfrw
         /bkRPaq97VIIspJKNuKc7luPOnIcS0tV9iwcn9xP1ETSpPvv1m3pKyhPJPll3UysqUZy
         13apm+c73YOVfmTCZGSkEnIID2JwLpUe3SNPXBTgn+pyLgl9Eo2v4InmS4VI0x5zWsyz
         S3RmYfjfHpSWZpKQQtm8v9rjfGPox7DtcBK0lvgS2QxrP4hQ19bE/ihH53tNnTy6dhFG
         jTn/LVRXjSC6RS81tHBse92oanoDwaJuqzH9s5V5nDtWXJvcN6RYPR99KNH4ekdPT98G
         JDJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eaMpQz/2+gIGl1l/NaHHR9r8rELtroyMHUNp7EK/mzA=;
        b=52jIHvMlgYwKQL9KqIJaSABvAhiNx0jchFjcOALYLEd5geLa0+BgGGhpPIDjYd51ML
         JwnkovNjHN0mr0BMTBlsaL8ReW1p5sK8Kb6kk3uT9fb+NxKKzP4JOV/4nFpv2LJMfsN5
         r7golrC1M7sN5ogZaQnsqcYN/XNEFzAbOdJSbSD4XZFlkaxiafHbKafqgApIugDPxkhZ
         1Q03cDw2uLFCH/xR/bydz7Ec3QkzhSYnyMLq/p/umq4LftmqycynL9n1zuQsD4kLEBnR
         Z213w57dTeXqadSFtrZzJvZZFvA45geWgQb8fHQjSTLpdmAMfwfeY0elZCFm8pBnaxXp
         Pydg==
X-Gm-Message-State: AOAM532OUJiTox+Nop0jMOxL+Ersraym6XMwy7ohe31sL8eDOYvcVGk3
        ePT1vW0kDhBsqPQWytmx7zvcXNCKek/JosyDS710XsKSRSHZgd6gmJN9Ald/yeGrWpL0s5Bm2Jj
        sCLymyk9/Cwd2R2y1tp434pbrYspTLVetsNoGx3VRjx77OVRF/+iRslP6d/SOBgAEGpX+BVoP
X-Google-Smtp-Source: ABdhPJwxJQuW8sN2Dk7+xF8QgGAHRKBKpRfkRsxXusPwZUYwUcL/DREHHbw6Wl/K/RBIHiR210AiJjavemar
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:b76a:f152:cb5e:5cd2])
 (user=bgardon job=sendgmr) by 2002:a05:690c:11b:b0:2e6:529:d6b2 with SMTP id
 bd27-20020a05690c011b00b002e60529d6b2mr12866359ywb.345.1647906543992; Mon, 21
 Mar 2022 16:49:03 -0700 (PDT)
Date:   Mon, 21 Mar 2022 16:48:38 -0700
In-Reply-To: <20220321234844.1543161-1-bgardon@google.com>
Message-Id: <20220321234844.1543161-6-bgardon@google.com>
Mime-Version: 1.0
References: <20220321234844.1543161-1-bgardon@google.com>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [PATCH v2 05/11] KVM: selftests: Improve error message in vm_phy_pages_alloc
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        David Matlack <dmatlack@google.com>,
        Jim Mattson <jmattson@google.com>,
        David Dunn <daviddunn@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Junaid Shahid <junaids@google.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make an error message in vm_phy_pages_alloc more specific, and log the
number of pages requested in the allocation.

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 09742a787546..9d72d1bb34fa 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -2408,9 +2408,10 @@ vm_paddr_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
 	} while (pg && pg != base + num);
 
 	if (pg == 0) {
-		fprintf(stderr, "No guest physical page available, "
+		fprintf(stderr,
+			"Unable to find %ld contiguous guest physical pages. "
 			"paddr_min: 0x%lx page_size: 0x%x memslot: %u\n",
-			paddr_min, vm->page_size, memslot);
+			num, paddr_min, vm->page_size, memslot);
 		fputs("---- vm dump ----\n", stderr);
 		vm_dump(stderr, vm, 2);
 		abort();
-- 
2.35.1.894.gb6a874cedc-goog

