Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5502C433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jun 2022 06:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349624AbiFEGdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jun 2022 02:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237490AbiFEGda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 02:33:30 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54CB37ABA;
        Sat,  4 Jun 2022 23:33:27 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id s14so9829378plk.8;
        Sat, 04 Jun 2022 23:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gTXDQA3UAEO7tNX14XzZUCf6yPO/J44tyIzcuOM5FZY=;
        b=PRsbXjfB88WBPVEEVMd1QO47Rm5Z0Uo7CJQDHZOPxrdcUMfknjsD5XyjxZ3wT0mkf7
         cw2rPiTQHfV8DiFTbHD3i67TMhNXqFm/6OVrJkdYzi/NqqlA2JbIpSVT8tu7r3l8GVKm
         ibJyNZ5Uf6Xo/8F2M5DDhWEAklmOseRj0z6kSB1nM0KFN29uyaCYaBehip9VsE9DVqpd
         ZvtwYq8CqDseNTYt0R5GQOLMGyvq6vFJ5DPyV0/6lhduwWWQO0sTuZZ5QY5CEZZk9VGB
         Xg3LIKVF+yLtkQ/EPgUYvRyjB2iutICMdnFMK4Nu1X5rlGYDKkhGzaJpkxkrKWN7zoXb
         c6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gTXDQA3UAEO7tNX14XzZUCf6yPO/J44tyIzcuOM5FZY=;
        b=3++PQSoasaWng0/EyvdH29pZYGpGYtZ1TTsY2+BCd2QkMjSFIY5NJX6BRIETQ8jNQo
         l4Ey6JIxK7L+Ts7uGGtoj4y1+gdm5vMF3xK2yzWeeh+99fKpKTcrv6YwcHsIZxyvelGj
         /a0KbTBL5Btb7zU58Rg6fqFrxOr8jxs7r3jDDkhTptGpHqWJ5A/EhKRIu2pRmZ+iBYd2
         aAI9TepxGLu4eAXgc/98WGplSl6/eY+11GONwSiXB8ZoNtylZ3blwOBR+5200UywnUJ2
         tA6HVdTMInP5VViz3jGO82aQK8jeoON3RcOgju/UfIYI6KpzK7elOGtwtJRCbDHEdkdF
         ZowA==
X-Gm-Message-State: AOAM5305UVeBZAcMPVtHW5DMUO75REYN2jvnvULWN2qMYHJnwqxnWrS0
        uSp+vg0aF+gyjSEFsszJVV/Zd5Fh/7c=
X-Google-Smtp-Source: ABdhPJzJoZGL+BdkBN04dvC1TGO6aG8yDIaEjs0KjtuixeCqFxhiqljjHs9UfChsuejXCQiY8B4XSg==
X-Received: by 2002:a17:903:41c9:b0:164:57e:4b22 with SMTP id u9-20020a17090341c900b00164057e4b22mr18320539ple.2.1654410806883;
        Sat, 04 Jun 2022 23:33:26 -0700 (PDT)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id w19-20020a170902ca1300b001616b71e5e6sm8063122pld.175.2022.06.04.23.33.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Jun 2022 23:33:26 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>
Subject: [PATCH 0/6] KVM: Trivial cleanups
Date:   Sun,  5 Jun 2022 14:34:11 +0800
Message-Id: <20220605063417.308311-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

A small collection of trivial cleanups.

Lai Jiangshan (6):
  KVM: X86/MMU: Remove unused macros from paging_tmpl.h
  KVM: X86/MMU: Remove unused PT32_DIR_BASE_ADDR_MASK from mmu.c
  KVM: X86/MMU: Update comments in paging_tmpl.h for the kinds of guest
    PTEs
  KVM: Rename ack_flush() to ack_kick()
  KVM: X86/MMU: Remove useless mmu_topup_memory_caches() in
    kvm_mmu_pte_write()
  KVM: X86/SVM: Use root_level in svm_load_mmu_pgd()

 arch/x86/kvm/mmu/mmu.c         |  9 ---------
 arch/x86/kvm/mmu/paging_tmpl.h | 16 ++--------------
 arch/x86/kvm/svm/svm.c         |  2 +-
 virt/kvm/kvm_main.c            |  4 ++--
 4 files changed, 5 insertions(+), 26 deletions(-)

-- 
2.19.1.6.gb485710b

