Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EEEDC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jul 2022 01:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbiGLB4G (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jul 2022 21:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiGLB4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 21:56:03 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F543E747
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 18:56:02 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id g67-20020a636b46000000b0040e64eee874so2609116pgc.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 18:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=ma3DpxT2sSfQaG/pKE2g5PTIPwl/pfsjFTL3vS5murs=;
        b=On7miwrY6VdGIDqKE36X6x+jz52HllnRn9rQj6SX1n+WNkzzuKYy+qOs0H/U+LN6Fz
         +Zs/cafLSHaei+GfbZ8Cxxt9Iu68hUqmFsGMZIk+TEOjatOt2iOmNDEBlDsWchN+mbn+
         S5kV8k5sUjy3SBxEKDllQCtbRE8swmZYpe7gBTfad2INLdMoB9hPrV3dQT9pzC5qJZ87
         vULPBYLlxGdICqjza1frOOWt32cXu3QmtWUIPniBY8IS//KKATSq0yjA7S8g9v5A7bBA
         T+iL3NqK/Mz97oKibpuvmV5v9FUFywNMfyqknHl8+arL/RKjNhEV/0YyFXo0AbMjjjj8
         cO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=ma3DpxT2sSfQaG/pKE2g5PTIPwl/pfsjFTL3vS5murs=;
        b=qFOdkaNFA/yVfYsP3qpSBZNT32QXgX9rxWhu18n4nAOL2pwCH795FhJ3JLxqsyVJzB
         miWUpTqke4b3hqjE52H03TrOErGhbUAmZVVBdNMLsR+whzXCWfBCnaZsMNbV+dcYjvy3
         lY2i6706akf4/qKvmC7ha9D8Jc8Upm2GZYAIQLdJrhQzDnqmF275vrzutTUejQYl1fNt
         Uj6ZHE/f+/g2CRuHsEuOJWJ+NtEA/UyNvSwQ+3XlPmmFhwBi+BTk+3G9Ca6DyXZ6BdJr
         y918CPCYSYBX4U9sUPfJikQndnCPoP1mJ8Ht+YQifEV3lfxaeHlHqGQSaTcuFufbHAQ/
         jUlQ==
X-Gm-Message-State: AJIora+jda9EPTQADgCaUPeh6etmNj/hITQyfow/KtWj11DfFakUGfK9
        8zvxH7MKRKUD2VJS0qZPbyP3k+JWXsk=
X-Google-Smtp-Source: AGRyM1t3hIM3KmVgR6JcODO/Ssu/SbRljN0Di0K/aFUIbO9/qfzDoknyyJYz+NI02Spn+IZyaOmbZK4yKcU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:2654:b0:16c:5120:f379 with SMTP id
 je20-20020a170903265400b0016c5120f379mr4917394plb.3.1657590962127; Mon, 11
 Jul 2022 18:56:02 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 12 Jul 2022 01:55:53 +0000
Message-Id: <20220712015558.1247978-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.144.g8ac04bfd2-goog
Subject: [PATCH 0/5]  KVM: x86: Clean up rmap zap helpers
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up the rmap helpers (mostly renames) to yield a more coherent set of
APIs, and to purge the irritating and inconsistent "rmapp" (p is for pointer)
nomenclature.

Patch 1 is a tangentially related fix for a benign bug.

Sean Christopherson (5):
  KVM: x86/mmu: Return a u64 (the old SPTE) from
    mmu_spte_clear_track_bits()
  KVM: x86/mmu: Rename rmap zap helpers to better show relationships
  KVM: x86/mmu: Remove underscores from __pte_list_remove()
  KVM: x86/mmu: Use innermost rmap zap helper when recycling rmaps
  KVM: x86/mmu: Drop the "p is for pointer" from rmap helpers

 arch/x86/kvm/mmu/mmu.c | 73 +++++++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 37 deletions(-)


base-commit: b9b71f43683ae9d76b0989249607bbe8c9eb6c5c
-- 
2.37.0.144.g8ac04bfd2-goog

