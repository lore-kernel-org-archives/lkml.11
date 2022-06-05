Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373E5C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jun 2022 06:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350721AbiFEGnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jun 2022 02:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348283AbiFEGnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 02:43:05 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4348463D1;
        Sat,  4 Jun 2022 23:43:04 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id mh16-20020a17090b4ad000b001e8313301f1so3646758pjb.1;
        Sat, 04 Jun 2022 23:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HAmVyG/FQPF9ZWY/eAgNLdHok7UOGyy5hasiOmhkNcE=;
        b=lBbKOrLHGvr+GpF7DCISUFAHsz816Jo/UoXSdRhOiielbgBmr67RMo5f1Jm06+ye59
         bGrL41ldb3KdisKNXS8lIHNBSH/lIr0hysM9Xe+/uIdJumCv49RVmmIAH7sjEjA2umsA
         HJhscro3m/CNz71o5E0u0H2pmgHV21YTLtBJmlfXAePl5/HSP4UVKGx16DXeoEZbKIsl
         JQpEZhethCoiJdN6TEdjMLzbdX4uRgnbjTbXwkw8oDq7gOG1aOq7wCyQoKo4ibYGqERR
         deMhN7DrDB/QVFC1Cv370AmfJJ4xv94tDgq87RQe+IIvuRpngpyHpiMmxAwEgcH1pm34
         7k0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HAmVyG/FQPF9ZWY/eAgNLdHok7UOGyy5hasiOmhkNcE=;
        b=l9vle7+acvrnK+MfgfyGtf4eEmcZhrRRi4KPJNv1Fo/Ztvndk4R/5z7a4x/aYl/rWv
         CJ9w9Iu7b3xQcn2vg4D6LQhBgRpxIwQgZ80Tibi4/U/x4ifcMQxVOQ8wIfC7zt3KV5WH
         aypcV66Ldw2GWkhtoLRmz5qabWj8aIa+XyUyLjiBrlHY03pFbR1yQyQ/nQhcaknDuC5J
         kzAn5BJmzfyoHn6e3l54FINXAGmh15Arm1yzaXYijhKuE6m2CflKQ/qdgASQnMpMev+F
         8ePmMtJFS4mPrMHTiiPAZYLEh7w60ah2w+5lNxbMzRbQjDtYmgy9E9A2sWhAI8jjVIPr
         HMeQ==
X-Gm-Message-State: AOAM532MC9464hGnx92RwsmnIfMu4+UxOpUD15uXYfdP9nFp9dlyhg2N
        6TDVywel/pNhAIsFoo6erhHymoZTtpU=
X-Google-Smtp-Source: ABdhPJyKKc0BEeR66F4GM+AUvXjxNwnksKvUdC3T6bUy7AZZZ5sp8LGzsvOdhMU5I0o96pF5LnfDaA==
X-Received: by 2002:a17:902:e751:b0:163:d8d9:8440 with SMTP id p17-20020a170902e75100b00163d8d98440mr18116143plf.12.1654411383686;
        Sat, 04 Jun 2022 23:43:03 -0700 (PDT)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id p2-20020a056a0026c200b0050dc76281e5sm4501036pfw.191.2022.06.04.23.43.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Jun 2022 23:43:03 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>
Subject: [PATCH 03/12] KVM: X86/MMU: Split a part of kvm_unsync_page() as kvm_mmu_page_mark_unsync()
Date:   Sun,  5 Jun 2022 14:43:33 +0800
Message-Id: <20220605064342.309219-4-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20220605064342.309219-1-jiangshanlai@gmail.com>
References: <20220605064342.309219-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

Make it as the opposite function of kvm_mmu_page_clear_unsync().

Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 arch/x86/kvm/mmu/mmu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index c20981dfc4fd..cc0207e26f6e 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2529,12 +2529,16 @@ static int kvm_mmu_unprotect_page_virt(struct kvm_vcpu *vcpu, gva_t gva)
 	return r;
 }
 
-static void kvm_unsync_page(struct kvm *kvm, struct kvm_mmu_page *sp)
+static void kvm_mmu_page_mark_unsync(struct kvm *kvm, struct kvm_mmu_page *sp)
 {
 	trace_kvm_mmu_unsync_page(sp);
 	++kvm->stat.mmu_unsync;
 	sp->unsync = 1;
+}
 
+static void kvm_unsync_page(struct kvm *kvm, struct kvm_mmu_page *sp)
+{
+	kvm_mmu_page_mark_unsync(kvm, sp);
 	kvm_mmu_mark_parents_unsync(sp);
 }
 
-- 
2.19.1.6.gb485710b

