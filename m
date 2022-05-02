Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF2BC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  2 May 2022 22:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387816AbiEBWKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 May 2022 18:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387811AbiEBWIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 18:08:31 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FDEDEED
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 15:03:55 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2f8d487f575so73910057b3.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 15:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=2gUboy0WpFlCg1gFI2kR0+guXhO1kfu4J8SY0iPJjDQ=;
        b=GewRa3J35S+FRxNXKKNFgCgf7atU9k5i09pFjVniOagEm8rpyRY7mK3a3MyKONvGMZ
         gNesx2hOixBJwkSpuKBZr1Po+U8aUb/Qb1UO7c2JL7F4D8oofG4pzq2GuXujTlHJpNWt
         pG8PVZxHVVVztANqRqQO0xzma2sAQyz2xZGXKGEMCkWPMpuNzmPIyn44DoiKCbMN/gQW
         Nrm86pDSQkwH8uo5SJHT0q+enzstOYvIvtu5iWpKQdvVrzV01Wy3rTMY0T6G24zBII2+
         8YRJOGw6Ics802QVk8asorbOB7jvWxV15lAvXI6HHNBDcuUdLRq+JZ2a0RGoFc+GRqaJ
         NnaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=2gUboy0WpFlCg1gFI2kR0+guXhO1kfu4J8SY0iPJjDQ=;
        b=xiBGTfPUzEEGc7MHG+/I/Gn3YIDbUHuAKzJaoa0z43lppFj8Za8zoREO1CAMZgodnm
         W6pqOBBPwGxw/gLvlMxFtQtebgQXC5C/NuyVfZiZtDn0ckBSL7RssRFwxo1owTIN6fPM
         mlnmlMjkhgl0iOLl79WbjavlC0QKoUvx64/t+cmRtyIXSCZtViL8gbkiuaDO58F3aNr7
         D2mLJHngFug3wH7KXF2jLJhnfPxtDGcJrvRjM04ORMfOicvJwfVyKlP9rD/75qYhtU6P
         3aGvlSS9A2StlNLv4ySGAzKaxva5xCKi7ZrjBFjjCxkVtYOe+nRs0JKsEs5vwpful+MO
         AiuA==
X-Gm-Message-State: AOAM530OG+DZGGPS4vtJ+naK9Z164t7QXKP/Dy3L6rTN83LZ+u0vBDja
        stFxfm9UdAB23NedIeLFoKWs9aqmJ90M
X-Google-Smtp-Source: ABdhPJzMjKvSd35EBOdYVwnOBd4B9dGqLkUE0gmUdyvpyWamIAbFHfgnhXf5yZ6H5mWCliCMcfTaEIE80lu+
X-Received: from vipinsh.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:36b0])
 (user=vipinsh job=sendgmr) by 2002:a5b:68a:0:b0:648:fcd2:3767 with SMTP id
 j10-20020a5b068a000000b00648fcd23767mr12309259ybq.358.1651529034451; Mon, 02
 May 2022 15:03:54 -0700 (PDT)
Date:   Mon,  2 May 2022 22:03:47 +0000
Message-Id: <20220502220347.174664-1-vipinsh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v2] KVM: x86/mmu: Speed up slot_rmap_walk_next for sparsely
 populated rmaps
From:   Vipin Sharma <vipinsh@google.com>
To:     pbonzini@redhat.com
Cc:     seanjc@google.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, dmatlack@google.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid calling handlers on empty rmap entries and skip to the next non
empty rmap entry.

Empty rmap entries are noop in handlers.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
Suggested-by: Sean Christopherson <seanjc@google.com>
---

v2:
- Removed noinline from slot_rmap_walk_next signature

v1:
- https://lore.kernel.org/lkml/20220325233125.413634-1-vipinsh@google.com

 arch/x86/kvm/mmu/mmu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 77785587332e..4e8d546431eb 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1501,9 +1501,11 @@ static bool slot_rmap_walk_okay(struct slot_rmap_walk_iterator *iterator)
 
 static void slot_rmap_walk_next(struct slot_rmap_walk_iterator *iterator)
 {
-	if (++iterator->rmap <= iterator->end_rmap) {
+	while (++iterator->rmap <= iterator->end_rmap) {
 		iterator->gfn += (1UL << KVM_HPAGE_GFN_SHIFT(iterator->level));
-		return;
+
+		if (iterator->rmap->val)
+			return;
 	}
 
 	if (++iterator->level > iterator->end_level) {

base-commit: 71d7c575a673d42ad7175ad5fc27c85c80330311
-- 
2.36.0.464.gb9c8b46e94-goog

